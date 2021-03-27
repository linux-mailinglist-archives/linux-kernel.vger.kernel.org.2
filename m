Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA38B34B4F9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 08:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhC0HQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 03:16:59 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:59816 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhC0HQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 03:16:56 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id AE1D098014B;
        Sat, 27 Mar 2021 15:16:52 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Wan Jiabing <wanjiabing@vivo.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] scripts: checkdeclares for checking duplicate struct declares
Date:   Sat, 27 Mar 2021 15:16:36 +0800
Message-Id: <20210327071641.1485896-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk9IH0NKGk0YTRhNVkpNSk1DSUJPSklDTU1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MC46SAw6FD8IFjNLMgkyFwE1
        Pw9PFBFVSlVKTUpNQ0lCT0pISUtIVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJTUJINwY+
X-HM-Tid: 0a78728af5bdd992kuwsae1d098014b
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
 scripts/checkdeclares.pl | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 scripts/checkdeclares.pl

diff --git a/scripts/checkdeclares.pl b/scripts/checkdeclares.pl
new file mode 100755
index 000000000000..f28c40ab0f00
--- /dev/null
+++ b/scripts/checkdeclares.pl
@@ -0,0 +1,55 @@
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
+	my @file_lines = ();
+
+	while (<$f>) {
+		if (m/^\s*struct\s*(\w*);$/o) {
+			++$declaredfiles{$1};
+		}
+		push(@file_lines, $_);
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

