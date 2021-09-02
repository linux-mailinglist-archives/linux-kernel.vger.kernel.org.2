Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14EB3FF6AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347894AbhIBV4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:56:45 -0400
Received: from foss.arm.com ([217.140.110.172]:58246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347907AbhIBV4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:56:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F07431B;
        Thu,  2 Sep 2021 14:55:15 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CC343F5A1;
        Thu,  2 Sep 2021 14:55:13 -0700 (PDT)
Subject: Re: [GIT PULL] (swiotlb) stable/for-linus-5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Claire Chang <tientzu@chromium.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Will Deacon <will@kernel.org>, pasic@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YS/r5eaf/ps5ekie@localhost.localdomain>
 <CAHk-=wiYNEj8JRO3f4L9GG06Akwwr18mM4Co8nWeAH44a9y-aw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bceb9212-8fb0-be6e-997f-82962f855081@arm.com>
Date:   Thu, 2 Sep 2021 22:55:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiYNEj8JRO3f4L9GG06Akwwr18mM4Co8nWeAH44a9y-aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2021-09-02 19:54, Linus Torvalds wrote:
> On Wed, Sep 1, 2021 at 2:09 PM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
>>
>> which has a new feature called restricted DMA pools. It allows SWIOTLB to utilize
>> per-device (or per-platform) allocated memory pools instead of using the global one.
>>
>> The first big user of this is ARM Confidential Computing where the memory for DMA
>> operations can be set per platform.
> 
> Hmm.
> 
> I was going to merge this, but I had already merged the dma-mapping
> updates from Christoph Hellwig first.
> 
> And it turns out that the conflicts are trivial to do the
> straightforward way, that's not a problem.
> 
> But I think that straightforward way is actually buggy, because it
> makes the is_swiotlb_for_alloc() type allocations then use that new
> global pool for allocations.
> 
> Just to check, I looked into what linux-next did, in case this had
> caused any discussion there. Nope. Linux-next does the obvious
> straightforward merge.
> 
> So I'm going to hold off merging until I can clarify what the rules
> for these restricted DMA pools are, because I get the feeling that
> people didn't actually think about the interaction with the new global
> pool very much.

Not to defend the state things have got into - frankly I've found it 
increasingly hard to follow for some time now too - but I believe the 
unwritten story is of the one true dma-direct trying to be all things to 
all users, and there are several aspects at play here which are mutually 
exclusive in practice.

> Or if they did, it didn't get communicated to me. Christoph mentioned
> the merge conflict, but he implied that I should just merge it the
> obvious way. And the more I look at that code, the less I think that's
> the right thing to do.
> 
> So just to make this very concrete, look at dma_direct_alloc(). The
> straightforward merge is to do this:
> 
>          if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
>              !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
>              !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
>              !dev_is_dma_coherent(dev) &&
>              !is_swiotlb_for_alloc(dev))
>                  return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
> 
>          if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
>              !dev_is_dma_coherent(dev))
>                  return dma_alloc_from_global_coherent(dev, size, dma_handle);
> 
> and that seems to be what linux-next did too.
> 
> But that means that a is_swiotlb_for_alloc(dev) allocation can use
> that new global coherent pool (see that second case).
 >
> Maybe that's ok. But I get the feeling that it is not. It sure as heck
> isn't obvious. If it's ok to use the global pool, then fine - but I
> want to know why (and I want the code to say why).

The global pool is essentially for noMMU, so should not be expected to 
overlap with SWIOTLB at all, much less systems using restricted DMA.

> I think that the second conditional should probably get an all-new added
> 
>              && !is_swiotlb_for_alloc(dev)
> 
> in it, but that's not what happened in linux-next. And all this code
> is messy and illogical and crazy.
> 
> Btw, what's the actual logic with the
> 
>              !dev_is_dma_coherent(dev)
> 
> tests anyway? Those are pre-existing, but seem odd and senseless. The
> function is called "dma_alloc_from_global_coherent()", but it is *not*
> called when "dev_is_dma_coherent()".

Heh, good terminology for this is hard to find. One way to make sense of 
it is to consider that either the device itself is coherent - i.e. can 
snoop caches such that we don't have to much in the way of special 
treatment - or otherwise it's the memory which has to be made coherent, 
i.e. remapped non-cacheable, such that CPUs and non-snooping devices can 
still maintain a consistent view of it (note: I'm focusing on caches 
here for simplicity, but in practice there's other stuff like memory 
encryption in the mix too). Hence a "coherent pool" is actually a pool 
of non-cacheably-mapped memory from which to allocate for 
non-hardware-coherent devices in contexts where we can't remap regular 
page allocations on-the-fly (also called an "atomic pool" in various 
places for that reason). For noMMU with caches, that's effectively all 
the time, which is where the global pool came from - unlike the atomic 
pool(s) for MMU systems which can just be allocated and remapped at 
boot, the global pool is often subject to platform-specific restrictions 
like being at a special physical alias, so starts life in a very 
different way.

[ And the reason it's called the global coherent pool is from the 
implementation growing out of per-device coherent pools, which are yet 
another similar-but-slightly-different thing. For added fun, those may 
also intersect with restricted DMA, but that all forks off down the 
dma_alloc_from_dev_coherent() path before we even get to dma-direct. ]

After the initial setup, though, I guess it might be possible with a bit 
more refactoring to streamline the global pool bits into the 
dma_alloc_from_pool() path, since by that point it's functionally 
equivalent to the atomic pool(s), just under different conditions.

> Is it just me, or does anybody else also get the feeling that too many
> recreational drugs may have been involved in the creation of this code
> over the years? People possibly self-medicating to take away the pain?
> 
> Anyway - I'm going to punt on this pull request, because I want
> clarification that didn't happen despite the conflict in linux-next.
> 
> I also have to say, looking at that code, you guys write collectively
> some disgusting code.
> 
> I think individually each change has been probably fairly small, but
> taken together it's just too nasty for words. That code should be
> taken out behind a shed and shot in the head, because it's entirely
> impossible to read all those nasty conditionals over multiple lines.
> 
> So regardless of what the merge resolution should be, I think this
> code needs reorganizing. Because those entirely random conditionals
> with several different config tests that DO NOT MAKE SENSE TOGETHER
> should not exist.
> 
> The merge conflict is just a symptom of the disease in this code, not
> the problem itself.
> 
> That code needs to be split up, and the logic needs to be made
> understandable. Preferably *obvious*. Which it isn't now.

I suppose one logical option would be to split out dedicated versions of 
dma-direct for at least the major differences - noMMU, 
CONFIG_DMA_DIRECT_REMAP, etc. - but that does run the risk of ending up 
as a lot of very similar looking code and being a rich source of bugs 
where things get added/fixed in one place but not the others.

> In particular, if the rule is that "is_swiotlb_for_alloc()" means that
> you *have* to use swiotlb_alloc() and absolutely nothing else", then
> that should be the logic, and it should be at the top, and that should
> be all it is. No m ixing with the other tests that are about entirely
> different issues.

Sadly it doesn't entirely mean that. A device using restricted DMA 
*should* usually end up allocating from its own dedicated SWIOTLB pool, 
but there may be cases where falling back to 
dma_direct_alloc_from_pool() is still OK, or maybe even necessary.

> Because right now, that code is literally set up to use completely
> random different allocation choices depending on completely random and
> illogical combinations of config rules mixed with random device rules.
> 
> Make each conditional be about *one* thing, and one thing only. Not
> about three unrelated things that may or may have the same end result
> rule.
> 
> See what I'm saying?
> 
> The solution may be something like
> 
>          if (is_swiotlb_for_alloc(dev))
>                  goto swiotlb_alloc_only;
> 
> at the top of the allocation routines, or whatever. Don't make the
> other conditionals - that have nothing to do with this thing - get
> mixed up in the fundamental rule.
> 
> Also, that's an odd name. "is_swiotlb_for_alloc()"? Those four words
> do not make sense together in that order. Shouldn't it be
> "use_swiotlb_for_alloc()"?
> 
> So make the actual rules individual, and make them make sense. It's ok
> to have five (or more) of those kinds of things, but they need to be
> individually sensible, and not randomly tied to each other as one big
> broken non-sensible thing.
> 
> Please no more of this completely crazy "let's mix it all together in
> a blender, and write code that makes no sense".
> 
> In the immediate short term, please
> 
>   (a) explain what the rules actually are

I hope some of the background above has helped a bit.

>   (b) so that I can do a merge that actually does the right thing (ie I
> _think_ I should add that extra test above, but I want this thought
> about and confirmed or be told why that isn't the case).
> 
> and then the rewrite should be a future step.  But that rewrite of
> those disgusting "rules" absolutely NEEDS to happen, because looking
> at that spaghetti of random config options and other random
> conditionals, that's simply not acceptable.

FWIW, no argument from me there - I believe it's actually ChromeOS and 
Android pKVM having the initial use-cases for getting this new SWIOTLB 
functionality landed, but in terms of Arm CCA we certainly still have 
some interest in it at the moment, so I might be able to wrangle some 
time to take on a bit of cleanup from that angle.

Cheers,
Robin.

> It's particularly not acceptable since I suspect that it all probably
> *works* even if you allocate from the wrong pool, but it then
> presumably violates some security rule that it was set up so that
> allocations would *not* preferably get mixed up in some global pool.
> 
> Pls advise. I'm not asking anybody to do the merge for me - I'm
> literally asking for that code and the rules to be clarified.
> 
>               Linus
> 
