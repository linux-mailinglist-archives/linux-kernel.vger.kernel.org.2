Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B031400AEB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351259AbhIDKwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41836 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351116AbhIDKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F98D20046;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NmCITsu3SjUoR6AqTZy28sgW06XAGWLV/AfP9mGddCA=;
        b=1PpnLh/SWqBUoi9RtqjnoMiMjLZfcoOEDyj5xT2s0DXFtOV02HRRiA0p7WUxpJLqzSoryn
        sE97fyOqHnaqjHA7GgtTv9cfxr0/mjupGB2E9hgKsOc33egj3/q8JyeBhs7GssHP0WOz8p
        zZX3MWpS/4ZcipMw886mPlaci6hLjjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NmCITsu3SjUoR6AqTZy28sgW06XAGWLV/AfP9mGddCA=;
        b=OaOvdZssdkoOtuPEGyK3rbPwkE+mMQw+eSQxJzjJTLiqOp7UPqBZ3GXgkx1ZCu94FMOjUM
        ptf1oqs4XaqHcxBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 195491348A;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MCJYBWRPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:12 +0000
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
Subject: [PATCH v6 16/33] mm, slub: check new pages with restored irqs
Date:   Sat,  4 Sep 2021 12:49:46 +0200
Message-Id: <20210904105003.11688-17-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; h=from:subject; bh=6PfVUQ9fHnkZFv9ywprYkU5t2Vrw+oeI2/lA/L05Ycg=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08vAbj488LLXmmHxAEHbyV3kkkeypGWP5xWVuVG +l+FEMWJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPLwAKCRDgIcpz8YmpENquB/ wMn5QModcRNAD5rl6KEHc/RjhpBsjOVloHUjIO1MTP+tsnaQjUP6AHbtq2KoA4HKuU1Oxl0jNx/gmY koDyl+S6lZSovti3fDo/NDk/Pw82Vy3yC4J2FSEkM3BdG0wo3kSdT9YDPfWkRVxuFfk/qGiYJwFUfT D6C1MkR9OvtKFPPx1zc7q98O2eh6XPWedjVsgjH53uywfDdoxXit0dcJPK0fa/RymLzyaMTaEXM66j KmdGKe1ZQ90VmejzV42Fu1Ghv4X4JQWicK263yR6y3QGkOg4Bsket4f4dQcoqwtaKr+UTSKxiokf5u 5z72Dz84qgE4M3Lfqcj1RuYRDoQ5GV
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
index a5e974defcb7..b5788040d92e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1009,8 +1009,6 @@ static int check_slab(struct kmem_cache *s, struct page *page)
 {
 	int maxobj;
 
-	VM_BUG_ON(!irqs_disabled());
-
 	if (!PageSlab(page)) {
 		slab_err(s, page, "Not a valid slab page");
 		return 0;
@@ -2802,10 +2800,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	lockdep_assert_irqs_disabled();
 
 	freelist = get_partial(s, gfpflags, node, &page);
+	local_irq_restore(flags);
 	if (freelist)
 		goto check_new_page;
 
-	local_irq_restore(flags);
 	put_cpu_ptr(s->cpu_slab);
 	page = new_slab(s, gfpflags, node);
 	c = get_cpu_ptr(s->cpu_slab);
@@ -2815,7 +2813,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		return NULL;
 	}
 
-	local_irq_save(flags);
 	/*
 	 * No other reference to the page yet so we can
 	 * muck around with it freely without cmpxchg
@@ -2830,7 +2827,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (kmem_cache_debug(s)) {
 		if (!alloc_debug_processing(s, page, freelist, addr)) {
 			/* Slab failed checks. Next slab needed */
-			local_irq_restore(flags);
 			goto new_slab;
 		} else {
 			/*
@@ -2848,6 +2844,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		goto return_single;
 
+	local_irq_save(flags);
 	if (unlikely(c->page))
 		flush_slab(s, c);
 	c->page = page;
@@ -2856,6 +2853,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 return_single:
 
+	local_irq_save(flags);
 	if (unlikely(c->page))
 		flush_slab(s, c);
 	c->page = page;
-- 
2.33.0

