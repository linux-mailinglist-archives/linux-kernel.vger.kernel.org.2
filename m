Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFB13A0CCB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhFIG5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:57:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3807 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFIG5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:57:31 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0Hmz3cS8zWtK4;
        Wed,  9 Jun 2021 14:50:43 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:55:25 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 14:55:24 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>, <dm-devel@redhat.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next v2] dm writecache: use list_move instead of list_del/list_add in dm-writecache.c
Date:   Wed, 9 Jun 2021 15:04:33 +0800
Message-ID: <20210609070433.1323812-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using list_move() instead of list_del() + list_add() in dm-writecache.c.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	CC mailist

 drivers/md/dm-writecache.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index ea9f0d8fff1d..a809a616d691 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1868,15 +1868,13 @@ static void writecache_writeback(struct work_struct *work)
 			if (unlikely(read_original_sector(wc, f) ==
 				     read_original_sector(wc, e))) {
 				BUG_ON(!f->write_in_progress);
-				list_del(&e->lru);
-				list_add(&e->lru, &skipped);
+				list_move(&e->lru, &skipped);
 				cond_resched();
 				continue;
 			}
 		}
 		wc->writeback_size++;
-		list_del(&e->lru);
-		list_add(&e->lru, &wbl.list);
+		list_move(&e->lru, &wbl.list);
 		wbl.size++;
 		e->write_in_progress = true;
 		e->wc_list_contiguous = 1;
@@ -1911,8 +1909,7 @@ static void writecache_writeback(struct work_struct *work)
 			//	break;
 
 			wc->writeback_size++;
-			list_del(&g->lru);
-			list_add(&g->lru, &wbl.list);
+			list_move(&g->lru, &wbl.list);
 			wbl.size++;
 			g->write_in_progress = true;
 			g->wc_list_contiguous = BIO_MAX_VECS;

