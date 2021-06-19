Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759873AD8FD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 11:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhFSJfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 05:35:05 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8281 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbhFSJe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 05:34:58 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G6VnS557Hz1BK5R;
        Sat, 19 Jun 2021 17:27:40 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 19
 Jun 2021 17:32:45 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vitalywool@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 3/6] mm/z3fold: remove magic number in z3fold_create_pool()
Date:   Sat, 19 Jun 2021 17:31:48 +0800
Message-ID: <20210619093151.1492174-4-linmiaohe@huawei.com>
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

It's meaningless to pass a magic number 2 to __alloc_percpu() as there is
a minimum alignment size of PCPU_MIN_ALLOC_SIZE (> 2) in it. Also there is
no special alignment requirement for unbuddied. So we could replace this
magic number with nature alignment, i.e. __alignof__(struct list_head), to
improve readability.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index e261e14b7753..988d57c143fd 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1000,7 +1000,8 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
 		goto out_c;
 	spin_lock_init(&pool->lock);
 	spin_lock_init(&pool->stale_lock);
-	pool->unbuddied = __alloc_percpu(sizeof(struct list_head)*NCHUNKS, 2);
+	pool->unbuddied = __alloc_percpu(sizeof(struct list_head) * NCHUNKS,
+					 __alignof__(struct list_head));
 	if (!pool->unbuddied)
 		goto out_pool;
 	for_each_possible_cpu(cpu) {
-- 
2.23.0

