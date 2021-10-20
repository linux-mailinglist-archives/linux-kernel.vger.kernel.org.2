Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF122434360
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 04:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJTCRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 22:17:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14830 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhJTCQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 22:16:58 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HYvFR0w7Bz90LJ;
        Wed, 20 Oct 2021 10:09:47 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 10:14:35 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 10:14:34 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v15 04/10] x86: kdump: move xen_pv_domain() check and insert_resource() to setup_arch()
Date:   Wed, 20 Oct 2021 10:03:11 +0800
Message-ID: <20211020020317.1220-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211020020317.1220-1-thunder.leizhen@huawei.com>
References: <20211020020317.1220-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

We will make the functions reserve_crashkernel() as generic, the
xen_pv_domain() check in reserve_crashkernel() is relevant only to
x86, the same as insert_resource() in reserve_crashkernel[_low]().
So move xen_pv_domain() check and insert_resource() to setup_arch()
to keep them in x86.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/setup.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2c9f5c71a870e..657ec7fb62da37c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -456,7 +456,6 @@ static int __init reserve_crashkernel_low(void)
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
-	insert_resource(&iomem_resource, &crashk_low_res);
 #endif
 	return 0;
 }
@@ -480,11 +479,6 @@ static void __init reserve_crashkernel(void)
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
@@ -531,7 +525,6 @@ static void __init reserve_crashkernel(void)
 
 	crashk_res.start = crash_base;
 	crashk_res.end   = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
 }
 #else
 static void __init reserve_crashkernel(void)
@@ -1131,7 +1124,17 @@ void __init setup_arch(char **cmdline_p)
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
2.25.1

