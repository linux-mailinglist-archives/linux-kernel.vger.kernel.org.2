Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071A534FDAE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhCaKAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbhCaJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:59:49 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4FDC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:59:48 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:ada2:b4da:6568:5ad5])
        by xavier.telenet-ops.be with bizsmtp
        id mxzd2400B5W9KJv01xzdYR; Wed, 31 Mar 2021 11:59:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lRXdQ-00BseR-EG; Wed, 31 Mar 2021 11:59:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lRXBt-001bpg-C4; Wed, 31 Mar 2021 11:31:09 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Ogness <john.ogness@linutronix.de>,
        Gary R Hook <gary.hook@amd.com>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-embedded@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] iommu: Use pr_crit() instead of long fancy messages
Date:   Wed, 31 Mar 2021 11:31:02 +0200
Message-Id: <20210331093104.383705-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331093104.383705-1-geert+renesas@glider.be>
References: <20210331093104.383705-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While long fancy messages have a higher probability of being seen than
small messages, they may scroll of the screen fast, if visible at all,
and may still be missed.  In addition, they increase boot time and
kernel size.

The correct mechanism to increase importance of a kernel message is not
to draw fancy boxes with more text, but to shout louder, i.e. increase
the message's reporting level.  Making sure the administrator of the
system is aware of such a message is a system policy, and is the
responsability of a user-space log daemon.

Fix this by increasing the reporting level from KERN_WARNING to
KERN_CRIT, and removing irrelevant text and graphics.

This reduces kernel size by ca. 0.5 KiB.

Fixes: bad614b24293ae46 ("iommu: Enable debugfs exposure of IOMMU driver internals")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/iommu-debugfs.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
index f0354894209648fd..c3306998de0687bd 100644
--- a/drivers/iommu/iommu-debugfs.c
+++ b/drivers/iommu/iommu-debugfs.c
@@ -32,20 +32,9 @@ void iommu_debugfs_setup(void)
 {
 	if (!iommu_debugfs_dir) {
 		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
-		pr_warn("\n");
-		pr_warn("*************************************************************\n");
-		pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
-		pr_warn("**                                                         **\n");
-		pr_warn("**  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **\n");
-		pr_warn("**                                                         **\n");
-		pr_warn("** This means that this kernel is built to expose internal **\n");
-		pr_warn("** IOMMU data structures, which may compromise security on **\n");
-		pr_warn("** your system.                                            **\n");
-		pr_warn("**                                                         **\n");
-		pr_warn("** If you see this message and you are not debugging the   **\n");
-		pr_warn("** kernel, report this immediately to your vendor!         **\n");
-		pr_warn("**                                                         **\n");
-		pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
-		pr_warn("*************************************************************\n");
+		pr_crit("IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL\n");
+		pr_crit("This means that this kernel is built to expose internal\n");
+		pr_crit("IOMMU data structures, which may compromise security on\n");
+		pr_crit("your system.\n");
 	}
 }
-- 
2.25.1

