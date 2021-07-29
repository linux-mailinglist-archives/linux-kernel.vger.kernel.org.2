Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DFF3DA3E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbhG2NWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:22:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38420 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbhG2NVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2BC25223D6;
        Thu, 29 Jul 2021 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6VhWY6JuMcwhpuUl6vau38Fqa9T1OGrHlS6+6xuZ1E=;
        b=RY/O1YbfGAgR++RZwP1SuHk53RuWMLKjQbVQmzb2fZaZhjUF35+gTmsd/Ukd8LgYBeUSw7
        6WV07VrUs806TIQ4L652IivEXxTa6owbIf2yHYZ++ntV2h7pW9T/5MdLbtRPLg2ohkAWgC
        cQG/T+uCQp0/PF2gT8D6DxfhhG5bZ0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564902;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6VhWY6JuMcwhpuUl6vau38Fqa9T1OGrHlS6+6xuZ1E=;
        b=TSD9acl5pCe+6x97JYBhWQgwRjdae41SDtt6CGUYdtIZ/UHWvpbawFYSfjI0CKMH/Zr2/0
        rMMiMwELobeMHiDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0F6313AE9;
        Thu, 29 Jul 2021 13:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YDA6OmWrAmF9AwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 13:21:41 +0000
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
Subject: [PATCH v3 10/35] mm, slub: restructure new page checks in ___slab_alloc()
Date:   Thu, 29 Jul 2021 15:21:07 +0200
Message-Id: <20210729132132.19691-11-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we allocate slab object from a newly acquired page (from node's partial
list or page allocator), we usually also retain the page as a new percpu slab.
There are two exceptions - when pfmemalloc status of the page doesn't match our
gfp flags, or when the cache has debugging enabled.

The current code for these decisions is not easy to follow, so restructure it
and add comments. The new structure will also help with the following changes.
No functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/slub.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 92a866adce3d..469aa8155663 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2765,13 +2765,29 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c->page = page;
 
 check_new_page:
-	if (likely(!kmem_cache_debug(s) && pfmemalloc_match(page, gfpflags)))
-		goto load_freelist;
 
-	/* Only entered in the debug case */
-	if (kmem_cache_debug(s) &&
-			!alloc_debug_processing(s, page, freelist, addr))
-		goto new_slab;	/* Slab failed checks. Next slab needed */
+	if (kmem_cache_debug(s)) {
+		if (!alloc_debug_processing(s, page, freelist, addr))
+			/* Slab failed checks. Next slab needed */
+			goto new_slab;
+		else
+			/*
+			 * For debug case, we don't load freelist so that all
+			 * allocations go through alloc_debug_processing()
+			 */
+			goto return_single;
+	}
+
+	if (unlikely(!pfmemalloc_match(page, gfpflags)))
+		/*
+		 * For !pfmemalloc_match() case we don't load freelist so that
+		 * we don't make further mismatched allocations easier.
+		 */
+		goto return_single;
+
+	goto load_freelist;
+
+return_single:
 
 	deactivate_slab(s, page, get_freepointer(s, freelist), c);
 	return freelist;
-- 
2.32.0

