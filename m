Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361B63D5A83
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhGZNAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:00:44 -0400
Received: from foss.arm.com ([217.140.110.172]:52018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233719AbhGZM7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:59:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CE6B139F;
        Mon, 26 Jul 2021 06:39:34 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3CF33F70D;
        Mon, 26 Jul 2021 06:39:32 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, stable@kernel.org,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RT 5/8] sched: Fix affine_move_task() self-concurrency
In-Reply-To: <20210725050349.GA983@bug>
References: <20210709215953.122804544@goodmis.org> <20210709220018.003428207@goodmis.org> <20210725050349.GA983@bug>
Date:   Mon, 26 Jul 2021 14:39:27 +0100
Message-ID: <87zgu9kxdc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/21 07:03, Pavel Machek wrote:
> Hi!
>
>> 5.10.47-rt46-rc1 stable review patch.
>> If anyone has any objections, please let me know.
>>
>> Add set_affinity_pending::stop_pending, to indicate if a stopper is in
>> progress.
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 9cbe12d8c5bd..20588a59300d 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1900,6 +1900,7 @@ struct migration_arg {
>>
>>  struct set_affinity_pending {
>>      refcount_t		refs;
>> +	unsigned int		stop_pending;
>>      struct completion	done;
>>      struct cpu_stop_work	stop_work;
>>      struct migration_arg	arg;
>
> For better readability, this should be bool, AFAICT.
>

It's intentionally declared as an int. sizeof(_Bool) is Implementation
Defined, so you can't sanely reason about struct layout.

There's been quite a few threads about this already, a quick search on lore
gave me:

https://lore.kernel.org/lkml/20180411081502.GJ4082@hirez.programming.kicks-ass.net/
