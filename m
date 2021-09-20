Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD84A4113D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhITL5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhITL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:57:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155E4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:55:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k17so1637934pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZKZIHqQbaushXF3880STu4eW1r+MpmKGfOUqwk8tg/I=;
        b=ecfAL32e1Oan/lTQAHB5xbX4D4fuf130CL99g2ZYFbU1ehlQgoL+ix/nf2B/MKjw0R
         KdJuxD8zxyd8Jmi5h/FEhkkAKHHW/bNs6t9CGiglJC8Flr4Vn7lMVpXlpopDWyrKwwFG
         cCGUuU67mG7e/3Bs1Lr2+aJrb+BiUBb8miHLRPJYCqbJJVIF6nCNw+dNmTjP2lrHmAlv
         dAhd+7UEC2esEhlMT+rUel9wjgHvlyUj12dkiA0TSm2YSZCZ4WnNRAn9w3KT3Tp00Sz5
         abNa5G1u+FrZI2MfrDsku/Qk90szWsY25q76qenb4Ckz6FaLIBDF3G59UyBQZyuAo9dS
         b6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZKZIHqQbaushXF3880STu4eW1r+MpmKGfOUqwk8tg/I=;
        b=cAZV7qoo6Ulk2JCI/zNQWuee2YtgitPZ7Hs0ieD9BKk9blR/eVOSqq5XMYUfmItV44
         5gJ1H2JMnEuFEyGJmaHU2u++WIxqAJufsZd5XmJBDWaDTm5HXVeBTAlkHUG4iNPm7nqc
         H+zSHjOXucK3EKcDAdaNoZ9Pbjexa3qUsuyg2udnBlYdh2q731ykoAHtSzrXWghp9lqr
         Eb+HaDNQz3Re4XHTdhqEHlSIUGV2KtjanzlGzkfnAe3OKQZDaQ5CpyCXpAc3KSYWWMQD
         yhOiVhsBinPvxEMSCd3zbetSpwLQ1oDkz7JPIKUGKa4+9FIifKWbfnf9EjAe7eQDGoeA
         7bsA==
X-Gm-Message-State: AOAM533vVt8rpaV1wNVr5wCQyj6Gbr5qJvdXvSJ3Grt4clFfH6CO4+o8
        wynGp+838H+ClagXlNGdvuI=
X-Google-Smtp-Source: ABdhPJx2ax+msLhKrXItxio1F/lGp05ksCDXkCMJVfHpQGBqDn9jqBHQ6Gvkvv5vbpASWpoN9ffKGQ==
X-Received: by 2002:a63:e64a:: with SMTP id p10mr23103490pgj.263.1632138941547;
        Mon, 20 Sep 2021 04:55:41 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id t14sm14887742pga.62.2021.09.20.04.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 04:55:41 -0700 (PDT)
Date:   Mon, 20 Sep 2021 11:55:36 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH] Introducing lockless cache built on top of slab
 allocator
Message-ID: <20210920115536.GA3117@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210919164239.49905-1-42.hyeyoo@gmail.com>
 <YUeM2J7X/i0CHjrz@casper.infradead.org>
 <20210920010938.GA3108@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YUfpniK6ZVeNhaX2@casper.infradead.org>
 <432da236-4d8c-1013-cd57-42c352281862@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432da236-4d8c-1013-cd57-42c352281862@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 11:07:36AM +0200, Vlastimil Babka wrote:
> On 9/20/21 03:53, Matthew Wilcox wrote:
> > On Mon, Sep 20, 2021 at 01:09:38AM +0000, Hyeonggon Yoo wrote:
> >> Hello Matthew, Thanks to give me a comment! I appreciate it.
> >> Yeah, we can implement lockless cache using kmem_cache_alloc_{bulk, free}
> >> but kmem_cache_alloc_{free,bulk} is not enough.
> >> 
> >> > I'd rather see this be part of the slab allocator than a separate API.
> >> 
> >> And I disagree on this. for because most of situation, we cannot
> >> allocate without lock, it is special case for IO polling.
> >> 
> >> To make it as part of slab allocator, we need to modify existing data
> >> structure. But making it part of slab allocator will be waste of memory
> >> because most of them are not using this.
> > 
> > Oh, it would have to be an option.  Maybe as a new slab_flags_t flag.
> > Or maybe a kmem_cache_alloc_percpu_lockless().
> 
> I've recently found out that similar attempts (introduce queueing to SLUB)
> have been done around 2010. See e.g. [1] but there will be other threads to
> search at lore too. Haven't checked yet while it wasn't ultimately merged, 
> I guess Christoph and David could remember (this was before my time).

There was attempt on SLUB with queueing as you said.
I searched a bit and found [2] and [3].

- SLUB with queueing (V2) beats SLAB netperf TCP_RR, 2010-07
[2] https://lore.kernel.org/lkml/alpine.DEB.2.00.1007121010420.14328@router.home/T/#m5a31c7caa28b93a00de3af6d547b79273449f5ba

- The Unified slab allocator (V4), 2010-10
[3] https://linux-mm.kvack.narkive.com/e595iCuz/unifiedv4-00-16-the-unified-slab-allocator-v4#post47

Looking at [3], There was still some regression comparing "SLUB with queueing"
with SLAB. And I couldn't find patch series after [3] yet. I'll add link
if I find.

> I guess making it opt-in only for caches where performance improvement was
> measured would make it easier to add, as for some caches it would mean no
> improvement, but increased memory usage. But of course it makes the API more
> harder to use.

Do you mean "lockless cache" it should be separate from slab because some caches
doesn't benefit at all?

> I'd be careful about the name "lockless", as that's ambiguous. Is it "mostly
> lockless" therefore fast, but if the cache is empty, it will still take
> locks as part of refill?

It is actually "mostly lockless" so it is ambiguous.
Can you suggest a name? like try_lockless or anything?

> Or is it lockless always, therefore useful in
> contexts that can take no locks, but then the caller has to have fallbacks
> in case the cache is empty and nothing is allocated?
> 
> [1] https://lore.kernel.org/linux-mm/20100804024531.914852850@linux.com/T/#u
