Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D96398176
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhFBGzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:55:50 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3337 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhFBGzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:55:49 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw04b3Vyfz19S9b;
        Wed,  2 Jun 2021 14:49:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:53:49 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:53:48 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 6/7] ARM: mm: Provide die_kernel_fault() helper
Date:   Wed, 2 Jun 2021 15:02:45 +0800
Message-ID: <20210602070246.83990-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide die_kernel_fault() helper to do the kernel fault reporting,
which with msg argument, it could report different message in different
scenes, and the later patch "ARM: mm: Fix PXN process with LPAE feature"
will use it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/fault.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 1383d465399b..7cfa9a59d3ec 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -108,12 +108,27 @@ void show_pte(const char *lvl, unsigned long addr)
 { }
 #endif					/* CONFIG_MMU */
 
+static void die_kernel_fault(const char *msg, unsigned long addr,
+			     unsigned int fsr, struct pt_regs *regs)
+{
+	bust_spinlocks(1);
+	pr_alert("8<--- cut here ---\n");
+	pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
+		 msg, addr);
+
+	show_pte(KERN_ALERT, addr);
+	die("Oops", regs, fsr);
+	bust_spinlocks(0);
+	do_exit(SIGKILL);
+}
+
 /*
  * Oops.  The kernel tried to access some page that wasn't present.
  */
 static void
 __do_kernel_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
+	const char *msg;
 	/*
 	 * Are we prepared to handle this kernel fault?
 	 */
@@ -123,16 +138,12 @@ __do_kernel_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	/*
 	 * No handler, we'll have to terminate things with extreme prejudice.
 	 */
-	bust_spinlocks(1);
-	pr_alert("8<--- cut here ---\n");
-	pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
-		 (addr < PAGE_SIZE) ? "NULL pointer dereference" :
-		 "paging request", addr);
+	if (addr < PAGE_SIZE)
+		msg = "NULL pointer dereference";
+	else
+		msg = "paging request";
 
-	show_pte(KERN_ALERT, addr);
-	die("Oops", regs, fsr);
-	bust_spinlocks(0);
-	do_exit(SIGKILL);
+	die_kernel_fault(msg, addr, fsr, regs);
 }
 
 /*
-- 
2.26.2

