Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082073AD8FC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 11:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhFSJfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 05:35:04 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11073 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbhFSJe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 05:34:58 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G6Vqw5jBDzZdyB;
        Sat, 19 Jun 2021 17:29:48 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 19
 Jun 2021 17:32:46 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vitalywool@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 5/6] mm/z3fold: fix potential memory leak in z3fold_destroy_pool()
Date:   Sat, 19 Jun 2021 17:31:50 +0800
Message-ID: <20210619093151.1492174-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210619093151.1492174-1-linmiaohe@huawei.com>
References: <20210619093151.1492174-1-linmiaohe@huawei.com>
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

There is a memoryleak in z3fold_destroy_pool() as it forgets to free_percpu
pool->unbuddied. Call free_percpu for pool->unbuddied to fix this issue.

Fixes: d30561c56f41 ("z3fold: use per-cpu unbuddied lists")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index bab08c08bf19..196d886a3436 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1048,6 +1048,7 @@ static void z3fold_destroy_pool(struct z3fold_pool *pool)
 	destroy_workqueue(pool->compact_wq);
 	destroy_workqueue(pool->release_wq);
 	z3fold_unregister_migration(pool);
+	free_percpu(pool->unbuddied);
 	kfree(pool);
 }
 
-- 
2.23.0

