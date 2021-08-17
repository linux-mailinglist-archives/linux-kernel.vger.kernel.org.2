Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515EC3EEFE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbhHQP6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:58:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60928 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbhHQP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:58:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52C4521FC2;
        Tue, 17 Aug 2021 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629215848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQ8jOXW2jq7FxQ+d387fczFLO3zDIdwXBUFi+y+us68=;
        b=H1PHPVvPYBxUqjbn15147SFP2GpZDTfvoTqwq5dLzmCQZHKpDWE+FByIk1/dZfdr3e7jQW
        ggwl7l+lfza3+gqv1bBKMFfIAGJdWjcvlK0ULCtTb/9sxsfhB1ZiDfpzIE9lPsHiwrh8BG
        hi7W0CiphI7MApEkIydxwLg3YhMYJPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629215848;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQ8jOXW2jq7FxQ+d387fczFLO3zDIdwXBUFi+y+us68=;
        b=qLNAM4Qid9IjsYJ1kcjEpmIqvPfaJo5zBwMZW4FRN6l3sMeof3Il+xpx6FkRrALfzRfdos
        gI2waqtdIElxkaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C7DA13CEA;
        Tue, 17 Aug 2021 15:57:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PbNtH2fcG2FWUwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Aug 2021 15:57:27 +0000
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
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
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-36-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7e9ccf34-57d1-786b-2dfd-3b9ba78e1b32@suse.cz>
Date:   Tue, 17 Aug 2021 17:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805152000.12817-36-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 5:20 PM, Vlastimil Babka wrote:
> Embed local_lock into struct kmem_cpu_slab and use the irq-safe versions of
> local_lock instead of plain local_irq_save/restore. On !PREEMPT_RT that's
> equivalent, with better lockdep visibility. On PREEMPT_RT that means better
> preemption.
> 
> However, the cost on PREEMPT_RT is the loss of lockless fast paths which only
> work with cpu freelist. Those are designed to detect and recover from being
> preempted by other conflicting operations (both fast or slow path), but the
> slow path operations assume they cannot be preempted by a fast path operation,
> which is guaranteed naturally with disabled irqs. With local locks on
> PREEMPT_RT, the fast paths now also need to take the local lock to avoid races.
> 
> In the allocation fastpath slab_alloc_node() we can just defer to the slowpath
> __slab_alloc() which also works with cpu freelist, but under the local lock.
> In the free fastpath do_slab_free() we have to add a new local lock protected
> version of freeing to the cpu freelist, as the existing slowpath only works
> with the page freelist.
> 
> Also update the comment about locking scheme in SLUB to reflect changes done
> by this series.
> 
> [ Mike Galbraith <efault@gmx.de>: use local_lock() without irq in PREEMPT_RT
>   scope; debugging of RT crashes resulting in put_cpu_partial() locking changes ]
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

And improvements in the RT land made the following fixup-cleanup
possible.
----8<----
From 8b87e5de5d79a9d3ab4627f5530f1888fa7824f8 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 17 Aug 2021 17:51:54 +0200
Subject: [PATCH] mm, slab: simplify lockdep_assert_held in
 lockdep_assert_held()

Sebastian reports [1] that the special version of lockdep_assert_held() for a
local lock with PREEMPT_RT is no longer necessary, and we can simplify.

[1] https://lore.kernel.org/linux-mm/20210817153937.hxnuh7mqp6vuiyws@linutronix.de/

This is a fixup for mmotm patch
mm-slub-convert-kmem_cpu_slab-protection-to-local_lock.patch

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index be57687062aa..df1ac8aff86f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2913,11 +2913,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 load_freelist:
 
-#ifdef CONFIG_PREEMPT_RT
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock.lock));
-#else
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
-#endif
 
 	/*
 	 * freelist is pointing to the list of objects to be used.
-- 
2.32.0

