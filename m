Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B91351EED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbhDASuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:50:52 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:17444 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbhDASbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:31:09 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 9AFE59800C3;
        Thu,  1 Apr 2021 19:09:51 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] scripts: A new script for checking duplicate struct declaration
Date:   Thu,  1 Apr 2021 19:09:43 +0800
Message-Id: <20210401110943.1010796-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTUxKTEJKQ0wYT0lLVkpNSkxJTE5IQkpDSkJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0NJQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6Pxw4Tj8SFisMIzM0MkJC
        HzAwFEtVSlVKTUpMSUxOSEJJS05DVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJTEpDNwY+
X-HM-Tid: 0a788d200efbd992kuws9afe59800c3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkdeclares: find struct declared more than once.
Inspired by checkincludes.pl.
This script checks for duplicate struct declares.
Note that this will not take into consideration macros, so
you should run this only if you know you do have real dups
and do not have them under #ifdef's.
You could also just review the results.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 scripts/checkdeclares.pl | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 scripts/checkdeclares.pl

diff --git a/scripts/checkdeclares.pl b/scripts/checkdeclares.pl
new file mode 100755
index 000000000000..d14a8cc39a4d
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
+	my %declaredstructs = ();
+
+	while (<$f>) {
+		if (m/^\s*struct\s*(\w*);$/o) {
+			++$declaredstructs{$1};
+		}
+	}
+
+	close($f);
+
+	foreach my $structname (keys %declaredstructs) {
+		if ($declaredstructs{$structname} > 1) {
+			print "$file: struct $structname is declared more than once.\n";
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

