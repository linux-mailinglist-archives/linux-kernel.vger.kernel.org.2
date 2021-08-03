Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F83DF6BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 23:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhHCVLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 17:11:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhHCVLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 17:11:02 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628025049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucRz86x6HiHEYCtpmG/kdLyW+gMVcGd2uqgj2++FHyY=;
        b=4qos3TSs7zhjn9p7Cdx34MeVq2fJyQrfd7ngeMgZsKH5T26mYqU5aFaClvosZQFjbHzfn1
        m7oUlPzNL7zAYYa7UBS6GDf78kPLB61Liph0Tg8NurmmSeN1hQYZkIUHjWFJjwj0ulqt/I
        gs2ONYuziXc3kJxI+mCj9mvSMs3+A52XTa6aVt7GXyT8zbJKRSwVdLQNToIK44qgthnzAQ
        F8IYWyHFUyVDYbE2wmNl4AwBdNlZPdNWIv8HDAxDNm5nni1OX0QBTd0TwVD+UQAKNxzRwY
        dVdNS1C7WK63zuJYcuw4CCPUV+H8QqJdbxPEke/PID0B0w0MlkZ85Qj+mCmwQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628025049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucRz86x6HiHEYCtpmG/kdLyW+gMVcGd2uqgj2++FHyY=;
        b=sLLrnG1Ffgk44cgWqfxBMQA+vSjkvGZiDAH+Yr21+BSrUU8t1SLDUIKPp22yrYit5GrBLb
        1/tTGt0UH2ER2IBw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 58/63] futex: Prevent requeue_pi() lock nesting issue on RT
In-Reply-To: <20210803100713.GB8057@worktop.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135208.418508738@linutronix.de>
 <20210803100713.GB8057@worktop.programming.kicks-ass.net>
Date:   Tue, 03 Aug 2021 23:10:49 +0200
Message-ID: <87pmuu2q06.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03 2021 at 12:07, Peter Zijlstra wrote:

> On Fri, Jul 30, 2021 at 03:51:05PM +0200, Thomas Gleixner wrote:
>> @@ -219,6 +221,10 @@ struct futex_q {
>>  	struct rt_mutex_waiter *rt_waiter;
>>  	union futex_key *requeue_pi_key;
>>  	u32 bitset;
>> +	atomic_t requeue_state;
>> +#ifdef CONFIG_PREEMPT_RT
>> +	struct rcuwait requeue_wait;
>> +#endif
>>  } __randomize_layout;
>>  
>>  static const struct futex_q futex_q_init = {
>
> Do we want to explicitly initialize requeue_state in futex_q_init? I was
> looking where we reset the state machine and eventually figured it out,
> but I'm thinking something more explicit might help avoid this for the
> next time.

Sure.
