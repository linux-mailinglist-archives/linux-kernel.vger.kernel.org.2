Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFFB356D41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhDGN02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhDGN0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:26:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383E3C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DqU136pMeSOSoQWy+JekLksx4xQgEA4xQQEdIn+mW9I=; b=ALbzOQZnEtgeLdyB5iZsZQif1n
        buwc0AiuUfkH+Aih8T444QdCxn9ZnQEijQ3up10oImhZ5lUCQtxnEXGu5TkoRlHBIG8PN5wGoiQp+
        bmQCu/f+DSBmqPHxdYQetlwcT/T/xTViFpqujBO0dqoR27RgoD5ZpgtrbckFZ3AeH3EkRHT8bIQ4L
        TUvfptJEyN8iTbox1mJ2BLpPSU9i3kKyIf+c7BqxS5h+zfEsJvPNTpfMBEcMZM8S1AwF5pjYFnqaN
        sS47Z5A/bUApTUBSS5QN9dBY21yorn6sl48klESukz1rHP/X/yG4ntCK8lPPF5b+qr+D06Y2SQPi7
        uU9AgXOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lU8BT-00EWKg-51; Wed, 07 Apr 2021 13:25:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dm: Remove dm_vcalloc
Date:   Wed,  7 Apr 2021 14:25:22 +0100
Message-Id: <20210407132523.3460814-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvcalloc or kvmalloc_array instead (depending whether zeroing is
useful).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/md/dm-snap-persistent.c |  6 +++---
 drivers/md/dm-snap.c            |  5 +++--
 drivers/md/dm-table.c           | 30 ++++++------------------------
 include/linux/device-mapper.h   |  5 -----
 4 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index 8e329c3f3a78..8e5775b5bd96 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -596,7 +596,7 @@ static void persistent_dtr(struct dm_exception_store *store)
 	free_area(ps);
 
 	/* Allocated in persistent_read_metadata */
-	vfree(ps->callbacks);
+	kvfree(ps->callbacks);
 
 	kfree(ps);
 }
@@ -621,8 +621,8 @@ static int persistent_read_metadata(struct dm_exception_store *store,
 	 */
 	ps->exceptions_per_area = (ps->store->chunk_size << SECTOR_SHIFT) /
 				  sizeof(struct disk_exception);
-	ps->callbacks = dm_vcalloc(ps->exceptions_per_area,
-				   sizeof(*ps->callbacks));
+	ps->callbacks = kvcalloc(ps->exceptions_per_area,
+				   sizeof(*ps->callbacks), GFP_KERNEL);
 	if (!ps->callbacks)
 		return -ENOMEM;
 
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 11890db71f3f..8f3ad87e6117 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -663,7 +663,8 @@ static int dm_exception_table_init(struct dm_exception_table *et,
 
 	et->hash_shift = hash_shift;
 	et->hash_mask = size - 1;
-	et->table = dm_vcalloc(size, sizeof(struct hlist_bl_head));
+	et->table = kvmalloc_array(size, sizeof(struct hlist_bl_head),
+			GFP_KERNEL);
 	if (!et->table)
 		return -ENOMEM;
 
@@ -689,7 +690,7 @@ static void dm_exception_table_exit(struct dm_exception_table *et,
 			kmem_cache_free(mem, ex);
 	}
 
-	vfree(et->table);
+	kvfree(et->table);
 }
 
 static uint32_t exception_hash(struct dm_exception_table *et, chunk_t chunk)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e5f0f1703c5d..2f38d00d125f 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -94,24 +94,6 @@ static int setup_btree_index(unsigned int l, struct dm_table *t)
 	return 0;
 }
 
-void *dm_vcalloc(unsigned long nmemb, unsigned long elem_size)
-{
-	unsigned long size;
-	void *addr;
-
-	/*
-	 * Check that we're not going to overflow.
-	 */
-	if (nmemb > (ULONG_MAX / elem_size))
-		return NULL;
-
-	size = nmemb * elem_size;
-	addr = vzalloc(size);
-
-	return addr;
-}
-EXPORT_SYMBOL(dm_vcalloc);
-
 /*
  * highs, and targets are managed as dynamic arrays during a
  * table load.
@@ -124,15 +106,15 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
 	/*
 	 * Allocate both the target array and offset array at once.
 	 */
-	n_highs = (sector_t *) dm_vcalloc(num, sizeof(struct dm_target) +
-					  sizeof(sector_t));
+	n_highs = kvcalloc(num, sizeof(struct dm_target) + sizeof(sector_t),
+				GFP_KERNEL);
 	if (!n_highs)
 		return -ENOMEM;
 
 	n_targets = (struct dm_target *) (n_highs + num);
 
 	memset(n_highs, -1, sizeof(*n_highs) * num);
-	vfree(t->highs);
+	kvfree(t->highs);
 
 	t->num_allocated = num;
 	t->highs = n_highs;
@@ -198,7 +180,7 @@ void dm_table_destroy(struct dm_table *t)
 
 	/* free the indexes */
 	if (t->depth >= 2)
-		vfree(t->index[t->depth - 2]);
+		kvfree(t->index[t->depth - 2]);
 
 	/* free the targets */
 	for (i = 0; i < t->num_targets; i++) {
@@ -210,7 +192,7 @@ void dm_table_destroy(struct dm_table *t)
 		dm_put_target_type(tgt->type);
 	}
 
-	vfree(t->highs);
+	kvfree(t->highs);
 
 	/* free the device list */
 	free_devices(&t->devices, t->md);
@@ -1077,7 +1059,7 @@ static int setup_indexes(struct dm_table *t)
 		total += t->counts[i];
 	}
 
-	indexes = (sector_t *) dm_vcalloc(total, (unsigned long) NODE_SIZE);
+	indexes = kvcalloc(total, NODE_SIZE, GFP_KERNEL);
 	if (!indexes)
 		return -ENOMEM;
 
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 5c641f930caf..ff700fb6ce1d 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -574,11 +574,6 @@ struct dm_table *dm_swap_table(struct mapped_device *md,
  */
 void dm_destroy_keyslot_manager(struct blk_keyslot_manager *ksm);
 
-/*
- * A wrapper around vmalloc.
- */
-void *dm_vcalloc(unsigned long nmemb, unsigned long elem_size);
-
 /*-----------------------------------------------------------------
  * Macros.
  *---------------------------------------------------------------*/
-- 
2.30.2

