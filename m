Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E762F3B1144
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 03:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFWBPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 21:15:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5066 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFWBPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 21:15:16 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G8lVr0wx4zXk7B;
        Wed, 23 Jun 2021 09:07:48 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 09:12:58 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 23
 Jun 2021 09:12:57 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dan.carpenter@oracle.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH -next] ubifs: ubifs_gc_start_commit: Fix error check for lp pointer
Date:   Wed, 23 Jun 2021 09:21:46 +0800
Message-ID: <20210623012146.1418360-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treating the NULL pointer returned from ubifs_fast_find_frdi_idx() as
ENOMEM will make ubifs_gc_start_commit() fails, which could make ubifs
read-only. Actually a returned NULL pointer is the termination
condition in while-loop in ubifs_gc_start_commit().

Fixes: c770cd5190ba ("ubifs: fix an IS_ERR() vs NULL check")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/gc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index 7cc22d7317ea..b1f276599b04 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -895,10 +895,6 @@ int ubifs_gc_start_commit(struct ubifs_info *c)
 	/* Record index freeable LEBs for unmapping after commit */
 	while (1) {
 		lp = ubifs_fast_find_frdi_idx(c);
-		if (!lp) {
-			err = -ENOMEM;
-			goto out;
-		}
 		if (!lp)
 			break;
 		idx_gc = kmalloc(sizeof(struct ubifs_gced_idx_leb), GFP_NOFS);
-- 
2.31.1

