Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979DC447918
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 05:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhKHEIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 23:08:02 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14723 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbhKHEH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:07:59 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HncsK6WcHzZckx;
        Mon,  8 Nov 2021 12:03:01 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 12:05:13 +0800
Received: from use12-sp2.huawei.com (10.67.189.174) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Mon, 8 Nov 2021 12:05:12 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>, <olof@lixom.net>, <21cnbao@gmail.com>,
        <grant.likely@secretlab.ca>, <santosh.shilimkar@ti.com>,
        <m.szyprowski@samsung.com>, <tony@atomide.com>,
        <t.figa@samsung.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH] arm:cache-l2x0: Fix resource leak in the l2x0_of_init() failed branch
Date:   Mon, 8 Nov 2021 12:05:10 +0800
Message-ID: <20211108040510.14494-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema774-chm.china.huawei.com (10.1.198.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the code review, some problems were found in the function l2x0_of_init().
1. Do not call Of_put_node() after calling of_find_match_node().
2. When __l2c_init() is called for identification, l2x0_base is not released.

Invoking Of_put_node() and iounmap() is added to solve this problem.

Fixes: 8c369264b6de3 ("ARM: 7009/1: l2x0: Add OF based initialization")
Fixes: 91c2ebb90b189 ("ARM: 7114/1: cache-l2x0: add resume entry for l2 in secure mode")
Fixes: 6b49241ac2525 ("ARM: 8259/1: l2c: Refactor the driver to use commit-like interface")
Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 arch/arm/mm/cache-l2x0.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 43d91bfd2360..105bf7575cdf 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1766,17 +1766,22 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	u32 cache_id, old_aux;
 	u32 cache_level = 2;
 	bool nosync = false;
+	int ret;
 
 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
 		return -ENODEV;
 
-	if (of_address_to_resource(np, 0, &res))
+	if (of_address_to_resource(np, 0, &res)) {
+		of_put_node(np);
 		return -ENODEV;
+	}
 
 	l2x0_base = ioremap(res.start, resource_size(&res));
-	if (!l2x0_base)
+	if (!l2x0_base) {
+		of_put_node(np);
 		return -ENOMEM;
+	}
 
 	l2x0_saved_regs.phy_base = res.start;
 
@@ -1820,6 +1825,12 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	else
 		cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
 
-	return __l2c_init(data, aux_val, aux_mask, cache_id, nosync);
+	ret = _l2c_init(data, aux_val, aux_mask, cache_id, nosync);
+	if (ret != 0) {
+		iounmap(l2x0_base);
+		l2x0_base = NULL;
+	}
+	of_put_node(np);
+	return ret;
 }
 #endif
-- 
2.27.0

