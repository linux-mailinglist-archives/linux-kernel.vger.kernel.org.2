Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3663522F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhDAWz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbhDAWz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:55:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F45C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 15:55:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e14so5129792ejz.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rM9eN7RTm/ym7qDc3Jff+hvqwP+VPzXvutnouMz4V3c=;
        b=R5gmt5BFJvTzzWDH9lOCZygJgLrcBKdzKLIzovB31sTDwlHXVlfRLWGGAfQeRxNnyO
         bEgBlcNZDqalEv8XSCyOWPtnEPPZCUWoTnhY1kI7YcKrQ2Y/wF4TeNJI66n0xiGk191c
         1OsaciF5+7JGf12vgM2N6X98wYVK3NAWWC4OF8nn1J+TREYLCmkpBCQqo+HlG1qaubJN
         0iK+SRGXMeeFO6EPVQpVodRq0GzZnWQ0yvMte6Q+oZQN6QguV13MSdkT9jn9EoqXTS9Z
         lL03VSYW189/nV+UpsyHu6rcu2GDkFGJDFTMTO3ZMPqR9oAUDW5IPL5UQE7VvutbgcHn
         0onA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rM9eN7RTm/ym7qDc3Jff+hvqwP+VPzXvutnouMz4V3c=;
        b=cYNfpNnStfVnw3iXi55MHCt0k9kMsHi1zVn5VJH2b3vb0X+uCdSk53eBed83oZbswu
         zGYMTanER8sJc1k+yvWapjEFjJ3RYXsIwGmBzxjtvQgP0IBVvTWEpFLCp63LmiWnywER
         +DFn6859RUlqARwFzPiPRiP3QFUbyt/OsIfuLXGkitoeGd0n86/n3TvwEEtqeixptn4U
         1Gh8Smk57cu3F3Mb8TuO+JkQknf3G9r/xaLwjYaYryRf2roxlrYDljIypWoMKdnAhJLY
         TG/hKRt2o6XYgcmzOFdMxO29xTSftl3R0zuHCcBIjVSvdgZFG0shuwiMcgoGxwDJFpJR
         MVcw==
X-Gm-Message-State: AOAM5301QTyT97aoqQarCe6ebGwekC0ukZwlMBmrj8nNlVpnpv3bsyXR
        C7xCCMEI/kkkmFHPEmHXpQ/IUfRLdl9+z4BdLz4=
X-Google-Smtp-Source: ABdhPJwHrsZ0WM/xul/ghkUBj22NalW34RWNVRvV4uNVfuON2378g6V5DT2apq3ilvZSYd70br3yU9c9Q4h4JeGoJRQ=
X-Received: by 2002:a17:906:4055:: with SMTP id y21mr11188171ejj.507.1617317723420;
 Thu, 01 Apr 2021 15:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
 <YGN0141iu5HTGiNJ@carbon.dhcp.thefacebook.com> <YGOYYgWbwiYlKmzV@cmpxchg.org>
 <YGOgth4IUflVE/Me@carbon.dhcp.thefacebook.com> <YGSSemLLpiHJHanV@cmpxchg.org>
In-Reply-To: <YGSSemLLpiHJHanV@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Apr 2021 15:55:11 -0700
Message-ID: <CAHbLzkqJfxUh4aZA1Qkumj0Za2Uz=wEfzuNv8NZpDaZ_dtUt=w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge the LRU pages
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 8:17 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Mar 30, 2021 at 03:05:42PM -0700, Roman Gushchin wrote:
> > On Tue, Mar 30, 2021 at 05:30:10PM -0400, Johannes Weiner wrote:
> > > On Tue, Mar 30, 2021 at 11:58:31AM -0700, Roman Gushchin wrote:
> > > > On Tue, Mar 30, 2021 at 11:34:11AM -0700, Shakeel Butt wrote:
> > > > > On Tue, Mar 30, 2021 at 3:20 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > > >
> > > > > > Since the following patchsets applied. All the kernel memory are charged
> > > > > > with the new APIs of obj_cgroup.
> > > > > >
> > > > > >         [v17,00/19] The new cgroup slab memory controller
> > > > > >         [v5,0/7] Use obj_cgroup APIs to charge kmem pages
> > > > > >
> > > > > > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > > > > > it exists at a larger scale and is causing recurring problems in the real
> > > > > > world: page cache doesn't get reclaimed for a long time, or is used by the
> > > > > > second, third, fourth, ... instance of the same job that was restarted into
> > > > > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > > > > > and make page reclaim very inefficient.
> > > > > >
> > > > > > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > > > > > to fix this problem, and then the LRU pages will not pin the memcgs.
> > > > > >
> > > > > > This patchset aims to make the LRU pages to drop the reference to memory
> > > > > > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > > > > > of the dying cgroups will not increase if we run the following test script.
> > > > > >
> > > > > > ```bash
> > > > > > #!/bin/bash
> > > > > >
> > > > > > cat /proc/cgroups | grep memory
> > > > > >
> > > > > > cd /sys/fs/cgroup/memory
> > > > > >
> > > > > > for i in range{1..500}
> > > > > > do
> > > > > >         mkdir test
> > > > > >         echo $$ > test/cgroup.procs
> > > > > >         sleep 60 &
> > > > > >         echo $$ > cgroup.procs
> > > > > >         echo `cat test/cgroup.procs` > cgroup.procs
> > > > > >         rmdir test
> > > > > > done
> > > > > >
> > > > > > cat /proc/cgroups | grep memory
> > > > > > ```
> > > > > >
> > > > > > Patch 1 aims to fix page charging in page replacement.
> > > > > > Patch 2-5 are code cleanup and simplification.
> > > > > > Patch 6-15 convert LRU pages pin to the objcg direction.
> > > > >
> > > > > The main concern I have with *just* reparenting LRU pages is that for
> > > > > the long running systems, the root memcg will become a dumping ground.
> > > > > In addition a job running multiple times on a machine will see
> > > > > inconsistent memory usage if it re-accesses the file pages which were
> > > > > reparented to the root memcg.
> > > >
> > > > I agree, but also the reparenting is not the perfect thing in a combination
> > > > with any memory protections (e.g. memory.low).
> > > >
> > > > Imagine the following configuration:
> > > > workload.slice
> > > > - workload_gen_1.service   memory.min = 30G
> > > > - workload_gen_2.service   memory.min = 30G
> > > > - workload_gen_3.service   memory.min = 30G
> > > >   ...
> > > >
> > > > Parent cgroup and several generations of the child cgroup, protected by a memory.low.
> > > > Once the memory is getting reparented, it's not protected anymore.
> > >
> > > That doesn't sound right.
> > >
> > > A deleted cgroup today exerts no control over its abandoned
> > > pages. css_reset() will blow out any control settings.
> >
> > I know. Currently it works in the following way: once cgroup gen_1 is deleted,
> > it's memory is not protected anymore, so eventually it's getting evicted and
> > re-faulted as gen_2 (or gen_N) memory. Muchun's patchset doesn't change this,
> > of course. But long-term we likely wanna re-charge such pages to new cgroups
> > and avoid unnecessary evictions and re-faults. Switching to obj_cgroups doesn't
> > help and likely will complicate this change. So I'm a bit skeptical here.
>
> We should be careful with the long-term plans.

Excuse me for a dumb question. I recall we did reparent LRU pages
before (before 4.x kernel). I vaguely recall there were some tricky
race conditions during reparenting so we didn't do it anymore once
reclaimer could reclaim from offlined memcgs. My memory may be wrong,
if it is not so please feel free to correct me. If my memory is true,
it means the race conditions are gone? Or the new obj_cgroup APIs made
life easier?

Thanks,
Yang

>
> The zombie issue is a pretty urgent concern that has caused several
> production emergencies now. It needs a fix sooner rather than later.
>
> The long-term plans of how to handle shared/reused data better will
> require some time to work out. There are MANY open questions around
> recharging to arbitrary foreign cgroup users. Like how to identify
> accesses after the page's cgroup has been deleted: Do we need to
> annotate every page cache lookup? Do we need to inject minor faults to
> recharge mmapped pages? We can't wait for this discussion to complete.
>
> I also think the objcg is helping with that direction rather than
> getting in the way because:
>
> - The old charge moving code we have for LRU pages isn't reusable
>   anyway. It relies on optimistic locking to work, and may leave
>   memory behind in arbitrary and unpredictable ways. After a few
>   cycles, objects tend to be spread all over the place.
>
>   The objcg provides a new synchronization scheme that will always
>   work because the readside (page/object to memcg lookup) needs to be
>   prepared for the memcg to change and/or die at any time.
>
> - There isn't much point in recharging only some of the abandoned
>   memory. We've tried per-allocation class reparenting and it didn't
>   work out too well. Newly accounted allocations crop up faster than
>   we can conjure up tailor-made reparenting schemes for them.
>
>   The objcg provides a generic reference and reassignment scheme that
>   can be used by all tracked objects.
>
>   Importantly, once we have a central thing as LRU pages converted, we
>   can require all new allocation tracking to use objcg from the start.
>
> > Also, in my experience the pagecache is not the main/worst memcg reference
> > holder (writeback structures are way worse). Pages are relatively large
> > (in comparison to some slab objects), and rarely there is only one page pinning
> > a separate memcg.
>
> I've seen that exact thing cause zombies to pile up: one or two pages
> in the old group, pinned by the next instance of a job. If the job has
> a sufficiently large working set, this can pin a LOT of dead
> cgroups. Is it the biggest or most problematic source of buildups?
> Maybe not. But there is definitely cause to fix it.
>
> LRU pages are also the most difficult to convert because of their rich
> interactions. It's a good test of the api. If it works for those
> pages, converting everybody else will be much simpler.
>
> And again, as the core memory consumer it sets the tone of how memcg
> rmapping is supposed to work for new and existing object types. This
> helps align ongoing development.
>
> > And switching to obj_cgroup doesn't completely eliminate the
> > problem: we just switch from accumulating larger mem_cgroups to
> > accumulating smaller obj_cgroups.
>
> In your own words, the discrepancy between tiny objects pinning large
> memcgs is a problem. objcgs are smaller than most objects, so it's not
> much different as if an object were simply a few bytes bigger in size.
> A memcg on the other hand is vastly bigger than most objects. It's
> also composed of many allocations and so causes more fragmentation.
>
> Another issue is that memcgs with abandoned objects need to be visited
> by the reclaimer on every single reclaim walk, a hot path. The list of
> objcgs on the other hand is only iterated when the cgroup is deleted,
> which is not a fast path. It's also rare that parents with many dead
> children are deleted at all (system.slice, workload.slice etc.)
>
> So no, I would say for all intents and purposes, it fixes all the
> problems we're having with zombie memcgs.
>
> > With all this said, I'm not necessarily opposing the patchset, but it's
> > necessary to discuss how it fits into the long-term picture.
> > E.g. if we're going to use obj_cgroup API for page-sized objects, shouldn't
> > we split it back into the reparenting and bytes-sized accounting parts,
> > as I initially suggested. And shouldn't we move the reparenting part to
> > the cgroup core level, so we could use it for other controllers
> > (e.g. to fix the writeback problem).
>
> Yes, I do think we want to generalize it. But I wouldn't say it's a
> requirement for these patches, either:
>
> - The byte-sized accounting part is one atomic_t. That's 4 bytes
>   pinned unnecessarily - compared to an entire struct memcg right now
>   which includes memory accounting, swap accounting, byte accounting,
>   and a whole lot of other things likely not used by the stale object.
>
> - The cgroup generalization is a good idea too, but that doesn't
>   really change the callsites either. Unless you were thinking of
>   renaming, but objcg seems like a good, generic fit for a name to
>   describe the linkage between objects to a cgroup.
>
>   The memcg member will need to change into something generic (a
>   css_set type mapping), but that can likely be hidden behind
>   page_memcg(), objcg_memcg() and similar helpers.
>
> Both of these aspects can be improved incrementally.
>
