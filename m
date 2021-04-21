Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF6366CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbhDUNkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhDUNkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:40:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A2CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:39:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o16so8054821plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhMLOnWO5qZngJMN7NKdOR6yuHZHGJTjvv7soDc2Xpo=;
        b=RZp8y013plb9zCPZP4ZesknGmTm7X/DyZwCOfFUmolq8UrIKRF6QqyYbwiZ2rX17OO
         BOiNITK1rollxoeIVzXwfCl4VrRFd99nWbYP6pNxQJJkUHmSeOsEToXPvHYFW/rG/bpj
         tMWnS0KX2n0EEf518JKKUi9Wedl3JTIGinQ1pJhACYXJo8Lv3fVoa6bfTDTBlyK0pTPs
         rbTZaZxuRD2Rw4xLBUOw/IvfvcdF62IyhwoUkSxgYX4fJQjJym2uFDhE6qzOInnsk4SG
         OXuUog/rFGw4HCA3/5JhHcLKv/Phj4HRSobca4JP0k9YprJHRuRLjCCRwhr3QkDoxUTj
         7hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhMLOnWO5qZngJMN7NKdOR6yuHZHGJTjvv7soDc2Xpo=;
        b=KOp8L1z/bQ1WuGaNuQKQzHONdcSEGWmlvrFEJYdDxgWC0i7E/0MPhLXcJcQ7Hc+kQE
         o+hlOBPHsX7WcP4zjfNk+DXhqbLhR/CLpmg2N/60br497DpSr02wpu7Oy2vpGD1qVFfl
         fk1xmVGR7j2vctilEejSGm8TgLgNe8USV5m+comKxY8/vAljH9YjHQ7Kge8DQvKOkX3s
         pPLaAmTjPYshB5WtdbKP3Pz12dXdhsKS9FLm7pCndIRvTKcQI54bIvDp3bi9YH5slICB
         YyLGCbbDW8O67LEHLVCp5AfxodK2lQ1BDzzMD1PBseEvOCfK8eOIVvbB5wqkL4vOH09P
         kO5A==
X-Gm-Message-State: AOAM530m7Ogzlgzuna6zzP0T9ViRG30W2qP6V3NqvXwJhTyQyzi6X/yT
        DEjiB/LoSwPSR99/1W3Cd5+E36WxoyfXx74+q3TeUw==
X-Google-Smtp-Source: ABdhPJzOl9yYrt/64p9ziBPGD3/TvD8+f3yKe8pN6dxoOUcsz3QU7eI4rPq8zKTMwRC1YjgRIwoslaT8CuBxnlAbvwM=
X-Received: by 2002:a17:902:d482:b029:ec:9091:d099 with SMTP id
 c2-20020a170902d482b02900ec9091d099mr21410029plg.34.1619012379567; Wed, 21
 Apr 2021 06:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210421062644.68331-1-songmuchun@bytedance.com>
 <YH/Vf8SDRy7VR7ur@dhcp22.suse.cz> <CAMZfGtVpz1FvzmhWFzXAJE3wWBMJwdwU+JqQ6a8KeOhV3FGJ4Q@mail.gmail.com>
 <YIAimEdqpen3/38Z@dhcp22.suse.cz>
In-Reply-To: <YIAimEdqpen3/38Z@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 21 Apr 2021 21:39:03 +0800
Message-ID: <CAMZfGtUOXyK3RDZ+P0GaO4p-P0XatFB8ZbmXEFvfet1HSrdFog@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix root_mem_cgroup charging
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
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

On Wed, Apr 21, 2021 at 9:03 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 21-04-21 17:50:06, Muchun Song wrote:
> > On Wed, Apr 21, 2021 at 3:34 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 21-04-21 14:26:44, Muchun Song wrote:
> > > > The below scenario can cause the page counters of the root_mem_cgroup
> > > > to be out of balance.
> > > >
> > > > CPU0:                                   CPU1:
> > > >
> > > > objcg = get_obj_cgroup_from_current()
> > > > obj_cgroup_charge_pages(objcg)
> > > >                                         memcg_reparent_objcgs()
> > > >                                             // reparent to root_mem_cgroup
> > > >                                             WRITE_ONCE(iter->memcg, parent)
> > > >     // memcg == root_mem_cgroup
> > > >     memcg = get_mem_cgroup_from_objcg(objcg)
> > > >     // do not charge to the root_mem_cgroup
> > > >     try_charge(memcg)
> > > >
> > > > obj_cgroup_uncharge_pages(objcg)
> > > >     memcg = get_mem_cgroup_from_objcg(objcg)
> > > >     // uncharge from the root_mem_cgroup
> > > >     page_counter_uncharge(&memcg->memory)
> > > >
> > > > This can cause the page counter to be less than the actual value,
> > > > Although we do not display the value (mem_cgroup_usage) so there
> > > > shouldn't be any actual problem, but there is a WARN_ON_ONCE in
> > > > the page_counter_cancel(). Who knows if it will trigger? So it
> > > > is better to fix it.
> > >
> > > The changelog doesn't explain the fix and why you have chosen to charge
> > > kmem objects to root memcg and left all other try_charge users intact.
> >
> > The object cgroup is special (because the page can reparent). Only the
> > user of objcg APIs should be fixed.
> >
> > > The reason is likely that those are not reparented now but that just
> > > adds an inconsistency.
> > >
> > > Is there any reason you haven't simply matched obj_cgroup_uncharge_pages
> > > to check for the root memcg and bail out early?
> >
> > Because obj_cgroup_uncharge_pages() uncharges pages from the
> > root memcg unconditionally. Why? Because some pages can be
> > reparented to root memcg, in order to ensure the correctness of
> > page counter of root memcg. We have to uncharge pages from
> > root memcg. So we do not check whether the page belongs to
> > the root memcg when it uncharges.
>
> I am not sure I follow. Let me ask differently. Wouldn't you
> achieve the same if you simply didn't uncharge root memcg in
> obj_cgroup_charge_pages?

I'm afraid not. Some pages should uncharge root memcg, some
pages should not uncharge root memcg. But all those pages belong
to the root memcg. We cannot distinguish between the two.

I believe Roman is very familiar with this mechanism (objcg APIs).

Hi Roman,

Any thoughts on this?

>
> Btw. which tree is this patch based on? The current linux-next doesn't
> uncharge from memcg->memory inside obj_cgroup_uncharge_pages (nor does
> the Linus tree).

Sorry. I should expose more details.

obj_cgroup_uncharge_pages
  refill_stock->drain_stock
    page_counter_uncharge  // uncharging is here

Thanks.

> --
> Michal Hocko
> SUSE Labs
