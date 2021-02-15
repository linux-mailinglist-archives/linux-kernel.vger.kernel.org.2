Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E3A31B6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 11:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBOKLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 05:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBOKLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:11:01 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F26DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 02:10:21 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gx20so3616090pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 02:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUkfBcazTUCSySsbiIpdf7O4sDkmamjhiSz7LSXU/q4=;
        b=H1TVCYlZbW83imFghMNQrgZVHaopx3G7upqnpaCf3o+DIiA7AB2ZPsVxte6UcaFTcX
         trlyNHKP2lqVPJhwEVc3NJADj9CHjpL1Xsch5BrecHXGTg8DGaWMACtBHW/D5d1h/ab3
         hwkpAA34c7CyoHgsja4N8BYXtgbS09kr+Nc8tDkomKLEaxh72pl/5HKUbwf50m7wg6Ha
         sjnAGUX5OPvd86woy4ls62/I9TR7JnfTFAjB1ODQ1RlG8YFW6I6rSMiumlVg+E9FXuIe
         7aVNrDtbVmpMzOQIQ6JMr6tCP/1m4VOC0eP9+AK/GzDTOHk52YNLBFYCEmXR4L5cFGoh
         rTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUkfBcazTUCSySsbiIpdf7O4sDkmamjhiSz7LSXU/q4=;
        b=G8cHisHLXhJdmRubSlNDQbSvtMfp4PKnNDRHRKC6GJt5m6djdBUdaFQ+COyq7pK0pB
         h5v+GqoTC4DAcknfO59GAhZNq97JzfSYNkbOzx2diEXm/uWq/uu/1hlU3R4S0bsZOKjJ
         trBaeOnY5z7BaJr4AGVbkUOLKAo9RO/1kKPcq1zKKs9pKcwuM9SspAXGvE7V6Higkox2
         9GE6GsDbnhXLMcxFZ/M3db/7F4zBcPkpGaOI+DLqAqllfwIS+I3NjmaLwGb6ZPy7FiOJ
         BlYVQ3a5UWADbNmHs1odi6mI/gxO1tG+fJkrVIP2iXIgoUjuHcG/BmuLbJN9OGqCg4OO
         J4Xg==
X-Gm-Message-State: AOAM532fN0fk4ZBBVu9n4yetCxQHeLLy7+Yolr1KMygkzY1tdiF+6k9n
        5fRyKpI+hGzb4CqkBQrVoh+pCoUw0qDkA1VmyCz4Cg==
X-Google-Smtp-Source: ABdhPJzmO6TWU1MkQeMZEYcgMqkOlI9BRJZd2Fv5/20y4X9tFe6U500m6dr22NKX22P40SGqOg/5qp2H0O2Uixeox+I=
X-Received: by 2002:a17:902:9341:b029:e1:7b4e:57a8 with SMTP id
 g1-20020a1709029341b02900e17b4e57a8mr14556708plp.34.1613383820620; Mon, 15
 Feb 2021 02:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-3-songmuchun@bytedance.com> <YCpBUm2N4Bqm5PM5@dhcp22.suse.cz>
In-Reply-To: <YCpBUm2N4Bqm5PM5@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Feb 2021 18:09:44 +0800
Message-ID: <CAMZfGtVkh-DeYLLo8Nn7kHMCq055RSvL03eON1iqmhydYiQ-iQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/4] mm: memcontrol: bail out early when id
 is zero
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 5:39 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Sat 13-02-21 01:01:58, Muchun Song wrote:
> > The memcg ID cannot be zero, but we can pass zero to mem_cgroup_from_id,
> > so idr_find() is pointless and wastes CPU cycles.
>
> Is this possible at all to happen? If not why should we add a test for
> _all_ invocations?

Yeah, this indeed can happen. If we allocate a new swap cache page
and charge it via mem_cgroup_charge, then the page will uncharge
the swap counter via mem_cgroup_uncharge_swap. When the swap
entry is indeed freed, we will call mem_cgroup_uncharge_swap again,
In this routine, we can pass zero to mem_cgroup_from_id. Right?


>
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/memcontrol.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index a3f26522765a..68ed4b297c13 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5173,6 +5173,9 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
> >  struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
> >  {
> >       WARN_ON_ONCE(!rcu_read_lock_held());
> > +     /* The memcg ID cannot be zero. */
> > +     if (id == 0)
> > +             return NULL;
> >       return idr_find(&mem_cgroup_idr, id);
> >  }
> >
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
