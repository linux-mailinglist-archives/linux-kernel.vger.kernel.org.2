Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09FC3AD8FB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhFSJfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 05:35:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7493 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbhFSJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 05:34:57 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G6Vqv3qKNzZcvB;
        Sat, 19 Jun 2021 17:29:47 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 19
 Jun 2021 17:32:45 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vitalywool@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 2/6] mm/z3fold: avoid possible underflow in z3fold_alloc()
Date:   Sat, 19 Jun 2021 17:31:47 +0800
Message-ID: <20210619093151.1492174-3-linmiaohe@huawei.com>
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

It is not enough to just make sure the z3fold header is not larger than the
page size. When z3fold header is equal to PAGE_SIZE, we would underflow
when check alloc size against PAGE_SIZE - ZHDR_SIZE_ALIGNED - CHUNK_SIZE
in z3fold_alloc(). Make sure there has remaining spaces for its buddy to
fix this theoretical issue.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
This causes the below checkpatch warning:
WARNING: Comparisons should place the constant on the right side of the
test
#31: FILE: mm/z3fold.c:1812:
+       BUILD_BUG_ON(ZHDR_SIZE_ALIGNED > PAGE_SIZE - CHUNK_SIZE);

But I think the error is false positives as all members are constant.
---
 mm/z3fold.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 04d0e493bd2e..e261e14b7753 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1805,8 +1805,11 @@ static int __init init_z3fold(void)
 {
 	int ret;
 
-	/* Make sure the z3fold header is not larger than the page size */
-	BUILD_BUG_ON(ZHDR_SIZE_ALIGNED > PAGE_SIZE);
+	/*
+	 * Make sure the z3fold header is not larger than the page size and
+	 * there has remaining spaces for its buddy.
+	 */
+	BUILD_BUG_ON(ZHDR_SIZE_ALIGNED > PAGE_SIZE - CHUNK_SIZE);
 	ret = z3fold_mount();
 	if (ret)
 		return ret;
-- 
2.23.0

