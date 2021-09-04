Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE78400AF2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351354AbhIDKwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41878 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbhIDKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E113320048;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxcPbBzPCQgU+uBxjGU3z+1m86UNQhrPnhaw3+3WQVs=;
        b=YEicRP8FWRu89Ds49FJSO2Q/U1s9fXcVzebgy5vo/XD2Z4PuEsJEqWS7N23hb2yRotJ3mu
        yOIfGLPir+JDNcUag6OlIjiEXvLmQQ7ecg/nOGLZUBQiaSDl+BCFIEgBC5njjDsnC7HGdC
        MDFVA6JoCh8M7bBXvgPCam0JbVkvLBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxcPbBzPCQgU+uBxjGU3z+1m86UNQhrPnhaw3+3WQVs=;
        b=5Wf/u8pEtzJKS2w8kuFE/iZhvg5zhpdIWdSkIWSMsG7RFGNg+ZfuwiGLkm49vT2Hz4FZWi
        qP/Kwv9pO8Sa0zCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA9BA1348A;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oIsBLWRPM2HoUQAAMHmgww
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
Subject: [PATCH v6 20/33] mm, slub: call deactivate_slab() without disabling irqs
Date:   Sat,  4 Sep 2021 12:49:50 +0200
Message-Id: <20210904105003.11688-21-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; h=from:subject; bh=IqPKvbtKPB28IqQYKvtPPfxPfR0/j0o7jqdB9gktbf0=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM084A0IrVxqUi/T2Tt3uE2aAXqGkNAiZJnnCyi04 zk5VpSOJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPOAAKCRDgIcpz8YmpEMcFB/ 9W2hTCTffZBzGoVZIgWuJR+tOGvhJbiAQrCZYLjtIHgXoF2S9LjfOaz/deESoORgJAfYlrc7K/8ciE R4zRPTDroc+NaZV9CjB2pbnKscBQXzBzMejNEETXNI+jJMKao/JJSRZCTJIlb6vuStsit9CkUFsvZj E129Nsfql9wTP5+5GfMcDDPmQEkIE9kBaCqb3zw9y/VWo5u8f7m4LqfC045xZ7M7fngtk8QqJWzxSP lghgusjdSAaIKOtLXA749RtsIdVDtKf/SBWhI+Nzj/w/SXErcH7pHq/8yYkAdIoDs1QbZp11EUFXkK dgVVVBwLB7k8xJ0l2ytwna20GLxSsI
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
index 6deb4080ef54..cb12a077c61c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2779,8 +2779,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	freelist = c->freelist;
 	c->page = NULL;
 	c->freelist = NULL;
-	deactivate_slab(s, page, freelist);
 	local_irq_restore(flags);
+	deactivate_slab(s, page, freelist);
 
 new_slab:
 
@@ -2848,18 +2848,32 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.33.0

