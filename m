Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334AB3DA3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbhG2NV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:21:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhG2NVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9643D223CA;
        Thu, 29 Jul 2021 13:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1/J2IKawzQ6YynsjxPysAh3AnMnsb8kH5Q3drk+3fQ=;
        b=ElCeyg2CfKOwB+VE6mxOeI47gCYio5XffieQGXA3wLA/DW3vmuFvcNTwKYNEIS1Ufz0vTo
        OQwPRbluruHqrhDqQhrTx5paThtFBHK5IRUeSym18/+DFvRONKPedeyQ+Iidf+T4aLIwB4
        qcYrd3AOSi/aDsKilzx99g0mFJU7cy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564900;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1/J2IKawzQ6YynsjxPysAh3AnMnsb8kH5Q3drk+3fQ=;
        b=NBujWOQcCLwdc3rnadhy9Fb8qhY5nbEX6ubNg/loB5RfBwS1yMvqjIRAQXacKoBpDn7IK6
        NCKPPkVgZ01LHMCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63BE713AE9;
        Thu, 29 Jul 2021 13:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UMvCF2SrAmF9AwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 13:21:40 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 02/35] mm, slub: allocate private object map for debugfs listings
Date:   Thu, 29 Jul 2021 15:20:59 +0200
Message-Id: <20210729132132.19691-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
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
index 422a61d7bf5f..66795aec6e10 100644
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
@@ -4874,17 +4880,17 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
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
@@ -5811,14 +5817,21 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
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
@@ -5829,12 +5842,13 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 
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

