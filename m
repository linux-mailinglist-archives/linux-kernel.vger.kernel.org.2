Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D4D439670
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhJYMjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:39:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29934 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhJYMj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:39:28 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HdDqZ1VkwzbnQQ;
        Mon, 25 Oct 2021 20:32:26 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 20:37:03 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 20:37:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <sj@kernel.org>
Subject: [PATCH -next] mm/damon: fix error return code in damon_reclaim_turn()
Date:   Mon, 25 Oct 2021 20:45:00 +0800
Message-ID: <20211025124500.2758060-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If damon_reclaim_new_scheme() fails, it should return
error code in damon_reclaim_turn()

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 mm/damon/reclaim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index f5ae4c422555..dc1485044eaf 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -292,8 +292,10 @@ static int damon_reclaim_turn(bool on)
 
 	/* Will be freed by 'damon_set_schemes()' below */
 	scheme = damon_reclaim_new_scheme();
-	if (!scheme)
+	if (!scheme) {
+		err = -ENOMEM;
 		goto free_region_out;
+	}
 	err = damon_set_schemes(ctx, &scheme, 1);
 	if (err)
 		goto free_scheme_out;
-- 
2.25.1

