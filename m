Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BD400AE1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351195AbhIDKvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:51:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59694 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351052AbhIDKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 88BC72268B;
        Sat,  4 Sep 2021 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rypmWzsNyLskC77AhW0nCBqnLzNqLTdMnECuscxL/JI=;
        b=D0Zxr9cphUYEkq1rOKZbw9RzRatvpPe27BvGr6PU7AmxwsVpmwEUT5ZcDbYf/ULQTTB6VE
        e8257F6BTyrKo3ujAa2FFNreOr3SY/VNN3NIZ8Ax0Zwahknnro0jHIYGyQehxwfneXWt+q
        uGVEI1KVoHdNInmYrpnuDKuN7A3C6ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rypmWzsNyLskC77AhW0nCBqnLzNqLTdMnECuscxL/JI=;
        b=PYdBGk5lik6kSnQyfbS1SeWgb7k9ulwatV9DWhbsxD+IrRXQvCkPXkTVp4gPb/efz+HUxE
        pbMjQiVAda6jykCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6180013A2C;
        Sat,  4 Sep 2021 10:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0AoxF2JPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:10 +0000
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
Subject: [PATCH v6 07/33] mm, slub: dissolve new_slab_objects() into ___slab_alloc()
Date:   Sat,  4 Sep 2021 12:49:37 +0200
Message-Id: <20210904105003.11688-8-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2827; h=from:subject; bh=Xs/v1BbaCn3vaJDzGz3xUHY0BoofGADNQ+HnnzPzljw=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08Y8K+EjUceWQjA1qRLrolcFIayiVJbiSbaz/Hl RQhb+9qJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPGAAKCRDgIcpz8YmpEC2gCA Cj0i/IZKb7yzfo/Pfwct+/5ELHv68cG3cuL6LUmkMeUlRFX6EDh7MIDFWJDG3zFBQ2pmp4WJTj2K4p o2XNAEhfGPrbFSakUnjj6HjL1CDYHXu4Nw9lEjQrAs8upfXTQlMGa2whuyZzV6qwvdjRtvBGDOVWhM m/HzgYAF+Mvu3NT7qTJXAmgmoOj1gQBxWSj1Fgpd5tZL83FKTBsO/zZy2JMftnNEpm+jbtBzOe8hKF /wj9UrTfI3VofvOMRgnaxYr8WPo66yBgrDoKCJThQXkCowzLPmLmNg4C4E7JThL/9yHqZjyzTxSwIv nOuH5ltNKWTqEm8ElsBJZzAN5r80o/
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The later patches will need more fine grained control over individual actions
in ___slab_alloc(), the only caller of new_slab_objects(), so dissolve it
there. This is a preparatory step with no functional change.

The only minor change is moving WARN_ON_ONCE() for using a constructor together
with __GFP_ZERO to new_slab(), which makes it somewhat less frequent, but still
able to catch a development change introducing a systematic misuse.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Christoph Lameter <cl@linux.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/slub.c | 50 ++++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index cd6aeeec4417..0c645b0e96d9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1885,6 +1885,8 @@ static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags = kmalloc_fix_flags(flags);
 
+	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
+
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
 }
@@ -2610,36 +2612,6 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 #endif
 }
 
-static inline void *new_slab_objects(struct kmem_cache *s, gfp_t flags,
-			int node, struct kmem_cache_cpu **pc)
-{
-	void *freelist = NULL;
-	struct kmem_cache_cpu *c = *pc;
-	struct page *page;
-
-	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
-
-	page = new_slab(s, flags, node);
-	if (page) {
-		c = raw_cpu_ptr(s->cpu_slab);
-		if (c->page)
-			flush_slab(s, c);
-
-		/*
-		 * No other reference to the page yet so we can
-		 * muck around with it freely without cmpxchg
-		 */
-		freelist = page->freelist;
-		page->freelist = NULL;
-
-		stat(s, ALLOC_SLAB);
-		c->page = page;
-		*pc = c;
-	}
-
-	return freelist;
-}
-
 static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags)
 {
 	if (unlikely(PageSlabPfmemalloc(page)))
@@ -2786,13 +2758,27 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (freelist)
 		goto check_new_page;
 
-	freelist = new_slab_objects(s, gfpflags, node, &c);
+	page = new_slab(s, gfpflags, node);
 
-	if (unlikely(!freelist)) {
+	if (unlikely(!page)) {
 		slab_out_of_memory(s, gfpflags, node);
 		return NULL;
 	}
 
+	c = raw_cpu_ptr(s->cpu_slab);
+	if (c->page)
+		flush_slab(s, c);
+
+	/*
+	 * No other reference to the page yet so we can
+	 * muck around with it freely without cmpxchg
+	 */
+	freelist = page->freelist;
+	page->freelist = NULL;
+
+	stat(s, ALLOC_SLAB);
+	c->page = page;
+
 check_new_page:
 	page = c->page;
 	if (likely(!kmem_cache_debug(s) && pfmemalloc_match(page, gfpflags)))
-- 
2.33.0

