Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FEC367CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhDVIpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:45:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:38740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhDVIpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:45:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619081086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iiKTZO7MN5KaIv4s0PldYG1G2gdvZF2Bde6z/Wg/Lxs=;
        b=rfvv5qZq0qZOEWjitR6GkxwWFqrrh7+kBsoIKmfQY1vT3nUZrtD2x52IkS9YXQwoqS59cQ
        f/lkvY2Sj9ebqp5G3kZWwZkiJZyax3DfsbOgx/+tuwli16RQwVJS/4zbIlZV9zaBjBZyRh
        WdQVPl5VYhDR+egIBPhtepR+5M4nxcY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 916EEB02A;
        Thu, 22 Apr 2021 08:44:46 +0000 (UTC)
Date:   Thu, 22 Apr 2021 10:44:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix root_mem_cgroup
 charging
Message-ID: <YIE3e3fVboWfIq7r@dhcp22.suse.cz>
References: <20210421062644.68331-1-songmuchun@bytedance.com>
 <YH/Vf8SDRy7VR7ur@dhcp22.suse.cz>
 <CAMZfGtVpz1FvzmhWFzXAJE3wWBMJwdwU+JqQ6a8KeOhV3FGJ4Q@mail.gmail.com>
 <YIAimEdqpen3/38Z@dhcp22.suse.cz>
 <CAMZfGtUOXyK3RDZ+P0GaO4p-P0XatFB8ZbmXEFvfet1HSrdFog@mail.gmail.com>
 <YIDKDQxOq8IK82Rt@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIDKDQxOq8IK82Rt@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-04-21 17:57:49, Roman Gushchin wrote:
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
> 
> But honestly I'm not sure the problem is worth the time spent on the fix
> and the discussion. It's a small race and it's generally hard to trigger
> a kernel allocation racing with a cgroup deletion and then you need *a lot*
> of such races and then maybe there will be a single warning printed without
> *any* other consequences.

Thanks for the clarification Roman! As I've said I am not a obj-cgroup
accounting insider but it would make some sense to opt out from
accounting in the uncharge path just from clarity point of view to match
the charging path (rather than what the patch is proposing and special
case the charging path and make it inconsistent with non obj-cgroup
tracking. What do you think?

-- 
Michal Hocko
SUSE Labs
