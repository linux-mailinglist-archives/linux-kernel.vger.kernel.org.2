Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4234B6C5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 12:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhC0LRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 07:17:01 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:9248 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhC0LQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 07:16:59 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 7FBE398010A;
        Sat, 27 Mar 2021 19:16:56 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Wan Jiabing <wanjiabing@vivo.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] [v2] scripts: checkdeclares for checking duplicate struct declares
Date:   Sat, 27 Mar 2021 19:16:41 +0800
Message-Id: <20210327111646.1708836-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHR9DQx9KTUMeTk1LVkpNSk1DT0hDSk1NTkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhg6ECo4Kz8RODM8MAErCDkd
        AgkKCy9VSlVKTUpNQ09IQ0pMS0tCVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJTEpINwY+
X-HM-Tid: 0a787366be83d992kuws7fbe398010a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkdeclares: find struct declared more than once.
Inspired by checkincludes.pl
This script checks for duplicate struct declares.
Note that this will not take into consideration macros so
you should run this only if you know you do have real dups
and do not have them under #ifdef's.
You could also just review the results.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Delete unused variable @file_lines.
---
 scripts/checkdeclares.pl | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 scripts/checkdeclares.pl

diff --git a/scripts/checkdeclares.pl b/scripts/checkdeclares.pl
new file mode 100755
index 000000000000..ce769572f807
--- /dev/null
+++ b/scripts/checkdeclares.pl
@@ -0,0 +1,53 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
+#
+# checkdeclares: find struct declared more than once
+#
+# Copyright 2021 Wan Jiabing<wanjiabing@vivo.com>
+# Inspired by checkincludes.pl
+#
+# This script checks for duplicate struct declares.
+# Note that this will not take into consideration macros so
+# you should run this only if you know you do have real dups
+# and do not have them under #ifdef's.
+# You could also just review the results.
+
+use strict;
+
+sub usage {
+	print "Usage: checkdeclares.pl \n";
+	print "We just warn of struct declaration duplicates\n";
+	exit 1;
+}
+
+if ($#ARGV < 0) {
+	usage();
+}
+
+my $dup_counter = 0;
+
+foreach my $file (@ARGV) {
+	open(my $f, '<', $file)
+	    or die "Cannot open $file: $!.\n";
+
+	my %declaredfiles = ();
+
+	while (<$f>) {
+		if (m/^\s*struct\s*(\w*);$/o) {
+			++$declaredfiles{$1};
+		}
+	}
+
+	close($f);
+
+	foreach my $filename (keys %declaredfiles) {
+		if ($declaredfiles{$filename} > 1) {
+			print "$file: struct $filename is declared more than once.\n";
+			++$dup_counter;
+		}
+	}
+}
+
+if ($dup_counter == 0) {
+	print "No duplicate struct declares found.\n";
+}
-- 
2.25.1

