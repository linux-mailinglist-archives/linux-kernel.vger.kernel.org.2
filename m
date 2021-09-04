Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022CC400AEA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351250AbhIDKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59828 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351115AbhIDKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1661322693;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mUlsuwJHAvWrWwqdtLB62kmN3qgv5TJrxQ2cxDjcmE=;
        b=BBSUyAXX5kguKuXcpd4Zj1oL/He0ejBI+SXoza9DHncYVVNpjlTy9zGdJdcZDBpta6SpJk
        ISDdoW5N3ioBayQOzVgjcFK9vco1QLOAq8ldv952sAuyKIFR4u/5PzYlig6Z6uHCLhy5UK
        +w5UH01Xmb9r4j7EAXB+GQldAAZBVLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mUlsuwJHAvWrWwqdtLB62kmN3qgv5TJrxQ2cxDjcmE=;
        b=YrY9Y4GaOV9p7Pgd7d7+0I31YZxo9L2gLFiZ+N4X/ZC+notpR3SH91NoAFRxu8aRVmG/iN
        YbR+aa+M8dweV9Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E244713A2C;
        Sat,  4 Sep 2021 10:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qD6hNmNPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:11 +0000
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
Subject: [PATCH v6 15/33] mm, slub: validate slab from partial list or page allocator before making it cpu slab
Date:   Sat,  4 Sep 2021 12:49:45 +0200
Message-Id: <20210904105003.11688-16-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080; h=from:subject; bh=6RMKkRPIFqUauCH8SJwma9svu+hJUqHG71X1n1a6wH8=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08tI9N51RCa6f2o+EKv7HZaeUBnieZWGaRsW7io r6kzmKKJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPLQAKCRDgIcpz8YmpEFWHB/ oCpGr5YOouRz5tfSzXgWhHJK8AbYmNHL3IL9+OF0nrlOp91ELjXLFYcblzjoNzKoxjM7f8BWiVsA2P gdKi8lXtY+w0Bhl6l86tgO4reK1Gy9o6P5+Uwo4e0LcBV0ujx+h2pOkTNeD6PkEFcTf+FtiRs+Q6T2 GvwOHRh9hvoNiyHKbuoQJOXXjpjB1j/EiEwfjbp7VfCTx4d+XZGRZAfvlrCNcZoNx2ikR7baf1uiQ1 u9YQGAHLotozScAnM33PIrBzZr89vCYEPrIx4eac+MfaYnGNSdLt2sS3+v61oOLfWuQOqkb3PP/oIA PzpItUyBr1HK0LhAVIyH6F6T+2BsNw
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we obtain a new slab page from node partial list or page allocator, we
assign it to kmem_cache_cpu, perform some checks, and if they fail, we undo
the assignment.

In order to allow doing the checks without irq disabled, restructure the code
so that the checks are done first, and kmem_cache_cpu.page assignment only
after they pass.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7798ba1c614f..a5e974defcb7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2802,10 +2802,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	lockdep_assert_irqs_disabled();
 
 	freelist = get_partial(s, gfpflags, node, &page);
-	if (freelist) {
-		c->page = page;
+	if (freelist)
 		goto check_new_page;
-	}
 
 	local_irq_restore(flags);
 	put_cpu_ptr(s->cpu_slab);
@@ -2818,9 +2816,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	}
 
 	local_irq_save(flags);
-	if (c->page)
-		flush_slab(s, c);
-
 	/*
 	 * No other reference to the page yet so we can
 	 * muck around with it freely without cmpxchg
@@ -2829,14 +2824,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	page->freelist = NULL;
 
 	stat(s, ALLOC_SLAB);
-	c->page = page;
 
 check_new_page:
 
 	if (kmem_cache_debug(s)) {
 		if (!alloc_debug_processing(s, page, freelist, addr)) {
 			/* Slab failed checks. Next slab needed */
-			c->page = NULL;
 			local_irq_restore(flags);
 			goto new_slab;
 		} else {
@@ -2855,10 +2848,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		goto return_single;
 
+	if (unlikely(c->page))
+		flush_slab(s, c);
+	c->page = page;
+
 	goto load_freelist;
 
 return_single:
 
+	if (unlikely(c->page))
+		flush_slab(s, c);
+	c->page = page;
+
 	deactivate_slab(s, page, get_freepointer(s, freelist), c);
 	local_irq_restore(flags);
 	return freelist;
-- 
2.33.0

