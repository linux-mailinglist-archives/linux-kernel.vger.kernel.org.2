Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0AE38D953
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 08:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhEWGrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 02:47:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4589 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhEWGrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 02:47:01 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FnrPb72gnzkX9d;
        Sun, 23 May 2021 14:42:43 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 23 May 2021 14:45:33 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 23
 May 2021 14:45:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mm/compaction: use DEVICE_ATTR_WO macro
Date:   Sun, 23 May 2021 14:45:21 +0800
Message-ID: <20210523064521.32912-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_WO helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/compaction.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 7d41b58fb17c..b7fb991dee1b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2722,9 +2722,9 @@ int sysctl_compaction_handler(struct ctl_table *table, int write,
 }
 
 #if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
-static ssize_t sysfs_compact_node(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t compact_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	int nid = dev->id;
 
@@ -2737,7 +2737,7 @@ static ssize_t sysfs_compact_node(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(compact, 0200, NULL, sysfs_compact_node);
+static DEVICE_ATTR_WO(compact);
 
 int compaction_register_node(struct node *node)
 {
-- 
2.17.1

