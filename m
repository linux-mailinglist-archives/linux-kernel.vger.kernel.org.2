Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C073FBAFC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbhH3RcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbhH3RcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:32:06 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781D4C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:31:12 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g11so12327915qtk.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FzQJtcmUOp3YOt6UkFdfJTSWRD6I/Fn5BlJnPjcuSAs=;
        b=NkC8IGugXV8J8S+6TutVR7tTaRrF3pZ+EBjKxijfl1pbAE0jj+awPCGY6Eg8KelTZn
         VAhg0RdV83VALBet6PFxjleMiPa/bJZZ+nc8QAaPys1lN2i0J9AMBy+D99hqu7Rn2Wak
         aAqxX93wvM4F2rD/8QuFXu6fugm3nuqlgbG1G7/X3kTWXSH5DI4Bqdt5noFHqTnqn3dI
         z6WZhPwEcYuSygE+YJJAJrY6IhBa//89La1gyyjPNFmGeNeMcMt08bfEFSRnMruJd7rT
         AryZ8VNbxd7ZNARbbxzthNhWFLNV/MXq7GmJbmzN67LTY00Ju0oDisZT6NnRj0hBY+eC
         W+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FzQJtcmUOp3YOt6UkFdfJTSWRD6I/Fn5BlJnPjcuSAs=;
        b=Vs579dZhtAuHWJ6md26Jda119uHqpOYnOjXj7qjx0ufKA2hTjFbA1Ib6oU+rwkTGK+
         WoLCtiH7YMyMUfV/zAmibgjWAMTbbWuk1XdfNxpmJtJvyUgU2n4pwWVoheAOf58S2PDe
         69aYiZLqa5BAB8T8uB6yg9ahz3xkvlXAwJZTqiI9TiImPm4SJ7jY5NvRUMoJfRhWw79J
         OCMqqCbNg6K5S+VJTbISqM/38IKx9/YDF34OtTsEmazs1SXK8b0PtjjnDJyipAalX1NB
         HwvFVLBGA4IKyb6zXst2gBqrNcDyZF0iqGd6ESHS6UTYREX7ZOJsPdflSEnPLgUBJZ1n
         GHvw==
X-Gm-Message-State: AOAM532j8xK9DdH8h1AsRl0BlPCRlnqGbP9R43+aIYzprzTGE9IgnZhq
        S6sFYgRgxgqAvfb2MyMVWErpow==
X-Google-Smtp-Source: ABdhPJynR8yzoYUAnr+cp0M+WqtlMoGcaJ03+KDozQjpOpLTH2XzngF0J5cJhlVA2vIvyoczs+mb2A==
X-Received: by 2002:a05:622a:81:: with SMTP id o1mr21577821qtw.361.1630344670262;
        Mon, 30 Aug 2021 10:31:10 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id l4sm11776487qkd.77.2021.08.30.10.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 10:31:08 -0700 (PDT)
Date:   Mon, 30 Aug 2021 13:32:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YS0WR38gCSrd6r41@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org>
 <YSZeKfHxOkEAri1q@cmpxchg.org>
 <20210826004555.GF12597@magnolia>
 <YSjxlNl9jeEX2Yff@cmpxchg.org>
 <YSkyjcX9Ih816mB9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSkyjcX9Ih816mB9@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 07:44:29PM +0100, Matthew Wilcox wrote:
> On Fri, Aug 27, 2021 at 10:07:16AM -0400, Johannes Weiner wrote:
> > We have the same thoughts in MM and growing memory sizes. The DAX
> > stuff said from the start it won't be built on linear struct page
> > mappings anymore because we expect the memory modules to be too big to
> > manage them with such fine-grained granularity.
> 
> Well, I did.  Then I left Intel, and Dan took over.  Now we have a struct
> page for each 4kB of PMEM.  I'm not particularly happy about this change
> of direction.
> 
> > But in practice, this
> > is more and more becoming true for DRAM as well. We don't want to
> > allocate gigabytes of struct page when on our servers only a very
> > small share of overall memory needs to be managed at this granularity.
> 
> This is a much less compelling argument than you think.  I had some
> ideas along these lines and I took them to a performance analysis group.
> They told me that for their workloads, doubling the amount of DRAM in a
> system increased performance by ~10%.  So increasing the amount of DRAM
> by 1/63 is going to increase performance by 1/630 or 0.15%.  There are
> more important performance wins to go after.

Well, that's kind of obvious.

Once a configuration is balanced for CPU, memory, IO, network etc,
adding sticks of RAM doesn't help; neither will freeing some memory
here and there. The short term isn't where this matters.

It matters rather a lot, though, when we design and purchase the
hardware. RAM is becoming a larger share of overall machine cost, so
at-scale deployments like ours are under more pressure than ever to
provision it tightly. When we configure our systems we look at the
workloads' resource consumption ratios, as well as the kernel
overhead, and then we need to buy capacity accordingly.

> Even in the cloud space where increasing memory by 1/63 might increase the
> number of VMs you can host by 1/63, how many PMs host as many as 63 VMs?
> ie does it really buy you anything?  It sounds like a nice big number
> ("My 1TB machine has 16GB occupied by memmap!"), but the real benefit
> doesn't really seem to be there.  And of course, that assumes that you
> have enough other resources to scale to 64/63 of your current workload;
> you might hit CPU, IO or some other limit first.

A lot of DC hosts nowadays are in a direct pipeline for handling user
requests, which are highly parallelizable.

They are much smaller, and there are a lot more of them than there are
VMs in the world. The per-request and per-host margins are thinner,
and the compute-to-memory ratio is more finely calibrated than when
you're renting out large VMs that don't neatly divide up the machine.

Right now, we're averaging ~1G of RAM per CPU thread for most of our
hosts. You don't need a very large system - certainly not in the TB
ballpark - where struct page takes up the memory budget of entire CPU
threads. So now we have to spec memory for it, and spend additional
capex and watts, or we'll end up leaving those CPU threads stranded.

You're certainly right that there are configurations that likely won't
care much - especially more legacy, big-iron style stuff that isn't
quite as parallelized and as thinly provisioned.

But you can't make the argument that nobody will miss 16G in a 1TB
host that has the CPU concurrency and the parallel work to match it.

> > Folio perpetuates the problem of the base page being the floor for
> > cache granularity, and so from an MM POV it doesn't allow us to scale
> > up to current memory sizes without horribly regressing certain
> > filesystem workloads that still need us to be able to scale down.
> 
> The mistake you're making is coupling "minimum mapping granularity" with
> "minimum allocation granularity".  We can happily build a system which
> only allocates memory on 2MB boundaries and yet lets you map that memory
> to userspace in 4kB granules.

Yeah, but I want to do it without allocating 4k granule descriptors
statically at boot time for the entirety of available memory.

> > I really don't think it makes sense to discuss folios as the means for
> > enabling huge pages in the page cache, without also taking a long hard
> > look at the allocation model that is supposed to back them. Because
> > you can't make it happen without that. And this part isn't looking so
> > hot to me, tbh.
> 
> Please, don't creep the scope of this project to "first, redesign
> the memory allocator".  This project is _if we can_, use larg(er)
> pages to cache files.  What Darrick is talking about is an entirely
> different project that I haven't signed up for and won't.

I never said the allocator needs to be fixed first. I've only been
advocating to remove (or keep out) unnecessary allocation assumptions
from folio to give us the flexibility to fix the allocator later on.

> > Willy says he has future ideas to make compound pages scale. But we
> > have years of history saying this is incredibly hard to achieve - and
> > it certainly wasn't for a lack of constant trying.
> 
> I genuinely don't understand.  We have five primary users of memory
> in Linux (once we're in a steady state after boot):
> 
>  - Anonymous memory
>  - File-backed memory
>  - Slab
>  - Network buffers
>  - Page tables
> 
> The relative importance of each one very much depends on your workload.
> Slab already uses medium order pages and can be made to use larger.
> Folios should give us large allocations of file-backed memory and
> eventually anonymous memory.  Network buffers seem to be headed towards
> larger allocations too.  Page tables will need some more thought, but
> once we're no longer interleaving file cache pages, anon pages and
> page tables, they become less of a problem to deal with.
> 
> Once everybody's allocating order-4 pages, order-4 pages become easy
> to allocate.  When everybody's allocating order-0 pages, order-4 pages
> require the right 16 pages to come available, and that's really freaking
> hard.

Well yes, once (and iff) everybody is doing that. But for the
foreseeable future we're expecting to stay in a world where the
*majority* of memory is in larger chunks, while we continue to see 4k
cache entries, anon pages, and corresponding ptes, yes?

Memory is dominated by larger allocations from the main workloads, but
we'll continue to have a base system that does logging, package
upgrades, IPC stuff, has small config files, small libraries, small
executables. It'll be a while until we can raise the floor on those
much smaller allocations - if ever.

So we need a system to manage them living side by side.

The slab allocator has proven to be an excellent solution to this
problem, because the mailing lists are not flooded with OOM reports
where smaller allocations fragmented the 4k page space. And even large
temporary slab explosions (inodes, dentries etc.) are usually pushed
back with fairly reasonable CPU overhead.

The same really cannot be said for the untyped page allocator and the
various solutions we've had to address fragmentation after the fact.

Again, I'm not saying any of this needs to be actually *fixed* MM-side
to enable the huge page cache in the filesystems. I'd be more than
happy to go ahead with the "cache descriptor" aspect of the folio.

All I'm saying we shouldn't double down on compound pages and tie the
filesystems to that anchor, just for that false synergy between the
new cache descriptor and fixing the compound_head() mess.
