Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5391F38D954
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 08:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhEWGso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 02:48:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3637 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhEWGsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 02:48:40 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FnrPy0DFszQrCS;
        Sun, 23 May 2021 14:43:02 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 23 May 2021 14:46:36 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 23
 May 2021 14:46:35 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <andriy.shevchenko@linux.intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mm/dmapool: use DEVICE_ATTR_RO macro
Date:   Sun, 23 May 2021 14:46:26 +0800
Message-ID: <20210523064626.41532-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/dmapool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 16483f86360e..62083ef04878 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -62,8 +62,8 @@ struct dma_page {		/* cacheable header for 'allocation' bytes */
 static DEFINE_MUTEX(pools_lock);
 static DEFINE_MUTEX(pools_reg_lock);
 
-static ssize_t
-show_pools(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t pools_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
 	unsigned temp;
 	unsigned size;
@@ -103,7 +103,7 @@ show_pools(struct device *dev, struct device_attribute *attr, char *buf)
 	return PAGE_SIZE - size;
 }
 
-static DEVICE_ATTR(pools, 0444, show_pools, NULL);
+static DEVICE_ATTR_RO(pools);
 
 /**
  * dma_pool_create - Creates a pool of consistent memory blocks, for dma.
-- 
2.17.1

