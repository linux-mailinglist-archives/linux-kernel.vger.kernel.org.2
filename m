Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9242D2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhJNGqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:46:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:55290 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhJNGqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:46:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227569699"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="227569699"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 23:43:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="481120249"
Received: from msavu-mobl1.ti.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.249.43.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 23:43:55 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     apw@canonical.com, joe@perches.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        peter.ujfalusi@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v7] checkpatch: get default codespell dictionary path from package location
Date:   Thu, 14 Oct 2021 09:44:06 +0300
Message-Id: <20211014064406.28052-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard location of dictionary.txt is under codespell's package, on
my machine atm (codespell 2.1, Artix Linux):
/usr/lib/python3.9/site-packages/codespell_lib/data/dictionary.txt

Since we enable the codespell by default for SOF I have constant:
No codespell typos will be found - \
file '/usr/share/codespell/dictionary.txt': No such file or directory

The patch proposes to try to fix up the path following the recommendation
found here:
https://github.com/codespell-project/codespell/issues/1540

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi,

Changes since v6:
- do not try to look for codespell install dir if the default
  /usr/share/codespell/dictionary.txt exists

Changes since v5:
- move the $python_codespell_dict to local
- drop extra semicolon
- execute python, not python3

Changes since v4:
- Use the readable version suggested by Joe Perches (store the pyhton snippet in
  python_codespell_dict)

Changes since v3:
- Do not try to override the use provided codespell file location

Changes since v2:
- Only try to check for dictionary path it is enabled or when the help is
  displayed
 - Move the check after the GetOptions()
 - Set $help to 2 in case invalid option is passed in order to be able to use
   correct exitcode and still display the correct path for dictionary.txt

Changes sicne v1:
- add missing ';' to the line updating the $codespellfile with $codespell_dict

Regards,
Peter

 scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 91798b07c6cb..1784921c645d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -63,6 +63,7 @@ my $min_conf_desc_length = 4;
 my $spelling_file = "$D/spelling.txt";
 my $codespell = 0;
 my $codespellfile = "/usr/share/codespell/dictionary.txt";
+my $user_codespellfile = "";
 my $conststructsfile = "$D/const_structs.checkpatch";
 my $docsfile = "$D/../Documentation/dev-tools/checkpatch.rst";
 my $typedefsfile;
@@ -130,7 +131,7 @@ Options:
   --ignore-perl-version      override checking of perl version.  expect
                              runtime errors.
   --codespell                Use the codespell dictionary for spelling/typos
-                             (default:/usr/share/codespell/dictionary.txt)
+                             (default:$codespellfile)
   --codespellfile            Use this codespell dictionary
   --typedefsfile             Read additional types from this file
   --color[=WHEN]             Use colors 'always', 'never', or only when output
@@ -317,7 +318,7 @@ GetOptions(
 	'debug=s'	=> \%debug,
 	'test-only=s'	=> \$tst_only,
 	'codespell!'	=> \$codespell,
-	'codespellfile=s'	=> \$codespellfile,
+	'codespellfile=s'	=> \$user_codespellfile,
 	'typedefsfile=s'	=> \$typedefsfile,
 	'color=s'	=> \$color,
 	'no-color'	=> \$color,	#keep old behaviors of -nocolor
@@ -325,9 +326,32 @@ GetOptions(
 	'kconfig-prefix=s'	=> \${CONFIG_},
 	'h|help'	=> \$help,
 	'version'	=> \$help
-) or help(1);
+) or $help = 2;
+
+if ($user_codespellfile) {
+	# Use the user provided codespell file unconditionally
+	$codespellfile = $user_codespellfile;
+} elsif (!(-f $codespellfile)) {
+	# If /usr/share/codespell/dictionary.txt is not present, try to find it
+	# under codespell's install directory: <codespell_root>/data/dictionary.txt
+	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
+		my $python_codespell_dict = << "EOF";
+
+import os.path as op
+import codespell_lib
+codespell_dir = op.dirname(codespell_lib.__file__)
+codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
+print(codespell_file, end='')
+EOF
+
+		my $codespell_dict = `python -c "$python_codespell_dict" 2> /dev/null`;
+		$codespellfile = $codespell_dict if (-f $codespell_dict);
+	}
+}
 
-help(0) if ($help);
+# $help is 1 if either -h, --help or --version is passed as option - exitcode: 0
+# $help is 2 if invalid option is passed - exitcode: 1
+help($help - 1) if ($help);
 
 die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
 die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
-- 
2.33.0

