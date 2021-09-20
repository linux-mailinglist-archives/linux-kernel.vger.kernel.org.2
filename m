Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1D5410E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 04:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhITCzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 22:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhITCzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 22:55:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFC3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 19:54:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n2so7474065plk.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 19:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mBw05sV24CGbBPxa3HJ1K125rdehCVx17LjyHhUTWT8=;
        b=KlM0TLYvKHq3hYTlt9aFuUlIEAPoGkvzMugqBOMKWuLHbiIHnW0qWbNX0XxNdXEMXO
         beoxuhxJ3sf6V92HHU2Iq+x/pP4SjAa5UoFeZgO5JgNZnE7TK1tX+tfjS8XzZpDtKId0
         k0gDfiBwMJFf8DzKpu62qDga7z0QFHRk/R161Cc9/bdCgnppk4DpzWLSTAFRSdmz1a1O
         zlbJA8xjiQQ63cFQwa6MDgsZuaoNEF7L8aZxPlw2XOFtTRlbv6sviO7Krx1bKPd/rh7G
         p3Y2z57w93mLSt7VZQs82h0Ixy49m/mM9gJLC5oA2R9Hz+vHFr7kZjSK/g8IW4RB9DS8
         epOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mBw05sV24CGbBPxa3HJ1K125rdehCVx17LjyHhUTWT8=;
        b=JDeGSyiGCJa+IToi6cOOT5oUlbwxFORgBWWHi68gJwzN15+RmhVYBY+F2KcdhVWink
         LJDJDr1NBiLwa5BjjbSAK1SC+mYDuNtipfGGbWsfIZ3CidPkd79/89lVoqQ+gmzPEwAF
         MYH0U4l3WltPWhOJsRObEmaR0YYh98amzWcv3950fahyazvZUTDeiGHguazgsIGwTY9g
         qIq/Mcf6gp1NtOrX6zXqUzdWiKuWGLDzYDz52XlxMypF//PtnWPyZ7yJ+uW8fZ7h5adc
         MBw+SJFwuFwSrMp+w1ezesKrW0oErQG6v0BbxVtur52qJEDOq8J4jUxDCtvV8o3joiY9
         y7qQ==
X-Gm-Message-State: AOAM530rNNwY4Q1FP8jIW3oJ2CS/ryYZQ6sofrrx7ouPMtpfuXivp4zZ
        D4AAP3Nol3vhYPeJXy4n95uKAZz3OGM=
X-Google-Smtp-Source: ABdhPJzBo+Nn1cOKj3Hk8PWmMve4xNxaTOIfPMYC3c8Uig13mfjJu6jwazq8Hutl8ObH3D0jfUawPg==
X-Received: by 2002:a17:903:310c:b0:13c:91b2:2ada with SMTP id w12-20020a170903310c00b0013c91b22adamr20518888plc.69.1632106454348;
        Sun, 19 Sep 2021 19:54:14 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id k190sm12597937pfd.211.2021.09.19.19.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 19:54:13 -0700 (PDT)
Date:   Mon, 20 Sep 2021 02:54:08 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH] Introducing lockless cache built on top of slab
 allocator
Message-ID: <20210920025408.GA3028@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210919164239.49905-1-42.hyeyoo@gmail.com>
 <YUeM2J7X/i0CHjrz@casper.infradead.org>
 <20210920010938.GA3108@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YUfpniK6ZVeNhaX2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUfpniK6ZVeNhaX2@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 02:53:34AM +0100, Matthew Wilcox wrote:
> On Mon, Sep 20, 2021 at 01:09:38AM +0000, Hyeonggon Yoo wrote:
> > Hello Matthew, Thanks to give me a comment! I appreciate it.
> > 
> > On Sun, Sep 19, 2021 at 08:17:44PM +0100, Matthew Wilcox wrote:
> > > On Sun, Sep 19, 2021 at 04:42:39PM +0000, Hyeonggon Yoo wrote:
> > > > It is just simple proof of concept, and not ready for submission yet.
> > > > There can be wrong code (like wrong gfp flags, or wrong error handling,
> > > > etc) it is just simple proof of concept. I want comment from you.
> > > 
> > > Have you read:
> > > 
> > > https://www.usenix.org/legacy/event/usenix01/full_papers/bonwick/bonwick_html/
> > > The relevant part of that paper is section 3, magazines.  We should have
> > > low and high water marks for number of objects
> > 
> > I haven't read that before, but after reading it seems not different from
> > SLAB's percpu queuing.
> >  
> > > and we should allocate
> > > from / free to the slab allocator in batches.  Slab has bulk alloc/free
> > > APIs already.
> > > 
> > 
> > There's kmem_cache_alloc_{bulk,free} functions for bulk
> > allocation. But it's designed for large number of allocation
> > to reduce locking cost, not for percpu lockless allocation.
> 
> What I'm saying is that rather than a linked list of objects, we should
> have an array of, say, 15 pointers per CPU (and a count of how many
> allocations we have).  If we are trying to allocate and have no objects,
> call kmem_cache_alloc_bulk() for 8 objects.  If we are trying to free
> and have 15 objects already, call kmem_cache_free_bulk() for the last
> 8 objects and set the number of allocated objects to 7.
> 
> (maybe 8 and 15 are the wrong numbers.  this is just an example)
>

Ah, Okay. it seems better to use array. Using cache for list is
unnecessary cost. array is simpler.

> > Yeah, we can implement lockless cache using kmem_cache_alloc_{bulk, free}
> > but kmem_cache_alloc_{free,bulk} is not enough.
> > 
> > > I'd rather see this be part of the slab allocator than a separate API.
> > 
> > And I disagree on this. for because most of situation, we cannot
> > allocate without lock, it is special case for IO polling.
> > 
> > To make it as part of slab allocator, we need to modify existing data
> > structure. But making it part of slab allocator will be waste of memory
> > because most of them are not using this.
> 
> Oh, it would have to be an option.  Maybe as a new slab_flags_t flag.
> Or maybe a kmem_cache_alloc_percpu_lockless().

Oh, Now I got what you mean. That is a good improvement!

For example,
there is a slab_flags_t flag like SLAB_LOCKLESS.
and a cache created with SLAB_LOCKLESS flag can allocate 
using both kmem_cache_alloc, or kmem_cache_alloc_percpu_lockless
depending on situation? (I suggest kmem_cache_alloc_lockless is better name)

it seems MUCH better. (because it prevents duplicating a cache)

I'll send RFC v2 soon.
Thank you so much Matthew.

If there's misunderstanding from me, please let me know.

Thanks,
Hyeonggon Yoo
