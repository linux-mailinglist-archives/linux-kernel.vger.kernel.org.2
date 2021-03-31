Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C865B350321
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhCaPRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbhCaPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:17:17 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B41CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:17:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y2so14644443qtw.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mQJB9vkE7e87SHqDgWgmkoQDJDbKiOS0ezadenIuC20=;
        b=vshvTb6l3ikIuhCEhv25/yHQRpzQs6IbuAlgcWUfxEib8PgeC8fBvjgIC4S1XFDaFF
         kRk2D/4swnAz3RMpvbZZQ6Kp4h6f8UlCJ9Kqo5mx0p2wznEMauswbfaHWSYvwRc1zAtO
         JuPfQ6Ay3ElFNpxEOrNbxqupFfQGVITNJhNd1ptry8lhc/gZOJh/CTj+S4uuk9lHNFFx
         C+9BKJdIF5VuVb+WtIPrEKApKjee5XWYuBSR5RBxIuyH+aBEMydxJQ/dGDPlaOregRA4
         DSUjFDvmq38FjPUafpG1zTPF+zRACGXEGeZy7QfaIS/DQzhpOyZNmXJFQ70V8JQJmpBI
         5vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mQJB9vkE7e87SHqDgWgmkoQDJDbKiOS0ezadenIuC20=;
        b=Ri1RNn2oS0sMxyQQJlrZzrrlgOEQUrqbl5GC/1egpbkCgbzqKZ6JUSSYQQGO8VsOSG
         dDCpRaD/Mlf1vc6H+4vmOvOjnrg9d8shgC4XLqmXEITiehpCMuvGHZ65BaV4Kkxdtbrh
         5o4drR5UdMtsZaVoVFtIrjPltwi91i6gDRjeQr/xSshvlaHSBZKmq8XCGZCAOHXhmi5h
         xEBVTJrwN8RhDdZlVQuvl0BqonTWrFkjg+mcxIKFUG4+jKsnaTqDruPJxGn+SgBpcTkg
         YZNUM+vDNIErcK7uXInadNuvdaarPL1V6fhjS85gPpbuq8ar80U0+mmKz3KwWSc0KIQr
         Y2IA==
X-Gm-Message-State: AOAM533P4trsTlnWR3Nhjwrftk1mwr6Pg+TU7iDadlTqJQaa0zd3sJ0l
        766+bYP786bIGK95Zo69hjjfMw==
X-Google-Smtp-Source: ABdhPJwiGfePgvAwGf+tWJBDIjIU7D91iY2jvHBDh0c8dgOFzXe7c6rEaXNlmszLruUCoIF2+hfyxg==
X-Received: by 2002:a05:622a:1c5:: with SMTP id t5mr2746112qtw.49.1617203835834;
        Wed, 31 Mar 2021 08:17:15 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id v128sm1641897qkc.127.2021.03.31.08.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 08:17:15 -0700 (PDT)
Date:   Wed, 31 Mar 2021 11:17:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Subject: Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YGSSemLLpiHJHanV@cmpxchg.org>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
 <YGN0141iu5HTGiNJ@carbon.dhcp.thefacebook.com>
 <YGOYYgWbwiYlKmzV@cmpxchg.org>
 <YGOgth4IUflVE/Me@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGOgth4IUflVE/Me@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 03:05:42PM -0700, Roman Gushchin wrote:
> On Tue, Mar 30, 2021 at 05:30:10PM -0400, Johannes Weiner wrote:
> > On Tue, Mar 30, 2021 at 11:58:31AM -0700, Roman Gushchin wrote:
> > > On Tue, Mar 30, 2021 at 11:34:11AM -0700, Shakeel Butt wrote:
> > > > On Tue, Mar 30, 2021 at 3:20 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > >
> > > > > Since the following patchsets applied. All the kernel memory are charged
> > > > > with the new APIs of obj_cgroup.
> > > > >
> > > > >         [v17,00/19] The new cgroup slab memory controller
> > > > >         [v5,0/7] Use obj_cgroup APIs to charge kmem pages
> > > > >
> > > > > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > > > > it exists at a larger scale and is causing recurring problems in the real
> > > > > world: page cache doesn't get reclaimed for a long time, or is used by the
> > > > > second, third, fourth, ... instance of the same job that was restarted into
> > > > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > > > > and make page reclaim very inefficient.
> > > > >
> > > > > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > > > > to fix this problem, and then the LRU pages will not pin the memcgs.
> > > > >
> > > > > This patchset aims to make the LRU pages to drop the reference to memory
> > > > > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > > > > of the dying cgroups will not increase if we run the following test script.
> > > > >
> > > > > ```bash
> > > > > #!/bin/bash
> > > > >
> > > > > cat /proc/cgroups | grep memory
> > > > >
> > > > > cd /sys/fs/cgroup/memory
> > > > >
> > > > > for i in range{1..500}
> > > > > do
> > > > >         mkdir test
> > > > >         echo $$ > test/cgroup.procs
> > > > >         sleep 60 &
> > > > >         echo $$ > cgroup.procs
> > > > >         echo `cat test/cgroup.procs` > cgroup.procs
> > > > >         rmdir test
> > > > > done
> > > > >
> > > > > cat /proc/cgroups | grep memory
> > > > > ```
> > > > >
> > > > > Patch 1 aims to fix page charging in page replacement.
> > > > > Patch 2-5 are code cleanup and simplification.
> > > > > Patch 6-15 convert LRU pages pin to the objcg direction.
> > > > 
> > > > The main concern I have with *just* reparenting LRU pages is that for
> > > > the long running systems, the root memcg will become a dumping ground.
> > > > In addition a job running multiple times on a machine will see
> > > > inconsistent memory usage if it re-accesses the file pages which were
> > > > reparented to the root memcg.
> > > 
> > > I agree, but also the reparenting is not the perfect thing in a combination
> > > with any memory protections (e.g. memory.low).
> > > 
> > > Imagine the following configuration:
> > > workload.slice
> > > - workload_gen_1.service   memory.min = 30G
> > > - workload_gen_2.service   memory.min = 30G
> > > - workload_gen_3.service   memory.min = 30G
> > >   ...
> > > 
> > > Parent cgroup and several generations of the child cgroup, protected by a memory.low.
> > > Once the memory is getting reparented, it's not protected anymore.
> > 
> > That doesn't sound right.
> > 
> > A deleted cgroup today exerts no control over its abandoned
> > pages. css_reset() will blow out any control settings.
> 
> I know. Currently it works in the following way: once cgroup gen_1 is deleted,
> it's memory is not protected anymore, so eventually it's getting evicted and
> re-faulted as gen_2 (or gen_N) memory. Muchun's patchset doesn't change this,
> of course. But long-term we likely wanna re-charge such pages to new cgroups
> and avoid unnecessary evictions and re-faults. Switching to obj_cgroups doesn't
> help and likely will complicate this change. So I'm a bit skeptical here.

We should be careful with the long-term plans.

The zombie issue is a pretty urgent concern that has caused several
production emergencies now. It needs a fix sooner rather than later.

The long-term plans of how to handle shared/reused data better will
require some time to work out. There are MANY open questions around
recharging to arbitrary foreign cgroup users. Like how to identify
accesses after the page's cgroup has been deleted: Do we need to
annotate every page cache lookup? Do we need to inject minor faults to
recharge mmapped pages? We can't wait for this discussion to complete.

I also think the objcg is helping with that direction rather than
getting in the way because:

- The old charge moving code we have for LRU pages isn't reusable
  anyway. It relies on optimistic locking to work, and may leave
  memory behind in arbitrary and unpredictable ways. After a few
  cycles, objects tend to be spread all over the place.

  The objcg provides a new synchronization scheme that will always
  work because the readside (page/object to memcg lookup) needs to be
  prepared for the memcg to change and/or die at any time.

- There isn't much point in recharging only some of the abandoned
  memory. We've tried per-allocation class reparenting and it didn't
  work out too well. Newly accounted allocations crop up faster than
  we can conjure up tailor-made reparenting schemes for them.

  The objcg provides a generic reference and reassignment scheme that
  can be used by all tracked objects.

  Importantly, once we have a central thing as LRU pages converted, we
  can require all new allocation tracking to use objcg from the start.

> Also, in my experience the pagecache is not the main/worst memcg reference
> holder (writeback structures are way worse). Pages are relatively large
> (in comparison to some slab objects), and rarely there is only one page pinning
> a separate memcg.

I've seen that exact thing cause zombies to pile up: one or two pages
in the old group, pinned by the next instance of a job. If the job has
a sufficiently large working set, this can pin a LOT of dead
cgroups. Is it the biggest or most problematic source of buildups?
Maybe not. But there is definitely cause to fix it.

LRU pages are also the most difficult to convert because of their rich
interactions. It's a good test of the api. If it works for those
pages, converting everybody else will be much simpler.

And again, as the core memory consumer it sets the tone of how memcg
rmapping is supposed to work for new and existing object types. This
helps align ongoing development.

> And switching to obj_cgroup doesn't completely eliminate the
> problem: we just switch from accumulating larger mem_cgroups to
> accumulating smaller obj_cgroups.

In your own words, the discrepancy between tiny objects pinning large
memcgs is a problem. objcgs are smaller than most objects, so it's not
much different as if an object were simply a few bytes bigger in size.
A memcg on the other hand is vastly bigger than most objects. It's
also composed of many allocations and so causes more fragmentation.

Another issue is that memcgs with abandoned objects need to be visited
by the reclaimer on every single reclaim walk, a hot path. The list of
objcgs on the other hand is only iterated when the cgroup is deleted,
which is not a fast path. It's also rare that parents with many dead
children are deleted at all (system.slice, workload.slice etc.)

So no, I would say for all intents and purposes, it fixes all the
problems we're having with zombie memcgs.

> With all this said, I'm not necessarily opposing the patchset, but it's
> necessary to discuss how it fits into the long-term picture.
> E.g. if we're going to use obj_cgroup API for page-sized objects, shouldn't
> we split it back into the reparenting and bytes-sized accounting parts,
> as I initially suggested. And shouldn't we move the reparenting part to
> the cgroup core level, so we could use it for other controllers
> (e.g. to fix the writeback problem).

Yes, I do think we want to generalize it. But I wouldn't say it's a
requirement for these patches, either:

- The byte-sized accounting part is one atomic_t. That's 4 bytes
  pinned unnecessarily - compared to an entire struct memcg right now
  which includes memory accounting, swap accounting, byte accounting,
  and a whole lot of other things likely not used by the stale object.

- The cgroup generalization is a good idea too, but that doesn't
  really change the callsites either. Unless you were thinking of
  renaming, but objcg seems like a good, generic fit for a name to
  describe the linkage between objects to a cgroup.

  The memcg member will need to change into something generic (a
  css_set type mapping), but that can likely be hidden behind
  page_memcg(), objcg_memcg() and similar helpers.

Both of these aspects can be improved incrementally.
