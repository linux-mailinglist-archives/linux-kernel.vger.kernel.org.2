Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3353F4CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhHWO7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:59:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60372 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhHWO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4284A2000A;
        Mon, 23 Aug 2021 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXKBdAz6o/7fiQUwuD+GwNS3u3n/eJ1b+sk3shml2ow=;
        b=Lgzovd8dIoDFdM4Eblvd3uG8fQBZPjh8+UXwajT+62BzynPcptuGx5524uutuGd1X2ViNq
        Kth3dZ2w3uCJJ11B7hPljIJLCGxDgWwjUJb7d+TQ1OfYO/mEOO6mdnY6xxFn3ONb6BkrgI
        6RPisynCKLrnVe8cWjebhuS5oBu9Dw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730718;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXKBdAz6o/7fiQUwuD+GwNS3u3n/eJ1b+sk3shml2ow=;
        b=zYbpjEVSXLHKuKjdEdjRKwiPDjHsDUov4Iq4F52DJQ7k5DQDHYDVWZP2lUUdaIHwARm4kE
        kQ8/BFwii6bGqSDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 171FC13BE1;
        Mon, 23 Aug 2021 14:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0HsiBZ63I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:38 +0000
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
Subject: [PATCH v5 03/35] mm, slub: allocate private object map for validate_slab_cache()
Date:   Mon, 23 Aug 2021 16:57:54 +0200
Message-Id: <20210823145826.3857-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
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
index fb603fdf58cb..4697280130f2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4679,11 +4679,11 @@ static int count_total(struct page *page)
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
 
@@ -4691,21 +4691,20 @@ static void validate_slab(struct kmem_cache *s, struct page *page)
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
@@ -4714,7 +4713,7 @@ static int validate_slab_node(struct kmem_cache *s,
 	spin_lock_irqsave(&n->list_lock, flags);
 
 	list_for_each_entry(page, &n->partial, slab_list) {
-		validate_slab(s, page);
+		validate_slab(s, page, obj_map);
 		count++;
 	}
 	if (count != n->nr_partial) {
@@ -4727,7 +4726,7 @@ static int validate_slab_node(struct kmem_cache *s,
 		goto out;
 
 	list_for_each_entry(page, &n->full, slab_list) {
-		validate_slab(s, page);
+		validate_slab(s, page, obj_map);
 		count++;
 	}
 	if (count != atomic_long_read(&n->nr_slabs)) {
@@ -4746,10 +4745,17 @@ long validate_slab_cache(struct kmem_cache *s)
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
2.32.0

