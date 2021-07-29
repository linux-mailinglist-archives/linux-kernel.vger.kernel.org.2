Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE36A3DA3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhG2NVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:21:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56670 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbhG2NVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C96BA2003D;
        Thu, 29 Jul 2021 13:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mj1/v9JenLsc1+hCorxYcobvriApan+7FwrmjTMbS+M=;
        b=kNgrKnfRfBx/mX+yvxcCSo9RDfu8Nc6kMIBYVIyImeHv7h9tj/Oc80c4gdHtBdrFJ2houE
        qBg6cF4S4ghmUZYmgjf+cT6rt097FUjdqTEoR0s9ZIIouBaB30k3/braTigSkLFsgb4dqy
        BKWtyg+9uuko6CfpdgcBZ468Uh/2T34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564900;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mj1/v9JenLsc1+hCorxYcobvriApan+7FwrmjTMbS+M=;
        b=Ag8XHghnu9vk9yh5y9PxmVjKToJMcajeu0wwgOF5CXycsE6h7pR4AWuYhQDvumhBssLpWE
        jHAIVF3guSweWsAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9705313AF4;
        Thu, 29 Jul 2021 13:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ODE7JGSrAmF9AwAAMHmgww
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
Subject: [PATCH v3 03/35] mm, slub: allocate private object map for validate_slab_cache()
Date:   Thu, 29 Jul 2021 15:21:00 +0200
Message-Id: <20210729132132.19691-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
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
index 66795aec6e10..743c6b7f8bb1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4674,11 +4674,11 @@ static int count_total(struct page *page)
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
 
@@ -4686,21 +4686,20 @@ static void validate_slab(struct kmem_cache *s, struct page *page)
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
@@ -4709,7 +4708,7 @@ static int validate_slab_node(struct kmem_cache *s,
 	spin_lock_irqsave(&n->list_lock, flags);
 
 	list_for_each_entry(page, &n->partial, slab_list) {
-		validate_slab(s, page);
+		validate_slab(s, page, obj_map);
 		count++;
 	}
 	if (count != n->nr_partial) {
@@ -4722,7 +4721,7 @@ static int validate_slab_node(struct kmem_cache *s,
 		goto out;
 
 	list_for_each_entry(page, &n->full, slab_list) {
-		validate_slab(s, page);
+		validate_slab(s, page, obj_map);
 		count++;
 	}
 	if (count != atomic_long_read(&n->nr_slabs)) {
@@ -4741,10 +4740,17 @@ long validate_slab_cache(struct kmem_cache *s)
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

