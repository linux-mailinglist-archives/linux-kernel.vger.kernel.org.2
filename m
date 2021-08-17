Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B160E3EEF4A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbhHQPk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:40:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33142 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238321AbhHQPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:40:12 -0400
Date:   Tue, 17 Aug 2021 17:39:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629214778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VijU9XyWJmgrJnMm1liziV+i68ZEXkpFrVAD78kLVvY=;
        b=srIWTjAHSBKRX4Ko/AoyjMsWogoODmGdhFAuZ9fDrDzwxKS5UwZAQjYP9hTXb2byQF0R0e
        Ghk3RpScGKHLnzAgPm3+pzlEHsR9jPldf626uUglIi753fAb05a43SJ8qeooAWAXcFIMCh
        cHNMh9BLl6UTk4hBjNhIL3EObdkPcKedf8IqiahQNXr9Sy4DP/4mqRxMPcivvcXn75orF3
        XhSRL5jDU2QP6kWL6J8hEZhfn4SR0INvXGIOWlYrXu1HfyqjLmFu68BZoOwuSoATvPx2aL
        LGbPAitILUS1TNMwTab9r7AZxXmb9CtnVv13i8u5BPTN5HWtmKtFW1UNnLW3Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629214778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VijU9XyWJmgrJnMm1liziV+i68ZEXkpFrVAD78kLVvY=;
        b=5YdvNXY8zZaHutR7hCZ2S7eiejzeEkVg4K8AjM98dNRTM/1T2YoVZzf2YqVdME35afRafB
        lRMZNCVDmpzOVQBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
Message-ID: <20210817153937.hxnuh7mqp6vuiyws@linutronix.de>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-36-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210805152000.12817-36-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-05 17:20:00 [+0200], Vlastimil Babka wrote:
> @@ -2849,7 +2891,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  load_freelist:
>  
> -	lockdep_assert_irqs_disabled();
> +#ifdef CONFIG_PREEMPT_RT
> +	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock.lock));
> +#else
> +	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
> +#endif

Could you please make this hunk only

	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));

i.e. the non-RT version?

>  	/*
>  	 * freelist is pointing to the list of objects to be used.


Sebastian
