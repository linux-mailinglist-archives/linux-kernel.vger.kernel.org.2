Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29AD342482
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhCSSUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhCSSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:20:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFE2C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:20:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o126so1911967lfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tz1A3bSsj9rkyv4dGud826X0c/D6fAibU1rcdURNzxA=;
        b=e2CW/V/+A9LjGE8tySVsj6k7xbzbHKqLyuKGKMK14Suap+1kHtnu0Twb29yzjixeCR
         85VI6Nz3sh840fxOdohZP6w7DS0gzzeCTGkigI2SWWKv/bidA3QlMY86meg/eNVLQQqD
         CPNEfQkn+yHZ17r5meKdKTJoEJ5Y6uAqGklYv0e0b12pBI0KrVkyLNI2ovG9LxbRn4d5
         9R5rMzUfzFAacvaYyrdjTyMgng185K5kKsbNOJnG3au2hZjCuMvBJmeJI5mvEsY2tWDb
         lscjrFmxER3OOEuixRLQxKZ1cRz5Y060Z1wJmfXryCJUKF9b+ujDQhqsAVdBcprNsTIG
         k/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tz1A3bSsj9rkyv4dGud826X0c/D6fAibU1rcdURNzxA=;
        b=KIM2auaYcNoADrngzz6dDAbYuGcUDX+ziS5WKs1hAU9SFYgKiIyROMAarchWq0MgQZ
         GVwmhtTjzf/VYLy73MNJ9cfDZbRwD53gIrKRzQdN5+HbEVZ8uu10mFhemQmX9SO/PCMh
         +V7+fk8eB1qo2wGUgaYWX2e3q0kqG4LgT/iLxQ7UGCclbTEv9rnh29IlugRVYEECEZIn
         fj2w+tIrGnAK67x2uhrmgYNdFCcpuRPlF5lEy5YKJn6hTOpK5t0Z5Io9IUbXRrBXpuHL
         JH0nrxT6AJHVNLP5mTyF0wctvI1YLMDmc2JzhQj8SbSzHTSsbElCM0Z5Y0jly7xJnLVy
         jaLg==
X-Gm-Message-State: AOAM531hO5J1cdmkFcWZWgcerIWe+ScoHKDMYHppTNH8chYntfV3Rd1H
        uePS/2jViKZ0RRX74fbQT2eHfWUsY9SVIPFYBJOgnA==
X-Google-Smtp-Source: ABdhPJw5auxNmMxHYh2Wy7/EwwcS9N1z0P4t0mjnwQsWaQuA2PVf+Wn/YVktqSTXqkuRF8PTIKRehoMVUEJWGVxRcKM=
X-Received: by 2002:a19:f50e:: with SMTP id j14mr1540575lfb.299.1616178037655;
 Fri, 19 Mar 2021 11:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210319054944.50048-1-hannes@cmpxchg.org> <20210319054944.50048-2-hannes@cmpxchg.org>
 <CALvZod6HYfoSnBoq7JGW1ifLmLMmwSAyCqjh+bJ6L9evAPVGLQ@mail.gmail.com> <YFThD2qnSCx5MJEh@cmpxchg.org>
In-Reply-To: <YFThD2qnSCx5MJEh@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Mar 2021 11:20:26 -0700
Message-ID: <CALvZod7gFUcZW0meF8kHUk3rizkUrrQW5knFKX_Rcb1g_dnW+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: memcontrol: deprecate swapaccounting=0 mode
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Mar 19, 2021 at 06:49:55AM -0700, Shakeel Butt wrote:
> > On Thu, Mar 18, 2021 at 10:49 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > The swapaccounting= commandline option already does very little
> > > today. To close a trivial containment failure case, the swap ownership
> > > tracking part of the swap controller has recently become mandatory
> > > (see commit 2d1c498072de ("mm: memcontrol: make swap tracking an
> > > integral part of memory control") for details), which makes up the
> > > majority of the work during swapout, swapin, and the swap slot map.
> > >
> > > The only thing left under this flag is the page_counter operations and
> > > the visibility of the swap control files in the first place, which are
> > > rather meager savings. There also aren't many scenarios, if any, where
> > > controlling the memory of a cgroup while allowing it unlimited access
> > > to a global swap space is a workable resource isolation stragegy.
> >
> > *strategy
>
> Will fix :)
>
> > > On the other hand, there have been several bugs and confusion around
> > > the many possible swap controller states (cgroup1 vs cgroup2 behavior,
> > > memory accounting without swap accounting, memcg runtime disabled).
> > >
> > > This puts the maintenance overhead of retaining the toggle above its
> > > practical benefits. Deprecate it.
> > >
> > > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > [...]
> > >
> > >  static int __init setup_swap_account(char *s)
> > >  {
> > > -       if (!strcmp(s, "1"))
> > > -               cgroup_memory_noswap = false;
> > > -       else if (!strcmp(s, "0"))
> > > -               cgroup_memory_noswap = true;
> > > -       return 1;
> > > +       pr_warn_once("The swapaccount= commandline option is deprecated. "
> > > +                    "Please report your usecase to linux-mm@kvack.org if you "
> > > +                    "depend on this functionality.\n");
> > > +       return 0;
> >
> > What's the difference between returning 0 or 1 here?
>
> It signals whether the parameter is "recognized" by the kernel as a
> valid thing to pass, or whether it's unknown. If it's unknown, it'll
> be passed on to the init system (which ignores it), so this resembles
> the behavior we'll have when we remove the __setup in the future.
>
> If somebody can make an argument why we should go with one over the
> other, I'll happily go with that.
>
> > >  __setup("swapaccount=", setup_swap_account);
> > >
> > > @@ -7291,27 +7287,13 @@ static struct cftype memsw_files[] = {
> > >         { },    /* terminate */
> > >  };
> > >
> > > -/*
> > > - * If mem_cgroup_swap_init() is implemented as a subsys_initcall()
> > > - * instead of a core_initcall(), this could mean cgroup_memory_noswap still
> > > - * remains set to false even when memcg is disabled via "cgroup_disable=memory"
> > > - * boot parameter. This may result in premature OOPS inside
> > > - * mem_cgroup_get_nr_swap_pages() function in corner cases.
> > > - */
> > >  static int __init mem_cgroup_swap_init(void)
> > >  {
> > > -       /* No memory control -> no swap control */
> > > -       if (mem_cgroup_disabled())
> > > -               cgroup_memory_noswap = true;
> > > -
> > > -       if (cgroup_memory_noswap)
> > > -               return 0;
> > > -
> >
> > Do we need a mem_cgroup_disabled() check here?
>
> cgroup_add_cftypes() implies this check from the cgroup side and will
> just do nothing and return success. So we don't need it now.
>
> But it is something we'd have to remember to add if we do add more
> code to this function later on.
>
> Either way works for me. I can add it if people think it's better.
>

I am fine with either way. For this patch:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
