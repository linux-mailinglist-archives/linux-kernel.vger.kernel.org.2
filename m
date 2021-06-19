Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71173AD8F9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 11:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhFSJfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 05:35:00 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7371 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhFSJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 05:34:57 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G6Vpf54kwz6wK5;
        Sat, 19 Jun 2021 17:28:42 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 19
 Jun 2021 17:32:44 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vitalywool@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 1/6] mm/z3fold: define macro NCHUNKS as TOTAL_CHUNKS - ZHDR_CHUNKS
Date:   Sat, 19 Jun 2021 17:31:46 +0800
Message-ID: <20210619093151.1492174-2-linmiaohe@huawei.com>
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

To improve the code readability, we could define macro NCHUNKS as
TOTAL_CHUNKS - ZHDR_CHUNKS. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 56321bf37d56..04d0e493bd2e 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -62,7 +62,7 @@
 #define ZHDR_SIZE_ALIGNED round_up(sizeof(struct z3fold_header), CHUNK_SIZE)
 #define ZHDR_CHUNKS	(ZHDR_SIZE_ALIGNED >> CHUNK_SHIFT)
 #define TOTAL_CHUNKS	(PAGE_SIZE >> CHUNK_SHIFT)
-#define NCHUNKS		((PAGE_SIZE - ZHDR_SIZE_ALIGNED) >> CHUNK_SHIFT)
+#define NCHUNKS		(TOTAL_CHUNKS - ZHDR_CHUNKS)
 
 #define BUDDY_MASK	(0x3)
 #define BUDDY_SHIFT	2
-- 
2.23.0

