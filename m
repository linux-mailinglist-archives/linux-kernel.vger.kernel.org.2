Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24B13A12F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbhFILmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46972 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbhFILl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B0C2F1FD65;
        Wed,  9 Jun 2021 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlrL7OICvBFstNZZ2XJMriwG3NzNdu907jHbbChxuc0=;
        b=CjpVp1rLvDZ8dbeBqHACPad2h/djS+XV2r2Cj3do2Z8zJCcvNb2LUc7OaGw7nz8jSBMrce
        hPm05vums1nTQYrZuX3cyHPuk6MrLNu6uD7Yi8AgBjy1UvKVT2U6fSCoU70yTi2wbXXnJ1
        LQn1zYDMtQEE95DVYNivcrhGabQyBkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlrL7OICvBFstNZZ2XJMriwG3NzNdu907jHbbChxuc0=;
        b=chweC4mL0L1KS071i9+/f0T+CnbFaP0Q3h2vvFwS8OMkyyyELVt2u99fphybzOc8OHFKfP
        if05UsHtBxkDzjBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 8155C11A98;
        Wed,  9 Jun 2021 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlrL7OICvBFstNZZ2XJMriwG3NzNdu907jHbbChxuc0=;
        b=CjpVp1rLvDZ8dbeBqHACPad2h/djS+XV2r2Cj3do2Z8zJCcvNb2LUc7OaGw7nz8jSBMrce
        hPm05vums1nTQYrZuX3cyHPuk6MrLNu6uD7Yi8AgBjy1UvKVT2U6fSCoU70yTi2wbXXnJ1
        LQn1zYDMtQEE95DVYNivcrhGabQyBkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlrL7OICvBFstNZZ2XJMriwG3NzNdu907jHbbChxuc0=;
        b=chweC4mL0L1KS071i9+/f0T+CnbFaP0Q3h2vvFwS8OMkyyyELVt2u99fphybzOc8OHFKfP
        if05UsHtBxkDzjBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id OLEaH3WowGD6XgAALh3uQQ
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
Subject: [RFC v2 11/34] mm, slub: simplify kmem_cache_cpu and tid setup
Date:   Wed,  9 Jun 2021 13:38:40 +0200
Message-Id: <20210609113903.1421-12-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In slab_alloc_node() and do_slab_free() fastpaths we need to guarantee that
our kmem_cache_cpu pointer is from the same cpu as the tid value. Currently
that's done by reading the tid first using this_cpu_read(), then the
kmem_cache_cpu pointer and verifying we read the same tid using the pointer and
plain READ_ONCE().

This can be simplified to just fetching kmem_cache_cpu pointer and then reading
tid using the pointer. That guarantees they are from the same cpu. We don't
need to read the tid using this_cpu_read() because the value will be validated
by this_cpu_cmpxchg_double(), making sure we are on the correct cpu and the
freelist didn't change by anyone preempting us since reading the tid.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/slub.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0d5c253a39b2..6d6a9a69db8a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2822,15 +2822,14 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	 * reading from one cpu area. That does not matter as long
 	 * as we end up on the original cpu again when doing the cmpxchg.
 	 *
-	 * We should guarantee that tid and kmem_cache are retrieved on
-	 * the same cpu. It could be different if CONFIG_PREEMPTION so we need
-	 * to check if it is matched or not.
+	 * We must guarantee that tid and kmem_cache_cpu are retrieved on the
+	 * same cpu. We read first the kmem_cache_cpu pointer and use it to read
+	 * the tid. If we are preempted and switched to another cpu between the
+	 * two reads, it's OK as the two are still associated with the same cpu
+	 * and cmpxchg later will validate the cpu.
 	 */
-	do {
-		tid = this_cpu_read(s->cpu_slab->tid);
-		c = raw_cpu_ptr(s->cpu_slab);
-	} while (IS_ENABLED(CONFIG_PREEMPTION) &&
-		 unlikely(tid != READ_ONCE(c->tid)));
+	c = raw_cpu_ptr(s->cpu_slab);
+	tid = READ_ONCE(c->tid);
 
 	/*
 	 * Irqless object alloc/free algorithm used here depends on sequence
@@ -3104,11 +3103,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	 * data is retrieved via this pointer. If we are on the same cpu
 	 * during the cmpxchg then the free will succeed.
 	 */
-	do {
-		tid = this_cpu_read(s->cpu_slab->tid);
-		c = raw_cpu_ptr(s->cpu_slab);
-	} while (IS_ENABLED(CONFIG_PREEMPTION) &&
-		 unlikely(tid != READ_ONCE(c->tid)));
+	c = raw_cpu_ptr(s->cpu_slab);
+	tid = READ_ONCE(c->tid);
 
 	/* Same with comment on barrier() in slab_alloc_node() */
 	barrier();
-- 
2.31.1

