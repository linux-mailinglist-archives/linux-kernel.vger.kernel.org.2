Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A0359259
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhDIDA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhDIDAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:00:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11BBC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=syOuUqYKnemAk3anZgARjuOCKmrkhLXvQq+rfAy8Zlc=; b=dXnhxaUJwjYn6Qj9c2TS65m6Dq
        n1Z6Z6QBz6Jh78YCUNqDMMdpiD0n9GgfIx/My2vgaHK3U5XkJVirrKG9UTRSwOusuwGH5ewZ1g4lS
        bcigFBV4V8kgdwM4LW92WRvBqkolszr5vGMTpH3h2457otT+QqEcaIbaXSlNLEqHdgdps/2gR/SuB
        gBM9V3UQKmTebpV2Lk0Lh9L2vkDEcOzwncQRFQUoqSNbmcw87f0y9vwXuKOSlu1sX76ouvrfuhpi5
        3Tedvq95+fCIP0f/+FsccKAczLQ/azyrV97HnCLaBJhX1HX8Hnx9LPvaGH0pYpcWJKfxBTFG4PWhF
        Vd3ZJp0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhLv-00HGsg-VU; Fri, 09 Apr 2021 02:58:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] zram: Add zram_table_lock
Date:   Fri,  9 Apr 2021 03:51:26 +0100
Message-Id: <20210409025131.4114078-13-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow lockdep to track the zram bit spin locks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/block/zram/zram_drv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cf8deecc39ef..8b678cc6ed21 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -59,20 +59,22 @@ static void zram_free_page(struct zram *zram, size_t index);
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 				u32 index, int offset, struct bio *bio);
 
+static DEFINE_SPLIT_LOCK(zram_table_lock);
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
-	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].flags);
+	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].flags,
+			&zram_table_lock);
 }
 
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
-	bit_spin_lock(ZRAM_LOCK, &zram->table[index].flags);
+	bit_spin_lock(ZRAM_LOCK, &zram->table[index].flags, &zram_table_lock);
 }
 
 static void zram_slot_unlock(struct zram *zram, u32 index)
 {
-	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].flags);
+	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].flags, &zram_table_lock);
 }
 
 static inline bool init_done(struct zram *zram)
-- 
2.30.2

