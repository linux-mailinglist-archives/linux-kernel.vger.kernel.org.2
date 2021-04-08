Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C676C358E59
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhDHU3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhDHU3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:29:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C708AC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 13:29:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h19so6124773lfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKWZkaAxh0POJeezT3yF35pSQ4SUrFeYy/oZPNJwPrY=;
        b=PVqhoyfl2f2u/ilqwkxpT5t81ZjQ6fxWkKlc9c7/UD8g7alBWP1Zni++NjyRMxKn/x
         59fA6xFmvuAtKQmM7EaCGS3h2iAfnFPq4yTuvUg8OCTtOJi3ITULqRYc3BYdW3+UJAYV
         fsmkZ7aHDcgXgRh3Yz6xBZl/0jYo5y0si1V3grdPkUb5kH0HNrG2dRAWWgttVkGZ0wq+
         eKaaxGg1m3BEezNW+GPliAbu3tm0kHN222/w+irUTxfvLu73Yd1WgPD+gmUYs7jBKHBj
         WVgEuA1U+aFGSZbrELbq5jBqJKM5DqT9aCwZnjXwDLWYBUEyMqk+K9HVIoEWbXpSLgwo
         GhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKWZkaAxh0POJeezT3yF35pSQ4SUrFeYy/oZPNJwPrY=;
        b=mzxEpKpzXZ33xUIgdReCMqTprbE0u68s73E9cg3LFlnWmgVvfs5QjXD8NpezX50AZ3
         aEHM6V3A1PLHFwoB6osWwzFygduPS6Mm3LkRfAk+rD/KKNowupfIBRq7+t6d4elcauzW
         p/TN6KSD51KDvyzDryRwaoAbvYchQrANet2nomCufR1lHO7pO3EWr6vRE3eRociSKvJn
         kA6oVFrHWCQKzrZ6/eDh+au/IhxpmI1GNj2dduJc/u5LlON8cwy9gBNJ9pkON1fXdJI3
         7XYHx0wh2s0MVQ+C8mC32pnoxIrSdXvgumsNXonk5MFVaxd5O/A7NH8itw7WjHvDrnfC
         DbhQ==
X-Gm-Message-State: AOAM533rNJrN+opaCUdzkYYUeNiFDalnYRsFn76IVms7eze93wUlxH+H
        zts4Sd0vkT16Sh52GEtgzhvKZfl2Kqfkye5MGosBrg==
X-Google-Smtp-Source: ABdhPJx9BhcY5woXbdg+3daXIYZOm/y17QAIL3rYs3JXjdmHsc5UfF+FCX7i2salJlUPCRTgqHgb0Ec9ZmZyqKWQMD8=
X-Received: by 2002:a05:6512:3703:: with SMTP id z3mr7860594lfr.358.1617913759939;
 Thu, 08 Apr 2021 13:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com> <CAHbLzkrPD6s9vRy89cgQ36e+1cs6JbLqV84se7nnvP9MByizXA@mail.gmail.com>
In-Reply-To: <CAHbLzkrPD6s9vRy89cgQ36e+1cs6JbLqV84se7nnvP9MByizXA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 8 Apr 2021 13:29:08 -0700
Message-ID: <CALvZod69-GcS2W57hAUvjbWBCD6B2dTeVsFbtpQuZOM2DphwCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered memory
To:     Yang Shi <shy828301@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 11:01 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Apr 8, 2021 at 10:19 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > Hi Tim,
> >
> > On Mon, Apr 5, 2021 at 11:08 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> > >
> > > Traditionally, all memory is DRAM.  Some DRAM might be closer/faster than
> > > others NUMA wise, but a byte of media has about the same cost whether it
> > > is close or far.  But, with new memory tiers such as Persistent Memory
> > > (PMEM).  there is a choice between fast/expensive DRAM and slow/cheap
> > > PMEM.
> > >
> > > The fast/expensive memory lives in the top tier of the memory hierachy.
> > >
> > > Previously, the patchset
> > > [PATCH 00/10] [v7] Migrate Pages in lieu of discard
> > > https://lore.kernel.org/linux-mm/20210401183216.443C4443@viggo.jf.intel.com/
> > > provides a mechanism to demote cold pages from DRAM node into PMEM.
> > >
> > > And the patchset
> > > [PATCH 0/6] [RFC v6] NUMA balancing: optimize memory placement for memory tiering system
> > > https://lore.kernel.org/linux-mm/20210311081821.138467-1-ying.huang@intel.com/
> > > provides a mechanism to promote hot pages in PMEM to the DRAM node
> > > leveraging autonuma.
> > >
> > > The two patchsets together keep the hot pages in DRAM and colder pages
> > > in PMEM.
> >
> > Thanks for working on this as this is becoming more and more important
> > particularly in the data centers where memory is a big portion of the
> > cost.
> >
> > I see you have responded to Michal and I will add my more specific
> > response there. Here I wanted to give my high level concern regarding
> > using v1's soft limit like semantics for top tier memory.
> >
> > This patch series aims to distribute/partition top tier memory between
> > jobs of different priorities. We want high priority jobs to have
> > preferential access to the top tier memory and we don't want low
> > priority jobs to hog the top tier memory.
> >
> > Using v1's soft limit like behavior can potentially cause high
> > priority jobs to stall to make enough space on top tier memory on
> > their allocation path and I think this patchset is aiming to reduce
> > that impact by making kswapd do that work. However I think the more
> > concerning issue is the low priority job hogging the top tier memory.
> >
> > The possible ways the low priority job can hog the top tier memory are
> > by allocating non-movable memory or by mlocking the memory. (Oh there
> > is also pinning the memory but I don't know if there is a user api to
> > pin memory?) For the mlocked memory, you need to either modify the
> > reclaim code or use a different mechanism for demoting cold memory.
>
> Do you mean long term pin? RDMA should be able to simply pin the
> memory for weeks. A lot of transient pins come from Direct I/O. They
> should be less concerned.
>
> The low priority jobs should be able to be restricted by cpuset, for
> example, just keep them on second tier memory nodes. Then all the
> above problems are gone.
>

Yes that's an extreme way to overcome the issue but we can do less
extreme by just (hard) limiting the top tier usage of low priority
jobs.

> >
> > Basically I am saying we should put the upfront control (limit) on the
> > usage of top tier memory by the jobs.
>
> This sounds similar to what I talked about in LSFMM 2019
> (https://lwn.net/Articles/787418/). We used to have some potential
> usecase which divides DRAM:PMEM ratio for different jobs or memcgs
> when I was with Alibaba.
>
> In the first place I thought about per NUMA node limit, but it was
> very hard to configure it correctly for users unless you know exactly
> about your memory usage and hot/cold memory distribution.
>
> I'm wondering, just off the top of my head, if we could extend the
> semantic of low and min limit. For example, just redefine low and min
> to "the limit on top tier memory". Then we could have low priority
> jobs have 0 low/min limit.
>

The low and min limits have semantics similar to the v1's soft limit
for this situation i.e. letting the low priority job occupy top tier
memory and depending on reclaim to take back the excess top tier
memory use of such jobs.

I have some thoughts on NUMA node limits which I will share in the other thread.
