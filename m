Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15D937B8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhELJHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhELJHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:07:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28584C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lPA4jdR9pUSuLVhz3k4AQEC1mWmI2as4o2MUbJuqgJQ=; b=Lb5g7JrV7yuJ6mBKsPot0g7+dZ
        qrn6L4z1ZCNPx0OVoBc/CF8C8OZ/B41NgL4NyxU9gJPtmJdwuDEsaEY4/z9lp8354Up0wy2Adfp++
        qMrxHeLKTBvdbMTyXzQnje+cW3KHHGB5SCDJOB3l6x5g7dOjc7cGHqiMVb0kIKMqArGUSVZnWcfZ4
        SOrPPVzAF/eyLEyMOS8DgyKzqKVVIuZHmx+F5HNTY/ZMlzIbaC0FybPcNf5iMNXKxLGFpkDp3qkBR
        AE0whaXY/fZjAt31heV3I4YHW9B+mXNwsngSpE+L+sgClZQd5UDA53CYcZhkKDBDViDIXjTR+AmqQ
        IS8lXMXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgkoX-002ORm-7v; Wed, 12 May 2021 09:05:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B06CD300242;
        Wed, 12 May 2021 11:05:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 812AA2BA8A555; Wed, 12 May 2021 11:05:56 +0200 (CEST)
Date:   Wed, 12 May 2021 11:05:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Hyser <chris.hyser@oracle.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>
Subject: Re: [PATCH 17/19] sched: Inherit task cookie on fork()
Message-ID: <YJuadFpNsfHu6n0Y@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.980003687@infradead.org>
 <CAEXW_YTHZF69YHD-r=ST97sagjnxEDy6492nDKaaJtkKMoQN9Q@mail.gmail.com>
 <3dbce4ff-44ed-73ca-2ea1-97b126dd664e@oracle.com>
 <CAEXW_YSX79vR9hdkjKcf08uZk85xhC8nOnesf8s6Cvp2kqKoFA@mail.gmail.com>
 <2b4ae2b4-62e5-96be-ddae-b261139842c1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4ae2b4-62e5-96be-ddae-b261139842c1@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 05:38:18PM -0400, Chris Hyser wrote:
> On 5/10/21 4:47 PM, Joel Fernandes wrote:
> > On Mon, May 10, 2021 at 12:23 PM Chris Hyser <chris.hyser@oracle.com> wrote:
> 
> > > > > +void sched_core_fork(struct task_struct *p)
> > > > > +{
> > > > > +       RB_CLEAR_NODE(&p->core_node);
> > > > > +       p->core_cookie = sched_core_clone_cookie(current);
> > > > 
> > > > Does this make sense also for !CLONE_THREAD forks?
> > > 
> > > Yes. Given the absence of a cgroup interface, fork inheritance
> > > (clone the cookie) is the best way to create shared cookie
> > > hierarchies. The security issue you mentioned was handled in my
> > > original code by setting a unique cookie on 'exec', but Peter took
> > > that out for the reason mentioned above. It was part of the "lets
> > > get this in compromise" effort.

Right, not only that, given all this is moot when parent and child have
the same PTRACE permissions, since if they do, they can inspect one
another's innards anyway, exec()/fork() just fundamentally isn't a
magical boundary we should care about.

The only special case there is SUID exec(), because in that case the
actual credentials change and the PTRACE permissions do actually change.

I sorta had a patch to do that, but it's yuck because that cred change
happens after the point of no return and we need an allocation for the
new cookie. Now, we could rely on the fact that a task context
allocation (GFP_KERNEL) for something as small as our cookie will never
fail and hence we shouldn't be bothered by it, we should do the error
path and yuck.

> > Thanks for sharing the history of it. I guess one can argue that this
> > policy is better to be hardcoded in userspace since core-scheduling
> > can be used for non-security usecases as well. Maybe one could simply
> > call the prctl(2) from userspace if they so desire, before calling
> > exec() ?
> 
> I think the defining use case is a container's init. If the cookie is set
> for it by the container creator and without any other user code knowing
> about core_sched, every descendant spawned will have the same cookie and be
> in the same core_sched group much like the cgroup interface had provided. If
> we create a unique cookie in the kernel either on fork or exec, we are
> secure, but we will now have 1000's of core sched groups.
> 
> CLEAR was also removed (temporarily, I hope) because a core_sched
> knowledgeable program in the example core_sched container group should not
> be able to remove itself from _all_ core sched groups. It can modify it's
> cookie, but that is no different than the normal case.

Note that much of clear is possible by using SHARE_FROM on your parent
to reset the cookie.

> Both of these beg for a kernel policy, but that discussion was TBD.

Right, I need a Champion that actually cares about cgroups and has
use-cases to go argue with TJ on this. I've proposed code that I think
has sane semantics, but I'm not in a position to argue for it, given I
think a world without cgroups is a better world :-)))
