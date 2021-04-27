Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3036C5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbhD0MML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:12:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:42662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235446AbhD0MMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:12:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619525484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0RAXz6OXOLLqupoEAR85Dz1rfZqBTn70Dv5cEBj8/0=;
        b=BZ2GdgVJsRFp+hXFd2BRtWV0mZ548UknXT9704FS+7BxIsBR9njow2drpQcRvYItyqHeuJ
        xhd7aIzD5LepFw8Gi1mIYk2VjMzW4wEU4nIRB8y+/2Bv6/5y06UrMUH1yr42XfCfVNX6Ro
        DzUWcId93eRUgTHImwUaB310ujOhrkw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9DD0B195;
        Tue, 27 Apr 2021 12:11:24 +0000 (UTC)
Date:   Tue, 27 Apr 2021 14:11:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexander Sosna <alexander@sosna.de>
Cc:     Chris Down <chris@chrisdown.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM casualties by enforcing memcg limits
Message-ID: <YIf/bOhWIKPuwIzg@dhcp22.suse.cz>
References: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
 <YIdWMC/iAdanDjLh@chrisdown.name>
 <410a58ba-d746-4ed6-a660-98b5f99258c3@sosna.de>
 <YIfGbd4wupW4mdHy@dhcp22.suse.cz>
 <c7e0a2f9-0b83-2d9b-8ec1-8141d5dca554@sosna.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e0a2f9-0b83-2d9b-8ec1-8141d5dca554@sosna.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-04-21 13:01:33, Alexander Sosna wrote:
[...]
> Please correct me if I am wrong, but "modern userspace which relies on
> considerable virtual memory overcommit" should not rely on the kernel to
> overcommit memory when OVERCOMMIT_NEVER is explicitly set.

Correct. Which makes it application very limited from my experience.

> >> When running in a memory cgroup - for example via systemd or on k8s -
> >> the kernel will not return ENOMEM even if the cgroup's memory limit is
> >> exceeded.
> > 
> > Yes, memcg doesn't change the overal approach. It just restricts the
> > existing semantic with a smaller memory limit. Also overcommit heuristic
> > has never been implemented for memory controllers.
> > 
> >> Instead the OOM killer is awakened and kills processes in the
> >> violating cgroup.  If any backend is killed with SIGKILL the shared
> >> memory of the whole cluster is deemed potentially corrupted and
> >> PostgreSQL needs to do an emergency restart.  This cancels all operation
> >> on all backends and it entails a potentially lengthy recovery process.
> >> Therefore the behavior is quite "costly".
> > 
> > One way around that would be to use high limit rather than hard limit
> > and pro-actively watch for memory utilization and communicate that back
> > to the application to throttle its workers. I can see how that
> > 
> >> I totally understand that vm.overcommit_memory 2 does not mean "no OOM
> >> killer". IMHO it should mean "no OOM killer if we can avoid it" and I
> > 
> > I do not see how it can ever promise anything like that. Memory
> > consumption by kernel subsystems cannot be predicted at the time virtual
> > memory allocated from the userspace. Not only it cannot be predicted but
> > it is also highly impractical to force kernel allocations - necessary
> > for the OS operation - to fail just because userspace has reserved
> > virtual memory. So this all is just a heuristic to help in some
> > extreme cases but overall I consider OVERCOMMIT_NEVER as impractical to
> > say the least.
> 
> I'm not fully able to follow you why we need to let kernel allocations
> fail here.  Yes, if you run a system to a point where the kernel can't
> free enough memory, invasive decisions have to be made.

OK. But then I do not see what "no OOM killer if we can avoid it" is
suppose to mean. There are only 2 ways around that. Either start
failing allocations or reclaim by tearing down processes as all other
means of memory reclaim have been already exercised.

> Think of an
> application server running multiple applications in memcgs each with its
> limits way below the available resources.  Why is it preferable to
> SIGKILL a process rather than just deny the limit exceeding malloc, when
> OVERCOMMIT_NEVER is set of cause?

Because the actual physical memory allocation for malloc might (and
usually does) happen much later than the virtual memory allocated for it
(brk or mmap). Memory requirements could have changed considerably
between the two events. An allocation struggling to make a forward
progress might be for a completely different purpose than the overcommit
accounted one. Does this make more sense now?

> >> would highly appreciate if the kernel would use a less invasive means
> >> whenever possible.  I guess this might also be the expectation by many
> >> other users.  In my described case - which is a real pain for me - it is
> >> quite easy to tweak the kernel behavior in order to handle this and
> >> other similar situations with less casualties.  This is why I send a
> >> patch instead of starting a theoretical discussion.
> > 
> > I am pretty sure that many users would agree with you on that but the
> > matter of fact is that a different approach has been chosen
> > historically. We can argue whether this has been a good or bad design
> > decision but I do not see that to change without a lot of fallouts. Btw.
> > a strong memory reservation approach can be found with hugetlb pages and
> > this one has turned out to be very tricky both from implementation and
> > userspace usage POV. Needless to say that it operates on a single
> > purpose preallocated memory pool and it would be quite reasonable to
> > expect the complexity would grow with more users of the pool which is
> > the general case for general purpose memory allocator.
> 
> The history is very interesting and needs to be taken into
> consideration.  What drives me is to help myself and all other Linux
> user to run workloads like RDBMS reliable, even in modern environments
> like k8s which make use of memory cgroups.  I see a gain for the
> community to develop a reliable and easy available solution, even if my
> current approach might be amateurish and is not the right answer.

Well, I am afraid that a reliable and easy solutions would be extremely
hard to find. A memcg aware overcommit policy is certainly possible but
as I've said it would require an additional accounting, it would be
quite unreliable - especially with small limits where the mapped (and
accounted) address space is not predominant. A lack of background
reclaim (kswapd in the global case) would result in ENOMEM reported even
though there is reclaimable memory to satisfy the reserved address space
etc.

> Could
> you elaborate on where you see "a lot of fallouts"?  overcommit_memory 2
> is only set when needed for the desired workload.

My above comment was more general to the approach Linux is embracing
overcommit and relies on oom killer to handle fallouts. This to change
would lead to lot of fallouts. E.g. many syscalls returning unexpected
and unhandled ENOMEM etc.
-- 
Michal Hocko
SUSE Labs
