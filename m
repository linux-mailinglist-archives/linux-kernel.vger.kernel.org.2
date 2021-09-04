Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D75400ADE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351169AbhIDKvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:51:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59624 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbhIDKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F44722684;
        Sat,  4 Sep 2021 10:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITxCAAL4SXwuHPYQguc6W8x3Sm4Ihsgn/MUBOil9JUc=;
        b=xxVrGwjwpQgeGE0RrLoE0kWeplXyQYTNYZAuYAepJptkDcKKrA+16QotFC+ZvNY9m3QGd6
        1hQsMOJ7aAgRWLWU4jTbreaH/PRD+RGdr0PF/u92xlfWtbY+VqFyiLBWhMEMvRPkGqccMp
        nB/XEJq39hFlt2CkTxY1L633cLdgFF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITxCAAL4SXwuHPYQguc6W8x3Sm4Ihsgn/MUBOil9JUc=;
        b=vJ80wD0u1f+FlRMXfbpusQcvj/t9PJ0ScpC8MbX+09jlmveV1ptbQZXLx3XIERyIxUS6pg
        6iwiMohWpa5pw3DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 773DA1348A;
        Sat,  4 Sep 2021 10:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KCyPHGFPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:09 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v6 02/33] mm, slub: allocate private object map for debugfs listings
Date:   Sat,  4 Sep 2021 12:49:32 +0200
Message-Id: <20210904105003.11688-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4107; h=from:subject; bh=yDD5rL6ZzdDujCTvdtzx623dCcV9M2Dg37A4C5ro2cw=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08CJB/81PGbk+hGGYj+nhySDq1zZ6FFCkLO/27G MTCJdtqJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPAgAKCRDgIcpz8YmpEDJRCA Cb35w6QHtuv5coDbTIlt8n3NSVE7DLZgtxBww+Q9RswH+xxyCaaAm4I+eND4O2bEWq8Jr9fOps9SjD WqABY5qnXdrXqXjiX8wemK7WrbmdOVaZJR+O4ugwtxIsj/NgOPz+Bn6Xu8m6oeE+Vf31L22AXwrv6e N84/5/Zv/HH4HYWZh5KGrHggk/gcHmFP2pP1shG4aGMIGtliIrnakMYPEjk5OPYxmPPf4ID0iYQj20 BARAjo5MWoEunH4OL0WzivGyozDqIgC0jAfPaASjUQU+i/1ETo8PEuohGLGhQZIcjVyKxDIbUPc+oF gqrQuY+bijtflod54JfZdQGCPEkhq4
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
2.33.0

