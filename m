Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0936F5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 08:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhD3GZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 02:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhD3GZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 02:25:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB73C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 23:24:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so989854wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 23:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YFIkLOXwzPtOenJjCQiiKg1nIMhir/w9NnvjOy6hjlk=;
        b=ssrM2lZ3tHZqS5AjLeEgyQQ34R3rHatMp6+MaePG4kjsYQb2YvILD7OIkqg/fcWMMh
         2S5E0vY6Rh2EKSthEMMdne3EN+VQBnEmYZ5gjsLfBf3H7dU4r0hYDIVWdK8Sx/R8t3sI
         771PXtnadp3N/ThrAafRjJcZhm0sxjClvZLXL2r/rYDE9k7fvB0JAtp9drqJzXFx4k1d
         hMIJyx+vSEMcIFKGA5Jl6bLxNqNrtVBJa44OpKT+jtdpvsTllmKebHI4M/RarngQfhrN
         23U1eCAiwuv4nDd7dmFs2Q87t/SIG5j+5mQ+CGt2jk7z06yxH8sGTS3zkCk1xEdLumS6
         R79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YFIkLOXwzPtOenJjCQiiKg1nIMhir/w9NnvjOy6hjlk=;
        b=qAZZgipW/uzCK3Do8M9NvFmoT/swjQPbJkgvOOD0j9cXhRV8Nty/iLfAgcTKauDj87
         POpC/IfTMhfxJ2kItrUlAItobJ14wgl11yfF0k09MmDxlO1TBANA/xHgUS0Num2DLmSy
         STKvqIqma0dc7EEZxy3N4TQuJTuPhCYPokRSWF0taYEIc+khgofaHhoGpgoVSP2Dj8E2
         XFMqctH9yUqGmUFp6eX6nnPIQI4MQ+ZD0BxcO948Ou4no5X3VoRVpRMHqvocImIe0DS/
         Il+zaEBw30ZQ6TFNz6Hbx5nqwaKPxhrYTkfGjN+vn3c7v0z11WH+pVw1ErXyy/ZTAZOJ
         1FiQ==
X-Gm-Message-State: AOAM532wNPh0oIu/X1dvIUVmwOS3+KyfdU8vXwFZXiNuKNOIey9HubGP
        etFjyvwPgm8gByx87lJSf+yCYEg6HtQyzMw2LHes9w==
X-Google-Smtp-Source: ABdhPJw2+y5IZ9nZ1JQ3YFqC95nxaDPwH63eKPyBTSKO6z3ePEydo5FduNfLn2criWdcaRROs52ule3mPitdFMNYZcw=
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr4234009wmg.37.1619763865958;
 Thu, 29 Apr 2021 23:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com> <YIGuvh70JbE1Cx4U@google.com>
 <7a0fecab-f9e1-ad39-d55e-01e574a35484@linux.intel.com> <YIMsykToLKUVMWbZ@google.com>
 <d7f670db-e77e-ca16-07c0-c0ebcce2c544@linux.intel.com>
In-Reply-To: <d7f670db-e77e-ca16-07c0-c0ebcce2c544@linux.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 30 Apr 2021 00:24:14 -0600
Message-ID: <CAOUHufYCk9W8BNkdnpQ=NwcdE-obd3=6B2ouC-39BuWRme+yrA@mail.gmail.com>
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by too_many_isolated()
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:57 PM Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
> Hi Yu,
>
> On 4/24/2021 4:23 AM, Yu Zhao wrote:
> > On Fri, Apr 23, 2021 at 02:57:07PM +0800, Xing Zhengjun wrote:
> >> On 4/23/2021 1:13 AM, Yu Zhao wrote:
> >>> On Thu, Apr 22, 2021 at 04:36:19PM +0800, Xing Zhengjun wrote:
> >>>> Hi,
> >>>>
> >>>>      In the system with very few file pages (nr_active_file + nr_ina=
ctive_file
> >>>> < 100), it is easy to reproduce "nr_isolated_file > nr_inactive_file=
",  then
> >>>> too_many_isolated return true, shrink_inactive_list enter "msleep(10=
0)", the
> >>>> long latency will happen.
> >>>>
> >>>> The test case to reproduce it is very simple: allocate many huge pag=
es(near
> >>>> the DRAM size), then do free, repeat the same operation many times.
> >>>> In the test case, the system with very few file pages (nr_active_fil=
e +
> >>>> nr_inactive_file < 100), I have dumpped the numbers of
> >>>> active/inactive/isolated file pages during the whole test(see in the
> >>>> attachments) , in shrink_inactive_list "too_many_isolated" is very e=
asy to
> >>>> return true, then enter "msleep(100)",in "too_many_isolated" sc->gfp=
_mask is
> >>>> 0x342cca ("_GFP_IO" and "__GFP_FS" is masked) , it is also very easy=
 to
> >>>> enter =E2=80=9Cinactive >>=3D3=E2=80=9D, then =E2=80=9Cisolated > in=
active=E2=80=9D will be true.
> >>>>
> >>>> So I  have a proposal to set a threshold number for the total file p=
ages to
> >>>> ignore the system with very few file pages, and then bypass the 100m=
s sleep.
> >>>> It is hard to set a perfect number for the threshold, so I just give=
 an
> >>>> example of "256" for it.
> >>>>
> >>>> I appreciate it if you can give me your suggestion/comments. Thanks.
> >>>
> >>> Hi Zhengjun,
> >>>
> >>> It seems to me using the number of isolated pages to keep a lid on
> >>> direct reclaimers is not a good solution. We shouldn't keep going
> >>> that direction if we really want to fix the problem because migration
> >>> can isolate many pages too, which in turn blocks page reclaim.
> >>>
> >>> Here is something works a lot better. Please give it a try. Thanks.
> >>
> >> Thanks, I will try it with my test cases.
> >
> > Thanks. I took care my sloppiness from yesterday and tested the
> > following. It should apply cleanly and work well. Please let me know.
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 47946cec7584..48bb2b77389e 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -832,6 +832,7 @@ typedef struct pglist_data {
> >   #endif
> >
> >       /* Fields commonly accessed by the page reclaim scanner */
> > +     atomic_t                nr_reclaimers;
> >
> >       /*
> >        * NOTE: THIS IS UNUSED IF MEMCG IS ENABLED.
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 562e87cbd7a1..3fcdfbee89c7 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1775,43 +1775,6 @@ int isolate_lru_page(struct page *page)
> >       return ret;
> >   }
> >
> > -/*
> > - * A direct reclaimer may isolate SWAP_CLUSTER_MAX pages from the LRU =
list and
> > - * then get rescheduled. When there are massive number of tasks doing =
page
> > - * allocation, such sleeping direct reclaimers may keep piling up on e=
ach CPU,
> > - * the LRU list will go small and be scanned faster than necessary, le=
ading to
> > - * unnecessary swapping, thrashing and OOM.
> > - */
> > -static int too_many_isolated(struct pglist_data *pgdat, int file,
> > -             struct scan_control *sc)
> > -{
> > -     unsigned long inactive, isolated;
> > -
> > -     if (current_is_kswapd())
> > -             return 0;
> > -
> > -     if (!writeback_throttling_sane(sc))
> > -             return 0;
> > -
> > -     if (file) {
> > -             inactive =3D node_page_state(pgdat, NR_INACTIVE_FILE);
> > -             isolated =3D node_page_state(pgdat, NR_ISOLATED_FILE);
> > -     } else {
> > -             inactive =3D node_page_state(pgdat, NR_INACTIVE_ANON);
> > -             isolated =3D node_page_state(pgdat, NR_ISOLATED_ANON);
> > -     }
> > -
> > -     /*
> > -      * GFP_NOIO/GFP_NOFS callers are allowed to isolate more pages, s=
o they
> > -      * won't get blocked by normal direct-reclaimers, forming a circu=
lar
> > -      * deadlock.
> > -      */
> > -     if ((sc->gfp_mask & (__GFP_IO | __GFP_FS)) =3D=3D (__GFP_IO | __G=
FP_FS))
> > -             inactive >>=3D 3;
> > -
> > -     return isolated > inactive;
> > -}
> > -
> >   /*
> >    * move_pages_to_lru() moves pages from private @list to appropriate =
LRU list.
> >    * On return, @list is reused as a list of pages to be freed by the c=
aller.
> > @@ -1911,20 +1874,6 @@ shrink_inactive_list(unsigned long nr_to_scan, s=
truct lruvec *lruvec,
> >       bool file =3D is_file_lru(lru);
> >       enum vm_event_item item;
> >       struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
> > -     bool stalled =3D false;
> > -
> > -     while (unlikely(too_many_isolated(pgdat, file, sc))) {
> > -             if (stalled)
> > -                     return 0;
> > -
> > -             /* wait a bit for the reclaimer. */
> > -             msleep(100);
> > -             stalled =3D true;
> > -
> > -             /* We are about to die and free our memory. Return now. *=
/
> > -             if (fatal_signal_pending(current))
> > -                     return SWAP_CLUSTER_MAX;
> > -     }
> >
> >       lru_add_drain();
> >
> > @@ -2903,6 +2852,8 @@ static void shrink_zones(struct zonelist *zonelis=
t, struct scan_control *sc)
> >       unsigned long nr_soft_scanned;
> >       gfp_t orig_mask;
> >       pg_data_t *last_pgdat =3D NULL;
> > +     bool should_retry =3D false;
> > +     int nr_cpus =3D num_online_cpus();
> >
> >       /*
> >        * If the number of buffer_heads in the machine exceeds the maxim=
um
> > @@ -2914,9 +2865,18 @@ static void shrink_zones(struct zonelist *zoneli=
st, struct scan_control *sc)
> >               sc->gfp_mask |=3D __GFP_HIGHMEM;
> >               sc->reclaim_idx =3D gfp_zone(sc->gfp_mask);
> >       }
> > -
> > +retry:
> >       for_each_zone_zonelist_nodemask(zone, z, zonelist,
> >                                       sc->reclaim_idx, sc->nodemask) {
> > +             /*
> > +              * Shrink each node in the zonelist once. If the zonelist=
 is
> > +              * ordered by zone (not the default) then a node may be s=
hrunk
> > +              * multiple times but in that case the user prefers lower=
 zones
> > +              * being preserved.
> > +              */
> > +             if (zone->zone_pgdat =3D=3D last_pgdat)
> > +                     continue;
> > +
> >               /*
> >                * Take care memory controller reclaiming has small influ=
ence
> >                * to global LRU.
> > @@ -2941,16 +2901,28 @@ static void shrink_zones(struct zonelist *zonel=
ist, struct scan_control *sc)
> >                               sc->compaction_ready =3D true;
> >                               continue;
> >                       }
> > +             }
> >
> > -                     /*
> > -                      * Shrink each node in the zonelist once. If the
> > -                      * zonelist is ordered by zone (not the default) =
then a
> > -                      * node may be shrunk multiple times but in that =
case
> > -                      * the user prefers lower zones being preserved.
> > -                      */
> > -                     if (zone->zone_pgdat =3D=3D last_pgdat)
> > -                             continue;
> > +             /*
> > +              * A direct reclaimer may isolate SWAP_CLUSTER_MAX pages =
from
> > +              * the LRU list and then get rescheduled. When there are =
massive
> > +              * number of tasks doing page allocation, such sleeping d=
irect
> > +              * reclaimers may keep piling up on each CPU, the LRU lis=
t will
> > +              * go small and be scanned faster than necessary, leading=
 to
> > +              * unnecessary swapping, thrashing and OOM.
> > +              */
> > +             VM_BUG_ON(current_is_kswapd());
> >
> > +             if (!atomic_add_unless(&zone->zone_pgdat->nr_reclaimers, =
1, nr_cpus)) {
> > +                     should_retry =3D true;
> > +                     continue;
> > +             }
> > +
> > +             if (last_pgdat)
> > +                     atomic_dec(&last_pgdat->nr_reclaimers);
> > +             last_pgdat =3D zone->zone_pgdat;
> > +
> > +             if (!cgroup_reclaim(sc)) {
> >                       /*
> >                        * This steals pages from memory cgroups over sof=
tlimit
> >                        * and returns the number of reclaimed pages and
> > @@ -2966,13 +2938,20 @@ static void shrink_zones(struct zonelist *zonel=
ist, struct scan_control *sc)
> >                       /* need some check for avoid more shrink_zone() *=
/
> >               }
> >
> > -             /* See comment about same check for global reclaim above =
*/
> > -             if (zone->zone_pgdat =3D=3D last_pgdat)
> > -                     continue;
> > -             last_pgdat =3D zone->zone_pgdat;
> >               shrink_node(zone->zone_pgdat, sc);
> >       }
> >
> > +     if (last_pgdat)
> > +             atomic_dec(&last_pgdat->nr_reclaimers);
> > +     else if (should_retry) {
> > +             /* wait a bit for the reclaimer. */
> > +             if (!schedule_timeout_killable(HZ / 10))
> > +                     goto retry;
> > +
> > +             /* We are about to die and free our memory. Return now. *=
/
> > +             sc->nr_reclaimed +=3D SWAP_CLUSTER_MAX;
> > +     }
> > +
> >       /*
> >        * Restore to original mask to avoid the impact on the caller if =
we
> >        * promoted it to __GFP_HIGHMEM.
> > @@ -4189,6 +4168,15 @@ static int __node_reclaim(struct pglist_data *pg=
dat, gfp_t gfp_mask, unsigned in
> >       set_task_reclaim_state(p, &sc.reclaim_state);
> >
> >       if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages=
) {
> > +             int nr_cpus =3D num_online_cpus();
> > +
> > +             VM_BUG_ON(current_is_kswapd());
> > +
> > +             if (!atomic_add_unless(&pgdat->nr_reclaimers, 1, nr_cpus)=
) {
> > +                     schedule_timeout_killable(HZ / 10);
> > +                     goto out;
> > +             }
> > +
> >               /*
> >                * Free memory by calling shrink node with increasing
> >                * priorities until we have enough memory freed.
> > @@ -4196,8 +4184,10 @@ static int __node_reclaim(struct pglist_data *pg=
dat, gfp_t gfp_mask, unsigned in
> >               do {
> >                       shrink_node(pgdat, &sc);
> >               } while (sc.nr_reclaimed < nr_pages && --sc.priority >=3D=
 0);
> > -     }
> >
> > +             atomic_dec(&pgdat->nr_reclaimers);
> > +     }
> > +out:
> >       set_task_reclaim_state(p, NULL);
> >       current->flags &=3D ~PF_SWAPWRITE;
> >       memalloc_noreclaim_restore(noreclaim_flag);
> >
>
> I use my compaction test case to test it, test more than 30 times can
> not reproduce the 100ms sleep. I find that applies the patch, direct
> reclaim path latency reduces much, but the direct compact path latency
> double compares with it before.

Thanks for the update. I think both the speedup and the slowdown are
good news. Why?

My theory is that this patch speeds up the reclaim path, which takes
the lru lock. This in turn induces the lock contention and causes the
slowdown in the compaction path. The compaction path also takes the
lru lock: compact_zone_order() -> isolate_migratepages() ->
isolate_migratepages_block() -> mem_cgroup_page_lruvec().

This theory can be proven by checking whether the slowdown in the path
above. Also did you compare the following stats with and without this
patch?

$ grep compact /proc/vmstat
compact_migrate_scanned 5114098
compact_free_scanned 93606243
compact_isolated 3629513
compact_stall 66
compact_fail 61
compact_success 5
compact_daemon_wake 390
compact_daemon_migrate_scanned 288911
compact_daemon_free_scanned 9835224

You might see a higher number of isolated pages.

>   24)               |  __alloc_pages_direct_compact() {
>   24)               |    try_to_compact_pages() {
>   24)   0.131 us    |      __next_zones_zonelist();
>   24) @ 184008.2 us |      compact_zone_order();
>   24)   0.189 us    |      __next_zones_zonelist();
>   24)   0.547 us    |      compact_zone_order();
>   24)   0.225 us    |      __next_zones_zonelist();
>   24)   0.592 us    |      compact_zone_order();
>   24)   0.146 us    |      __next_zones_zonelist();
>   24) @ 184012.3 us |    }
>   24)               |    get_page_from_freelist() {
>   24)   0.160 us    |      __zone_watermark_ok();
>   24)   0.140 us    |      __next_zones_zonelist();
>   24)   0.141 us    |      __zone_watermark_ok();
>   24)   0.134 us    |      __next_zones_zonelist();
>   24)   0.121 us    |      __zone_watermark_ok();
>   24)   0.123 us    |      __next_zones_zonelist();
>   24)   1.688 us    |    }
>   24)   0.130 us    |    ___might_sleep();
>   24)               |    __cond_resched() {
>   24)   0.123 us    |      rcu_all_qs();
>   24)   0.370 us    |    }
>   24) @ 184015.2 us |  }
>   24)               |  /* mm_page_alloc: page=3D0000000000000000 pfn=3D0
> order=3D9 migratetype=3D1
> gfp_flags=3DGFP_HIGHUSER_MOVABLE|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE *=
/
>   24)               |  /* memlatency: lat=3D184716 order=3D9
> gfp_flags=3D342cca
> (GFP_HIGHUSER_MOVABLE|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE|0x812a3c6000=
000000^@)migratetype=3D1
> */
> /*The memlatency measures the latency of "__alloc_pages_nodemask" */
>
>
> --
> Zhengjun Xing
