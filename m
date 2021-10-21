Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEB7435D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhJUIld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:41:33 -0400
Received: from mx22.baidu.com ([220.181.50.185]:43244 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231491AbhJUIl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:41:28 -0400
Received: from BJHW-Mail-Ex09.internal.baidu.com (unknown [10.127.64.32])
        by Forcepoint Email with ESMTPS id 300F11A63D338FBF8652;
        Thu, 21 Oct 2021 16:39:12 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex09.internal.baidu.com (10.127.64.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 16:39:12 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 16:39:11 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dm writecache: Make use of the helper macro kthread_run()
Date:   Thu, 21 Oct 2021 16:39:09 +0800
Message-ID: <20211021083910.1971-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex09_2021-10-21 16:39:12:212
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repalce kthread_create/wake_up_process() with kthread_run()
to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/md/dm-writecache.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 017806096b91..4b8991cde223 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2264,14 +2264,13 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 	raw_spin_lock_init(&wc->endio_list_lock);
 	INIT_LIST_HEAD(&wc->endio_list);
-	wc->endio_thread = kthread_create(writecache_endio_thread, wc, "writecache_endio");
+	wc->endio_thread = kthread_run(writecache_endio_thread, wc, "writecache_endio");
 	if (IS_ERR(wc->endio_thread)) {
 		r = PTR_ERR(wc->endio_thread);
 		wc->endio_thread = NULL;
 		ti->error = "Couldn't spawn endio thread";
 		goto bad;
 	}
-	wake_up_process(wc->endio_thread);
 
 	/*
 	 * Parse the mode (pmem or ssd)
@@ -2493,14 +2492,13 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		wc->memory_map_size -= (uint64_t)wc->start_sector << SECTOR_SHIFT;
 
 		bio_list_init(&wc->flush_list);
-		wc->flush_thread = kthread_create(writecache_flush_thread, wc, "dm_writecache_flush");
+		wc->flush_thread = kthread_run(writecache_flush_thread, wc, "dm_writecache_flush");
 		if (IS_ERR(wc->flush_thread)) {
 			r = PTR_ERR(wc->flush_thread);
 			wc->flush_thread = NULL;
 			ti->error = "Couldn't spawn flush thread";
 			goto bad;
 		}
-		wake_up_process(wc->flush_thread);
 
 		r = calculate_memory_size(wc->memory_map_size, wc->block_size,
 					  &n_blocks, &n_metadata_blocks);
-- 
2.25.1

