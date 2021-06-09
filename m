Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB243A12EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhFILlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:41:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46756 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbhFILl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:27 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E30C81FD4E;
        Wed,  9 Jun 2021 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yIopAqiYKYuUjHruBmtFqmPxVRpqk1W58WY5m3tQOo=;
        b=S79B+ZPYD1ZEeUaxt9hKWMzfTD9TOCTuQo++QSf3MvKDtglnvsOS8/YGbi3Xq0JJ6K6lmW
        dtNx6p12EKQ3My9QOMM53cX1ikrojSZ9U7mnFv7sHMjP04xp6R9yIHmO+Fp8h6njhfUxQ/
        rXeGkSO2barA5BNDxVQ6PPyWVxcH9d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yIopAqiYKYuUjHruBmtFqmPxVRpqk1W58WY5m3tQOo=;
        b=tvWi3K3sT5luoYzW/nK8wj0xXpVpZ8R87g1ey45dq0fCH2nFemnOGde2D5HP1jxG4N3U+L
        BHQF/jdnl506dGCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B6328118DD;
        Wed,  9 Jun 2021 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yIopAqiYKYuUjHruBmtFqmPxVRpqk1W58WY5m3tQOo=;
        b=S79B+ZPYD1ZEeUaxt9hKWMzfTD9TOCTuQo++QSf3MvKDtglnvsOS8/YGbi3Xq0JJ6K6lmW
        dtNx6p12EKQ3My9QOMM53cX1ikrojSZ9U7mnFv7sHMjP04xp6R9yIHmO+Fp8h6njhfUxQ/
        rXeGkSO2barA5BNDxVQ6PPyWVxcH9d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yIopAqiYKYuUjHruBmtFqmPxVRpqk1W58WY5m3tQOo=;
        b=tvWi3K3sT5luoYzW/nK8wj0xXpVpZ8R87g1ey45dq0fCH2nFemnOGde2D5HP1jxG4N3U+L
        BHQF/jdnl506dGCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id sF8ALHOowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:31 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC v2 02/34] mm, slub: allocate private object map for sysfs listings
Date:   Wed,  9 Jun 2021 13:38:31 +0200
Message-Id: <20210609113903.1421-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slub has a static spinlock protected bitmap for marking which objects are on
freelist when it wants to list them, for situations where dynamically
allocating such map can lead to recursion or locking issues, and on-stack
bitmap would be too large.

The handlers of sysfs files alloc_calls and free_calls also currently use this
shared bitmap, but their syscall context makes it straightforward to allocate a
private map before entering locked sections, so switch these processing paths
to use a private bitmap.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Christoph Lameter <cl@linux.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/slub.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f928607230b2..92c3ab3a95ba 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -448,6 +448,18 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
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
 /*
  * Determine a map of object in use on a page.
  *
@@ -457,17 +469,11 @@ static DEFINE_SPINLOCK(object_map_lock);
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
@@ -4813,17 +4819,17 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
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
 
 static int list_locations(struct kmem_cache *s, char *buf,
@@ -4834,9 +4840,15 @@ static int list_locations(struct kmem_cache *s, char *buf,
 	struct loc_track t = { 0, 0, NULL };
 	int node;
 	struct kmem_cache_node *n;
+	unsigned long *obj_map;
+
+	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
+	if (!obj_map)
+		return sysfs_emit(buf, "Out of memory\n");
 
 	if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
 			     GFP_KERNEL)) {
+		bitmap_free(obj_map);
 		return sysfs_emit(buf, "Out of memory\n");
 	}
 
@@ -4849,12 +4861,14 @@ static int list_locations(struct kmem_cache *s, char *buf,
 
 		spin_lock_irqsave(&n->list_lock, flags);
 		list_for_each_entry(page, &n->partial, slab_list)
-			process_slab(&t, s, page, alloc);
+			process_slab(&t, s, page, alloc, obj_map);
 		list_for_each_entry(page, &n->full, slab_list)
-			process_slab(&t, s, page, alloc);
+			process_slab(&t, s, page, alloc, obj_map);
 		spin_unlock_irqrestore(&n->list_lock, flags);
 	}
 
+	bitmap_free(obj_map);
+
 	for (i = 0; i < t.count; i++) {
 		struct location *l = &t.loc[i];
 
-- 
2.31.1

