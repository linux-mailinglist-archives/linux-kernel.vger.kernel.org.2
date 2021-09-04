Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97834400AE2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351209AbhIDKvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:51:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41768 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351050AbhIDKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F37120043;
        Sat,  4 Sep 2021 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfHGUcxOtQcpRocYMBeT8o2Jhck+B4VvflfszUTFIlo=;
        b=L8wBa14+6rOBmdxbqli0ZAEKt9XtYziwjLPqQFiZHjnwXYBt0uVSmpdsBeWGwIpfK5JrWH
        vR3H3QJIRTrNy/0aT1rjOPLh/03GY2B+Ht1mTqTli6XHFt9SpmO4d3kCLkxP0ujoz037bp
        76zVwhRm36oQTTLGSydm/CTSRNyYs78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfHGUcxOtQcpRocYMBeT8o2Jhck+B4VvflfszUTFIlo=;
        b=iKrVkmIiNZs5sbxcg8kn7mtq04xuKTxWF/4M8MCxIUIO23zZbCOdeqLGzJZIurq53JnDPx
        NT/j2hyIM+VCFUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35D9C1348A;
        Sat,  4 Sep 2021 10:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oNuQDGJPM2HoUQAAMHmgww
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
Subject: [PATCH v6 06/33] mm, slub: extract get_partial() from new_slab_objects()
Date:   Sat,  4 Sep 2021 12:49:36 +0200
Message-Id: <20210904105003.11688-7-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; h=from:subject; bh=kYxcK2mGmSvDL/oEhPAmYyZKFYaxCLv8j4pwx4P+nVc=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08Vu1Gk0CUPDhgyTeaHd2tVrIAHgUC+VFDy5d8p y45osPKJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPFQAKCRDgIcpz8YmpEPiYB/ 9z/GmUQcFqBuhe+YVBkVJwa3H7gYbISl/qWC7cemv9ov2E/wG3p5f821e1sg3QS0kZ/hrBzeaHUxCS NyAEspLAIcLWT9YQm9MPViS0dQtBIKUGheoFH7VZ9PUXHHse4Qo3FtFjTyAT0L5T7T7kSd5Y5v7mnE jDF86N0iZn8eTH7FMUdXPh2qGtSdCqz6dnXBcnhIwXWmnveOI94dyD7PK/DYOrR8vMx9YkgvicWQxz ysOT8KUb4PBLGR+I9wC2G1Gvb89IvIpCO5aRUVCSCtK3WgIJxyyXjNZzOSl/jqVmdN8rwVU1jkUwPJ I8oBaXZWM+Lqw/Rl+f2/HbHxYR10QJ
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The later patches will need more fine grained control over individual actions
in ___slab_alloc(), the only caller of new_slab_objects(), so this is a first
preparatory step with no functional change.

This adds a goto label that appears unnecessary at this point, but will be
useful for later changes.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Christoph Lameter <cl@linux.com>
---
 mm/slub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 79e53303844c..cd6aeeec4417 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2613,17 +2613,12 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 static inline void *new_slab_objects(struct kmem_cache *s, gfp_t flags,
 			int node, struct kmem_cache_cpu **pc)
 {
-	void *freelist;
+	void *freelist = NULL;
 	struct kmem_cache_cpu *c = *pc;
 	struct page *page;
 
 	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
 
-	freelist = get_partial(s, flags, node, c);
-
-	if (freelist)
-		return freelist;
-
 	page = new_slab(s, flags, node);
 	if (page) {
 		c = raw_cpu_ptr(s->cpu_slab);
@@ -2787,6 +2782,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto redo;
 	}
 
+	freelist = get_partial(s, gfpflags, node, c);
+	if (freelist)
+		goto check_new_page;
+
 	freelist = new_slab_objects(s, gfpflags, node, &c);
 
 	if (unlikely(!freelist)) {
@@ -2794,6 +2793,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		return NULL;
 	}
 
+check_new_page:
 	page = c->page;
 	if (likely(!kmem_cache_debug(s) && pfmemalloc_match(page, gfpflags)))
 		goto load_freelist;
-- 
2.33.0

