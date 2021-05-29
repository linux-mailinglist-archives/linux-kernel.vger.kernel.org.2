Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFC0394A21
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 05:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhE2DeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 23:34:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2458 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhE2Dd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 23:33:58 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsRqq04cNz67PB;
        Sat, 29 May 2021 11:29:27 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 11:32:21 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 11:32:20 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/2] ARM: mm: Fix PXN process when ARM_LPAE enabled
Date:   Sat, 29 May 2021 11:41:38 +0800
Message-ID: <20210529034138.83384-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210529034138.83384-1-wangkefeng.wang@huawei.com>
References: <20210529034138.83384-1-wangkefeng.wang@huawei.com>
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

If we support PXN feature, should panic when user code execution
with privilege mode, but it is not true when LAPE enabled, let's
fix it by adding the check in do_page_fault().

Fixes: 1d4d37159d01 ("ARM: 8235/1: Support for the PXN CPU feature on ARMv7")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/fault.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 81cf3e6e2a3d..a6ada914cdf5 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -241,8 +241,13 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		vm_flags = VM_WRITE;
 	}
 
-	if (fsr & FSR_LNX_PF)
+	if (fsr & FSR_LNX_PF) {
 		vm_flags = VM_EXEC;
+#ifdef CONFIG_ARM_LPAE
+		if (addr < TASK_SIZE && !user_mode(regs))
+			__do_kernel_fault(mm, addr, fsr, regs);
+#endif
+	}
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
-- 
2.26.2

