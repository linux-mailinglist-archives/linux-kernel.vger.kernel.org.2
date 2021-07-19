Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86263CCC00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 03:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhGSBlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 21:41:51 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:42146 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233713AbhGSBlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 21:41:51 -0400
X-Greylist: delayed 1799 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jul 2021 21:41:50 EDT
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 19 Jul 2021 10:08:50 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
        by 156.147.1.126 with ESMTP; 19 Jul 2021 10:08:50 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gunho Lee <gunho.lee@lge.com>, Juneho Choi <juno.choi@lge.com>,
        Inkyu Hwang <inkyu.hwang@lge.com>,
        Chanho Min <chanho.min@lge.com>
Subject: [PATCH] mm: make falutaround selectable
Date:   Mon, 19 Jul 2021 10:08:45 +0900
Message-Id: <20210719010845.31898-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While faultaround can have performance gains, on certain platform it
increases pss and causes swap to occur more frequently. This patch allows
to unselect faultaround on platforms that do not want this behavior.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 mm/Kconfig  | 6 ++++++
 mm/memory.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 39a6a977537d..8f834386e7f3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -750,4 +750,10 @@ config ARCH_HAS_PTE_SPECIAL
 config ARCH_HAS_HUGEPD
 	bool
 
+config FAULT_AROUND
+	bool "Enable fault around"
+	default y
+	help
+	 This option enables fault around. If say N, fault_around_bytes set to PAGE_SIZE
+	 and disables fault around.
 endmenu
diff --git a/mm/memory.c b/mm/memory.c
index 10d2e4734e82..0bb037265dda 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3500,7 +3500,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 }
 
 static unsigned long fault_around_bytes __read_mostly =
+#ifdef CONFIG_FAULT_AROUND
 	rounddown_pow_of_two(65536);
+#else
+	PAGE_SIZE;
+#endif
 
 #ifdef CONFIG_DEBUG_FS
 static int fault_around_bytes_get(void *data, u64 *val)
-- 
2.17.1

