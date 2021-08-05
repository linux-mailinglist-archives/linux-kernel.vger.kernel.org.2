Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596103E127D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbhHEKUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbhHEKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:20:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7D6C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ufzLcdasBp9TZkZo99ISHJjHvl3EIHYv0z/j6KmuarU=; b=RXrhSLXAlcvUpM/jlk15iJxVCi
        HoacusdjBUzOZj2x7C6AtqXXwOmQ9dvVW0OjllW4pjwLB7lM1kvn0/ycuGxKtiqvYleZ4zSMxqc6X
        wnEQ2C0yRUAAcShK+HaFLQvsS4XP4s8lVO2nxk1inRXl6EZHRSem8jihVgpVjXMmE5wGpJYRLniUU
        o7LxbgfsEACTyb9Y1ZhHvrCziTGCp4TF/eFEzj/MPfK71ahpa90yqmXN/hG2pxHoq4dD1DDawEjYR
        1LBN5Li4ZJzSgvtZ91kRbZb7WZE/ywaZPRa/Bj4bRf0Yp8T7+v620CxLYc1eCEeJnrp06eDhvmSjK
        cJk+CSjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBaSh-006qiz-Hj; Thu, 05 Aug 2021 10:19:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8C3F9862B0; Thu,  5 Aug 2021 12:18:49 +0200 (CEST)
Date:   Thu, 5 Aug 2021 12:18:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched: cgroup SCHED_IDLE support
Message-ID: <20210805101849.GH8057@worktop.programming.kicks-ass.net>
References: <20210730020019.1487127-1-joshdon@google.com>
 <20210730020019.1487127-2-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730020019.1487127-2-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 07:00:18PM -0700, Josh Don wrote:
> This extends SCHED_IDLE to cgroups.
> 
> Interface: cgroup/cpu.idle.
>  0: default behavior
>  1: SCHED_IDLE
> 
> Extending SCHED_IDLE to cgroups means that we incorporate the existing
> aspects of SCHED_IDLE; a SCHED_IDLE cgroup will count all of its
> descendant threads towards the idle_h_nr_running count of all of its
> ancestor cgroups. Thus, sched_idle_rq() will work properly.
> Additionally, SCHED_IDLE cgroups are configured with minimum weight.
> 
> There are two key differences between the per-task and per-cgroup
> SCHED_IDLE interface:
> 
> - The cgroup interface allows tasks within a SCHED_IDLE hierarchy to
> maintain their relative weights. The entity that is "idle" is the
> cgroup, not the tasks themselves.
> 
> - Since the idle entity is the cgroup, our SCHED_IDLE wakeup preemption
> decision is not made by comparing the current task with the woken task,
> but rather by comparing their matching sched_entity.
> 
> A typical use-case for this is a user that creates an idle and a
> non-idle subtree. The non-idle subtree will dominate competition vs
> the idle subtree, but the idle subtree will still be high priority
> vs other users on the system. The latter is accomplished via comparing
> matching sched_entity in the waken preemption path (this could also be
> improved by making the sched_idle_rq() decision dependent on the
> perspective of a specific task).
> 
> For now, we maintain the existing SCHED_IDLE semantics. Future patches
> may make improvements that extend how we treat SCHED_IDLE entities.
> 
> The per-task_group idle field is an integer that currently only holds
> either a 0 or a 1. This is explicitly typed as an integer to allow for
> further extensions to this API. For example, a negative value may
> indicate a highly latency-sensitive cgroup that should be preferred for
> preemption/placement/etc.
> 
> Signed-off-by: Josh Don <joshdon@google.com>

So I'm tempted to apply this, but last time TJ wasn't liking it much for
the interface or somesuch. His argument that this encodes the
hierarchical scheduling behaviour, but I'm not really buying that
argument, as it doesn't really add more constraints than we already have
by the hierarchical relative weight.
