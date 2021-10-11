Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A206428C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbhJKLvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:51:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:53092 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234279AbhJKLvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:51:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="226755387"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="226755387"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 04:49:44 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="479823875"
Received: from acleivam-mobl1.amr.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.249.40.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 04:49:42 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     apw@canonical.com, joe@perches.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        peter.ujfalusi@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4] checkpatch: get default codespell dictionary path from package location
Date:   Mon, 11 Oct 2021 14:49:52 +0300
Message-Id: <20211011114952.26145-1-peter.ujfalusi@linux.intel.com>
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

 scripts/checkpatch.pl | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c27d2312cfc3..485be7d27596 100755
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
@@ -325,9 +326,22 @@ GetOptions(
 	'kconfig-prefix=s'	=> \${CONFIG_},
 	'h|help'	=> \$help,
 	'version'	=> \$help
-) or help(1);
+) or $help = 2;
 
-help(0) if ($help);
+if ($user_codespellfile) {
+	# Use the user provided codespell file unconditionally
+	$codespellfile = $user_codespellfile;
+} else {
+	# Try to find the codespell install location to use it as default path
+	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
+		my $codespell_dict = `python -c "import os.path as op; import codespell_lib; print(op.join(op.dirname(codespell_lib.__file__), 'data', 'dictionary.txt'), end='')" 2> /dev/null`;
+		$codespellfile = $codespell_dict if (-e $codespell_dict);
+	}
+}
+
+# $help is 1 if either -h, --help or --version is passed as option - exitcode: 0
+# $help is 2 if invalid option is passed - exitcode: 1
+help($help - 1) if ($help);
 
 die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
 die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
-- 
2.33.0

