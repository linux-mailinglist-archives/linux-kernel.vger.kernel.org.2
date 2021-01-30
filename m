Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF82E309307
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhA3JNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:13:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11947 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhA3JM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:12:59 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DSQFk09sbzjFJ9;
        Sat, 30 Jan 2021 15:05:14 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 15:06:05 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <mingo@redhat.com>, <tglx@linutronix.de>, <rppt@kernel.org>,
        <dyoung@redhat.com>, <bhe@redhat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <nsaenzjulienne@suse.de>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <bhsharma@redhat.com>,
        <prabhakar.pkin@gmail.com>
CC:     <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <james.morse@arm.com>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <chenzhou10@huawei.com>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        John Donnelly <John.p.donnelly@oracle.com>
Subject: [PATCH v14 04/11] x86: kdump: move xen_pv_domain() check and insert_resource() to setup_arch()
Date:   Sat, 30 Jan 2021 15:10:18 +0800
Message-ID: <20210130071025.65258-5-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210130071025.65258-1-chenzhou10@huawei.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will make the functions reserve_crashkernel() as generic, the
xen_pv_domain() check in reserve_crashkernel() is relevant only to
x86, the same as insert_resource() in reserve_crashkernel[_low]().
So move xen_pv_domain() check and insert_resource() to setup_arch()
to keep them in x86.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
---
 arch/x86/kernel/setup.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 086a04235be4..5d676efc32f6 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -454,7 +454,6 @@ static int __init reserve_crashkernel_low(void)
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
-	insert_resource(&iomem_resource, &crashk_low_res);
 #endif
 	return 0;
 }
@@ -478,11 +477,6 @@ static void __init reserve_crashkernel(void)
 		high = true;
 	}
 
-	if (xen_pv_domain()) {
-		pr_info("Ignoring crashkernel for a Xen PV domain\n");
-		return;
-	}
-
 	/* 0 means: find the address automatically */
 	if (!crash_base) {
 		/*
@@ -529,7 +523,6 @@ static void __init reserve_crashkernel(void)
 
 	crashk_res.start = crash_base;
 	crashk_res.end   = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
 }
 #else
 static void __init reserve_crashkernel(void)
@@ -1151,7 +1144,17 @@ void __init setup_arch(char **cmdline_p)
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
 	 * won't consume hotpluggable memory.
 	 */
-	reserve_crashkernel();
+	if (xen_pv_domain())
+		pr_info("Ignoring crashkernel for a Xen PV domain\n");
+	else {
+		reserve_crashkernel();
+#ifdef CONFIG_KEXEC_CORE
+		if (crashk_res.end > crashk_res.start)
+			insert_resource(&iomem_resource, &crashk_res);
+		if (crashk_low_res.end > crashk_low_res.start)
+			insert_resource(&iomem_resource, &crashk_low_res);
+#endif
+	}
 
 	memblock_find_dma_reserve();
 
-- 
2.20.1

