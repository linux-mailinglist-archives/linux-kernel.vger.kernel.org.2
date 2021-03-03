Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D689A32BA90
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357898AbhCCLhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhCCDO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 22:14:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745DFC06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 19:13:03 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d8so2821836plg.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 19:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPtyv7FWNE5afHArRbhNorqbEBt/90YtJ2/j1QcFJFk=;
        b=L2HVGMBbxOe1DUQxG0VZsngFSjQuWnhYhNGZmw4MHVlJRyqbmUwS8iL9WGQ/8pWBei
         /XN3a1460NKQsgVyKnsD5Rq2n++ewQ8EQadRMPs4XpnfqYtazzjce6/qqHHzc46N0xHq
         gVJQSelHZ5nrFMSUA9sD63r6gRTOwkJsMZB4jurQlq3ntGcBN8jZX2bjdBpAyUtNdZ+B
         iWByPp5+QhBBfOJtdyYLc8rJVM7qGBTPuYeo3JQBHH2bq5cnDef+ycCNtasjW1zNaLRQ
         YLr8n/VbJGaPj3r5lV0lvW1y6J1scJUg3LG23obPzPSolQIMtVfzNp5hpsgsnuyOrM4e
         6bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPtyv7FWNE5afHArRbhNorqbEBt/90YtJ2/j1QcFJFk=;
        b=W50ePuK6C2tPLcwRILvj7jnLAAJiPns0Gyt8/0fFd3dcFoEMqqA8xIkDpbOFUz1am5
         gkt6uTrWctQbblPhCoSHSmQKbNP4tCsarGNnzKg+8bPzpqTW/ArQPnKxpps0CBwYAjIQ
         4lV7SJqoKwGiMFR8wgCPp/cbqRqE9Kp3KD241bK14GMggTu8guPqC8qNOyM7BDycS4hO
         D8qfUejOAP5gPX7QRzjH3OLTvxYIVL4IfYKyqgNabdd5js4Nk2Qk1li0aNM7BRXC9xIm
         9BJDrDbS//jYmznWcTyHirYU4EvjNHkGDUZkuqdOPuE6QDdxhaLim7vg8ICEIH2RUEbk
         17LQ==
X-Gm-Message-State: AOAM530ULOKx4ls4VyLpNW8OCSoDa0El0opv28AHgI79g+YJcb2Q8Fcw
        +cy37sKBTyJv0stjZHrD13QCVqgArP5D29Iy8IxBhw==
X-Google-Smtp-Source: ABdhPJx3chnssos306qpL9AmHwbrb44kCCmB0MEYUU84BwvstDSlD/D91l1sBkVKXSYBrKUHOk9rCIv3wyp3pOsPqyM=
X-Received: by 2002:a17:90a:f008:: with SMTP id bt8mr1365042pjb.13.1614741183030;
 Tue, 02 Mar 2021 19:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20210302081823.9849-1-songmuchun@bytedance.com> <YD6K3HghLy5glOgi@carbon.dhcp.thefacebook.com>
In-Reply-To: <YD6K3HghLy5glOgi@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 3 Mar 2021 11:12:26 +0800
Message-ID: <CAMZfGtWbEzgDqkHr1Pu598tfEHHCzKRXbSnVHyDWk5FeH2372w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix root_mem_cgroup charging
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 2:58 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Mar 02, 2021 at 04:18:23PM +0800, Muchun Song wrote:
> > CPU0:                                   CPU1:
> >
> > objcg = get_obj_cgroup_from_current();
> > obj_cgroup_charge(objcg);
> >                                         memcg_reparent_objcgs();
> >                                             xchg(&objcg->memcg, root_mem_cgroup);
> >     // memcg == root_mem_cgroup
> >     memcg = obj_cgroup_memcg(objcg);
> >     __memcg_kmem_charge(memcg);
> >         // Do not charge to the root memcg
> >         try_charge(memcg);
> >
> > If the objcg->memcg is reparented to the root_mem_cgroup,
> > obj_cgroup_charge() can pass root_mem_cgroup as the first
> > parameter to here. The root_mem_cgroup is skipped in the
> > try_charge(). So the page counters of it do not update.
> >
> > When we uncharge this, we will decrease the page counters
> > (e.g. memory and memsw) of the root_mem_cgroup. This will
> > cause the page counters of the root_mem_cgroup to be out
> > of balance. Fix it by charging the page to the
> > root_mem_cgroup unconditional.
>
> Is this a problem? It seems that we do not expose root memcg's counters
> except kmem and tcp.

In the page_counter_cancel(), we can see a WARN_ON_ONCE()
to catch this issue. Yeah, it is very hard to trigger this warn for
root memcg. But it actually can. Right?

If we do not care about the root memcg counter, we should not warn
for the root memcg.

> It seems that the described problem is not
> applicable to the kmem counter. Please, explain.

The kmem counter of the root memcg is updated unconditionally.
Because we do not check whether the memcg is root when we
charge pages to the kmem counter.

Thanks.

>
> Thanks!
>
> >
> > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/memcontrol.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 2db2aeac8a9e..edf604824d63 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3078,6 +3078,19 @@ static int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
> >       if (ret)
> >               return ret;
> >
> > +     /*
> > +      * If the objcg->memcg is reparented to the root_mem_cgroup,
> > +      * obj_cgroup_charge() can pass root_mem_cgroup as the first
> > +      * parameter to here. We should charge the page to the
> > +      * root_mem_cgroup unconditional to keep it's page counters
> > +      * balance.
> > +      */
> > +     if (unlikely(mem_cgroup_is_root(memcg))) {
> > +             page_counter_charge(&memcg->memory, nr_pages);
> > +             if (do_memsw_account())
> > +                     page_counter_charge(&memcg->memsw, nr_pages);
> > +     }
> > +
> >       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
> >           !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
> >
> > --
> > 2.11.0
> >
