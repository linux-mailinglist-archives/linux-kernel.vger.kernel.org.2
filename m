Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D043606D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhJULne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJULnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:43:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D248C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:41:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a15-20020a17090a688f00b001a132a1679bso2925583pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jRDu67UN4//HE7dg80MGnHq8ullkWEYTnuYL8y+5HtM=;
        b=ifZJzIcQ88huba0uUZN5I3h44XVzA3nAbeCvYZxdjy9KrlrS1XSrIa2HnJ5QaLa52B
         OqCd6UxCS+lpcRepJJtXtEL93v+fiq/PnRC5puMwBk3YSk89xh8+jG1rHGQCGFFTckEl
         tRP71IOTX2pAJc5NtnF7KcT0DUy9jYVzHM4zviL7a7VMg+gseuU/6S/quROEIeYrXznP
         Vc5B4zBB7t18VBTV2G1e+gBMazp/1Yw+9Gzi9sNAWzy8iw4sDdSmmayOHJZo2g46fSBO
         9c/L7HhxlHb+FTQhkVLY8+76Ia+MkixS0hkVH7HN1YrH5uLQepuzbnod07OmUUkseG7v
         e7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jRDu67UN4//HE7dg80MGnHq8ullkWEYTnuYL8y+5HtM=;
        b=L/H36rfjXHyUc97jnUAvDGYL1P6cIt4EgYCdA23XJT2qYpmINo56vCdQcy4KFeVacr
         3FzwFVEBvo5LLK6v4QWsa3rOIYkvfiq1oXcVMzHYUmYv/Mg6NmHpoFFtLFoPLdqK1/93
         BSkohKD2CAJuvMwn128y/MnUCuJP949E8D9VEg40ZDbJzJzh7DhkeOVX2LDDBVHdqpLe
         6JlQOcbEYS4Ea2w189eDRa59BVrObaeXEAY/4VzGLvM/GrGO+YqtRIQu066wtAAaR5gi
         3rGVgbE7K46RtJGJxYV8kZRFHD37qzp87jNTW7BaZSh5F0SI2AbhuaDcxadQbEwK/sup
         ThPA==
X-Gm-Message-State: AOAM532E1TLsNCN+BSp5OUvLBv9+QiDDukQjtOr/hz4KaQ/y8pT8jZEG
        3GdZybVMWumsMXmX4JVx5LU=
X-Google-Smtp-Source: ABdhPJwiONEoJhzfpzCePGv3CUV7E3ZTE2PSxs/2hMDperfF/Bk83XDZl7rfjFr5UBaHFK6zWNijEw==
X-Received: by 2002:a17:90b:38c6:: with SMTP id nn6mr6213603pjb.28.1634816477001;
        Thu, 21 Oct 2021 04:41:17 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (139.96.64.34.bc.googleusercontent.com. [34.64.96.139])
        by smtp.gmail.com with ESMTPSA id oo9sm6246532pjb.53.2021.10.21.04.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:41:16 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:41:12 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Taht <dave.taht@gmail.com>
Subject: Re: [RFC PATCH] mm, slob: Rewrite SLOB using segregated free list
Message-ID: <20211021114112.GA4004@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211020135535.517236-1-42.hyeyoo@gmail.com>
 <cf8ef7b4-ca18-064f-9c5d-01047e40446b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf8ef7b4-ca18-064f-9c5d-01047e40446b@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.. I think I need to clarify my intention.

I'm not saying this should be merged or we should put effort to make
SLOB into lightweight SLOB. I just rewrote it just for fun.
I wanted to know how small a segregated free list allocator can be.

And when I rewrote it, I wondered who is users of SLOB
and where SLOB should be used.

I think SLOB was useful when there was only SLAB and there was no SLUB,
but I wonder where SLOB should be used now.

When I compared SLOB and SLUB without cpu partials,
That made 300kB of difference in Slab memory.

Then Is SLOB used where 300kB of difference is so important?
But I think we need at least 16MB of RAM to run linux.

So I'm not saying we need to turn SLOB into lightweight SLUB,
but wanted to talk about the questions:

> > But after rewriting, I thought I need to discuss what SLOB is for.
> > According to Matthew, SLOB is for small machines whose
> > memory is 1~16 MB.
> > 
> > I wonder adding 48kB on SLOB memory for speed/lower latency
> > is worth or harmful.
> > 
> > So.. questions in my head now:
> >     - Who is users of SLOB?
> >     - Is it harmful to add some kilobytes of memory into SLOB?
> >     - Is it really possible to run linux under 10MB of RAM?
> >     	(I failed with tinyconfig.)
> >     - What is the boundary to make decision between SLOB and SLUB?

On Thu, Oct 21, 2021 at 10:46:46AM +0200, Vlastimil Babka wrote:
> On 10/20/21 15:55, Hyeonggon Yoo wrote:
> > Hello linux-mm, I rewrote SLOB using segregated free list,
> > to understand SLOB and SLUB more. It uses more kilobytes
> > of memory (48kB on 32bit tinyconfig) and became 9~10x faster.
> > 
> > But after rewriting, I thought I need to discuss what SLOB is for.
> > According to Matthew, SLOB is for small machines whose
> > memory is 1~16 MB.
> > 
> > I wonder adding 48kB on SLOB memory for speed/lower latency
> > is worth or harmful.
> > 
> > So.. questions in my head now:
> >     - Who is users of SLOB?
> >     - Is it harmful to add some kilobytes of memory into SLOB?
> >     - Is it really possible to run linux under 10MB of RAM?
> >     	(I failed with tinyconfig.)
> >     - What is the boundary to make decision between SLOB and SLUB?
> > 
> > Anyway, below is my work.
> > Any comments/opinions will be appreciated!
> > 
> > SLOB uses sequential fit method. the advantages of this method
> > is the fact that it is simple and does not have complex metadata.
> > 
> > But big downside of sequential fit method is its high latency
> > in allocation/deallocation and fast fragmentation.
> > 
> > High latency comes from iterating pages and also iterating objects
> > in the page to find suitable free object. And fragmentation easily
> > happens because objects of difference size is allocated in same page.
> > 
> > This patch tries to minimize both its latency and fragmentation by
> > re-implmenting SLOB using segregated free list method and adding
> > support for slab merging. it looks like lightweight SLUB but more
> > compact than SLUB.
> 
> My immediate reaction is that we probably don't want to turn SLOB into
> lightweight SLUB. SLOB choses the tradeoff of low memory usage over speed
> and shifting it towards more speed kinda defeats this purpose. Also it's a
> major rewrite, so without a very clear motivation there will be resistance
> to that.
>

Yes, I agree that SLOB is for memory efficiency, not a performance.
That's why I said:
> > I wonder adding 48kB on SLOB memory for speed/lower latency
> > is worth or harmful.

But on the contrary, I wonder when SLOB is useful than SLUB.
is it for really tiny linux systems that has under 1M of RAM?
But can linux be that small?

> SLUB itself could be probably tuned to less memory overhead if needed. Most
> of the debug options effectively disable percpu slabs, we could add a mode
> that disables them without the rest of the debugging overhead. Allocation
> order can be lowered (although some object sizes might benefit from less
> fragmentation with a higher order).

Yes, that's what I was curious about. As SLUB is not that big,
I wonder where SLOB is useful.

> > One notable difference is after this patch SLOB uses kmalloc_caches
> > like SL[AU]B.
> > 
> > Below is performance impacts of this patch.
> > 
> > Memory usage was measured on 32 bit + tinyconfig + slab merging.
> > 
> > Before:
> >     MemTotal:          29668 kB
> >     MemFree:           19364 kB
> >     MemAvailable:      18396 kB
> >     Slab:                668 kB
> > 
> > After:
> >     MemTotal:          29668 kB
> >     MemFree:           19420 kB
> >     MemAvailable:      18452 kB
> >     Slab:                716 kB
> > 
> > This patch adds about 48 kB after boot.
> > 
> > hackbench was measured on 64 bit typical buildroot configuration.
> > After this patch it's 9~10x faster than before.
> > 
> > Before:
> >     memory usage:
> >         after boot:
> >             Slab:               7908 kB
> >         after hackbench:
> >             Slab:               8544 kB
> > 
> >     Time: 189.947
> >     Performance counter stats for 'hackbench -g 4 -l 10000':
> >          379413.20 msec cpu-clock                 #    1.997 CPUs utilized
> >            8818226      context-switches          #   23.242 K/sec
> >             375186      cpu-migrations            #  988.859 /sec
> >               3954      page-faults               #   10.421 /sec
> >       269923095290      cycles                    #    0.711 GHz
> >       212341582012      instructions              #    0.79  insn per cycle
> >         2361087153      branch-misses
> >        58222839688      cache-references          #  153.455 M/sec
> >         6786521959      cache-misses              #   11.656 % of all cache refs
> > 
> >      190.002062273 seconds time elapsed
> > 
> >        3.486150000 seconds user
> >      375.599495000 seconds sys
> > 
> > After:
> >     memory usage:
> >        after boot:
> >            Slab:               7560 kB
> >         after hackbench:
> >            Slab:               7836 kB
> 
> Interesting that the memory usage in this test is actually lower with your
> patch.

I didn't mention that because if we have enough memory,
I think we have no reason to use SLOB. (why not use SLUB?)
I thought memory usage on small machine is important.

> 
> > hackbench:
> >     Time: 20.780
> >     Performance counter stats for 'hackbench -g 4 -l 10000':
> >           41509.79 msec cpu-clock                 #    1.996 CPUs utilized
> >             630032      context-switches          #   15.178 K/sec
> >               8287      cpu-migrations            #  199.640 /sec
> >               4036      page-faults               #   97.230 /sec
> >        57477161020      cycles                    #    1.385 GHz
> >        62775453932      instructions              #    1.09  insn per cycle
> >          164902523      branch-misses
> >        22559952993      cache-references          #  543.485 M/sec
> >          832404011      cache-misses              #    3.690 % of all cache refs
> > 
> >       20.791893590 seconds time elapsed
> > 
> >        1.423282000 seconds user
> >       40.072449000 seconds sys
> 
> That's significant, but also hackbench is kind of worst case test, so in
> practice the benefit won't be that prominent.

> 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
