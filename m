Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB33C9464
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 01:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbhGNXX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 19:23:28 -0400
Received: from foss.arm.com ([217.140.110.172]:43826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237514AbhGNXX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 19:23:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5F9031B;
        Wed, 14 Jul 2021 16:20:34 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D4893F7D8;
        Wed, 14 Jul 2021 16:20:33 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <20210713160746.207208684@linutronix.de>
References: <20210713151054.700719949@linutronix.de> <20210713160746.207208684@linutronix.de>
Date:   Thu, 15 Jul 2021 00:20:28 +0100
Message-ID: <87r1g0mqir.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/07/21 17:10, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Waiting for spinlocks and rwlocks on non RT enabled kernels is task::state
> preserving. Any wakeup which matches the state is valid.
>
> RT enabled kernels substitutes them with 'sleeping' spinlocks. This creates
> an issue vs. task::state.
>
> In order to block on the lock the task has to overwrite task::state and a
> consecutive wakeup issued by the unlocker sets the state back to
> TASK_RUNNING. As a consequence the task loses the state which was set
> before the lock acquire and also any regular wakeup targeted at the task
> while it is blocked on the lock.
>

I'm not sure I get this for spinlocks - p->__state != TASK_RUNNING means
task is stopped (or about to be), IMO that doesn't go with spinning. I was
thinking perhaps ptrace could be an issue, but I don't have a clear picture
on that either. What am I missing?

> @@ -213,6 +234,47 @@ struct task_group;
>               raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
>       } while (0)
>
> +/*
> + * PREEMPT_RT specific variants for "sleeping" spin/rwlocks
> + *
> + * RT's spin/rwlock substitutions are state preserving. The state of the
> + * task when blocking on the lock is saved in task_struct::saved_state and
> + * restored after the lock has been acquired.  These operations are
> + * serialized by task_struct::pi_lock against try_to_wake_up(). Any non RT
> + * lock related wakeups while the task is blocked on the lock are
> + * redirected to operate on task_struct::saved_state to ensure that these
> + * are not dropped. On restore task_struct::saved_state is set to
> + * TASK_RUNNING so any wakeup attempt redirected to saved_state will fail.
> + *
> + * The lock operation looks like this:
> + *
> + *	current_save_and_set_rtlock_wait_state();
> + *	for (;;) {
> + *		if (try_lock())
> + *			break;
> + *		raw_spin_unlock_irq(&lock->wait_lock);
> + *		schedule_rtlock();
> + *		raw_spin_lock_irq(&lock->wait_lock);
> + *		set_current_state(TASK_RTLOCK_WAIT);
> + *	}
> + *	current_restore_rtlock_saved_state();
> + */
> +#define current_save_and_set_rtlock_wait_state()			\
> +	do {								\
> +		raw_spin_lock(&current->pi_lock);			\
> +		current->saved_state = current->state;			\
                                                ^^^^^
That one somehow survived the s/state/__state/ renaming.
