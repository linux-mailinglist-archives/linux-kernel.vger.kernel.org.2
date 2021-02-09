Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB49B31550C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhBIR1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:27:10 -0500
Received: from foss.arm.com ([217.140.110.172]:54452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232986AbhBIR0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:26:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F28F0ED1;
        Tue,  9 Feb 2021 09:25:46 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B6B23F73B;
        Tue,  9 Feb 2021 09:25:44 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: trigger the update of blocked load on newly idle cpu
In-Reply-To: <CAKfTPtBshO4kq4EvoOLdo+Dx30fVhKQKUiGGqw13-gtNbK14mA@mail.gmail.com>
References: <20210205114830.781-1-vincent.guittot@linaro.org> <20210205114830.781-6-vincent.guittot@linaro.org> <jhjsg65tmju.mognet@arm.com> <CAKfTPtBshO4kq4EvoOLdo+Dx30fVhKQKUiGGqw13-gtNbK14mA@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 09 Feb 2021 17:25:39 +0000
Message-ID: <jhjpn19tap8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/21 14:57, Vincent Guittot wrote:
> On Tue, 9 Feb 2021 at 14:09, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> On 05/02/21 12:48, Vincent Guittot wrote:
>> > @@ -261,6 +261,12 @@ static void cpuidle_idle_call(void)
>> >  static void do_idle(void)
>> >  {
>> >       int cpu = smp_processor_id();
>> > +
>> > +     /*
>> > +      * Check if we need to update some blocked load
>> > +      */
>> > +     nohz_run_idle_balance(cpu);
>> > +
>>
>> What do we gain from doing this here vs having a stats update in
>> newidle_balance()?
>
> As mentioned by Joel, newidle_balance is called in the schedule
> context with preempt and irq off  which prevent any local activity
> like irq/timer. Whereas in this new place, we have the same condition
> as during ILB with only preemptoff and _nohz_idle_balance() regularly
> checks if it has to abort because something has been scheduled on the
> cpu.
>

Gotcha, that's already hinted at in the cover letter. Could you point this
out in the changelog? Other than that, I don't see anything wrong with this
approach.
