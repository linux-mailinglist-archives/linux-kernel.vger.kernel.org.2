Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E082143D757
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhJ0XOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhJ0XOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:14:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72E8460FC0;
        Wed, 27 Oct 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635376346;
        bh=CLgz+BVrkml9MB9rQ4pnX111YaTQ4GX7f2ZA2ydTKpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mswwpVag0G8YBwRHQIQoouc8z9pUPZU6j+uAjkBzTdgWlVrbfHmZK2qBNKIOtEc0W
         0yCyomplxEYXfzvBX793o1ap9jNxBRvHf2c7lbLwpDs2FcwlBMAQjQH0NgJLJeV/5w
         ejFfmW4VqTjL8AMq/u6SqZCT4rE9URjEnxTAsX7Nz827rVrjAtdPWM9tI+jkPuAFDX
         wbolJ8tjTbhQS0No7icI/AScRnzle9jEBaz/3pF8XvctbeorhHjLBY/IOltuI3mAii
         nm2ag422MAbZCNdJ5UOYFrMIPS97hNg9HeiHLKeIIn8NQaGJyfmgPypSgZ9BFE+ao5
         K2HJ8/VYvtwgQ==
Date:   Thu, 28 Oct 2021 01:12:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 0/2] bind rcu offload (nohz_full/isolation) into cpuset
Message-ID: <20211027231223.GA73746@lothringen>
References: <20211027204319.22697-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027204319.22697-1-paul.gortmaker@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 04:43:17PM -0400, Paul Gortmaker wrote:
> One of the earlier pre-mainline RCU nocb patchsets had a temporary sysfs
> knob in /sys/devices/system/cpu/cpu*/hotplug/nocb for testing[1].
> 
> That not-for-merge commit from Frederic said:
> 
>   This is only intended for those who want to test this patchset. The
>   real interfaces will be cpuset/isolation and rcutorture.
> 
> We've had rcutorture as the one and only mainline user of nocb toggle
> for a while now[2], and so I thought I'd take a crack at what Frederic
> had in mind for cpuset with some code vs. asking 100 random questions.
> 
> Note that I intentionally didn't Cc any cgroup/cpuset people (yet),
> since at this point this is only my guess on what things were to look
> like based on a single sentence fragment.  So this is really early
> "Not-for-Merge", but truly just RFC -- to start a conversation.
> 
> It won't be really useful until we adjust tick/housekeeping in addition
> to nocb, but I think we can develop the interface in parallel to that?
> And maybe use this to expand testing at the same time if it is layered
> on top of those future work/patchsets?  I don't know...
> 
> We'll also have to look at corner cases - like whether we want to treat
> the root cpuset differently; whether we want to sync boot arg values
> with the cpuset's initial isol flag value, whether we un-isolate cores
> when an isolation cpuset is rmdir/removed, etc etc.
> 
> But as a proof of concept, it "works" as can be seen in the 2nd commit.

I'm working on the same thing :o)

With quite a rework of housekeeping core behind (WIP):

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	isolation/split

It's not yet ready either and I'm glad you posted this, it shows I'm not
the only one interested in it.

One thing about cpuset: I arranged to implement it only on cgroup v2 and
exclusively mutable on root partition (which doesn't mean only _the_ root
partition but also those whose cpuset.cpus.partition == "root". This way
I make sure the set of cpus is exclusive. I didn't want to bother with
intersecting cpusets with different nocb values.

Thanks.

> Paul.
> --
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?h=rcu/nocb&id=6abe8408307e
>     part of https://lwn.net/Articles/820544/
>             https://lwn.net/Articles/832031/   <------ v2
>             https://lwn.net/Articles/835039/   <------ v3
>             https://lwn.net/Articles/837128/   <------ v4
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d97b078182406
> 
> 
> Paul Gortmaker (2):
>   sched: isolation: cpu isolation handles for cpuset
>   cpuset: add binding to CPU isolation
> 
>  include/linux/sched/isolation.h |  4 ++++
>  kernel/cgroup/cpuset.c          | 42 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/isolation.c        | 22 +++++++++++++++++++++
>  3 files changed, 68 insertions(+)
> 
> -- 
> 2.15.0
> 
