Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F2355816
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhDFPgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345869AbhDFPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:34:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C65C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iFwsgCp2syGzR4eApHAo8y+qmn4pYUkTyP24/VboNC4=; b=abTf179GUU7P34I1qUp9kBM6eI
        Ls24Wn3V7h4KkfksE8D4irtlH/hNNglpUXlCqObokF42u+1j7CNhqd9Yaf2Bvo8BFKOXGBPhTWawS
        +lqqxrN6pCBAAthxcZ+iGEJjspwCqCbHfO5HYK09ZDK1N3ETHDJ+flhDANf2JWgFcI0N7j6PUGdn6
        ybHNG7QJ8bp5mliEp90iG1bNjk5nUdP/mDyqLlzcBYbo9aJoj7mTwniCXz10jaH1ic0wxS6yN5uVR
        xldfAfY7mEvQr/fO0iJS3lyUETRH0DUSuI2ICmj3KHlYxDdOXOjow+X9Ss46+LvuTsbbdxQgfsxOM
        Tk4HwA1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTngT-00D0x3-IL; Tue, 06 Apr 2021 15:32:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4074305F04;
        Tue,  6 Apr 2021 17:32:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C75122C237A61; Tue,  6 Apr 2021 17:32:04 +0200 (CEST)
Date:   Tue, 6 Apr 2021 17:32:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YGx+9EVS5kDrLOD0@hirez.programming.kicks-ass.net>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 07:39:03PM -0400, Tejun Heo wrote:
> cc'ing Michal and Christian who've been spending some time on cgroup
> interface issues recently and Li Zefan for cpuset.
> 
> On Thu, Apr 01, 2021 at 03:10:12PM +0200, Peter Zijlstra wrote:
> > The cgroup interface now uses a 'core_sched' file, which still takes 0,1. It is
> > however changed such that you can have nested tags. The for any given task, the
> > first parent with a cookie is the effective one. The rationale is that this way
> > you can delegate subtrees and still allow them some control over grouping.
> 
> I find it difficult to like the proposed interface from the name (the term
> "core" is really confusing given how the word tends to be used internally)
> to the semantics (it isn't like anything else) and even the functionality
> (we're gonna have fixed processors at some point, right?).

Core is the topological name for the thing that hosts the SMT threads.
Can't really help that.

> Here are some preliminary thoughts:
> 
> * Are both prctl and cgroup based interfaces really necessary? I could be
>   being naive but given that we're (hopefully) working around hardware
>   deficiencies which will go away in time, I think there's a strong case for
>   minimizing at least the interface to the bare minimum.

I'm not one for cgroups much, so I'll let others argue that case, except
that per systemd and all the other new fangled shit, people seem to use
cgroups a lot to group tasks. So it makes sense to also expose this
through cgroups in some form.

That said; I've had requests from lots of non security folks about this
feature to help mitigate the SMT interference.

Consider for example Real-Time. If you have an active SMT sibling, the
CPU performance is much less than it would be when the SMT sibling is
idle. Therefore, for the benefit of determinism, it would be very nice
if RT tasks could force-idle their SMT siblings, and voila, this
interface allows exactly that.

The same is true for other workloads that care about interference.

>   Given how cgroups are set up (membership operations happening only for
>   seeding, especially with the new clone interface), it isn't too difficult
>   to synchronize process tree and cgroup hierarchy where it matters - ie.
>   given the right per-process level interface, restricting configuration for
>   a cgroup sub-hierarchy may not need any cgroup involvement at all. This
>   also nicely gets rid of the interaction between prctl and cgroup bits.

I've no idea what you mean :/ The way I use cgroups (when I have to, for
testing) is to echo the pid into /cgroup/foo/tasks. No clone or anything
involved.

None of my test machines come up with cgroupfs mounted, and any and all
cgroup setup is under my control.

> * If we *have* to have cgroup interface, I wonder whether this would fit a
>   lot better as a part of cpuset. If you squint just right, this can be
>   viewed as some dynamic form of cpuset. Implementation-wise, it probably
>   won't integrate with the rest but I think the feature will be less jarring
>   as a part of cpuset, which already is a bit of kitchensink anyway.

Not sure I agree, we do not change the affinity of things, we only
control who's allowed to run concurrently on SMT siblings. There could
be a cpuset partition split between the siblings and it would still work
fine.

