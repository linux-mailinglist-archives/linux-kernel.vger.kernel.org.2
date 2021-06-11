Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B073A43EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhFKOVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:21:35 -0400
Received: from foss.arm.com ([217.140.110.172]:59708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231584AbhFKOVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:21:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4026B1FB;
        Fri, 11 Jun 2021 07:19:35 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8A973F73D;
        Fri, 11 Jun 2021 07:19:34 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     paulmck@kernel.org
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about a8ea6fc9b089 ("sched: Stop PF_NO_SETAFFINITY from being inherited by various init system threads")
In-Reply-To: <20210611135207.GB4397@paulmck-ThinkPad-P17-Gen-1>
References: <20210610170435.GA2187550@paulmck-ThinkPad-P17-Gen-1> <8735tpd15i.mognet@arm.com> <20210610201713.GU4397@paulmck-ThinkPad-P17-Gen-1> <87zgvwbtgy.mognet@arm.com> <20210611135207.GB4397@paulmck-ThinkPad-P17-Gen-1>
Date:   Fri, 11 Jun 2021 15:19:29 +0100
Message-ID: <87r1h8bi1a.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/21 06:52, Paul E. McKenney wrote:
> On Fri, Jun 11, 2021 at 11:12:29AM +0100, Valentin Schneider wrote:
>>
>> The way I see 570a752b7a9b is that, if a task is pinned to a single CPU but
>> doesn't have PF_NO_SETAFFINITY, then userspace can unpin it. This means it
>> ought to have entered check_preemption_disabled() with preemption disabled
>> - right now it may be pinned, but that can change at any minute, and
>> whatever code it is running needs to cope with that.
>
> Thank you for catching me up on this topic!
>
>> Could you share some details on which tasks you are hitting this with?
>
> Let's start with ref_scale_reader() in kernel/rcu/refscale.c.  This
> is for fine-grained in-kernel benchmarking, so it really wants kthreads
> running this function to be pinned.
>
> I took a look at kthread_bind(), but it is not intended to be called by
> the kthread itself.  Looking elsewhere in the kernel, it looks like I
> just do this right after invoking set_cpus_allowed_ptr():
>
>       current->flags != PF_NO_SETAFFINITY;
>
> Or am I missing a better way to handle this?

Looking at ref_scale_reader(), ISTM the initial configuration (affinity,
niceness) should be done by its parent thread, not by itself. i.e.:

  p = kthread_create(ref_scale_reader);
  kthread_bind(p, cpu); // Does the pinning + sets PF_NO_SETAFFINITY
  set_user_nice(p, MAX_NICE);
  wake_up_process(p);

(kthread_create_on_cpu() is also an option)

From what I can see, torture_create_kthread() immediately wakes the
newly-created kthread, we'd need a version that calls kthread_create()
instead of kthread_run() for the above. Would that be an issue?

>
>                                                       Thanx, Paul
