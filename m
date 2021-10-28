Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C39043D83C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 02:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhJ1Asi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 20:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ1Asg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:48:36 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA14C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 17:46:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id a5so41097qvn.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 17:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WP0EhpkPG4zhYCdaeYS6YIcnXfowG3Qfj8auHLu7RCs=;
        b=EUM+LqN+o9a7VH2KekR6Y3w0AyEmah+uVCPv4CyO8pqV9nqErxTZPWntW2h9ZNKKL4
         5XrX0FbXUAJRY/ge7AsF0Nf6S8tAdWeOwSoRvH3INOmxPgASeqvu4K6D+dSKdLBDPmw5
         ePdkiNF9duZVtFg3xIVCkeTJSuMmEPWkHb1bvDAMOJXIEs1LeFl5ym78dui0ygwWKhEa
         Yo+iXBuPbBKhz+xRPwYYIAKm3L01i+257lvHbK17Mxc3zSZnosxNZ2KP2CAY8YVkaMeV
         dG7/h9Px9uYj3w938TzUh4Y+k1BvRhVQo66BeeyMMpWNtPBpTumQp2jVBGylPXxqqGtH
         EbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WP0EhpkPG4zhYCdaeYS6YIcnXfowG3Qfj8auHLu7RCs=;
        b=zWFtegl3hVZE8MaUoUFgSWUy8xwfgnGWWIV3aTCwt6NEReJMInw/vdvbF30nowIuIV
         6wEo71gx0iWxT5D6qqQzPX94vFhofpdyXY7l6ZVBWKcki6SqOguZqSl4cuu8MgAernT9
         mWsR922DIdoyCSPriErOztjDCoxeyUT5Vl5RDXQ8nWB4TX+olw686ojLPtkno4MrUafE
         8TtWCObMTaqP/QjNcCIs6gu7cnGL+g7LzxVHEc3EfOlI3ssKefabBzOMIL52FSF1LZOa
         qxX1AssIdon8jARrBMduY2RJj55lZHrInlwm1nveXiTt7IerxevIgmgZ8wKhzHgeafNb
         VFmQ==
X-Gm-Message-State: AOAM530deRgab34ZDXS/r/AljzScO3iyT4x7ypzlslUwdfHQYuc7t3KI
        NO2tgFDeES5AKFCgkHdsD6OjQ2TU8LmNvwNFS/g=
X-Google-Smtp-Source: ABdhPJyk1ad7CpmSuwErS4kaMQ80cWFsf/AMP3JYRDaABDbZQ4W5J6rNN9xROzGYWZigqV/y4ckIjFElBHtqIMPUplI=
X-Received: by 2002:a05:6214:411e:: with SMTP id kc30mr1228742qvb.6.1635381969675;
 Wed, 27 Oct 2021 17:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <1635318110-1905-1-git-send-email-huangzhaoyang@gmail.com>
 <YXj9w+8Bwlkz5PRy@dhcp22.suse.cz> <CAGWkznHVHVBrQEiO32p2uX_5BDUMc1fE64KuV34WJfpwC_23Pw@mail.gmail.com>
 <YXkNJjD4axYlmqQ5@dhcp22.suse.cz> <CAGWkznHrZ=Y3kG5j5aYdTV2294QGrQbM6251zcdGphzCGUP6dw@mail.gmail.com>
 <YXk9a3X62vNTyvGE@dhcp22.suse.cz> <CAGWkznEZhPxgb_K2vcfyhnGufPMaX3ksxbJvQSurwkNtLKRTGg@mail.gmail.com>
 <YXlGhEDYtnKtwKUb@dhcp22.suse.cz>
In-Reply-To: <YXlGhEDYtnKtwKUb@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 28 Oct 2021 08:45:48 +0800
Message-ID: <CAGWkznGp8Z9F8wK5UN+1Z-5NwQjZ+okpVfnq9-Gzv38xHPEDrQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: have kswapd only reclaiming use min protection on memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 8:31 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 27-10-21 20:05:30, Zhaoyang Huang wrote:
> > On Wed, Oct 27, 2021 at 7:52 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 27-10-21 17:19:56, Zhaoyang Huang wrote:
> > > > On Wed, Oct 27, 2021 at 4:26 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Wed 27-10-21 15:46:19, Zhaoyang Huang wrote:
> > > > > > On Wed, Oct 27, 2021 at 3:20 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Wed 27-10-21 15:01:50, Huangzhaoyang wrote:
> > > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > > >
> > > > > > > > For the kswapd only reclaiming, there is no chance to try again on
> > > > > > > > this group while direct reclaim has. fix it by judging gfp flag.
> > > > > > >
> > > > > > > There is no problem description (same as in your last submissions. Have
> > > > > > > you looked at the patch submission documentation as recommended
> > > > > > > previously?).
> > > > > > >
> > > > > > > Also this patch doesn't make any sense. Both direct reclaim and kswapd
> > > > > > > use a gfp mask which contains __GFP_DIRECT_RECLAIM (see balance_pgdat
> > > > > > > for the kswapd part)..
> > > > > > ok, but how does the reclaiming try with memcg's min protection on the
> > > > > > alloc without __GFP_DIRECT_RECLAIM?
> > > > >
> > > > > I do not follow. There is no need to protect memcg if the allocation
> > > > > request doesn't have __GFP_DIRECT_RECLAIM because that would fail the
> > > > > charge if a hard limit is reached, see try_charge_memcg and
> > > > > gfpflags_allow_blocking check.
> > > > >
> > > > > Background reclaim, on the other hand never breaches reclaim protection.
> > > > >
> > > > > What is the actual problem you want to solve?
> > > > Imagine there is an allocation with gfp_mask & ~GFP_DIRECT_RECLAIM and
> > > > all processes are under cgroups. Kswapd is the only hope here which
> > > > however has a low efficiency of get_scan_count. I would like to have
> > > > kswapd work as direct reclaim in 2nd round which will have
> > > > protection=memory.min.
> > >
> > > Do you have an example where this would be a practical problem? Atomic
> > > allocations should be rather rare.
> > Please find below for the search result of '~__GFP_DIRECT_RECLAIM'
> > which shows some drivers and net prefer to behave like that.
> > Furthermore, the allocations are always together with high order.
>
> And what is the _practical_ problem you are seeing or trying to solve?
We do have out of tree code behave like this and want to make the
mechanics more robust
>
> --
> Michal Hocko
> SUSE Labs
