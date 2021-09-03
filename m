Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB563FF86C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 02:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbhICAnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 20:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbhICAna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 20:43:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F931C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 17:42:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p15so6887807ljn.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gyGIfPvRH9/NCfQ7TGegB3Buo2A/4bm39ph4Oj4IIII=;
        b=SdjZETMafWt3AOX6tGD/IB2li/etuj1f/zjzA93FdIGctS8C59Zq1K6aTCbFtxi/BC
         RFFvrzct/Nbi6hOtaDcwhMOsXkZaVN1gLpvYjpDmkTcNHTOkyLokRO1cGd788fL56nkF
         Uca5Lj6aPsruu6WK/Jfujw7XHNGFsLUoWYCF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gyGIfPvRH9/NCfQ7TGegB3Buo2A/4bm39ph4Oj4IIII=;
        b=WsBfM9sVpqcb8gLmVamduYKYTUcfy4FZpZRYkeCywTSNhY29y9WKnFTW+oNDURNAYM
         Ee3jRfjuh9s1nv8Drl8XvZQzOqJ4rNWvljxIAl/TBhBbJxVKhJCHCyDbSVHdS/CietT/
         qy/taL9Yl1TS/BtzmB2amg1BwJ4ZaCkzixXpqg7X6XXYAufNiXf+waE/wq/oIzAB//hr
         FL1KPsp1wY8zfbGKWMkmTGUf/3nykr8MnUsVbjyYb9rruF3xTw0pZYWTfAxlZk1kw1ZF
         6eH0eVP9jjUAtdyIBd/5dQFClyMV/qGDJyiREmiZPXMSKj78rH1hYy44THERd5cY9dZt
         WJkg==
X-Gm-Message-State: AOAM5307F3XE45/vWLZuIxh4IIZdtooepO673cNsR1p4yLH1FW46WOjO
        otocOppqslzbwBk7kcZgajZtYREUmOjfjgVfIHI=
X-Google-Smtp-Source: ABdhPJwyn8IPl/2hlWcdeMlqkSG4IpJ5XSUlSIMVuElp2DctEiSd8gPAYTO4xCkm2/5Ps77gMv1zJg==
X-Received: by 2002:a2e:b173:: with SMTP id a19mr828404ljm.210.1630629749128;
        Thu, 02 Sep 2021 17:42:29 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y10sm409983ljj.10.2021.09.02.17.42.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 17:42:28 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id f18so8162719lfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 17:42:28 -0700 (PDT)
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr618121lfu.253.1630629747904;
 Thu, 02 Sep 2021 17:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <YS/r5eaf/ps5ekie@localhost.localdomain> <CAHk-=wiYNEj8JRO3f4L9GG06Akwwr18mM4Co8nWeAH44a9y-aw@mail.gmail.com>
 <bceb9212-8fb0-be6e-997f-82962f855081@arm.com>
In-Reply-To: <bceb9212-8fb0-be6e-997f-82962f855081@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 17:42:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg35pAyCFC6_hhBTAGGUPprf=hwx5+Ey1tnqXzuaOLsRQ@mail.gmail.com>
Message-ID: <CAHk-=wg35pAyCFC6_hhBTAGGUPprf=hwx5+Ey1tnqXzuaOLsRQ@mail.gmail.com>
Subject: Re: [GIT PULL] (swiotlb) stable/for-linus-5.15
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Claire Chang <tientzu@chromium.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Will Deacon <will@kernel.org>, pasic@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 2:55 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Not to defend the state things have got into - frankly I've found it
> increasingly hard to follow for some time now too - but I believe the
> unwritten story is of the one true dma-direct trying to be all things to
> all users, and there are several aspects at play here which are mutually
> exclusive in practice.

Ugh.

Some of that "mutual exclusion" seems to be encoded in peoples heads,
not in the code itself.

> The global pool is essentially for noMMU, so should not be expected to
> overlap with SWIOTLB at all, much less systems using restricted DMA.

If I read that right, you're saying that in this case, the possible
mis-merge doesn't matter?

> > Btw, what's the actual logic with the
> >
> >              !dev_is_dma_coherent(dev)
> >
> > tests anyway? Those are pre-existing, but seem odd and senseless. The
> > function is called "dma_alloc_from_global_coherent()", but it is *not*
> > called when "dev_is_dma_coherent()".
>
> Heh, good terminology for this is hard to find. One way to make sense of
> it is to consider that either the device itself is coherent - i.e. can
> snoop caches such that we don't have to much in the way of special
> treatment - or otherwise it's the memory which has to be made coherent,
> i.e. remapped non-cacheable, such that CPUs and non-snooping devices can
> still maintain a consistent view of it (note: I'm focusing on caches
> here for simplicity, but in practice there's other stuff like memory
> encryption in the mix too). Hence a "coherent pool" is actually a pool
> of non-cacheably-mapped memory from which to allocate for
> non-hardware-coherent devices

Ok. Reading that code as an innocent (well, somewhat!) outsider sure
makes that confusing, though.

> > That code needs to be split up, and the logic needs to be made
> > understandable. Preferably *obvious*. Which it isn't now.
>
> I suppose one logical option would be to split out dedicated versions of
> dma-direct for at least the major differences - noMMU,
> CONFIG_DMA_DIRECT_REMAP, etc. - but that does run the risk of ending up
> as a lot of very similar looking code and being a rich source of bugs
> where things get added/fixed in one place but not the others.

I would hope that all the actual *code* is in these helper functions
that do not have the "in this situation, do X" AT ALL.

That does actually seem to be what the intent of some of those
functions are - so there are functions like that
"dma_direct_alloc_from_pool()", which does one thing and one thing
only, and doesn't have any odd conditionals.

And then dma_direct_alloc() _kind_ of tries to be the wrapper function
that dispatches to the different versions. I think.

Except the dispatch logic ends up being all those different cases that
have nothing to do with each other, because people have very clearly
tried to avoid code duplication by just saying "ok, in these two
entirely unrelated situations, we do the same thing".

So instead of having a

     if (case_X) do_Y();

kind of logic, it ends up doing

     if (case_X && !case_Y) do_A();

even if case_X and case_Y don't seem to really be related in any real way.

And any time somebody comes up with a new case, it gets added to the pile.

Which doesn't help readability.

It doesn't really help when the code also has comments like

        /* we always manually zero the memory once we are done */

that aren't actually true at all - the "always" here is about that one
single case, and the comment comes from the fact that in *that* case -
but not other cases - we're now masking off the __GFP_ZERO from the
gfp flags, and then zeroing manually at the end.

I had to go back into the history of where that comment came from to
really make sense of it. The "always" used to be true within the
context of __dma_direct_alloc_pages(), then it got moved to be one
sub-case in dma_direct_alloc() and now it's really more of a "in this
case" than "always", because other cases depend on the zeroing being
done by the other helper cases.

It's certainly possible that the code makes more sense to somebody who
has stared at that more than I have.

> > In the immediate short term, please
> >
> >   (a) explain what the rules actually are
>
> I hope some of the background above has helped a bit.

Well, I'd really like a very explicit "the is_swiotlb_for_alloc()
situation cannot happen for that global pool case because XYZ, so the
condition in that conflict doesn't matter".

That's what I _think_ you implied at the top. But it wasn't very
explicit. You say "essentially noMMU, so it should be expected to
overlap".

"essentially"? "shouldn't be expected"? I'm not getting a lot of warm
and fuzzies from that. I'd like to have something a bit more concrete.

Then I can do that merge that I think looks nonsensical, but in the hope that

 (a) it works correctly and does what people expect

and

 (b) that hopefully somebody will look at that logic and make it
actually make sense.

which would just make me feel a lot better about things.

         Linus
