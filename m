Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E571736DAD2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhD1PGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhD1PGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:06:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CF4C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:05:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k128so34014801wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/utO0JUES8bqsMHp6o1HbmgumSL9/IkbjkGaOE+fxJM=;
        b=sXVaOijJfNFI19nbo7RcDhdrRvL5CF+2EI4624OSIpoi7pG8IP89DKxS8Uaq8ge+2l
         0hhhOb/xBebUTxMR81v1MENznZIYN8p/aowm+NcKsJfimzDOi5642mdEaAr451xFuwAB
         ZTK6Kl/mOS1Q0TkWzoFG6gpHHKkuJsGSjBYMLDNVPeEKBs03SQWVSHpXl9iCB0cqncZE
         WrhhN8Xv78oE9RgL7XKoiSuUG+NoRPdW07vrPRg4Cz3sdR11V2uoTL1xI7Vz9iooUPqz
         K3Rr/sbEXYL+nmAuKQDWDknH05q9pctZu5yJ23e+Dynnt9pmVJuuUEwlH/G426VNx4T4
         grzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/utO0JUES8bqsMHp6o1HbmgumSL9/IkbjkGaOE+fxJM=;
        b=DYKWo1Shvt8DVopM+qEgis0Ga4klHcNg/3c/PfV+JlXaQgZzVEgN7h8DOrL8Q1FUhD
         ltxfoVKo57SfZOgHYblz8FhZkKfav2dXBbcIg6A6gSuqRZeuBI6Bt1Wz2Na54VbcwojT
         3t8NYaahOdbnUyoQStu9qmAv7YvdbN3uUstXTcV2MbYJyHsdGCWfW6i69yK63tzpUXF8
         pCTyqq5anXzwKtr5S3tVe/iuhMl0dmOPImp0k7GQy4rcUs+RlAwVmKlqnxP5HVv0L7sq
         ucRYz8CGLWw2s5EII/QI94ygWRYMt0Dj60akuR8pZTw9AXKwXmEeqdkVpy1k+rEj7sRB
         /fTQ==
X-Gm-Message-State: AOAM530W6NmLv61KbHPspjQqjKLiFzVWWhd8y8LaF6Ul0rXgpJMWsSWR
        TeaXP43e82t7Vj9HkiXOCqh4Gvdw1hhqqGRDZiiTDA==
X-Google-Smtp-Source: ABdhPJwzc8Bo3yQZy0zHTPtuY0RXeQo+X9BpX8xL6qrPlR+iYaCnn0fD7g7FalokrLkDRRHwImEJLPllBxUO+I/e9jk=
X-Received: by 2002:a7b:c929:: with SMTP id h9mr3588261wml.48.1619622317994;
 Wed, 28 Apr 2021 08:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com> <YIGuvh70JbE1Cx4U@google.com>
 <YIlNKds8klSiOalo@dhcp22.suse.cz>
In-Reply-To: <YIlNKds8klSiOalo@dhcp22.suse.cz>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 28 Apr 2021 09:05:06 -0600
Message-ID: <CAOUHufYXzYs__HSgXC2NfYJGHQzZEE6C+AZ78cvNbrZk_VyKxQ@mail.gmail.com>
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by too_many_isolated()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>, wfg@mail.ustc.edu.cn,
        Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 5:55 AM Michal Hocko <mhocko@suse.com> wrote:
>
> [Cc Rik and Andrea]
>
> On Thu 22-04-21 11:13:34, Yu Zhao wrote:
> > On Thu, Apr 22, 2021 at 04:36:19PM +0800, Xing Zhengjun wrote:
> > > Hi,
> > >
> > >    In the system with very few file pages (nr_active_file + nr_inacti=
ve_file
> > > < 100), it is easy to reproduce "nr_isolated_file > nr_inactive_file"=
,  then
> > > too_many_isolated return true, shrink_inactive_list enter "msleep(100=
)", the
> > > long latency will happen.
> > >
> > > The test case to reproduce it is very simple: allocate many huge page=
s(near
> > > the DRAM size), then do free, repeat the same operation many times.
> > > In the test case, the system with very few file pages (nr_active_file=
 +
> > > nr_inactive_file < 100), I have dumpped the numbers of
> > > active/inactive/isolated file pages during the whole test(see in the
> > > attachments) , in shrink_inactive_list "too_many_isolated" is very ea=
sy to
> > > return true, then enter "msleep(100)",in "too_many_isolated" sc->gfp_=
mask is
> > > 0x342cca ("_GFP_IO" and "__GFP_FS" is masked) , it is also very easy =
to
> > > enter =E2=80=9Cinactive >>=3D3=E2=80=9D, then =E2=80=9Cisolated > ina=
ctive=E2=80=9D will be true.
> > >
> > > So I  have a proposal to set a threshold number for the total file pa=
ges to
> > > ignore the system with very few file pages, and then bypass the 100ms=
 sleep.
> > > It is hard to set a perfect number for the threshold, so I just give =
an
> > > example of "256" for it.
> > >
> > > I appreciate it if you can give me your suggestion/comments. Thanks.
> >
> > Hi Zhengjun,
> >
> > It seems to me using the number of isolated pages to keep a lid on
> > direct reclaimers is not a good solution. We shouldn't keep going
> > that direction if we really want to fix the problem because migration
> > can isolate many pages too, which in turn blocks page reclaim.
> >
> > Here is something works a lot better. Please give it a try. Thanks.
>
> O do have a very vague recollection that number of reclaimers used to be
> a criterion in very old days and it has proven to be quite bad in the
> end. I am sorry but I do not have an reference at hands and do not have
> time to crawl git history. Maybe Rik/Andrea will remember details.

Well, I found nothing.

> The existing throttling mechanism is quite far from optimal but it aims
> at handling close to OOM situations where effectivelly a large part of
> the existing LRUs can be already isolated. We already have a retry
> logic which is LRU aware in the page allocator
> (should_reclaim_retry). The logic would have to be extended but that
> sounds like a better fit for the back off to me.
>
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 507d216610bf2..9a09f7e76f6b8 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -951,6 +951,8 @@ typedef struct pglist_data {
> >
> >       /* Fields commonly accessed by the page reclaim scanner */
> >
> > +     atomic_t nr_reclaimers;
> > +
> >       /*
> >        * NOTE: THIS IS UNUSED IF MEMCG IS ENABLED.
> >        *
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 1c080fafec396..f7278642290a6 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1786,43 +1786,6 @@ int isolate_lru_page(struct page *page)
> >       return ret;
> >  }
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
> >  /*
> >   * move_pages_to_lru() moves pages from private @list to appropriate L=
RU list.
> >   * On return, @list is reused as a list of pages to be freed by the ca=
ller.
> > @@ -1924,19 +1887,6 @@ shrink_inactive_list(unsigned long nr_to_scan, s=
truct lruvec *lruvec,
> >       struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
> >       bool stalled =3D false;
> >
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
> > -
> >       lru_add_drain();
> >
> >       spin_lock_irq(&lruvec->lru_lock);
> > @@ -3302,6 +3252,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mas=
k, struct zonelist *zonelist,
> >  unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> >                               gfp_t gfp_mask, nodemask_t *nodemask)
> >  {
> > +     int nr_cpus;
> >       unsigned long nr_reclaimed;
> >       struct scan_control sc =3D {
> >               .nr_to_reclaim =3D SWAP_CLUSTER_MAX,
> > @@ -3334,8 +3285,17 @@ unsigned long try_to_free_pages(struct zonelist =
*zonelist, int order,
> >       set_task_reclaim_state(current, &sc.reclaim_state);
> >       trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
> >
> > +     nr_cpus =3D current_is_kswapd() ? 0 : num_online_cpus();
> > +     while (nr_cpus && !atomic_add_unless(&pgdat->nr_reclaimers, 1, nr=
_cpus)) {
> > +             if (schedule_timeout_killable(HZ / 10))
> > +                     return SWAP_CLUSTER_MAX;
> > +     }
> > +
> >       nr_reclaimed =3D do_try_to_free_pages(zonelist, &sc);
> >
> > +     if (nr_cpus)
> > +             atomic_dec(&pgdat->nr_reclaimers);
> > +
> >       trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
> >       set_task_reclaim_state(current, NULL);
>
> This will surely break any memcg direct reclaim.

Mind elaborating how it will "surely" break any memcg direct reclaim?
