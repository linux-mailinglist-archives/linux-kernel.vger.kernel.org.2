Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D746A3A2B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhFJM3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:29:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3835 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFJM3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:29:17 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G135C0rWrzWsWR;
        Thu, 10 Jun 2021 20:22:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 20:27:16 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 20:27:11 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Will Deacon <will@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 5/6] ARM: mm: Provide die_kernel_fault() helper
Date:   Thu, 10 Jun 2021 20:35:55 +0800
Message-ID: <20210610123556.171328-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
References: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 arch/arm/mm/fault.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 76aced067b12..82bcfe57de20 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -99,6 +99,21 @@ void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
 { }
 #endif					/* CONFIG_MMU */
 
+static void die_kernel_fault(const char *msg, struct mm_struct *mm,
+			     unsigned long addr, unsigned int fsr,
+			     struct pt_regs *regs)
+{
+	bust_spinlocks(1);
+	pr_alert("8<--- cut here ---\n");
+	pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
+		 msg, addr);
+
+	show_pte(KERN_ALERT, mm, addr);
+	die("Oops", regs, fsr);
+	bust_spinlocks(0);
+	do_exit(SIGKILL);
+}
+
 /*
  * Oops.  The kernel tried to access some page that wasn't present.
  */
@@ -106,6 +121,7 @@ static void
 __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 		  struct pt_regs *regs)
 {
+	const char *msg;
 	/*
 	 * Are we prepared to handle this kernel fault?
 	 */
@@ -115,16 +131,12 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
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
 
-	show_pte(KERN_ALERT, mm, addr);
-	die("Oops", regs, fsr);
-	bust_spinlocks(0);
-	do_exit(SIGKILL);
+	die_kernel_fault(msg, mm, addr, fsr, regs);
 }
 
 /*
-- 
2.26.2

