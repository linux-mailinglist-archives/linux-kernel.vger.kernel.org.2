Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F553DA3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbhG2NWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:22:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56744 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbhG2NVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93F6B20040;
        Thu, 29 Jul 2021 13:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7D4gi9Ymm/JtjOgio23z86mac5EswQa3LXKOhbrYygA=;
        b=P+uZ6ZoB1uB6S+r6sg08M6pC3HoodN5uPvtF0Vtu/nCQf1C60XCDJtWYl7nQAod7pdzzHo
        W5xnmOCQ9Z3JlHJe7+Wwvun9mRekwFFiOvfh+k9hlbbt9SYRrV96xe2wW9U2Q8OQtmhtF8
        86HipLNdCv1dNkApugHu+r0PAePL7fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7D4gi9Ymm/JtjOgio23z86mac5EswQa3LXKOhbrYygA=;
        b=em0+wF63ecfijpHaGdSCoalSP1FWnGj4TOMOxGq4hcsQxAwl4AKOCAQF+z0Sow3pMN+Qfw
        B6BvNPxYi3TKI3Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6855E13AF4;
        Thu, 29 Jul 2021 13:21:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Li0GGerAmF9AwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 13:21:43 +0000
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
Subject: [PATCH v3 17/35] mm, slub: check new pages with restored irqs
Date:   Thu, 29 Jul 2021 15:21:14 +0200
Message-Id: <20210729132132.19691-18-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on top of the previous patch, re-enable irqs before checking new
pages. alloc_debug_processing() is now called with enabled irqs so we need to
remove VM_BUG_ON(!irqs_disabled()); in check_slab() - there doesn't seem to be
a need for it anyway.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c1a88ad4048b..fe0594b60e93 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -995,8 +995,6 @@ static int check_slab(struct kmem_cache *s, struct page *page)
 {
 	int maxobj;
 
-	VM_BUG_ON(!irqs_disabled());
-
 	if (!PageSlab(page)) {
 		slab_err(s, page, "Not a valid slab page");
 		return 0;
@@ -2772,10 +2770,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	lockdep_assert_irqs_disabled();
 
 	freelist = get_partial(s, gfpflags, node, &page);
+	local_irq_restore(flags);
 	if (freelist)
 		goto check_new_page;
 
-	local_irq_restore(flags);
 	put_cpu_ptr(s->cpu_slab);
 	page = new_slab(s, gfpflags, node);
 	c = get_cpu_ptr(s->cpu_slab);
@@ -2785,7 +2783,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		return NULL;
 	}
 
-	local_irq_save(flags);
 	/*
 	 * No other reference to the page yet so we can
 	 * muck around with it freely without cmpxchg
@@ -2800,7 +2797,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (kmem_cache_debug(s)) {
 		if (!alloc_debug_processing(s, page, freelist, addr)) {
 			/* Slab failed checks. Next slab needed */
-			local_irq_restore(flags);
 			goto new_slab;
 		} else {
 			/*
@@ -2818,6 +2814,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		goto return_single;
 
+	local_irq_save(flags);
 	if (unlikely(c->page))
 		flush_slab(s, c);
 	c->page = page;
@@ -2826,6 +2823,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 return_single:
 
+	local_irq_save(flags);
 	if (unlikely(c->page))
 		flush_slab(s, c);
 	c->page = page;
-- 
2.32.0

