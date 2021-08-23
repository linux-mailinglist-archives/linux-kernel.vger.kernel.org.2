Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18863F4CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhHWPBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:01:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60506 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhHWO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 735462000E;
        Mon, 23 Aug 2021 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7C6WkKCP/QfcrOR2kZEz0iLuag1TgZUnlUexFdv3Ms=;
        b=TrE5Ax+GqOBEZ62oO3QwwNMc39lpaPh68C7NPbhre3O1Gky1KzPb+CbpQ/xm6a4ue1bDLE
        lNarGVOT4MB/wLiOQllFWRHozkFOMTW/JdfnvYTMrTDOFiItk12Ew9rDE/SzL9hkWfkLyK
        0oMxVUjfKzQTQ8rzkvIAWjmZpUoeJdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7C6WkKCP/QfcrOR2kZEz0iLuag1TgZUnlUexFdv3Ms=;
        b=ZmzvDnUWFmIWrCNv6drqzvWW5PuOkaxvid+mRTP0Jg5evL54O0rrSRrKbT8LgBLRjn5BI6
        oLhFMf4RNHHQafBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AC7513BE1;
        Mon, 23 Aug 2021 14:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IKavEaG3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:41 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v5 21/35] mm, slub: call deactivate_slab() without disabling irqs
Date:   Mon, 23 Aug 2021 16:58:12 +0200
Message-Id: <20210823145826.3857-22-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
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
index 00a96e9030e5..44c4de4b3755 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2765,8 +2765,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	freelist = c->freelist;
 	c->page = NULL;
 	c->freelist = NULL;
-	deactivate_slab(s, page, freelist);
 	local_irq_restore(flags);
+	deactivate_slab(s, page, freelist);
 
 new_slab:
 
@@ -2834,18 +2834,32 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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

