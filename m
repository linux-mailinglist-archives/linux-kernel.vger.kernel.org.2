Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE403A12FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbhFILml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47072 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbhFILla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:30 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E25B21FD6A;
        Wed,  9 Jun 2021 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=volf3/1v2fagmByxx16yvJir7+qLZbMW6i+3I7p6Sqc=;
        b=lr54bFG1gI4xnJeu9xxylzjCxMUOqNqFn/br4xXHq81J69rcBsj28VivKVSEAEArKZDAqs
        h4rhgbwAeCs851IARKYZ+p4ZCItRK5L6PHtYZxVglhNAxtFCxN+fYOeSoYthoCHh6aWBOj
        JWWQgmM/g94TpKtwJNw/LbxsKiSgcVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=volf3/1v2fagmByxx16yvJir7+qLZbMW6i+3I7p6Sqc=;
        b=wA99Gg5Pd7WMagaeXluGX6o8cRtQqRLxmU2ZtrWMN2q8RXGYk1MIWLpRajaR3MkBkyPGrN
        cG2wR3V0vN3R36Cg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B391D11A98;
        Wed,  9 Jun 2021 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=volf3/1v2fagmByxx16yvJir7+qLZbMW6i+3I7p6Sqc=;
        b=lr54bFG1gI4xnJeu9xxylzjCxMUOqNqFn/br4xXHq81J69rcBsj28VivKVSEAEArKZDAqs
        h4rhgbwAeCs851IARKYZ+p4ZCItRK5L6PHtYZxVglhNAxtFCxN+fYOeSoYthoCHh6aWBOj
        JWWQgmM/g94TpKtwJNw/LbxsKiSgcVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=volf3/1v2fagmByxx16yvJir7+qLZbMW6i+3I7p6Sqc=;
        b=wA99Gg5Pd7WMagaeXluGX6o8cRtQqRLxmU2ZtrWMN2q8RXGYk1MIWLpRajaR3MkBkyPGrN
        cG2wR3V0vN3R36Cg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ONReK3aowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:34 +0000
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
Subject: [RFC v2 17/34] mm, slub: check new pages with restored irqs
Date:   Wed,  9 Jun 2021 13:38:46 +0200
Message-Id: <20210609113903.1421-18-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
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
index 378f1cb040b3..760080b58957 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -954,8 +954,6 @@ static int check_slab(struct kmem_cache *s, struct page *page)
 {
 	int maxobj;
 
-	VM_BUG_ON(!irqs_disabled());
-
 	if (!PageSlab(page)) {
 		slab_err(s, page, "Not a valid slab page");
 		return 0;
@@ -2729,10 +2727,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	lockdep_assert_irqs_disabled();
 
 	freelist = get_partial(s, gfpflags, node, &page);
+	local_irq_restore(flags);
 	if (freelist)
 		goto check_new_page;
 
-	local_irq_restore(flags);
 	put_cpu_ptr(s->cpu_slab);
 	page = new_slab(s, gfpflags, node);
 	c = get_cpu_ptr(s->cpu_slab);
@@ -2742,7 +2740,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		return NULL;
 	}
 
-	local_irq_save(flags);
 	/*
 	 * No other reference to the page yet so we can
 	 * muck around with it freely without cmpxchg
@@ -2757,7 +2754,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (kmem_cache_debug(s)) {
 		if (!alloc_debug_processing(s, page, freelist, addr)) {
 			/* Slab failed checks. Next slab needed */
-			local_irq_restore(flags);
 			goto new_slab;
 		} else {
 			/*
@@ -2775,6 +2771,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		goto return_single;
 
+	local_irq_save(flags);
 	if (unlikely(c->page))
 		flush_slab(s, c);
 	c->page = page;
@@ -2783,6 +2780,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 return_single:
 
+	local_irq_save(flags);
 	if (unlikely(c->page))
 		flush_slab(s, c);
 	c->page = page;
-- 
2.31.1

