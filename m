Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A21422AB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhJEOSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbhJEOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:18:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1242EC06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 07:16:27 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p1so11481076pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EwHZDZ7kt9Qt3vhwKnm3A0/y/1Nf7STGF1vfsq6DqDE=;
        b=Dr39kURPHYYkONhvPaa1UE9yMgqt/Yk1d3oR/j6onhWoiP1TOjLwFVVO5LuwdSMa9+
         Qq8WPcfNJqOgQnwYdeo41itxFbrJ1B0wcYIdXzb09PUYC5byA94xP3OSjKv9WNGnFmIx
         7H/lKUIj0t5npCbJOiucP6vKNwmPPS2kfeuV1UwSVTGIjtjaf9xe8B49nNn5DEb/3jE5
         KJG8xuUzynfhtD5v+kdFRPH7wCWKZFkyhNDhpywMdmzQ59IAmU/sSRsxxrYudN5I0rv3
         3q980hqhNLR7gZmAdE8Z3ov64U07sFf+UsTgSvd2WrEaKVYHDjqcTNb7XmKo1GhDIhv3
         VQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwHZDZ7kt9Qt3vhwKnm3A0/y/1Nf7STGF1vfsq6DqDE=;
        b=GinLm8MgB2lO/OsKDXrqT8ohbi8ZvHL8F4M2JUkXb8oFfUPbIx/YYdV01uIEuAfQKa
         FYPpGa+t2IWihlHXWPc8MLi4xEbRMMuLc9JbamyKUMgdqn0XSOIxRpkGMM7XVF2dOFkY
         2fMWXUC0vHm9GTmHZMtExmfsZuTLY6sjvoEWVOhIzWHPHVlqt3abSds0wtjKBt8sSY3o
         G05EaVGEbMpcGLfYQtUf3M+aflzu0bSMJSXkj5I7y4/EcVyLgYNtK3lTvBOp+H8+lXTB
         LPGpAN8JSk5fUUOBKlFSeKYDWYJUyk9QVMx3QXOTB3MxBfwHTbPc/5lyYP08k4uu7oIH
         eTdg==
X-Gm-Message-State: AOAM533WPKmDdzR33P4nRszN24UtARC0XJkdFO0Jy0KY3VXNbJ9vOuaK
        hDym5lWHQkbgXzfXobOOTks=
X-Google-Smtp-Source: ABdhPJwvUVLH835WDiej69cMmIrlamhNnH89ABSVEQgdVQE+O4tPcP2eaBfVx30kXpcDuXkHKDUEUA==
X-Received: by 2002:a63:1d13:: with SMTP id d19mr16047813pgd.383.1633443386517;
        Tue, 05 Oct 2021 07:16:26 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id d26sm17723862pfo.116.2021.10.05.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 07:16:26 -0700 (PDT)
Date:   Tue, 5 Oct 2021 14:16:22 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@gentwo.de>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Queueing is outside of SLUB nowdays
Message-ID: <20211005141622.GC2760@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
 <20211001003908.GA2657@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <alpine.DEB.2.22.394.2110041648220.294708@gentwo.de>
 <09ca489a-ecfb-dd5e-b057-dc9c59c8585e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ca489a-ecfb-dd5e-b057-dc9c59c8585e@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 10:19:32AM +0200, Vlastimil Babka wrote:
> On 10/4/21 16:56, Christoph Lameter wrote:
> > On Fri, 1 Oct 2021, Hyeonggon Yoo wrote:
> > 
> >> Looking at other layers, they implemented queuing layer outside of SLUB.
> >> See commit 795bb1c00dd ("net: bulk free infrastructure for NAPI context,
> >> use napi_consume_skb") for example. They made skb cache because SLUB is
> >> not suitable for intensive alloc/free.
> >>
> >> And because the queue is outside of slab, it can go lockless
> >> depending on it's context. (But it's not easy to do so in slab because
> >> slab is general purpose allocator.)
> > 
> > The queuing within in SLUB/SLAB is lockless.
> >

Oh, yes. both SLAB/SLUB has lockless queueing.

I misused word 'lockless'. it's lockless and also without disabling
interrupt.

> >> So current approach on place where slab's performance is critical
> >> is implementing queuing layer on top of slab.
> > 
> > If you have to use object specific characteristics to optimize then yes
> > you can optimize further. However, the slab allocators implement each
> > their own form of queuing that is generic.
> >
> >> Then new question arising:
> >>     - Is that proper way to solve fundamental problem?
> > 
> > There is a problem?
> 
> If someone benefits from implementing a caching layer on top of SL*B, it
> probably indicates a problem.
>

Before I say something, I want to ask why Christoph stopped
implementing SLUB+Q at that time.

And Yeah, I think there are some problems.

If objects are manged outside of slab allocator and most of alloc/frees
are done outside of slab, it's waste of memory.

To say the extreme case (even if it's not common situation), how does implementing 
queueing layer on SLAB, on system with high NUMA nodes makes sense?
it's wasting lots of memory.

and objects are treated as 'allocated' even if it's actually being not
used in queue outside slab. so the memory is unreclaimable.

I think that, If objects are mostly allocated / freed outside of slab
allocator, it does not need to be on top of slab allocator.

and implementing same queueing layers on similar situation is duplication
of code and increased maintenance cost.

So what I tried was generalizing optimizations that are done in some layers
(block and networks). But that was not an easy task, though.

=============================================================================

And what recently I was surprised was:

    I asked Jens (who recently made bio caching layer on slab)
    "I think it would have better performance if you run benchmarks with SLAB?".
    because there is lots of allocations (Millions of allocations per second),
    it's likely to cache-friendly characteristics of SLAB would have result in performance.

    but the response was "I would be surprised if SLAB was better, SLAB
    is considered legacy and everybody uses SLUB."

    and the solution was too SLUB-specific way. (implementing queuing
    layer) I'll say it's too SLUB-specific because SLAB's cache
    utilization functionalities weren't even considered.

    That's why I started this thread at first.

> >>       - why not use SLAB if they need queuing?
> > 
> > SLAB is LIFO queuing whereas SLUB uses spatial considerations and queues
> > within a page before going outside.
> 
> IIUC SLUB queueing works well for allocation (we just consume a per-cpu
> freelist that nobody else can touch) but freeing uses the corresponding
> page's freelist so the atomics are more expensive. In both cases the linked
> freelists might be also worse for cache locality than an array of pointers.
> So perhaps some workload still benefit from a array-based cache on top of
> SLUB and it would be great if they didn't have to implement own solutions?
>

I wonder if page-based policy will work well with queueing.
What to do if the page is full and we must take new page to satisfy a
request?

and what If the queue is mixed with objects of different pages?
That might be somewhat losing spatial locality of SLUB.

So if what you need is queueing, I think SLAB might be better
than adding queueing on SLUB because adding queueing on SLUB
might result in losing its own characteristics.

It seems it's really difficult to consider all situations
in a single memory allocator... T.T.

> > Slab requires disabling interrupts,
> > SLUB is optimized to rely on per cpu atomics and there are numerous other
> > differences.
> > 
> >>       - how does this approach work on SLAB?
> > 
> > SLAB has a lockless layer that is only requiring disabling interrupts. It
> > provides a generic queuing layer as well.
> > 
> > See my talk on Slab allocators awhile back.
> > 
> > https://www.youtube.com/watch?v=h0VMLXavx30

Thank you for sharing that! I have read the presentation before
but didn't know that there was a video too!

It's very useful and I became more familiar with them.

> > 
> 

If I wrongly understand something, please tell me.
I'm so excited to talk about this topic.

Thanks,
Hyeonggon.
