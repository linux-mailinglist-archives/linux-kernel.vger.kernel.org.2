Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3BF3399F6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 00:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbhCLXTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 18:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbhCLXSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 18:18:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2A9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 15:18:52 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id t18so103481lfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 15:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mK2aSnmbGyTuRcFoPtY3rwHLVLofTtX1TRzm5DaMZsQ=;
        b=EYYAWKTb46EhgkJ6ATfk1K+QMBJUeLlZ+F7wWLEs/eYy4fbaF5/kgjBg0efBbt3ZdX
         AkSomeYqhVzPSv8U4uX9pRp44mspQHaNfQebeQt+kIrPzcfiHu1eyywuTJOBsWBxZxar
         i6lWX/MqGqFaECINQ4jztNzKr6nFitwb0wlMAM4VXaI3IsNOzanLJV3s/a+nfqNvDmeN
         a2FbnZ7ksi0QP9Erjq7csaFe+BeyMSrOVZQhp1xvzTRwurud0uRcFzwpl0ASZLT6c+A9
         K/ZgvB7/IgFM7SRkkpgNCUREq3dAacn3IK/2gPPtswfx4q8y05Odx3x5iRZyMKNuj46k
         wVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mK2aSnmbGyTuRcFoPtY3rwHLVLofTtX1TRzm5DaMZsQ=;
        b=JW7juymTO+DZfW64RxlEnxeduahyw9BK9S13fyzaun6uPmKiNj1i4xd2QQbwiOmXEl
         Kj+ao4WAdNG1Pignbqnoi0Q02hW7QnZI2kxR6NWVGg+oSJ2V3pvCqt+M1ik+eHNgnp4B
         JPoUUOjxBWXZeUGYhucyLRQFTjNi6s1NZ08v2/sQe5Nv5Pa+bVJjpN7CTT7KDBZ9vgu2
         hcUbAomp+iZCDLB5jsCs5glsjq9YRTSQYuFqOT0IJuBazWkrFBceDhKtkNGQGIr/pWsB
         kcD6SNlfC9FyAMucVZc4Ve9UXpryW+lnOX71Wq7ciAtBVI+4M98tCvC1QQ0VyiIyLcDX
         /knw==
X-Gm-Message-State: AOAM530k7F3fzSlwOehIzlS/ZP1RidWiKKJi/JlU60wGer+/9m2c6uby
        OUGmF1S/c89k2jOygcaFRBSF99CfzIe1ub/c2hOnQg==
X-Google-Smtp-Source: ABdhPJwVrSTWR49g3B/sEW1zu6GRQiJdkX8bUu6PAjNwqo76aOwqrS5un3q8ZCEc1wErqlo7lug9dq6WK5xvPLbYa+k=
X-Received: by 2002:a05:6512:6c6:: with SMTP id u6mr873792lff.347.1615591130812;
 Fri, 12 Mar 2021 15:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-3-songmuchun@bytedance.com> <YEoXLX37sVgULO4A@cmpxchg.org>
 <CAMZfGtXZqe7g6e4wf=tUZqxBs-F1QkS2=01Td4Rv3_qTuF0bPA@mail.gmail.com>
 <YEu/pnK0n8nI2OBy@cmpxchg.org> <CALvZod5sEcsu9AHAzdkJyjxm4ws_aKXyyer99+f2rs-OnOQAMg@mail.gmail.com>
 <YEv0JkGtgotHJlO2@cmpxchg.org>
In-Reply-To: <YEv0JkGtgotHJlO2@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 12 Mar 2021 15:18:38 -0800
Message-ID: <CALvZod5n6Yqgz4x=sHTz+Sx7oS2B0id3KsWDVkb8xwbVbrZUWg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/4] mm: memcontrol: make
 page_memcg{_rcu} only applicable for non-kmem page
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 3:07 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Mar 12, 2021 at 02:42:45PM -0800, Shakeel Butt wrote:
> > Hi Johannes,
> >
> > On Fri, Mar 12, 2021 at 11:23 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > [...]
> > >
> > > Longer term we most likely need it there anyway. The issue you are
> > > describing in the cover letter - allocations pinning memcgs for a long
> > > time - it exists at a larger scale and is causing recurring problems
> > > in the real world: page cache doesn't get reclaimed for a long time,
> > > or is used by the second, third, fourth, ... instance of the same job
> > > that was restarted into a new cgroup every time. Unreclaimable dying
> > > cgroups pile up, waste memory, and make page reclaim very inefficient.
> > >
> >
> > For the scenario described above, do we really want to reparent the
> > page cache pages? Shouldn't we recharge the pages to the second,
> > third, fourth and so on, memcgs? My concern is that we will see a big
> > chunk of page cache pages charged to root and will only get reclaimed
> > on global pressure.
>
> Sorry, I'm proposing to reparent to the ancestor, not root. It's an
> optimization, not a change in user-visible behavior.
>
> As far as the user can tell, the pages already belong to the parent
> after deletion: they'll show up in the parent's stats, naturally, and
> they will get reclaimed as part of the parent being reclaimed.
>
> The dead cgroup doesn't even have its own limit anymore after
> .css_reset() has run. And we already physically reparent slab objects
> in memcg_reparent_objcgs() and memcg_drain_all_list_lrus().
>
> I'm just saying we should do the same thing for LRU pages.

I understand the proposal and I agree it makes total sense when a job
is recycling sub-job/sub-container.

I was talking about the (recycling of the) top level cgroups. Though
for that to be an issue, I suppose the file system has to be shared
between the jobs on the system. I was wondering if a page cache
reaches the root memcg on multiple reparenting, should the next access
cause that page to be charged to the accessor?
