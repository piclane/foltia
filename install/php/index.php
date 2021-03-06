<?php
/*
  Anime recording system foltia
  http://www.dcc-jpl.com/soft/foltia/

  index.php

  目的
  全番組放映予定を表示します。
  録画予約されている番組は別色でわかりやすく表現されています。


  オプション
  mode:"new"を指定すると、新番組(第1話)のみの表示となる。
  now:YmdHi形式で日付を指定するとその日からの番組表が表示される。

  DCC-JPL Japan/foltia project

*/

include("./foltialib.php");
include("./sqlite_accessor.php");
$con = m_connect();

if ($useenvironmentpolicy == 1) {
    if (!isset($_SERVER['PHP_AUTH_USER'])) {
	header("WWW-Authenticate: Basic realm=\"foltia\"");
	header("HTTP/1.0 401 Unauthorized");
	redirectlogin();
	exit;
    } else {
	login($con,$_SERVER['PHP_AUTH_USER'],$_SERVER['PHP_AUTH_PW']);
    }
}//end if login

$mode = getgetform(mode);

$now = getgetnumform(date);
if(($now < 200001010000 ) || ($now > 209912342353 )) { 
    $now = date("YmdHi");   
}

//ページの表示レコード数
$lim = 300;		
//クエリ取得
$p = getgetnumform(p);
//ページ取得の計算
list($st,$p,$p2) = number_page($p,$lim);
//同一番組他局検索
$reservedpidsametid = get_reserved_rs_same_tid($con);
//録画番組検索
$reservedpid = get_reserved_rs_tid($con, $now);

if ($mode == "new") {
    //新番組表示モード
    $query = get_query_for_new_program($con);

} else {

    ////////////////////////////////////////////////////////////
    //レコード総数取得
    $dtcnt = get_all_record_or_die($con, $now);
    //レコード表示
    $query = get_query_for_program($con, $lim, $st);
    ////////////////////////////////////////////////////////////

}//end if

$rs = sql_query($con, $query, "DBクエリに失敗しました",array($now));
$rowdata = $rs->fetch();

if (! $rowdata) {

    header("Status: 404 Not Found",TRUE,404);
    printtitle("<title>foltia:放映予定</title>", true);
    print "<body><div id=\"wrapper\"><div align=\"center\">\n";    
    print_navigate_bar();
    printhtmlpageheader();
    print "<hr size=\"4\">\n";
    die_exit("番組データがありません<BR>");

}//endif

printtitle("<title>foltia:放映予定</title>", true);

?>

<body>
  <div id="wrapper">

    <!-- ナビゲーションバーなど -->
    <div align="center">

      <?php 

    print_navigate_bar();
printhtmlpageheader();

      ?>

    </div>


    <!-- 表示するページ FIXME: テンプレートが有効に使える場面であるためあとで重複コードは排除する -->
    <div id="page-wrapper">
      <div id="container-fluid">

	<!-- ページタイトル -->
	<div class="row">
          <div class="col-lg-12">
            <h1 class="page-header">
              &nbsp;
	      <?php
		if ($mode == "new") {
		    print "新番組放映予定";
		} else {
		    print "放映予定";
		}
	      ?>
            </h1>
	    
	    <p align="left">放映番組リストを表示します。</p>

            <ol class="breadcrumb">
              <li>
		<i class="fa fa-fw fa-table"></i>  <a href="./index.php"> 放映予定</a>
              </li>
              <li class="active">
		<?php
			  if ($mode == "new") {
			      print "<i class=\"fa fa-fw fa-bell\"></i>  <a href=\"./index.php?mode=new\"> 新番組</a>";
			  } else {
			      print "<i class=\"fa fa-fw fa-table\"></i>  <a href=\"./index.php\"> 放映予定</a>";
			  }		  
		?>
              </li>
            </ol>
          </div>
	</div>

	<?php
	  /* フィールド数 */
	  $maxcols = $rs->columnCount();
	  //Autopager
	  echo "<div id=contents class=autopagerize_page_element />";
	?>
	<!-- /.row -->

	<!-- ページのコンテンツ -->
	<div class="row">
	  <div class="col-lg-12">


	    <div class="table-responsive">
	      <table class="table table-bordered table-hover">

		<!-- テーブルのヘッダ -->
		<thead>
		  <tr>
		    <th>TID</th>
		    <th>放映局</th>
		    <th>タイトル</th>
		    <th>話数</th>
		    <th>サブタイトル</th>
		    <th>開始時刻(ズレ)</th>
		    <th>総尺</th>
		  </tr>
		</thead>

		<tbody>

		  <?php
	      /* テーブルのデータを出力 */
	      do {
		  //他局で同一番組録画済みなら色変え
		  if (in_array($rowdata[7], $reservedpidsametid)) {
		      $rclass = "reservedtitle";
		  } else {
		      $rclass = "";
		  }
		  //録画予約済みなら色変え
		  if (in_array($rowdata[7], $reservedpid)) {
		      $rclass = "reserved";
		  }
		  $pid = htmlspecialchars($rowdata[7]);
		  $tid = htmlspecialchars($rowdata[0]);
		  $title = htmlspecialchars($rowdata[2]);
		  $subtitle =  htmlspecialchars($rowdata[4]);

		  echo("<tr class=\"$rclass\">\n");
		  // TID
		  print "<td>";
		  if ($tid == 0) {
		      print "$tid";
		  } else {
		      print "<a href=\"reserveprogram.php?tid=$tid\">$tid</a>";
		  }
		  print "</td>\n";
		  // 放映局
		  echo("<td>".htmlspecialchars($rowdata[1])."<br></td>\n");
		  // タイトル
		  print "<td>";
		  if ($tid == 0) {
		      print "$title";
		  } else {
		      print "<a href=\"http://cal.syoboi.jp/tid/$tid\" target=\"_blank\">$title</a>";
                  }
		  print "</td>\n";
		  // 話数
		  echo("<td>".htmlspecialchars($rowdata[3])."<br></td>\n");
		  // サブタイ
		  if ($pid > 0 ) {
		      print "<td><a href=\"http://cal.syoboi.jp/tid/$tid/time#$pid\" target=\"_blank\">$subtitle<br></td>\n";
                  } else {
		      print "<td>$subtitle<br></td>\n";
		  }
		  // 開始時刻(ズレ)
		  echo("<td>".htmlspecialchars(foldate2print($rowdata[5]))."<br>(".htmlspecialchars($rowdata[8]).")</td>\n");
		  // 総尺
		  echo("<td>".htmlspecialchars($rowdata[6])."<br></td>\n");
		  echo("</tr>\n");
     
	} while ($rowdata = $rs->fetch());

		?>

		</tbody>
	      </table>
	    </div>
	  </div>
	</div>

<?php
/////////////////////////////////////////////////
//Autopageing処理とページのリンクを表示
page_display("",$p,$p2,$lim,$dtcnt,$mode);
/////////////////////////////////////////////////
?>

      </div>
    </div>
  </body>
</html>
