Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4953A12EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbhFILlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:41:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54592 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbhFILl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:27 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1FA57219D8;
        Wed,  9 Jun 2021 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ep08mPuIvp4EJCRoqvQdo5MzcdTX3TMZH7zztWTIia0=;
        b=R7fnjYimc679BHUpiF6s6n+TndfMlmv3in5YbEsoWvVbtrIM3mjnwQ/JN6gj05Fd5zjfp1
        b+agQmoPzJei/HQeYdPB/oxCe6bPVSDgBxvpb3Q4JP5IUa7uG3tL2EIFicdbX+qw+uwrzP
        8hDpPUNN5Ifpc7fnGC5vMWLyc/JIxtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ep08mPuIvp4EJCRoqvQdo5MzcdTX3TMZH7zztWTIia0=;
        b=oWylKST498T94BiWwVY8PKNnX8opFCzB2faYnQDQdhR/HtEaAKADRTehjawfbaToeq/Yzp
        hG5pC1E5+QpdPQBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E509A11A98;
        Wed,  9 Jun 2021 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ep08mPuIvp4EJCRoqvQdo5MzcdTX3TMZH7zztWTIia0=;
        b=R7fnjYimc679BHUpiF6s6n+TndfMlmv3in5YbEsoWvVbtrIM3mjnwQ/JN6gj05Fd5zjfp1
        b+agQmoPzJei/HQeYdPB/oxCe6bPVSDgBxvpb3Q4JP5IUa7uG3tL2EIFicdbX+qw+uwrzP
        8hDpPUNN5Ifpc7fnGC5vMWLyc/JIxtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ep08mPuIvp4EJCRoqvQdo5MzcdTX3TMZH7zztWTIia0=;
        b=oWylKST498T94BiWwVY8PKNnX8opFCzB2faYnQDQdhR/HtEaAKADRTehjawfbaToeq/Yzp
        hG5pC1E5+QpdPQBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id gPl2N3OowGD6XgAALh3uQQ
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
Subject: [RFC v2 03/34] mm, slub: allocate private object map for validate_slab_cache()
Date:   Wed,  9 Jun 2021 13:38:32 +0200
Message-Id: <20210609113903.1421-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

validate_slab_cache() is called either to handle a sysfs write, or from a
self-test context. In both situations it's straightforward to preallocate a
private object bitmap instead of grabbing the shared static one meant for
critical sections, so let's do that.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Christoph Lameter <cl@linux.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/slub.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 92c3ab3a95ba..5a940bd3cebb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4622,11 +4622,11 @@ static int count_total(struct page *page)
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
-static void validate_slab(struct kmem_cache *s, struct page *page)
+static void validate_slab(struct kmem_cache *s, struct page *page,
+			  unsigned long *obj_map)
 {
 	void *p;
 	void *addr = page_address(page);
-	unsigned long *map;
 
 	slab_lock(page);
 
@@ -4634,21 +4634,20 @@ static void validate_slab(struct kmem_cache *s, struct page *page)
 		goto unlock;
 
 	/* Now we know that a valid freelist exists */
-	map = get_map(s, page);
+	__fill_map(obj_map, s, page);
 	for_each_object(p, s, addr, page->objects) {
-		u8 val = test_bit(__obj_to_index(s, addr, p), map) ?
+		u8 val = test_bit(__obj_to_index(s, addr, p), obj_map) ?
 			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
 
 		if (!check_object(s, page, p, val))
 			break;
 	}
-	put_map(map);
 unlock:
 	slab_unlock(page);
 }
 
 static int validate_slab_node(struct kmem_cache *s,
-		struct kmem_cache_node *n)
+		struct kmem_cache_node *n, unsigned long *obj_map)
 {
 	unsigned long count = 0;
 	struct page *page;
@@ -4657,7 +4656,7 @@ static int validate_slab_node(struct kmem_cache *s,
 	spin_lock_irqsave(&n->list_lock, flags);
 
 	list_for_each_entry(page, &n->partial, slab_list) {
-		validate_slab(s, page);
+		validate_slab(s, page, obj_map);
 		count++;
 	}
 	if (count != n->nr_partial)
@@ -4668,7 +4667,7 @@ static int validate_slab_node(struct kmem_cache *s,
 		goto out;
 
 	list_for_each_entry(page, &n->full, slab_list) {
-		validate_slab(s, page);
+		validate_slab(s, page, obj_map);
 		count++;
 	}
 	if (count != atomic_long_read(&n->nr_slabs))
@@ -4685,10 +4684,17 @@ static long validate_slab_cache(struct kmem_cache *s)
 	int node;
 	unsigned long count = 0;
 	struct kmem_cache_node *n;
+	unsigned long *obj_map;
+
+	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
+	if (!obj_map)
+		return -ENOMEM;
 
 	flush_all(s);
 	for_each_kmem_cache_node(s, node, n)
-		count += validate_slab_node(s, n);
+		count += validate_slab_node(s, n, obj_map);
+
+	bitmap_free(obj_map);
 
 	return count;
 }
-- 
2.31.1

