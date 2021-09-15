Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13A940CEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhIOVdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhIOVds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:33:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541EDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:32:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g8so8780244edt.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mGAw8q3zl1bN5UgJDAsMqPFpzfSB+ntQZVF/1Dwx18=;
        b=e7W4RVWATeJ+Hx6ccBrK+gg6gqb939OThgRsu8bcxwl44QamDn3pUQvuFM6GUYJLLV
         ZXqP2KMSQSciTNEASFdhpOcDhTPWZoXlKIm7XnTM5HloZwvOYupFHwQz1jX3He2zMOVA
         ELvZ4iapE18Xm5dDotEVuYvnMdln3vp55pTKKLICr9knmk2VXfuLFf860MYRYUGGjN3u
         CcCsvqdSgEc0euLVlSdjAnQ07QK6mIFICQ2wpnutZFnEpCIacSp+NB39hENVqvRHLEve
         r+7190qyoLfyPxqRy89NSk7ucByoxMc0GJYuZ+nZ/8zllXA9RfGW++OieJloxx/CBRI2
         kcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mGAw8q3zl1bN5UgJDAsMqPFpzfSB+ntQZVF/1Dwx18=;
        b=NNbq+qaygyuQb3D1uH1pcjEW5AXThQaAZc5Z79KkFEryTvwya7u7TTj5Cp8zNxI/ow
         hHAmJvQPoNap6xxpRHF2jD28sUyKwFUiVdJm2I0mjoAFk9ATSsnM4PNDU2+IDK/KKON3
         qu0mBBvXNc1NfUggJ444N5cgZJoJZLYUg76WrXTxhd4POJXLN4i8IYtKqVmfhqwszsJh
         ZO0PP/B7FqR2V6rb1VCaXpDDRcw9uhK7yiYpamPVSQ1GC9RB4QlxKUfYmhzrN7mHuvTz
         oiZgBGLqT0GANHZKrepzviOV/goKFsenX1KV5lwQCBM4V+SAwOwOe2RI7lkzGPJgA9F8
         HJug==
X-Gm-Message-State: AOAM533uzEGYMgi/gkiWz3ad7YWod1skJbIi8PidzXk8n/Svqn/BYV0/
        NlFkl8Ji2FGqIW0vhOid0cNijYD+OCEkXNWhRkA=
X-Google-Smtp-Source: ABdhPJyfguV+pBRLuXuGAUmQtB4w48ln/YI8aXfUR5crJ9iL8Z0JXDb/b6P9JlCCoAULge/zlsu9HHH7c9jrQi+drzM=
X-Received: by 2002:a17:906:3854:: with SMTP id w20mr2215243ejc.537.1631741547865;
 Wed, 15 Sep 2021 14:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210914013701.344956-1-ying.huang@intel.com> <20210914013701.344956-2-ying.huang@intel.com>
 <CAHbLzkpRWwtkhnXUZEUk3LgpHtmgNJRPGUjKzd9bhQU33Y4u2g@mail.gmail.com>
 <8735q63947.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAHbLzko-hR74s5HKMx5SG6bwaoJvcHSLeKwihkpvhYj7+hX+Sw@mail.gmail.com>
 <874kamwkvn.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <874kamwkvn.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Sep 2021 14:32:15 -0700
Message-ID: <CAHbLzkqO4mNUGO=wpzPjU=rdc+=KyssqapmEDLAzVDKPGGfY0Q@mail.gmail.com>
Subject: Re: [PATCH -V8 1/6] NUMA balancing: optimize page placement for
 memory tiering system
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:58 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > On Tue, Sep 14, 2021 at 6:45 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Yang Shi <shy828301@gmail.com> writes:
> >>
> >> > On Mon, Sep 13, 2021 at 6:37 PM Huang Ying <ying.huang@intel.com> wrote:
> >> >>
> >> >> With the advent of various new memory types, some machines will have
> >> >> multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
> >> >> memory subsystem of these machines can be called memory tiering
> >> >> system, because the performance of the different types of memory are
> >> >> usually different.
> >> >>
> >> >> In such system, because of the memory accessing pattern changing etc,
> >> >> some pages in the slow memory may become hot globally.  So in this
> >> >> patch, the NUMA balancing mechanism is enhanced to optimize the page
> >> >> placement among the different memory types according to hot/cold
> >> >> dynamically.
> >> >>
> >> >> In a typical memory tiering system, there are CPUs, fast memory and
> >> >> slow memory in each physical NUMA node.  The CPUs and the fast memory
> >> >> will be put in one logical node (called fast memory node), while the
> >> >> slow memory will be put in another (faked) logical node (called slow
> >> >> memory node).  That is, the fast memory is regarded as local while the
> >> >> slow memory is regarded as remote.  So it's possible for the recently
> >> >> accessed pages in the slow memory node to be promoted to the fast
> >> >> memory node via the existing NUMA balancing mechanism.
> >> >>
> >> >> The original NUMA balancing mechanism will stop to migrate pages if the free
> >> >> memory of the target node will become below the high watermark.  This
> >> >> is a reasonable policy if there's only one memory type.  But this
> >> >> makes the original NUMA balancing mechanism almost not work to optimize page
> >> >> placement among different memory types.  Details are as follows.
> >> >>
> >> >> It's the common cases that the working-set size of the workload is
> >> >> larger than the size of the fast memory nodes.  Otherwise, it's
> >> >> unnecessary to use the slow memory at all.  So in the common cases,
> >> >> there are almost always no enough free pages in the fast memory nodes,
> >> >> so that the globally hot pages in the slow memory node cannot be
> >> >> promoted to the fast memory node.  To solve the issue, we have 2
> >> >> choices as follows,
> >> >>
> >> >> a. Ignore the free pages watermark checking when promoting hot pages
> >> >>    from the slow memory node to the fast memory node.  This will
> >> >>    create some memory pressure in the fast memory node, thus trigger
> >> >>    the memory reclaiming.  So that, the cold pages in the fast memory
> >> >>    node will be demoted to the slow memory node.
> >> >>
> >> >> b. Make kswapd of the fast memory node to reclaim pages until the free
> >> >>    pages are a little more (about 10MB) than the high watermark.  Then,
> >> >>    if the free pages of the fast memory node reaches high watermark, and
> >> >>    some hot pages need to be promoted, kswapd of the fast memory node
> >> >>    will be waken up to demote some cold pages in the fast memory node to
> >> >>    the slow memory node.  This will free some extra space in the fast
> >> >>    memory node, so the hot pages in the slow memory node can be
> >> >>    promoted to the fast memory node.
> >> >>
> >> >> The choice "a" will create the memory pressure in the fast memory
> >> >> node.  If the memory pressure of the workload is high, the memory
> >> >> pressure may become so high that the memory allocation latency of the
> >> >> workload is influenced, e.g. the direct reclaiming may be triggered.
> >> >>
> >> >> The choice "b" works much better at this aspect.  If the memory
> >> >> pressure of the workload is high, the hot pages promotion will stop
> >> >> earlier because its allocation watermark is higher than that of the
> >> >> normal memory allocation.  So in this patch, choice "b" is
> >> >> implemented.
> >> >>
> >> >> In addition to the original page placement optimization among sockets,
> >> >> the NUMA balancing mechanism is extended to be used to optimize page
> >> >> placement according to hot/cold among different memory types.  So the
> >> >> sysctl user space interface (numa_balancing) is extended in a backward
> >> >> compatible way as follow, so that the users can enable/disable these
> >> >> functionality individually.
> >> >>
> >> >> The sysctl is converted from a Boolean value to a bits field.  The
> >> >> definition of the flags is,
> >> >>
> >> >> - 0x0: NUMA_BALANCING_DISABLED
> >> >> - 0x1: NUMA_BALANCING_NORMAL
> >> >> - 0x2: NUMA_BALANCING_MEMORY_TIERING
> >> >
> >> > Thanks for coming up with the patches. TBH the first question off the
> >> > top of my head is all the complexity is really worthy for real life
> >> > workload at the moment? And the interfaces (sysctl knob files exported
> >> > to users) look complicated for the users. I don't know if the users
> >> > know how to set an optimal value for their workloads.
> >> >
> >> > I don't disagree the NUMA balancing needs optimization and improvement
> >> > for tiering memory, the question we need answer is how far we should
> >> > go for now and what the interfaces should look like. Does it make
> >> > sense to you?
> >> >
> >> > IMHO I'd prefer the most simple and straightforward approach at the
> >> > moment. For example, we could just skip high water mark check for PMEM
> >> > promotion.
> >>
> >> Hi, Yang,
> >>
> >> Thanks for comments.
> >>
> >> I understand your concerns about complexity.  I have tried to organize
> >> the patchset so that the initial patch is as simple as possible and the
> >> complexity is introduced step by step.  But it seems that your simplest
> >> version is even simpler than my one :-)
> >>
> >> In this patch ([1/6]), I introduced 2 stuff.
> >>
> >> Firstly, a sysctl knob is provided to disable the NUMA balancing based
> >> promotion.  Per my understanding, you suggest to remove this.  If so,
> >> optimizing cross-socket access and promoting hot PMEM pages to DRAM must
> >> be enabled/disabled together.  If a user wants to enable promoting the
> >> hot PMEM pages to DRAM but disable optimizing cross-socket access
> >> because they have already bound the CPU of the workload so that there's no
> >> much cross-socket access, how can they do?
> >
> > I should make myself clearer. Here I mean the whole series, not this
> > specific patch. I'm concerned that the interfaces (hint fault latency
> > and ratelimit) are hard to understand and configure for users and
> > whether we go too far at the moment or not. I'm dealing with the end
> > users, I'd admit I'm not even sure how to configure the knobs to
> > achieve optimal performance for different real life workloads.
>
> Sorry, I misunderstand your original idea.  I understand that the knob
> isn't user-friendly.  But sometimes, we cannot avoid it completely :-(
> In this patchset, I try to introduce the complexity and knobs one by
> one, and show the performance benefit of each step for people to judge
> whether the newly added complexity and knob can be complemented by the
> performance increment.  If the benefit of some patches cannot complement
> its complexity, I am OK to merge just part of the patchset firstly.

Understood. But I really hesitate to go that far at this moment since
the picture is not that clear yet IMHO. We have to support them (maybe
forever) once we merge them.

So I'd prefer to work on the simplest and most necessary stuff for
now. Just like how we dealt with demotion.

>
> So how about be more specific?  For example, if you are general OK about
> the complexity and knob introduced by [1-3/6], but have concerns about
> [4/6], then we can discuss about that specifically?

Yeah, we could.

>
> > For this specific patch I'm ok to a new promotion mode. There might be
> > usecase that users just want to do promotion between tiered memory but
> > not care about NUMA locality.
>
> Yes.
>
> >> Secondly, we add a promote watermark to the DRAM node so that we can
> >> demote/promote pages between the high and promote watermark.  Per my
> >> understanding, you suggest just to ignore the high watermark checking
> >> for promoting.  The problem is that this may make the free pages of the
> >> DRAM node too few.  If many pages are promoted in short time, the free
> >> pages will be kept near the min watermark for a while, so that the page
> >> allocation from the application will trigger direct reclaiming.  We have
> >> observed page allocation failure in a test before with a similar policy.
> >
> > The question is, applicable to the hint fault latency and ratelimit
> > too, we already have some NUMA balancing knobs to control scan period
> > and scan size and watermark knobs to tune how aggressively kswapd
> > works, can they do the same jobs instead of introducing any new knobs?
>
> In this specific patch, we don't introduce a new knob for the page
> demotion.  For other knobs, how about discuss them in the patch that
> introduce them and one by one?

That comment is applicable to the watermark hack in this patch too.
Per your above description, the problem is the significant amount of
promotion in short period of time may deplete free memory. So I'm
wondering if the amount of promotion could be ratelimited by NUMA
balancing scan period and scan size. I understand this may have some
hot pages stay on PMEM for a longer time, but does it really matter?
In addition, the gap between low <--> min <--> high could be adjusted
by watermark_scale_factor, so kswapd could work more aggressively to
keep free memory.

>
> Best Regards,
> Huang, Ying
