Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561994000C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 15:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhICNwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 09:52:45 -0400
Received: from foss.arm.com ([217.140.110.172]:43480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235009AbhICNwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 09:52:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43751D6E;
        Fri,  3 Sep 2021 06:51:44 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D07DC3F694;
        Fri,  3 Sep 2021 06:51:42 -0700 (PDT)
Subject: Re: [GIT PULL] (swiotlb) stable/for-linus-5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Claire Chang <tientzu@chromium.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Will Deacon <will@kernel.org>, pasic@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YS/r5eaf/ps5ekie@localhost.localdomain>
 <CAHk-=wiYNEj8JRO3f4L9GG06Akwwr18mM4Co8nWeAH44a9y-aw@mail.gmail.com>
 <bceb9212-8fb0-be6e-997f-82962f855081@arm.com>
 <CAHk-=wg35pAyCFC6_hhBTAGGUPprf=hwx5+Ey1tnqXzuaOLsRQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ab606dd7-87a7-25cd-8f0e-841638cc40e3@arm.com>
Date:   Fri, 3 Sep 2021 14:51:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg35pAyCFC6_hhBTAGGUPprf=hwx5+Ey1tnqXzuaOLsRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-03 01:42, Linus Torvalds wrote:
> On Thu, Sep 2, 2021 at 2:55 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Not to defend the state things have got into - frankly I've found it
>> increasingly hard to follow for some time now too - but I believe the
>> unwritten story is of the one true dma-direct trying to be all things to
>> all users, and there are several aspects at play here which are mutually
>> exclusive in practice.
> 
> Ugh.
> 
> Some of that "mutual exclusion" seems to be encoded in peoples heads,
> not in the code itself.
> 
>> The global pool is essentially for noMMU, so should not be expected to
>> overlap with SWIOTLB at all, much less systems using restricted DMA.
> 
> If I read that right, you're saying that in this case, the possible
> mis-merge doesn't matter?

Yes, as things currently stand, DMA_GLOBAL_POOL is only enabled by Arm 
noMMU and Hexagon, neither of which enable SWIOTLB.

>>> Btw, what's the actual logic with the
>>>
>>>               !dev_is_dma_coherent(dev)
>>>
>>> tests anyway? Those are pre-existing, but seem odd and senseless. The
>>> function is called "dma_alloc_from_global_coherent()", but it is *not*
>>> called when "dev_is_dma_coherent()".
>>
>> Heh, good terminology for this is hard to find. One way to make sense of
>> it is to consider that either the device itself is coherent - i.e. can
>> snoop caches such that we don't have to much in the way of special
>> treatment - or otherwise it's the memory which has to be made coherent,
>> i.e. remapped non-cacheable, such that CPUs and non-snooping devices can
>> still maintain a consistent view of it (note: I'm focusing on caches
>> here for simplicity, but in practice there's other stuff like memory
>> encryption in the mix too). Hence a "coherent pool" is actually a pool
>> of non-cacheably-mapped memory from which to allocate for
>> non-hardware-coherent devices
> 
> Ok. Reading that code as an innocent (well, somewhat!) outsider sure
> makes that confusing, though.
> 
>>> That code needs to be split up, and the logic needs to be made
>>> understandable. Preferably *obvious*. Which it isn't now.
>>
>> I suppose one logical option would be to split out dedicated versions of
>> dma-direct for at least the major differences - noMMU,
>> CONFIG_DMA_DIRECT_REMAP, etc. - but that does run the risk of ending up
>> as a lot of very similar looking code and being a rich source of bugs
>> where things get added/fixed in one place but not the others.
> 
> I would hope that all the actual *code* is in these helper functions
> that do not have the "in this situation, do X" AT ALL.
> 
> That does actually seem to be what the intent of some of those
> functions are - so there are functions like that
> "dma_direct_alloc_from_pool()", which does one thing and one thing
> only, and doesn't have any odd conditionals.
> 
> And then dma_direct_alloc() _kind_ of tries to be the wrapper function
> that dispatches to the different versions. I think.
> 
> Except the dispatch logic ends up being all those different cases that
> have nothing to do with each other, because people have very clearly
> tried to avoid code duplication by just saying "ok, in these two
> entirely unrelated situations, we do the same thing".

Indeed, although one could argue "entirely unrelated" - the fact that 
they end up wanting the same handling *makes* them related by purpose. 
By way of analogy, when I go to the supermarket I'll usually find the 
tomatoes closer to other salad vegetables than to the potatoes ;)

> So instead of having a
> 
>       if (case_X) do_Y();
> 
> kind of logic, it ends up doing
> 
>       if (case_X && !case_Y) do_A();
> 
> even if case_X and case_Y don't seem to really be related in any real way.
> 
> And any time somebody comes up with a new case, it gets added to the pile.
> 
> Which doesn't help readability.

Yup, however the inherently overlapping nature of some of the things 
involved means that flipping things around arguably just brings a 
*different* set of readability/maintainability issues:

	if (X) //do A
	else if (Y) //do A and C
	else if (Z) //do B and C

Basically if you consolidate the conditions then you're doomed to 
duplicate non-trivial amounts of the actual handling. In fact now that 
I'm looking closely I'm wondering why we already have the 
set_memory_decrypted() stanza in there twice, and starting to 
second-guess myself as to whether there might be some really subtle 
significance to it that I can't see :/

> It doesn't really help when the code also has comments like
> 
>          /* we always manually zero the memory once we are done */
> 
> that aren't actually true at all - the "always" here is about that one
> single case, and the comment comes from the fact that in *that* case -
> but not other cases - we're now masking off the __GFP_ZERO from the
> gfp flags, and then zeroing manually at the end.

Hmm, I guess I'd read "always" in the middle of a function as inherently 
only qualifying execution which actually reaches that point in the 
function, but either way it's indeed a long way from "We mask out 
__GFP_ZERO here because if we're remapping then we need to memset() 
through the new address anyway, so it's simplest if we do that 
unconditionally and skip any other possibly-redundant zeroing."

> I had to go back into the history of where that comment came from to
> really make sense of it. The "always" used to be true within the
> context of __dma_direct_alloc_pages(), then it got moved to be one
> sub-case in dma_direct_alloc() and now it's really more of a "in this
> case" than "always", because other cases depend on the zeroing being
> done by the other helper cases.
> 
> It's certainly possible that the code makes more sense to somebody who
> has stared at that more than I have.
> 
>>> In the immediate short term, please
>>>
>>>    (a) explain what the rules actually are
>>
>> I hope some of the background above has helped a bit.
> 
> Well, I'd really like a very explicit "the is_swiotlb_for_alloc()
> situation cannot happen for that global pool case because XYZ, so the
> condition in that conflict doesn't matter".
> 
> That's what I _think_ you implied at the top. But it wasn't very
> explicit. You say "essentially noMMU, so it should be expected to
> overlap".
> 
> "essentially"? "shouldn't be expected"? I'm not getting a lot of warm
> and fuzzies from that. I'd like to have something a bit more concrete.

As above, upstream Kconfigs do prevent any possible overlap at the 
moment (with "swiotlb: use depends on for DMA_RESTRICTED_POOL" fixing 
the bug which inadvertently made SWIOTLB user-selectable). I was a bit 
handwavy since I'm familiar with the global pool as used by Arm noMMU, 
but I'm not entirely sure what Hexagon's deal is (it looks like it does 
have an MMU, yet still doesn't do remapping) so I didn't want to speak 
in absolutes which might prove to be inaccurate. I also can't 
unequivocally rule out someone coming along in future with some wacky 
use-case for enabling both configs at once (TBH I can imagine some of 
the protected VM schemes maybe going in that direction), but that 
couldn't happen without further patches anyway.

Thanks,
Robin.

> Then I can do that merge that I think looks nonsensical, but in the hope that
> 
>   (a) it works correctly and does what people expect
> 
> and
> 
>   (b) that hopefully somebody will look at that logic and make it
> actually make sense.
> 
> which would just make me feel a lot better about things.
> 
>           Linus
> 
