Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751EB366BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbhDUNE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:04:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:60798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240429AbhDUNDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619010201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Ybdj/fzU2bZRYjiULaAlp9LEAozBU/5F769WjomL9o=;
        b=FwNpjTAQ6/tVzAdHxCKKtyRhZI311dm0XNmvqBDpqllIsyzXcDB/cJuVwb263FExHg8O/u
        zyVEOXPmyDRoR3wc5G19i4WDlF+H1WIfF7ErzdKBc7jCnmt6Oy/e9ZHCCl51+Sv3OfvJRc
        EZSji6GQhUL+0Gb+i+jwlCIUVUcCQDE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EE21B314;
        Wed, 21 Apr 2021 13:03:21 +0000 (UTC)
Date:   Wed, 21 Apr 2021 15:03:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix root_mem_cgroup
 charging
Message-ID: <YIAimEdqpen3/38Z@dhcp22.suse.cz>
References: <20210421062644.68331-1-songmuchun@bytedance.com>
 <YH/Vf8SDRy7VR7ur@dhcp22.suse.cz>
 <CAMZfGtVpz1FvzmhWFzXAJE3wWBMJwdwU+JqQ6a8KeOhV3FGJ4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVpz1FvzmhWFzXAJE3wWBMJwdwU+JqQ6a8KeOhV3FGJ4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-04-21 17:50:06, Muchun Song wrote:
> On Wed, Apr 21, 2021 at 3:34 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 21-04-21 14:26:44, Muchun Song wrote:
> > > The below scenario can cause the page counters of the root_mem_cgroup
> > > to be out of balance.
> > >
> > > CPU0:                                   CPU1:
> > >
> > > objcg = get_obj_cgroup_from_current()
> > > obj_cgroup_charge_pages(objcg)
> > >                                         memcg_reparent_objcgs()
> > >                                             // reparent to root_mem_cgroup
> > >                                             WRITE_ONCE(iter->memcg, parent)
> > >     // memcg == root_mem_cgroup
> > >     memcg = get_mem_cgroup_from_objcg(objcg)
> > >     // do not charge to the root_mem_cgroup
> > >     try_charge(memcg)
> > >
> > > obj_cgroup_uncharge_pages(objcg)
> > >     memcg = get_mem_cgroup_from_objcg(objcg)
> > >     // uncharge from the root_mem_cgroup
> > >     page_counter_uncharge(&memcg->memory)
> > >
> > > This can cause the page counter to be less than the actual value,
> > > Although we do not display the value (mem_cgroup_usage) so there
> > > shouldn't be any actual problem, but there is a WARN_ON_ONCE in
> > > the page_counter_cancel(). Who knows if it will trigger? So it
> > > is better to fix it.
> >
> > The changelog doesn't explain the fix and why you have chosen to charge
> > kmem objects to root memcg and left all other try_charge users intact.
> 
> The object cgroup is special (because the page can reparent). Only the
> user of objcg APIs should be fixed.
> 
> > The reason is likely that those are not reparented now but that just
> > adds an inconsistency.
> >
> > Is there any reason you haven't simply matched obj_cgroup_uncharge_pages
> > to check for the root memcg and bail out early?
> 
> Because obj_cgroup_uncharge_pages() uncharges pages from the
> root memcg unconditionally. Why? Because some pages can be
> reparented to root memcg, in order to ensure the correctness of
> page counter of root memcg. We have to uncharge pages from
> root memcg. So we do not check whether the page belongs to
> the root memcg when it uncharges.

I am not sure I follow. Let me ask differently. Wouldn't you
achieve the same if you simply didn't uncharge root memcg in
obj_cgroup_charge_pages?

Btw. which tree is this patch based on? The current linux-next doesn't
uncharge from memcg->memory inside obj_cgroup_uncharge_pages (nor does
the Linus tree).
-- 
Michal Hocko
SUSE Labs
