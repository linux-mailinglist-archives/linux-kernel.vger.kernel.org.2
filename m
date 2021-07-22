Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD773D2244
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhGVKIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 06:08:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11463 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhGVKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:08:18 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GVpxz5xgHzch0G;
        Thu, 22 Jul 2021 18:45:27 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 18:48:51 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 18:48:51 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        <iommu@lists.linux-foundation.org>
Subject: [PATCH resend] dma-debug: Use memory_intersects() directly
Date:   Thu, 22 Jul 2021 18:55:12 +0800
Message-ID: <20210722105512.183795-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a memory_intersects() helper in sections.h,
use memory_intersects() directly instead of private overlap().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---

Resend this patch only.

 kernel/dma/debug.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index dadae6255d05..fe6efd181614 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1064,20 +1064,10 @@ static void check_for_stack(struct device *dev,
 	}
 }
 
-static inline bool overlap(void *addr, unsigned long len, void *start, void *end)
-{
-	unsigned long a1 = (unsigned long)addr;
-	unsigned long b1 = a1 + len;
-	unsigned long a2 = (unsigned long)start;
-	unsigned long b2 = (unsigned long)end;
-
-	return !(b1 <= a2 || a1 >= b2);
-}
-
 static void check_for_illegal_area(struct device *dev, void *addr, unsigned long len)
 {
-	if (overlap(addr, len, _stext, _etext) ||
-	    overlap(addr, len, __start_rodata, __end_rodata))
+	if (memory_intersects(_stext, _etext, addr, len) ||
+	    memory_intersects(__start_rodata, __end_rodata, addr, len))
 		err_printk(dev, NULL, "device driver maps memory from kernel text or rodata [addr=%p] [len=%lu]\n", addr, len);
 }
 
-- 
2.26.2

