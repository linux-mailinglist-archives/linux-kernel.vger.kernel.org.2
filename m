Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0505400AE3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351220AbhIDKvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:51:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41794 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351089AbhIDKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF17520044;
        Sat,  4 Sep 2021 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VoLeY7+Afh9ZsA0cNFKiMXjj0drfqsWveV98Vysevbg=;
        b=2fF62YLk7YC+bAb0nPZRwt0YxwwxQZdGVQStYVQQVAIP6f0Aa88P4CgGiwByBgmfbXNTJ2
        toUbgOXThELdFOIMpYiL75hM48hWWay5siEMT+nVwdNT9vbuglJnRfojbYGE14R3TTntpE
        YBsyO8LwtW0y5xENg1C6aU9nv0a8I7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VoLeY7+Afh9ZsA0cNFKiMXjj0drfqsWveV98Vysevbg=;
        b=JZqlwOzIno7o+2BlexDjOVfc5W3Mn+2L3Ec006p6RC5os8DAP1JE8TqUqwA1sG8VkJBMVO
        oLeorT1lY2MplaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B545713A2C;
        Sat,  4 Sep 2021 10:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sM6vK2JPM2HoUQAAMHmgww
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
Subject: [PATCH v6 09/33] mm, slub: restructure new page checks in ___slab_alloc()
Date:   Sat,  4 Sep 2021 12:49:39 +0200
Message-Id: <20210904105003.11688-10-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; h=from:subject; bh=cTI28CzoWvLSfFayxzYm7bnXwtvYONmwMSO/dMD+k9Y=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08dw3VbU8f/S9qM3NoZnUyP9HUuUrw1ci/9KFa6 4HUwRI2JATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPHQAKCRDgIcpz8YmpED6LCA CUXfBIWK3C5femaiBytbdi9JRjQIZpgV//CwmiHknD6r8H+wMLPSQ+IS5s4/Il5Jqocj5OdwKO4l6F ZAWjq+1/aJfL4M3775HeJ5ugfSkyzKHrNWieQxWkvnnUrK0E8ZOk/0EWRsO+fnFcAEopfZac/bDxLA I2EoIGessG6x08tqZPVOAy6KzuDd5EoSTYWvLSO3aAe+fqMZ5BCISsTfU++X3HxUZBs4b+jwB3abOF n0/7Eg4fFlRdjMPyPFP5o/zE8sh6sCT0VPrq6rl7TvqES8ArVOtQEByIlgM6HuV3MePK90KvScx7Fg oenaCKc+otjPS6dGJJaK0chHdW9Rxs
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
index e9d582eee7d7..9607ce37e661 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2782,13 +2782,29 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.33.0

