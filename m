Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91E336C093
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhD0IJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:09:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:53066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235096AbhD0II6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:08:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619510894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klwWqyK3auUS6+5hVctEXn3+tFSjH6GGhQv3RZ56Qfs=;
        b=PJrk6LYsru1lgJXaIIQqXuFueCtKXLNiUR6l0DmBl5NI28OXh/gLOyeeR1le7Ueq1+tUCK
        ykwE6eqBnlkpBPr2rtI0cWVFz3m1ndyZ0BAd9UuhWM7hSp5cLLOWktf08QG8LFLzoz+Gb5
        SUMJ2oYPwX9g4ezPVCRIRRxcXKeLwXI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 942AAB001;
        Tue, 27 Apr 2021 08:08:14 +0000 (UTC)
Date:   Tue, 27 Apr 2021 10:08:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexander Sosna <alexander@sosna.de>
Cc:     Chris Down <chris@chrisdown.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM casualties by enforcing memcg limits
Message-ID: <YIfGbd4wupW4mdHy@dhcp22.suse.cz>
References: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
 <YIdWMC/iAdanDjLh@chrisdown.name>
 <410a58ba-d746-4ed6-a660-98b5f99258c3@sosna.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <410a58ba-d746-4ed6-a660-98b5f99258c3@sosna.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-04-21 08:37:30, Alexander Sosna wrote:
> Hi Chris,
> 
> Am 27.04.21 um 02:09 schrieb Chris Down:
> > Hi Alexander,
> > 
> > Alexander Sosna writes:
> >> Before this commit memory cgroup limits were not enforced during
> >> allocation.  If a process within a cgroup tries to allocates more
> >> memory than allowed, the kernel will not prevent the allocation even if
> >> OVERCOMMIT_NEVER is set.  Than the OOM killer is activated to kill
> >> processes in the corresponding cgroup.
> > 
> > Unresolvable cgroup overages are indifferent to vm.overcommit_memory,
> > since exceeding memory.max is not overcommitment, it's just a natural
> > consequence of the fact that allocation and reclaim are not atomic
> > processes. Overcommitment, on the other hand, is about the bounds of
> > available memory at the global resource level.
> > 
> >> This behavior is not to be expected
> >> when setting OVERCOMMIT_NEVER (vm.overcommit_memory = 2) and it is a huge
> >> problem for applications assuming that the kernel will deny an allocation
> >> if not enough memory is available, like PostgreSQL.  To prevent this a
> >> check is implemented to not allow a process to allocate more memory than
> >> limited by it's cgroup.  This means a process will not be killed while
> >> accessing pages but will receive errors on memory allocation as
> >> appropriate.  This gives programs a chance to handle memory allocation
> >> failures gracefully instead of being reaped.
> > 
> > We don't guarantee that vm.overcommit_memory 2 means "no OOM killer". It
> > can still happen for a bunch of reasons, so I really hope PostgreSQL
> > isn't relying on that.
> > 
> > Could you please be more clear about the "huge problem" being solved
> > here? I'm not seeing it.
> 
> let me explain the problem I encounter and why I fell down the mm rabbit
> hole.  It is not a PostgreSQL specific problem but that's where I run
> into it.  PostgreSQL forks a backend for each client connection.  All
> backends have shared memory as well as local work memory.  When a
> backend needs more dynamic work_mem to execute a query, new memory
> is allocated.  It is normal that such an allocation can fail.  If the
> backend gets an ENOMEM the current query is rolled back an all dynamic
> work_mem is freed. The RDBMS stays operational an no other query is
> disturbed.

I am afraid the kernel MM implementation has never been really
compatible with such a memory allocation model. Linux has always
preferred to pretend there is always memory available and rather reclaim
memory - including by killing some processes - rather than fail the
allocation eith ENOMEM. Overcommit configuration (especially
OVERCOMMIT_NEVER) is an attempt to somehow mitigate this ambitious
memory allocation approach but in reality this has turned out a)
unreliable and b) unsuable with modern userspace which relies on
considerable virtual memory overcommit.

> When running in a memory cgroup - for example via systemd or on k8s -
> the kernel will not return ENOMEM even if the cgroup's memory limit is
> exceeded.

Yes, memcg doesn't change the overal approach. It just restricts the
existing semantic with a smaller memory limit. Also overcommit heuristic
has never been implemented for memory controllers.

> Instead the OOM killer is awakened and kills processes in the
> violating cgroup.  If any backend is killed with SIGKILL the shared
> memory of the whole cluster is deemed potentially corrupted and
> PostgreSQL needs to do an emergency restart.  This cancels all operation
> on all backends and it entails a potentially lengthy recovery process.
> Therefore the behavior is quite "costly".

One way around that would be to use high limit rather than hard limit
and pro-actively watch for memory utilization and communicate that back
to the application to throttle its workers. I can see how that

> I totally understand that vm.overcommit_memory 2 does not mean "no OOM
> killer". IMHO it should mean "no OOM killer if we can avoid it" and I

I do not see how it can ever promise anything like that. Memory
consumption by kernel subsystems cannot be predicted at the time virtual
memory allocated from the userspace. Not only it cannot be predicted but
it is also highly impractical to force kernel allocations - necessary
for the OS operation - to fail just because userspace has reserved
virtual memory. So this all is just a heuristic to help in some
extreme cases but overall I consider OVERCOMMIT_NEVER as impractical to
say the least.

> would highly appreciate if the kernel would use a less invasive means
> whenever possible.  I guess this might also be the expectation by many
> other users.  In my described case - which is a real pain for me - it is
> quite easy to tweak the kernel behavior in order to handle this and
> other similar situations with less casualties.  This is why I send a
> patch instead of starting a theoretical discussion.

I am pretty sure that many users would agree with you on that but the
matter of fact is that a different approach has been chosen
historically. We can argue whether this has been a good or bad design
decision but I do not see that to change without a lot of fallouts. Btw.
a strong memory reservation approach can be found with hugetlb pages and
this one has turned out to be very tricky both from implementation and
userspace usage POV. Needless to say that it operates on a single
purpose preallocated memory pool and it would be quite reasonable to
expect the complexity would grow with more users of the pool which is
the general case for general purpose memory allocator.

> What do you think is necessary to get this to an approvable quality?

See my other reply.
-- 
Michal Hocko
SUSE Labs
