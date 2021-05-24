Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8338E578
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhEXLan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:30:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3926 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhEXLaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:30:39 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FpZfM0tLPzCx72;
        Mon, 24 May 2021 19:26:19 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:29:09 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 19:29:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <andriy.shevchenko@linux.intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] mm/dmapool: use DEVICE_ATTR_RO macro
Date:   Mon, 24 May 2021 19:28:52 +0800
Message-ID: <20210524112852.34716-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: DEVICE_ATTR_RO -> DEVICE_ATTR_RO()
    DEVICE_ATTR -> DEVICE_ATTR()

 mm/dmapool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 16483f86360e..64b537b3ccb0 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -62,8 +62,7 @@ struct dma_page {		/* cacheable header for 'allocation' bytes */
 static DEFINE_MUTEX(pools_lock);
 static DEFINE_MUTEX(pools_reg_lock);
 
-static ssize_t
-show_pools(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t pools_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	unsigned temp;
 	unsigned size;
@@ -103,7 +102,7 @@ show_pools(struct device *dev, struct device_attribute *attr, char *buf)
 	return PAGE_SIZE - size;
 }
 
-static DEVICE_ATTR(pools, 0444, show_pools, NULL);
+static DEVICE_ATTR_RO(pools);
 
 /**
  * dma_pool_create - Creates a pool of consistent memory blocks, for dma.
-- 
2.17.1

