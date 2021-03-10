Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078E3334A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhCJV5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:57:55 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:56838 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhCJV5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:57:37 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK6pc-00Ds0D-Kv; Wed, 10 Mar 2021 14:57:28 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK6pb-001CWv-CA; Wed, 10 Mar 2021 14:57:28 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de>
        <m1zgzj7uv2.fsf@fess.ebiederm.org>
        <20210304081142.digtkddajkadwwq5@linutronix.de>
        <87tupr55ea.fsf@nanos.tec.linutronix.de>
        <m11rcu7nbr.fsf@fess.ebiederm.org>
        <87lfb263h2.fsf@nanos.tec.linutronix.de>
        <87sg524z6t.fsf@nanos.tec.linutronix.de>
Date:   Wed, 10 Mar 2021 15:57:31 -0600
In-Reply-To: <87sg524z6t.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Wed, 10 Mar 2021 19:54:18 +0100")
Message-ID: <m1pn06oeno.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lK6pb-001CWv-CA;;;mid=<m1pn06oeno.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/y2KJLzzNiNHbboU3wiz8U/ySACPMMHY8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 724 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 11 (1.5%), b_tie_ro: 10 (1.3%), parse: 1.06
        (0.1%), extract_message_metadata: 13 (1.8%), get_uri_detail_list: 2.1
        (0.3%), tests_pri_-1000: 8 (1.1%), tests_pri_-950: 1.82 (0.3%),
        tests_pri_-900: 1.19 (0.2%), tests_pri_-90: 67 (9.3%), check_bayes: 65
        (9.0%), b_tokenize: 9 (1.3%), b_tok_get_all: 11 (1.5%), b_comp_prob:
        3.2 (0.4%), b_tok_touch_all: 38 (5.2%), b_finish: 0.92 (0.1%),
        tests_pri_0: 337 (46.5%), check_dkim_signature: 0.84 (0.1%),
        check_dkim_adsp: 2.2 (0.3%), poll_dns_idle: 263 (36.3%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 278 (38.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Thu, Mar 04 2021 at 21:58, Thomas Gleixner wrote:
>> On Thu, Mar 04 2021 at 13:04, Eric W. Biederman wrote:
>>> Thomas Gleixner <tglx@linutronix.de> writes:
>>>>
>>>> We could of course do the caching unconditionally for all tasks.
>>>
>>> Is there any advantage to only doing this for realtime tasks?
>>
>> It was mostly to avoid tons of cached entries hanging around all over
>> the place. So I limited it to the case which the RT users deeply cared
>> about. Also related to the accounting question below.
>>
>>> If not it probably makes sense to do the caching for all tasks.
>>>
>>> I am wondering if we want to count the cached sigqueue structure to the
>>> users rt signal rlimit?
>>
>> That makes some sense, but that's a user visible change as a single
>> signal will up the count for a tasks lifetime while today it is removed
>> from accounting again once the signal is delivered. So that needs some
>> thought.
>
> Thought more about it. To make this accounting useful we'd need:
>
>   - a seperate user::sigqueue_cached counter
>   - a seperate RLIMIT_SIGQUEUE_CACHED
>
> Then you need to think about the defaults. Any signal heavy application
> will want this enabled and obviously automagically.
>
> Also there is an argument not to have this due to possible pointless
> memory consumption.
>
> But what are we talking about? 80 bytes worth of memory per task in the
> worst case. Which is compared to the rest of a task's memory consumption
> just noise.
>
> Looking at some statistics from a devel system there are less than 10
> items cached when the machine is fully idle after boot. During a kernel
> compile the cache utilization goes up to ~150 at max (make -j128 and 64
> CPUs). What's interesting is the allocation statistics after boot and
> full kernel compile:
>
>   from slab:            23996
>   from task cache:	52223
>
> A typical pattern there is:
>
>     <ls>-58490   [010] d..2  7765.664198: __sigqueue_alloc: 58488 from slab ffff8881132df460 10
>     <ls>-58488   [002] d..1  7765.664294: __sigqueue_free.part.35: cache ffff8881132df460 10
>     <ls>-58488   [002] d..2  7765.665146: __sigqueue_alloc: 1149 from cache ffff8881103dc550 10
>      bash-1149   [000] d..2  7765.665220: exit_task_sighand: free ffff8881132df460 8 9
>      bash-1149   [000] d..1  7765.665662: __sigqueue_free.part.35: cache ffff8881103dc550 9
>
> 58488 grabs the sigqueue from bash's task cache and bash sticks it back
> in. Lather, rinse and repeat. 
>
> IMO, not bothering with an extra counter and rlimit plus the required
> atomic operations is just fine and having this for all tasks
> unconditionally looks like a clear win.
>
> I'll post an updated version of this soonish.

That looks like a good analysis.

I see that there is a sigqueue_cachep.  As I recall there are per cpu
caches and all kinds of other good stuff when using kmem_cache_alloc.

Are those goodies falling down?

I am just a little unclear on why a slab allocation is sufficiently
problematic that we want to avoid it.

Eric
