Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89F33A12F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbhFILmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46968 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbhFILl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F3091FD64;
        Wed,  9 Jun 2021 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZTiZ2krokRZPz74ttwlqY3E9OPfJw2MVLDApZp5kJ0=;
        b=LDp5gkLsDT1plakKx1QbWTNmHjfTbVB/ZEIRrspp9/GdglbQNNmsfwGjZkEpn/Sxy7U7/U
        zy0rjY96XUhFuNvSNBUY45+z6MUydML6SOyuq1HAgqSj1C7hvXRl13bX+p27x0FPiHEk72
        drEpQmA9Kgi6O5+zbkdunga9lqCMy3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZTiZ2krokRZPz74ttwlqY3E9OPfJw2MVLDApZp5kJ0=;
        b=z65b+i1Nn4+r+AFVNc7LKQ3aYAOq7ZlkVGPjGctN+mrDVuLJ9vgCJ260MIpvYEty25LiyI
        O/d/ETQxIENCwTCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 507FE118DD;
        Wed,  9 Jun 2021 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZTiZ2krokRZPz74ttwlqY3E9OPfJw2MVLDApZp5kJ0=;
        b=LDp5gkLsDT1plakKx1QbWTNmHjfTbVB/ZEIRrspp9/GdglbQNNmsfwGjZkEpn/Sxy7U7/U
        zy0rjY96XUhFuNvSNBUY45+z6MUydML6SOyuq1HAgqSj1C7hvXRl13bX+p27x0FPiHEk72
        drEpQmA9Kgi6O5+zbkdunga9lqCMy3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZTiZ2krokRZPz74ttwlqY3E9OPfJw2MVLDApZp5kJ0=;
        b=z65b+i1Nn4+r+AFVNc7LKQ3aYAOq7ZlkVGPjGctN+mrDVuLJ9vgCJ260MIpvYEty25LiyI
        O/d/ETQxIENCwTCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id OPssE3WowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:33 +0000
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
Subject: [RFC v2 10/34] mm, slub: restructure new page checks in ___slab_alloc()
Date:   Wed,  9 Jun 2021 13:38:39 +0200
Message-Id: <20210609113903.1421-11-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
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
index ca7cfc7706cc..0d5c253a39b2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2722,13 +2722,29 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.31.1

