Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BEE360032
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 05:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhDODOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 23:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDODOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 23:14:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D17C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 20:13:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d124so15084412pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Fmh4liS79Et/TiMhWSk7GeZ0Io6rybbiYkaLqbUOfg=;
        b=WPvI4faUCBMBDYwBdUQ1ea7lAY2O/HpTKORWELEWhp7s9skrAJ30T7iC9gXud+u+sO
         bytUQgsqxDlYHWQtTaCbzzCRUPmCpGnknKOE9pydf7liyY5quX1rXMeJ8RD9QcHpMwla
         qvspoElyrNWNejQDLi9hh1w1uVilmciRcO0U7UobXbr6IOdtTL7vh1yNMELOStsQwRCg
         RtUtPaQLSKpIY7lsPN+nQudCZH/rxGt1TznF0fXNi7ioZnxbstHjITbbKsd90ESxPvMg
         FMAVCcQxtJ9XUbIFtJRvlLfqIfx/zuHC12+dnYhaqw6MlD153ZQxi00mzf5UhvUs+1B7
         uHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Fmh4liS79Et/TiMhWSk7GeZ0Io6rybbiYkaLqbUOfg=;
        b=DjyabccgKPooyf6DRafSJaJG6f0rJL9qfgQDc5dWnr+dVCYsU+Q4lDIBgi9Tnpy8/0
         fFDyVx9u5h/FpHlnVjFWH3Fy/tUvKzF6YFr1np1wqQvJHyuqlqyaKsAHLFzJQCNhGXuD
         WMaCnk5LIdBQfe+5WeJDlz1hvQ0e6ccALspgwAdCs9y7LFSs3BDzdUUyHDnKyDyPzFKT
         hzyUPLYXM57BMHvpYTai7RVdAElxUpKdAI6XiTUyytYKs9BUmMCFum8vvCjRyqL+UBM3
         5nRIxb4UGmG298PNNs+RroOgh20wPvdacue1a2m1L1rdPmPw8AWWTVqipIYs7KngXhaX
         942w==
X-Gm-Message-State: AOAM532LoX654vBgbepZBfjHotKE9x8pYfgwqFX4aiL62v1EGfn2IZ8A
        rYTxOY7EtIC1n0Ehp2fkA78+mXtX2nwxgT2lY0m0Kw==
X-Google-Smtp-Source: ABdhPJwPDd8ibKe1hHYudB4GXH9XEvmHZJhxqiFbMrk7qzbeN0F7LOU8HEdco9pn8nGRqmohF3gmyM11nLDVx4e2bxY=
X-Received: by 2002:a63:1665:: with SMTP id 37mr1526545pgw.31.1618456434129;
 Wed, 14 Apr 2021 20:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-3-songmuchun@bytedance.com> <YHa00lx7ACWcS1/h@dhcp22.suse.cz>
 <CAMZfGtVpUW1=Zvys7J=gW1xqkuUVLuPYcQbwJoe=TEkBa6qqQw@mail.gmail.com> <YHbAzL9ls6EBsB3L@dhcp22.suse.cz>
In-Reply-To: <YHbAzL9ls6EBsB3L@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 15 Apr 2021 11:13:16 +0800
Message-ID: <CAMZfGtVGBW-j8_2+dmrD=Bbc2mOXUj4Hg_pjOKi0YrY_OVj1nA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/7] mm: memcontrol: bail out early when
 !mm in get_mem_cgroup_from_mm
To:     Michal Hocko <mhocko@suse.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 6:15 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 14-04-21 18:04:35, Muchun Song wrote:
> > On Wed, Apr 14, 2021 at 5:24 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 13-04-21 14:51:48, Muchun Song wrote:
> > > > When mm is NULL, we do not need to hold rcu lock and call css_tryget for
> > > > the root memcg. And we also do not need to check !mm in every loop of
> > > > while. So bail out early when !mm.
> > >
> > > mem_cgroup_charge and other callers unconditionally drop the reference
> > > so how come this does not underflow reference count?
> >
> > For the root memcg, the CSS_NO_REF flag is set, so css_get
> > and css_put do not get or put reference.
>
> Ohh, right you are. I must have forgot about that special case. I am
> pretty sure I (and likely few more) will stumble over that in the future
> again. A small comment explaining that the reference can be safely
> ignore would be helpful.

OK. Will do.

>
> Anyway
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

>
> Thanks!
>
> --
> Michal Hocko
> SUSE Labs
