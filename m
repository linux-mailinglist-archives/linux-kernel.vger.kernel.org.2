Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199FE3B2EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhFXM0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:26:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11092 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:26:26 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G9fPB0tbDzZjNW;
        Thu, 24 Jun 2021 20:21:02 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 20:24:03 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: workingset: define macro WORKINGSET_SHIFT
Date:   Thu, 24 Jun 2021 20:23:07 +0800
Message-ID: <20210624122307.1759342-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The magic number 1 is used in several places in workingset.c. Define a
macro WORKINGSET_SHIFT for it to improve code readability.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/workingset.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 9d3d2b4ce44d..cf8bb34fb321 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -168,8 +168,10 @@
  * refault distance will immediately activate the refaulting page.
  */
 
+#define WORKINGSET_SHIFT 1
 #define EVICTION_SHIFT	((BITS_PER_LONG - BITS_PER_XA_VALUE) +	\
-			 1 + NODES_SHIFT + MEM_CGROUP_ID_SHIFT)
+			 WORKINGSET_SHIFT + NODES_SHIFT + \
+			 MEM_CGROUP_ID_SHIFT)
 #define EVICTION_MASK	(~0UL >> EVICTION_SHIFT)
 
 /*
@@ -189,7 +191,7 @@ static void *pack_shadow(int memcgid, pg_data_t *pgdat, unsigned long eviction,
 	eviction &= EVICTION_MASK;
 	eviction = (eviction << MEM_CGROUP_ID_SHIFT) | memcgid;
 	eviction = (eviction << NODES_SHIFT) | pgdat->node_id;
-	eviction = (eviction << 1) | workingset;
+	eviction = (eviction << WORKINGSET_SHIFT) | workingset;
 
 	return xa_mk_value(eviction);
 }
@@ -201,8 +203,8 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 	int memcgid, nid;
 	bool workingset;
 
-	workingset = entry & 1;
-	entry >>= 1;
+	workingset = entry & ((1UL << WORKINGSET_SHIFT) - 1);
+	entry >>= WORKINGSET_SHIFT;
 	nid = entry & ((1UL << NODES_SHIFT) - 1);
 	entry >>= NODES_SHIFT;
 	memcgid = entry & ((1UL << MEM_CGROUP_ID_SHIFT) - 1);
-- 
2.23.0

