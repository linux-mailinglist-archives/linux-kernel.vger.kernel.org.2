Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE5940EE75
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 02:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbhIQAta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 20:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhIQAt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 20:49:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7019CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:48:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c21so23206906edj.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NpzT3fgbL3NrbU5ItkkZ9aOfo9ffuVM3LtA5XE7/Ves=;
        b=be76PH15gofA7Ctau9Z4+/xqQIL4CJJEtI0PxZrlDSxJhtmrBaBbXf55+4obvF8GJq
         mxWljkgy50vaUeMy5/fShmmkL7VVIooiTiF9bNIko1TPtUv7NPNSCpMiZeiWRtayDVpl
         LIYMyhbwFirpAcviKs64crg58pXsp6GkFmvzJbX+c1Ss7c/j79TQkE8SWwmb+fS1L7Bf
         91AXY2Vwci6HK/FMG1v8C/e4klhRkHqTYQ81Hv87PorUCmouIe2YEHFG6ca25KNRxlg8
         b/rVY7RfpylcVohjLFp351OJKmR75gPhAJHEFPn08TR/x9ecr2MSwtHmcHwwO/nU4k5a
         38cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpzT3fgbL3NrbU5ItkkZ9aOfo9ffuVM3LtA5XE7/Ves=;
        b=EgnrjD8z3B8xl9eQw1V2PzlIQMNZbPeU9RowIIEkUH2V3+AoSkod49ArjVqTyaRrrz
         qyh/burgLdJ1bK/oVJY/tgPLohM7RueSzmXrLgYrDdIQAGUxUSFoEgSXvq4FYbxgFDR1
         pgy4uPp4tFQ+3qXkEljrbdx0VL1vrWvB/bDcIcJxVBEhoyCwLw3MfxQ31oFrNd7dOqDG
         mPcl7JfeZANoi+GO9EjvqC+9EMFDrE+yqjPuxRsYiUppxGtu//jJ8it4hrh/c2GhlxyB
         krlDibpwYMfhHRF4QtuYozLaBLahIkfOCZmf7/wTzxezVhaADR4GswwMzqoSynmH9Y2r
         kLHQ==
X-Gm-Message-State: AOAM533hRkq7f9IEBA/J83esGW+UqQt92IqwPBRh9e9Xv3BPzGe+QMIR
        cepqg4EeLAhl9bFAheUod8EenAweqzvDkVC8s58=
X-Google-Smtp-Source: ABdhPJzn03GRsOWNjSNButuzww8kjABIHhS12m78YTP7fCh6AnvMX0P4Bd28BIKVjrHONId9zj86TrwiJG/xEhfLaPk=
X-Received: by 2002:a50:af86:: with SMTP id h6mr9555749edd.283.1631839684076;
 Thu, 16 Sep 2021 17:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210914013701.344956-1-ying.huang@intel.com> <20210914013701.344956-2-ying.huang@intel.com>
 <CAHbLzkpRWwtkhnXUZEUk3LgpHtmgNJRPGUjKzd9bhQU33Y4u2g@mail.gmail.com>
 <8735q63947.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAHbLzko-hR74s5HKMx5SG6bwaoJvcHSLeKwihkpvhYj7+hX+Sw@mail.gmail.com>
 <874kamwkvn.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAHbLzkqO4mNUGO=wpzPjU=rdc+=KyssqapmEDLAzVDKPGGfY0Q@mail.gmail.com>
 <87sfy5uwdm.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sfy5uwdm.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 16 Sep 2021 17:47:52 -0700
Message-ID: <CAHbLzkp2EB2GrdinheoTtcFOZMfb3ZUgqUtv76De_Riy6Sv5mg@mail.gmail.com>
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

On Wed, Sep 15, 2021 at 6:45 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > On Tue, Sep 14, 2021 at 8:58 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Yang Shi <shy828301@gmail.com> writes:
> >>
> >> > On Tue, Sep 14, 2021 at 6:45 PM Huang, Ying <ying.huang@intel.com> wrote:
> >> >>
> >> >> Yang Shi <shy828301@gmail.com> writes:
> >> >>
> >> >> > On Mon, Sep 13, 2021 at 6:37 PM Huang Ying <ying.huang@intel.com> wrote:
> >> >> >>
> >> >> >> With the advent of various new memory types, some machines will have
> >> >> >> multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
> >> >> >> memory subsystem of these machines can be called memory tiering
> >> >> >> system, because the performance of the different types of memory are
> >> >> >> usually different.
> >> >> >>
> >> >> >> In such system, because of the memory accessing pattern changing etc,
> >> >> >> some pages in the slow memory may become hot globally.  So in this
> >> >> >> patch, the NUMA balancing mechanism is enhanced to optimize the page
> >> >> >> placement among the different memory types according to hot/cold
> >> >> >> dynamically.
> >> >> >>
> >> >> >> In a typical memory tiering system, there are CPUs, fast memory and
> >> >> >> slow memory in each physical NUMA node.  The CPUs and the fast memory
> >> >> >> will be put in one logical node (called fast memory node), while the
> >> >> >> slow memory will be put in another (faked) logical node (called slow
> >> >> >> memory node).  That is, the fast memory is regarded as local while the
> >> >> >> slow memory is regarded as remote.  So it's possible for the recently
> >> >> >> accessed pages in the slow memory node to be promoted to the fast
> >> >> >> memory node via the existing NUMA balancing mechanism.
> >> >> >>
> >> >> >> The original NUMA balancing mechanism will stop to migrate pages if the free
> >> >> >> memory of the target node will become below the high watermark.  This
> >> >> >> is a reasonable policy if there's only one memory type.  But this
> >> >> >> makes the original NUMA balancing mechanism almost not work to optimize page
> >> >> >> placement among different memory types.  Details are as follows.
> >> >> >>
> >> >> >> It's the common cases that the working-set size of the workload is
> >> >> >> larger than the size of the fast memory nodes.  Otherwise, it's
> >> >> >> unnecessary to use the slow memory at all.  So in the common cases,
> >> >> >> there are almost always no enough free pages in the fast memory nodes,
> >> >> >> so that the globally hot pages in the slow memory node cannot be
> >> >> >> promoted to the fast memory node.  To solve the issue, we have 2
> >> >> >> choices as follows,
> >> >> >>
> >> >> >> a. Ignore the free pages watermark checking when promoting hot pages
> >> >> >>    from the slow memory node to the fast memory node.  This will
> >> >> >>    create some memory pressure in the fast memory node, thus trigger
> >> >> >>    the memory reclaiming.  So that, the cold pages in the fast memory
> >> >> >>    node will be demoted to the slow memory node.
> >> >> >>
> >> >> >> b. Make kswapd of the fast memory node to reclaim pages until the free
> >> >> >>    pages are a little more (about 10MB) than the high watermark.  Then,
> >> >> >>    if the free pages of the fast memory node reaches high watermark, and
> >> >> >>    some hot pages need to be promoted, kswapd of the fast memory node
> >> >> >>    will be waken up to demote some cold pages in the fast memory node to
> >> >> >>    the slow memory node.  This will free some extra space in the fast
> >> >> >>    memory node, so the hot pages in the slow memory node can be
> >> >> >>    promoted to the fast memory node.
> >> >> >>
> >> >> >> The choice "a" will create the memory pressure in the fast memory
> >> >> >> node.  If the memory pressure of the workload is high, the memory
> >> >> >> pressure may become so high that the memory allocation latency of the
> >> >> >> workload is influenced, e.g. the direct reclaiming may be triggered.
> >> >> >>
> >> >> >> The choice "b" works much better at this aspect.  If the memory
> >> >> >> pressure of the workload is high, the hot pages promotion will stop
> >> >> >> earlier because its allocation watermark is higher than that of the
> >> >> >> normal memory allocation.  So in this patch, choice "b" is
> >> >> >> implemented.
> >> >> >>
> >> >> >> In addition to the original page placement optimization among sockets,
> >> >> >> the NUMA balancing mechanism is extended to be used to optimize page
> >> >> >> placement according to hot/cold among different memory types.  So the
> >> >> >> sysctl user space interface (numa_balancing) is extended in a backward
> >> >> >> compatible way as follow, so that the users can enable/disable these
> >> >> >> functionality individually.
> >> >> >>
> >> >> >> The sysctl is converted from a Boolean value to a bits field.  The
> >> >> >> definition of the flags is,
> >> >> >>
> >> >> >> - 0x0: NUMA_BALANCING_DISABLED
> >> >> >> - 0x1: NUMA_BALANCING_NORMAL
> >> >> >> - 0x2: NUMA_BALANCING_MEMORY_TIERING
> >> >> >
> >> >> > Thanks for coming up with the patches. TBH the first question off the
> >> >> > top of my head is all the complexity is really worthy for real life
> >> >> > workload at the moment? And the interfaces (sysctl knob files exported
> >> >> > to users) look complicated for the users. I don't know if the users
> >> >> > know how to set an optimal value for their workloads.
> >> >> >
> >> >> > I don't disagree the NUMA balancing needs optimization and improvement
> >> >> > for tiering memory, the question we need answer is how far we should
> >> >> > go for now and what the interfaces should look like. Does it make
> >> >> > sense to you?
> >> >> >
> >> >> > IMHO I'd prefer the most simple and straightforward approach at the
> >> >> > moment. For example, we could just skip high water mark check for PMEM
> >> >> > promotion.
> >> >>
> >> >> Hi, Yang,
> >> >>
> >> >> Thanks for comments.
> >> >>
> >> >> I understand your concerns about complexity.  I have tried to organize
> >> >> the patchset so that the initial patch is as simple as possible and the
> >> >> complexity is introduced step by step.  But it seems that your simplest
> >> >> version is even simpler than my one :-)
> >> >>
> >> >> In this patch ([1/6]), I introduced 2 stuff.
> >> >>
> >> >> Firstly, a sysctl knob is provided to disable the NUMA balancing based
> >> >> promotion.  Per my understanding, you suggest to remove this.  If so,
> >> >> optimizing cross-socket access and promoting hot PMEM pages to DRAM must
> >> >> be enabled/disabled together.  If a user wants to enable promoting the
> >> >> hot PMEM pages to DRAM but disable optimizing cross-socket access
> >> >> because they have already bound the CPU of the workload so that there's no
> >> >> much cross-socket access, how can they do?
> >> >
> >> > I should make myself clearer. Here I mean the whole series, not this
> >> > specific patch. I'm concerned that the interfaces (hint fault latency
> >> > and ratelimit) are hard to understand and configure for users and
> >> > whether we go too far at the moment or not. I'm dealing with the end
> >> > users, I'd admit I'm not even sure how to configure the knobs to
> >> > achieve optimal performance for different real life workloads.
> >>
> >> Sorry, I misunderstand your original idea.  I understand that the knob
> >> isn't user-friendly.  But sometimes, we cannot avoid it completely :-(
> >> In this patchset, I try to introduce the complexity and knobs one by
> >> one, and show the performance benefit of each step for people to judge
> >> whether the newly added complexity and knob can be complemented by the
> >> performance increment.  If the benefit of some patches cannot complement
> >> its complexity, I am OK to merge just part of the patchset firstly.
> >
> > Understood. But I really hesitate to go that far at this moment since
> > the picture is not that clear yet IMHO. We have to support them (maybe
> > forever) once we merge them.
>
> OK.  The [1-3/6] is the simplest implementation.  We can start with that
> firstly?

Sure.

>
> > So I'd prefer to work on the simplest and most necessary stuff for
> > now. Just like how we dealt with demotion.
> >
> >>
> >> So how about be more specific?  For example, if you are general OK about
> >> the complexity and knob introduced by [1-3/6], but have concerns about
> >> [4/6], then we can discuss about that specifically?
> >
> > Yeah, we could.
> >
> >>
> >> > For this specific patch I'm ok to a new promotion mode. There might be
> >> > usecase that users just want to do promotion between tiered memory but
> >> > not care about NUMA locality.
> >>
> >> Yes.
> >>
> >> >> Secondly, we add a promote watermark to the DRAM node so that we can
> >> >> demote/promote pages between the high and promote watermark.  Per my
> >> >> understanding, you suggest just to ignore the high watermark checking
> >> >> for promoting.  The problem is that this may make the free pages of the
> >> >> DRAM node too few.  If many pages are promoted in short time, the free
> >> >> pages will be kept near the min watermark for a while, so that the page
> >> >> allocation from the application will trigger direct reclaiming.  We have
> >> >> observed page allocation failure in a test before with a similar policy.
> >> >
> >> > The question is, applicable to the hint fault latency and ratelimit
> >> > too, we already have some NUMA balancing knobs to control scan period
> >> > and scan size and watermark knobs to tune how aggressively kswapd
> >> > works, can they do the same jobs instead of introducing any new knobs?
> >>
> >> In this specific patch, we don't introduce a new knob for the page
> >> demotion.  For other knobs, how about discuss them in the patch that
> >> introduce them and one by one?
> >
> > That comment is applicable to the watermark hack in this patch too.
> > Per your above description, the problem is the significant amount of
> > promotion in short period of time may deplete free memory. So I'm
> > wondering if the amount of promotion could be ratelimited by NUMA
> > balancing scan period and scan size. I understand this may have some
> > hot pages stay on PMEM for a longer time, but does it really matter?
> > In addition, the gap between low <--> min <--> high could be adjusted
> > by watermark_scale_factor, so kswapd could work more aggressively to
> > keep free memory.
>
> We can control the NUMA balancing scan speed, but we cannot control the
> speed of the hint page faults.  For example, we scanned a large portion

Could adjusting scan size help out?


> of PMEM without many hint page faults because the pages are really cold,
> but suddenly a large amount of cold pages become hot, so they will be
> promoted to DRAM.  This will create heavy memory pressure on DRAM node,
> make it hard for the normal page allocation from the applications.
>
> And, for some workloads, we need to promote the hot pages to DRAM
> quickly, otherwise, the pages will become cold.  We should make it
> possible to support these users too.  Do you agree?

I agree there may be such workloads. But do we have to achieve very
good support for them right now? We don't even know how common such
workload is.

>
> Best Regards,
> Huang, Ying
