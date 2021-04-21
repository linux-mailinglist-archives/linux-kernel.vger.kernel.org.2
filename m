Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B9736680E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbhDUJd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:33:27 -0400
Received: from foss.arm.com ([217.140.110.172]:56694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237041AbhDUJd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:33:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE32A113E;
        Wed, 21 Apr 2021 02:32:53 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAB193F73B;
        Wed, 21 Apr 2021 02:32:51 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs hotplug-rollback
In-Reply-To: <YH7r+AoQEReSvxBI@hirez.programming.kicks-ass.net>
References: <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me> <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net> <87r1jfmn8d.mognet@arm.com> <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net> <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net> <87a6pzmxec.mognet@arm.com> <20210419105541.GA40111@e120877-lin.cambridge.arm.com> <20210420094632.GA165360@e120877-lin.cambridge.arm.com> <YH7jSPZx0BhyHoLe@hirez.programming.kicks-ass.net> <YH7niBZDWjsz+jBa@hirez.programming.kicks-ass.net> <YH7r+AoQEReSvxBI@hirez.programming.kicks-ass.net>
Date:   Wed, 21 Apr 2021 10:32:43 +0100
Message-ID: <87eef4ugn8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/21 16:58, Peter Zijlstra wrote:
> On Tue, Apr 20, 2021 at 04:39:04PM +0200, Peter Zijlstra wrote:
>> On Tue, Apr 20, 2021 at 04:20:56PM +0200, Peter Zijlstra wrote:
>> > On Tue, Apr 20, 2021 at 10:46:33AM +0100, Vincent Donnefort wrote:
>> >
>> > > Found the issue:
>> > >
>> > > $ cat hotplug/states:
>> > > 219: sched:active
>> > > 220: online
>> > >
>> > > CPU0:
>> > >
>> > > $ echo 219 > hotplug/fail
>> > > $ echo 0 > online
>> > >
>> > > => cpu_active = 1 cpu_dying = 1
>> > >
>> > > which means that later on, for another CPU hotunplug, in
>> > > __balance_push_cpu_stop(), the fallback rq for a kthread can select that
>> > > CPU0, but __migrate_task() would fail and we end-up in an infinite loop,
>> > > trying to migrate that task to CPU0.
>> > >
>> > > The problem is that for a failure in sched:active, as "online" has no callback,
>> > > there will be no call to cpuhp_invoke_callback(). Hence, the cpu_dying bit would
>> > > not be reset.
>> >
>> > Urgh! Good find.
>
>> I seem to have triggered the BUG() in select_fallback_rq() with your recipie.
>> Have cpu0 fail on sched:active, then offline all other CPUs.
>>
>> Now lemme add that patch.
>
> (which obviously didn't actually build) seems to fix it.
>

Moving the cpu_dying_mask update from cpuhp_invoke_callback() to
cpuhp_{set, reset}_state() means we lose an update in cpuhp_issue_call(),
but AFAICT that wasn't required (this doesn't actually change a CPU's
hotplug state, rather executes some newly installed/removed callbacks whose
state maps below the CPU's current hp state).

Actually staring at it some more, it might have caused bugs: if a
cpuhp_setup_state() fails, we can end up in cpuhp_rollback_install() which
will end up calling cpuhp_invoke_callback(bringup=false) and mess with the
dying mask.

FWIW:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
