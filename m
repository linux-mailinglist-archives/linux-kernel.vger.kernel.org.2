Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA2D3FF398
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347120AbhIBSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhIBSz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:55:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FCDC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 11:54:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y34so6488721lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBFfgaMaIxlO/zlR1k/F2i9I/s/LN+kTHhWS9J4gOnY=;
        b=QwTU/Y6+ZPvfYAOSWlEZ7wwV+XCMbhemhGtTvyWrPUUszrTCYA9GtrXHO2IBHzAP0x
         vj4dGolcu6JpdvqdeJ1k6Rc0EyMwj1yEXpuJYJtN+317QXYR5N3rP7sB1Sg3Y/+O6lir
         o9nxe0yYH24xH3+N45Kq+g0JV0ssyguRKTeEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBFfgaMaIxlO/zlR1k/F2i9I/s/LN+kTHhWS9J4gOnY=;
        b=CcFp0/8CXFIkKJk/W9LOIwRBjjXB1dNp44Avi6pBiB/1Z+fW3SiHKxAqLzdPuGDWG0
         p/CSAi9dSdvXzNXPA0pZivR7KJ0cQYUJ1DLxFFhCrKcglaL0QPRu2NeLA0EjFxaEyaiH
         U21ZiE2vuADvoWLepKwpf9jK7H3bQL3cecaV94CZ3xVxJiWUEBDRNT9AQ22XlGny4lnq
         YM0/6j1BccsQD3rNtvzGKjXMeDja1um6rKyBpwsZgZglqeRkFp8toE0rXMkmIlTBRVSv
         rItXIaDbAhIRj/1R/k1Pbgu7hfL3xqfK+nf5q+5FAoYtkkDy1NPmmryBPuVc9vZ8VcWz
         uCwQ==
X-Gm-Message-State: AOAM5305CQa3V3e4nZ40ugowlqdKrPuYlmoslz2J1lE0521GTmbpEIIF
        MD+ucxSK7kh+Ojt4HeCH482pgnoDu5KEJB6SeAY=
X-Google-Smtp-Source: ABdhPJw9Ts+4lsioHbD/aWwzbvCW/m5sreQyIxk5Fmqkj4nSmCCeh04fgTn08kz+8vt+fhAg24RoKA==
X-Received: by 2002:ac2:4c56:: with SMTP id o22mr3567445lfk.240.1630608865219;
        Thu, 02 Sep 2021 11:54:25 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s14sm314919ljh.38.2021.09.02.11.54.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 11:54:24 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id p38so6595731lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:54:24 -0700 (PDT)
X-Received: by 2002:a05:6512:681:: with SMTP id t1mr3560113lfe.487.1630608864014;
 Thu, 02 Sep 2021 11:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <YS/r5eaf/ps5ekie@localhost.localdomain>
In-Reply-To: <YS/r5eaf/ps5ekie@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 11:54:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYNEj8JRO3f4L9GG06Akwwr18mM4Co8nWeAH44a9y-aw@mail.gmail.com>
Message-ID: <CAHk-=wiYNEj8JRO3f4L9GG06Akwwr18mM4Co8nWeAH44a9y-aw@mail.gmail.com>
Subject: Re: [GIT PULL] (swiotlb) stable/for-linus-5.15
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Claire Chang <tientzu@chromium.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Will Deacon <will@kernel.org>, pasic@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 2:09 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> which has a new feature called restricted DMA pools. It allows SWIOTLB to utilize
> per-device (or per-platform) allocated memory pools instead of using the global one.
>
> The first big user of this is ARM Confidential Computing where the memory for DMA
> operations can be set per platform.

Hmm.

I was going to merge this, but I had already merged the dma-mapping
updates from Christoph Hellwig first.

And it turns out that the conflicts are trivial to do the
straightforward way, that's not a problem.

But I think that straightforward way is actually buggy, because it
makes the is_swiotlb_for_alloc() type allocations then use that new
global pool for allocations.

Just to check, I looked into what linux-next did, in case this had
caused any discussion there. Nope. Linux-next does the obvious
straightforward merge.

So I'm going to hold off merging until I can clarify what the rules
for these restricted DMA pools are, because I get the feeling that
people didn't actually think about the interaction with the new global
pool very much.

Or if they did, it didn't get communicated to me. Christoph mentioned
the merge conflict, but he implied that I should just merge it the
obvious way. And the more I look at that code, the less I think that's
the right thing to do.

So just to make this very concrete, look at dma_direct_alloc(). The
straightforward merge is to do this:

        if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
            !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
            !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
            !dev_is_dma_coherent(dev) &&
            !is_swiotlb_for_alloc(dev))
                return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);

        if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
            !dev_is_dma_coherent(dev))
                return dma_alloc_from_global_coherent(dev, size, dma_handle);

and that seems to be what linux-next did too.

But that means that a is_swiotlb_for_alloc(dev) allocation can use
that new global coherent pool (see that second case).

Maybe that's ok. But I get the feeling that it is not. It sure as heck
isn't obvious. If it's ok to use the global pool, then fine - but I
want to know why (and I want the code to say why).

I think that the second conditional should probably get an all-new added

            && !is_swiotlb_for_alloc(dev)

in it, but that's not what happened in linux-next. And all this code
is messy and illogical and crazy.

Btw, what's the actual logic with the

            !dev_is_dma_coherent(dev)

tests anyway? Those are pre-existing, but seem odd and senseless. The
function is called "dma_alloc_from_global_coherent()", but it is *not*
called when "dev_is_dma_coherent()".

Is it just me, or does anybody else also get the feeling that too many
recreational drugs may have been involved in the creation of this code
over the years? People possibly self-medicating to take away the pain?

Anyway - I'm going to punt on this pull request, because I want
clarification that didn't happen despite the conflict in linux-next.

I also have to say, looking at that code, you guys write collectively
some disgusting code.

I think individually each change has been probably fairly small, but
taken together it's just too nasty for words. That code should be
taken out behind a shed and shot in the head, because it's entirely
impossible to read all those nasty conditionals over multiple lines.

So regardless of what the merge resolution should be, I think this
code needs reorganizing. Because those entirely random conditionals
with several different config tests that DO NOT MAKE SENSE TOGETHER
should not exist.

The merge conflict is just a symptom of the disease in this code, not
the problem itself.

That code needs to be split up, and the logic needs to be made
understandable. Preferably *obvious*. Which it isn't now.

In particular, if the rule is that "is_swiotlb_for_alloc()" means that
you *have* to use swiotlb_alloc() and absolutely nothing else", then
that should be the logic, and it should be at the top, and that should
be all it is. No m ixing with the other tests that are about entirely
different issues.

Because right now, that code is literally set up to use completely
random different allocation choices depending on completely random and
illogical combinations of config rules mixed with random device rules.

Make each conditional be about *one* thing, and one thing only. Not
about three unrelated things that may or may have the same end result
rule.

See what I'm saying?

The solution may be something like

        if (is_swiotlb_for_alloc(dev))
                goto swiotlb_alloc_only;

at the top of the allocation routines, or whatever. Don't make the
other conditionals - that have nothing to do with this thing - get
mixed up in the fundamental rule.

Also, that's an odd name. "is_swiotlb_for_alloc()"? Those four words
do not make sense together in that order. Shouldn't it be
"use_swiotlb_for_alloc()"?

So make the actual rules individual, and make them make sense. It's ok
to have five (or more) of those kinds of things, but they need to be
individually sensible, and not randomly tied to each other as one big
broken non-sensible thing.

Please no more of this completely crazy "let's mix it all together in
a blender, and write code that makes no sense".

In the immediate short term, please

 (a) explain what the rules actually are

 (b) so that I can do a merge that actually does the right thing (ie I
_think_ I should add that extra test above, but I want this thought
about and confirmed or be told why that isn't the case).

and then the rewrite should be a future step.  But that rewrite of
those disgusting "rules" absolutely NEEDS to happen, because looking
at that spaghetti of random config options and other random
conditionals, that's simply not acceptable.

It's particularly not acceptable since I suspect that it all probably
*works* even if you allocate from the wrong pool, but it then
presumably violates some security rule that it was set up so that
allocations would *not* preferably get mixed up in some global pool.

Pls advise. I'm not asking anybody to do the merge for me - I'm
literally asking for that code and the rules to be clarified.

             Linus
