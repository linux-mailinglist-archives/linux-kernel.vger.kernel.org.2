Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A214286B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhJKGUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:20:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:9039 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233874AbhJKGUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:20:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="213952386"
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="213952386"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 23:18:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="490337863"
Received: from acleivam-mobl1.amr.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.249.40.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 23:18:29 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     apw@canonical.com, joe@perches.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        peter.ujfalusi@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: get default codespell dictionary path from package location
Date:   Mon, 11 Oct 2021 09:18:39 +0300
Message-Id: <20211011061839.4199-1-peter.ujfalusi@linux.intel.com>
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
 scripts/checkpatch.pl | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c27d2312cfc3..e8e416056066 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -73,6 +73,12 @@ my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
 my ${CONFIG_} = "CONFIG_";
 
+# Override the codespellfile location based on codespell install location
+if (which("codespell") ne "" && which("python") ne "") {
+	my $codespell_dict = `python -c "import os.path as op; import codespell_lib; print(op.join(op.dirname(codespell_lib.__file__), 'data', 'dictionary.txt'), end='')" 2> /dev/null`;
+	$codespellfile = $codespell_dict if (-e $codespell_dict)
+}
+
 sub help {
 	my ($exitcode) = @_;
 
@@ -130,7 +136,7 @@ Options:
   --ignore-perl-version      override checking of perl version.  expect
                              runtime errors.
   --codespell                Use the codespell dictionary for spelling/typos
-                             (default:/usr/share/codespell/dictionary.txt)
+                             (default:$codespellfile)
   --codespellfile            Use this codespell dictionary
   --typedefsfile             Read additional types from this file
   --color[=WHEN]             Use colors 'always', 'never', or only when output
-- 
2.33.0

