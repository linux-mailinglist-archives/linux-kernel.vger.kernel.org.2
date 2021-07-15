Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1739B3CA04C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbhGOOLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:11:36 -0400
Received: from foss.arm.com ([217.140.110.172]:53014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhGOOLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:11:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C45666D;
        Thu, 15 Jul 2021 07:08:42 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BF953F694;
        Thu, 15 Jul 2021 07:08:41 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 03/50] sched: Prepare for RT sleeping spin/rwlocks
In-Reply-To: <20210715092703.GI2725@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de> <20210713160746.207208684@linutronix.de> <87r1g0mqir.mognet@arm.com> <20210715092703.GI2725@worktop.programming.kicks-ass.net>
Date:   Thu, 15 Jul 2021 15:08:36 +0100
Message-ID: <87im1bmzyz.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/21 11:27, Peter Zijlstra wrote:
> On Thu, Jul 15, 2021 at 12:20:28AM +0100, Valentin Schneider wrote:
>> Hi,
>>
>> On 13/07/21 17:10, Thomas Gleixner wrote:
>> > From: Thomas Gleixner <tglx@linutronix.de>
>> >
>> > Waiting for spinlocks and rwlocks on non RT enabled kernels is task::state
>> > preserving. Any wakeup which matches the state is valid.
>> >
>> > RT enabled kernels substitutes them with 'sleeping' spinlocks. This creates
>> > an issue vs. task::state.
>> >
>> > In order to block on the lock the task has to overwrite task::state and a
>> > consecutive wakeup issued by the unlocker sets the state back to
>> > TASK_RUNNING. As a consequence the task loses the state which was set
>> > before the lock acquire and also any regular wakeup targeted at the task
>> > while it is blocked on the lock.
>> >
>>
>> I'm not sure I get this for spinlocks - p->__state != TASK_RUNNING means
>> task is stopped (or about to be), IMO that doesn't go with spinning. I was
>> thinking perhaps ptrace could be an issue, but I don't have a clear picture
>> on that either. What am I missing?
>
> spinlocks will become rtmutex. They're going to clobber __state by
> virtue of a nested block.

I wasn't expecting there to be any task taking spinlocks with state !=
TASK_RUNNING, but I just didn't know where to look.

For instance do_wait() sets current to TASK_INTERRUPTIBLE and can then faff
around with some sighand locks before eventually calling into schedule(),
so clearly that one would be affected by the clobbering.

The more you know...
