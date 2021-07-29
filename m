Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EB33DA3EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhG2NXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:23:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38376 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbhG2NVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5D61B223CA;
        Thu, 29 Jul 2021 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UiCxRMMHMOS5L/ydhMEkZsbsrTOn4byCcROCCC2JXf4=;
        b=PqH1P7qLLkcXKDgXD6IE8BG16RZe41LGnaZXMz9YqjhUYdqHjc+cbQ3PT14w3bmOJ8C+DV
        4uEFcVPFt4SKyvXaAOT5GPrP/sTXoRd9a+rYBFc0wzV5835nhCJDGz+yD13wBq8YXA+659
        h2uf202DQq4LzHjNpIWtqA8lMuJicNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564904;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UiCxRMMHMOS5L/ydhMEkZsbsrTOn4byCcROCCC2JXf4=;
        b=xEo5d3saBi/iGsw59tp8K87J57o+ylSeGBiXGkgb1x6d35m3p3gskxiUoQKHB1E9kmW1qG
        W39TPxCCe4ULtOCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FCAA13AF4;
        Thu, 29 Jul 2021 13:21:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uArTCmirAmF9AwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 13:21:44 +0000
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
Subject: [PATCH v3 21/35] mm, slub: call deactivate_slab() without disabling irqs
Date:   Thu, 29 Jul 2021 15:21:18 +0200
Message-Id: <20210729132132.19691-22-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is now safe to be called with irqs enabled, so move the calls
outside of irq disabled sections.

When called from ___slab_alloc() -> flush_slab() we have irqs disabled, so to
reenable them before deactivate_slab() we need to open-code flush_slab() in
___slab_alloc() and reenable irqs after modifying the kmem_cache_cpu fields.
But that means a IRQ handler meanwhile might have assigned a new page to
kmem_cache_cpu.page so we have to retry the whole check.

The remaining callers of flush_slab() are the IPI handler which has disabled
irqs anyway, and slub_cpu_dead() which will be dealt with in the following
patch.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3d5a2f9371f8..1fdbc2ea8f67 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2749,8 +2749,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	freelist = c->freelist;
 	c->page = NULL;
 	c->freelist = NULL;
-	deactivate_slab(s, page, freelist);
 	local_irq_restore(flags);
+	deactivate_slab(s, page, freelist);
 
 new_slab:
 
@@ -2818,18 +2818,32 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		goto return_single;
 
+retry_load_page:
+
 	local_irq_save(flags);
-	if (unlikely(c->page))
-		flush_slab(s, c);
+	if (unlikely(c->page)) {
+		void *flush_freelist = c->freelist;
+		struct page *flush_page = c->page;
+
+		c->page = NULL;
+		c->freelist = NULL;
+		c->tid = next_tid(c->tid);
+
+		local_irq_restore(flags);
+
+		deactivate_slab(s, flush_page, flush_freelist);
+
+		stat(s, CPUSLAB_FLUSH);
+
+		goto retry_load_page;
+	}
 	c->page = page;
 
 	goto load_freelist;
 
 return_single:
 
-	local_irq_save(flags);
 	deactivate_slab(s, page, get_freepointer(s, freelist));
-	local_irq_restore(flags);
 	return freelist;
 }
 
-- 
2.32.0

