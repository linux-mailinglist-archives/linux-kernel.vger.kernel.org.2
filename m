Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C4F367816
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 05:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhDVDst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 23:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbhDVDsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 23:48:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06445C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 20:47:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h15so13068572pfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 20:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MiO1r/tF/SPp2chrs+UsuwHw9hLWYuR43hQib9+gOqE=;
        b=U+KS9XDereb/Ih6K0rzxGkcqdDI1mZD9n7C+Qbg1bMGhPCM1D9/s+6VPvj1JSM1kcE
         LRylrzWGVJpTywMfvaQBWLc3jw6MCNvjiF22aYRA4hj2SwOGiwBMvA5be5RRNgEbKpcJ
         M3/dM27qTqhJZhK8bCa0hYcfstsjEAmDsQ0gffrPxkCvsKZvoQ5AyRJuuJiyTXEZt4QO
         iul03Gp5ak8Zcy5RXsDLUH006teykR+KteMKkcver0hrB+iU+qvvtoMKsmmhx1aJcIE4
         1vMGx2r8zbQJs8UTlvzCDSJJbIOVtnwY3EEPJWQtVD0Gdhp9G7SFk4F7HrBqKZAzp2HT
         lNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MiO1r/tF/SPp2chrs+UsuwHw9hLWYuR43hQib9+gOqE=;
        b=W3nk26ZUYeH2XybuYfA3WuEA/R50KrZZ193Sk3kveMMAdAT+WX+aKU3xOR8wnvUkgO
         SY+C6jBsQJjhdT+90VcftZRAQ9gcHQ0zVMFU4bfgL2PCIyZz5GERDgOD7q+q87ZSuwY/
         0hZsis7jXk9TidQEWA8cHbSTfTzW8oAUpzjWXQILAEDxYCZs0SLltBUbhGW+jpRh47/d
         G7l5ZS6v12pVXMA3DEhsmw9RxdyYF+x/n37j0i/ndtuJeP4UZDnf2wCanfuNZJu8ONom
         URqIALlZx2eFhBCZrGDfd+jYBaj96tdb7riPFM7IEkBQmdXEE0fbAWe/Y0DrbkJsa1eY
         UOaw==
X-Gm-Message-State: AOAM531FcSLSFs/mY7nLJZq9P2S7k5NW/yMAiJLA4Q8RY16HaOx1+lhx
        c7a5iLrM1loXBNUZ+z78OOOhyVIcG0YQWW77keYfBA==
X-Google-Smtp-Source: ABdhPJyl6y5tR1TLHC/RvLcVNvBQXydLZtm56XiC4ejGL/jVT8B2P/GuV2f9FlrJBZ3oV4+c3uBf+9qzNEkQ9GTj67A=
X-Received: by 2002:a05:6a00:228a:b029:264:1ec7:7c3 with SMTP id
 f10-20020a056a00228ab02902641ec707c3mr1274166pfe.2.1619063267537; Wed, 21 Apr
 2021 20:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210421062644.68331-1-songmuchun@bytedance.com>
 <YH/Vf8SDRy7VR7ur@dhcp22.suse.cz> <CAMZfGtVpz1FvzmhWFzXAJE3wWBMJwdwU+JqQ6a8KeOhV3FGJ4Q@mail.gmail.com>
 <YIAimEdqpen3/38Z@dhcp22.suse.cz> <CAMZfGtUOXyK3RDZ+P0GaO4p-P0XatFB8ZbmXEFvfet1HSrdFog@mail.gmail.com>
 <YIDKDQxOq8IK82Rt@carbon.dhcp.thefacebook.com>
In-Reply-To: <YIDKDQxOq8IK82Rt@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 22 Apr 2021 11:47:05 +0800
Message-ID: <CAMZfGtWHSVrJA3ERzZmV5k_1VNe+dic44ophaoF15jC1c_-BmA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix root_mem_cgroup charging
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 8:57 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Apr 21, 2021 at 09:39:03PM +0800, Muchun Song wrote:
> > On Wed, Apr 21, 2021 at 9:03 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 21-04-21 17:50:06, Muchun Song wrote:
> > > > On Wed, Apr 21, 2021 at 3:34 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Wed 21-04-21 14:26:44, Muchun Song wrote:
> > > > > > The below scenario can cause the page counters of the root_mem_cgroup
> > > > > > to be out of balance.
> > > > > >
> > > > > > CPU0:                                   CPU1:
> > > > > >
> > > > > > objcg = get_obj_cgroup_from_current()
> > > > > > obj_cgroup_charge_pages(objcg)
> > > > > >                                         memcg_reparent_objcgs()
> > > > > >                                             // reparent to root_mem_cgroup
> > > > > >                                             WRITE_ONCE(iter->memcg, parent)
> > > > > >     // memcg == root_mem_cgroup
> > > > > >     memcg = get_mem_cgroup_from_objcg(objcg)
> > > > > >     // do not charge to the root_mem_cgroup
> > > > > >     try_charge(memcg)
> > > > > >
> > > > > > obj_cgroup_uncharge_pages(objcg)
> > > > > >     memcg = get_mem_cgroup_from_objcg(objcg)
> > > > > >     // uncharge from the root_mem_cgroup
> > > > > >     page_counter_uncharge(&memcg->memory)
> > > > > >
> > > > > > This can cause the page counter to be less than the actual value,
> > > > > > Although we do not display the value (mem_cgroup_usage) so there
> > > > > > shouldn't be any actual problem, but there is a WARN_ON_ONCE in
> > > > > > the page_counter_cancel(). Who knows if it will trigger? So it
> > > > > > is better to fix it.
> > > > >
> > > > > The changelog doesn't explain the fix and why you have chosen to charge
> > > > > kmem objects to root memcg and left all other try_charge users intact.
> > > >
> > > > The object cgroup is special (because the page can reparent). Only the
> > > > user of objcg APIs should be fixed.
> > > >
> > > > > The reason is likely that those are not reparented now but that just
> > > > > adds an inconsistency.
> > > > >
> > > > > Is there any reason you haven't simply matched obj_cgroup_uncharge_pages
> > > > > to check for the root memcg and bail out early?
> > > >
> > > > Because obj_cgroup_uncharge_pages() uncharges pages from the
> > > > root memcg unconditionally. Why? Because some pages can be
> > > > reparented to root memcg, in order to ensure the correctness of
> > > > page counter of root memcg. We have to uncharge pages from
> > > > root memcg. So we do not check whether the page belongs to
> > > > the root memcg when it uncharges.
> > >
> > > I am not sure I follow. Let me ask differently. Wouldn't you
> > > achieve the same if you simply didn't uncharge root memcg in
> > > obj_cgroup_charge_pages?
> >
> > I'm afraid not. Some pages should uncharge root memcg, some
> > pages should not uncharge root memcg. But all those pages belong
> > to the root memcg. We cannot distinguish between the two.
> >
> > I believe Roman is very familiar with this mechanism (objcg APIs).
> >
> > Hi Roman,
> >
> > Any thoughts on this?
>
> First, unfortunately we do export the root's counter on cgroup v1:
> /sys/fs/cgroup/memory/memory.kmem.usage_in_bytes
> But we don't ignore these counters for the root mem cgroup, so there
> are no bugs here. (Otherwise, please, reproduce it). So it's all about
> the potential warning in page_counter_cancel().

Right.

>
> The patch looks technically correct to me. Not sure about __try_charge()
> naming, we never use "__" prefix to do something with the root_mem_cgroup.
>
> The commit message should be more clear and mention the following:
> get_obj_cgroup_from_current() never returns a root_mem_cgroup's objcg,
> so we never explicitly charge the root_mem_cgroup. And it's not
> going to change.
> It's all about a race when we got an obj_cgroup pointing at some non-root
> memcg, but before we were able to charge it, the cgroup was gone, objcg was
> reparented to the root and so we're skipping the charging. Then we store the
> objcg pointer and later use to uncharge the root_mem_cgroup.

Very clear. Thanks.

>
> But honestly I'm not sure the problem is worth the time spent on the fix
> and the discussion. It's a small race and it's generally hard to trigger
> a kernel allocation racing with a cgroup deletion and then you need *a lot*
> of such races and then maybe there will be a single warning printed without
> *any* other consequences.

I agree the race is very small. Since the fix is easy, but a little confusing
to someone. I want to hear other people's suggestions on whether to fix it.

>
> Thanks!
