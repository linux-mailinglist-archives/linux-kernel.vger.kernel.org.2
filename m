Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7333558D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244090AbhDFQJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhDFQJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:09:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C870C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:08:53 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 7so15467318qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5/mFayIis/baEhLeL6xfv5yb9Nbsev0wh0qeDzQZWhM=;
        b=WfRdFcOY43AoAMr0pm9dLpEkYgsoUvSmeUC+VvhykcV+hfMo2J/qRWgjUti58HnLYb
         t8yGZwOWWHcGhCKSeoC3Co6mX76R3UwmZhdgBJiLfcw/unMhSi+uX+Ah9co/lSiKvoNS
         4ao3PKYfbLE7D3KOHQpQUv699Z3WFoqCSXU5jN3d9WYUJnNUW191BfHwSyXxKgJJPLBH
         WOiTgEV9lC8O65MV0/zeI02YzCNV/JmZkD9ew8eTg7qshdr/id7GRJxcecuyNmwq3Moy
         A8YrvwfEAcMBxLjIxcVoJF1eQn8M33FubX6sIPuD3Jqbn5ojvqPlf/TRK07RM8u5efao
         RNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5/mFayIis/baEhLeL6xfv5yb9Nbsev0wh0qeDzQZWhM=;
        b=evz14VeECKOnSw5y/s31YD8bVD8jKIG4fd7P08viuvcogE/ChbV8MVfmc8YyXY89DX
         lvoZI0HDBUljXof917cbOBNErNUF11lAxUn4JYVCEVaM3e8MQjM5BvtUYiCav3poV9cG
         b8BaD2NjrM/uiAUVcWSqdmZoCwTxIlshhx3Ql9jCX4lAgW3pteuZJpQ3Ekds5+dASnQh
         KUko3pjR1LS4dF+VG6kzklrcSOZjyNzDU9v+olyOSxZvdabDJjX3KnvEQi2kX5jmDGdt
         f8rSIBgjnPqGvHI0ZiKYCDBSn+QQNAn/mKUziG2f+tFcYLyV0oIWugS+YrVcdMcypDAX
         ZJTg==
X-Gm-Message-State: AOAM530n9IBk3MH9bw006ktRC8YI3+MQX49suVXCNH9ZVwAQkh7GcKs8
        lKF4mv3xY66wW5S+oWcZ6is=
X-Google-Smtp-Source: ABdhPJzH/Cilyw+bTKV75qss6PElJBY+MmL5dDpWgfyzcQd+nSAacU6z66UyXUVHNSCGbRO4OWfawA==
X-Received: by 2002:a37:4091:: with SMTP id n139mr29677557qka.360.1617725332219;
        Tue, 06 Apr 2021 09:08:52 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id n77sm16497912qkn.128.2021.04.06.09.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:08:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Apr 2021 12:08:50 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YGyHknFJhHO99e5a@slm.duckdns.org>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <YGx+9EVS5kDrLOD0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGx+9EVS5kDrLOD0@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 06, 2021 at 05:32:04PM +0200, Peter Zijlstra wrote:
> > I find it difficult to like the proposed interface from the name (the term
> > "core" is really confusing given how the word tends to be used internally)
> > to the semantics (it isn't like anything else) and even the functionality
> > (we're gonna have fixed processors at some point, right?).
> 
> Core is the topological name for the thing that hosts the SMT threads.
> Can't really help that.

I find the name pretty unfortunate given how overloaded the term is
generally and also in kernel but oh well...

> > Here are some preliminary thoughts:
> > 
> > * Are both prctl and cgroup based interfaces really necessary? I could be
> >   being naive but given that we're (hopefully) working around hardware
> >   deficiencies which will go away in time, I think there's a strong case for
> >   minimizing at least the interface to the bare minimum.
> 
> I'm not one for cgroups much, so I'll let others argue that case, except
> that per systemd and all the other new fangled shit, people seem to use
> cgroups a lot to group tasks. So it makes sense to also expose this
> through cgroups in some form.

All the new fangled things follow a certain usage pattern which makes
aligning parts of process tree with cgroup layout trivial, so when
restrictions can be applied along the process tree like this and there isn't
a particular need for dynamic hierarchical control, there isn't much need
for direct cgroup interface.

> That said; I've had requests from lots of non security folks about this
> feature to help mitigate the SMT interference.
> 
> Consider for example Real-Time. If you have an active SMT sibling, the
> CPU performance is much less than it would be when the SMT sibling is
> idle. Therefore, for the benefit of determinism, it would be very nice
> if RT tasks could force-idle their SMT siblings, and voila, this
> interface allows exactly that.
> 
> The same is true for other workloads that care about interference.

I see.

> >   Given how cgroups are set up (membership operations happening only for
> >   seeding, especially with the new clone interface), it isn't too difficult
> >   to synchronize process tree and cgroup hierarchy where it matters - ie.
> >   given the right per-process level interface, restricting configuration for
> >   a cgroup sub-hierarchy may not need any cgroup involvement at all. This
> >   also nicely gets rid of the interaction between prctl and cgroup bits.
> 
> I've no idea what you mean :/ The way I use cgroups (when I have to, for
> testing) is to echo the pid into /cgroup/foo/tasks. No clone or anything
> involved.

The usage pattern is creating a new cgroup, seeding it with a process
(either writing to tasks or using CLONE_INTO_CGROUP) and let it continue
only on that sub-hierarchy, so cgroup hierarchy usually partially overlays
process trees.

> None of my test machines come up with cgroupfs mounted, and any and all
> cgroup setup is under my control.
>
> > * If we *have* to have cgroup interface, I wonder whether this would fit a
> >   lot better as a part of cpuset. If you squint just right, this can be
> >   viewed as some dynamic form of cpuset. Implementation-wise, it probably
> >   won't integrate with the rest but I think the feature will be less jarring
> >   as a part of cpuset, which already is a bit of kitchensink anyway.
> 
> Not sure I agree, we do not change the affinity of things, we only
> control who's allowed to run concurrently on SMT siblings. There could
> be a cpuset partition split between the siblings and it would still work
> fine.

I see. Yeah, if we really need it, I'm not sure it fits in cgroup interface
proper. As I wrote elsewhere, these things are usually implemented on the
originating subsystem interface with cgroup ID as a parameter.

Thanks.

-- 
tejun
