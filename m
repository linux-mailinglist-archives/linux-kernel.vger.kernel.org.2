Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1063F4CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhHWO7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:59:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60338 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhHWO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1686220009;
        Mon, 23 Aug 2021 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywpqepUgy/Rz6MTdGigVCOR/VtCNeGcEfMKJU4z/L9Q=;
        b=psnXgLusa8d+4Ln6u0fs4tAC/BWI14xusUrbpRNNQ80f2yxJDdjV1p13Yuv3CT+n+9uCz8
        Et4oW0HLA1N0Y4UMgnuChgx2K1yFdI3aeOq75PJWS51KfCbAZUaM8UTRt2mn+aI0OuwOtP
        fhRycnVTBorug/x4QECwYqZzlqnlju8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730718;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywpqepUgy/Rz6MTdGigVCOR/VtCNeGcEfMKJU4z/L9Q=;
        b=GhrBClxgT/g5IuCGGGgRzRcX+Gjp2ajt2k7xWiAyJXXTpT4/pi/y9bnvH9K0ArOs9sCkno
        zt4BiYr9uHHZxfAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFC5113BE0;
        Mon, 23 Aug 2021 14:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MPQJNp23I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:37 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v5 02/35] mm, slub: allocate private object map for debugfs listings
Date:   Mon, 23 Aug 2021 16:57:53 +0200
Message-Id: <20210823145826.3857-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slub has a static spinlock protected bitmap for marking which objects are on
freelist when it wants to list them, for situations where dynamically
allocating such map can lead to recursion or locking issues, and on-stack
bitmap would be too large.

The handlers of debugfs files alloc_traces and free_traces also currently use this
shared bitmap, but their syscall context makes it straightforward to allocate a
private map before entering locked sections, so switch these processing paths
to use a private bitmap.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Christoph Lameter <cl@linux.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/slub.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f6063ec97a55..fb603fdf58cb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -454,6 +454,18 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
 static DEFINE_SPINLOCK(object_map_lock);
 
+static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
+		       struct page *page)
+{
+	void *addr = page_address(page);
+	void *p;
+
+	bitmap_zero(obj_map, page->objects);
+
+	for (p = page->freelist; p; p = get_freepointer(s, p))
+		set_bit(__obj_to_index(s, addr, p), obj_map);
+}
+
 #if IS_ENABLED(CONFIG_KUNIT)
 static bool slab_add_kunit_errors(void)
 {
@@ -483,17 +495,11 @@ static inline bool slab_add_kunit_errors(void) { return false; }
 static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 	__acquires(&object_map_lock)
 {
-	void *p;
-	void *addr = page_address(page);
-
 	VM_BUG_ON(!irqs_disabled());
 
 	spin_lock(&object_map_lock);
 
-	bitmap_zero(object_map, page->objects);
-
-	for (p = page->freelist; p; p = get_freepointer(s, p))
-		set_bit(__obj_to_index(s, addr, p), object_map);
+	__fill_map(object_map, s, page);
 
 	return object_map;
 }
@@ -4879,17 +4885,17 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 }
 
 static void process_slab(struct loc_track *t, struct kmem_cache *s,
-		struct page *page, enum track_item alloc)
+		struct page *page, enum track_item alloc,
+		unsigned long *obj_map)
 {
 	void *addr = page_address(page);
 	void *p;
-	unsigned long *map;
 
-	map = get_map(s, page);
+	__fill_map(obj_map, s, page);
+
 	for_each_object(p, s, addr, page->objects)
-		if (!test_bit(__obj_to_index(s, addr, p), map))
+		if (!test_bit(__obj_to_index(s, addr, p), obj_map))
 			add_location(t, s, get_track(s, p, alloc));
-	put_map(map);
 }
 #endif  /* CONFIG_DEBUG_FS   */
 #endif	/* CONFIG_SLUB_DEBUG */
@@ -5816,14 +5822,21 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 	struct loc_track *t = __seq_open_private(filep, &slab_debugfs_sops,
 						sizeof(struct loc_track));
 	struct kmem_cache *s = file_inode(filep)->i_private;
+	unsigned long *obj_map;
+
+	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
+	if (!obj_map)
+		return -ENOMEM;
 
 	if (strcmp(filep->f_path.dentry->d_name.name, "alloc_traces") == 0)
 		alloc = TRACK_ALLOC;
 	else
 		alloc = TRACK_FREE;
 
-	if (!alloc_loc_track(t, PAGE_SIZE / sizeof(struct location), GFP_KERNEL))
+	if (!alloc_loc_track(t, PAGE_SIZE / sizeof(struct location), GFP_KERNEL)) {
+		bitmap_free(obj_map);
 		return -ENOMEM;
+	}
 
 	for_each_kmem_cache_node(s, node, n) {
 		unsigned long flags;
@@ -5834,12 +5847,13 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 
 		spin_lock_irqsave(&n->list_lock, flags);
 		list_for_each_entry(page, &n->partial, slab_list)
-			process_slab(t, s, page, alloc);
+			process_slab(t, s, page, alloc, obj_map);
 		list_for_each_entry(page, &n->full, slab_list)
-			process_slab(t, s, page, alloc);
+			process_slab(t, s, page, alloc, obj_map);
 		spin_unlock_irqrestore(&n->list_lock, flags);
 	}
 
+	bitmap_free(obj_map);
 	return 0;
 }
 
-- 
2.32.0

