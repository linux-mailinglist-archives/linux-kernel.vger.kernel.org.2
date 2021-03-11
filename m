Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8D6337973
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhCKQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:33:19 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:53828 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCKQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:32:47 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKOEv-00FIkF-Nc; Thu, 11 Mar 2021 09:32:45 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKOEu-00053m-2T; Thu, 11 Mar 2021 09:32:44 -0700
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
        <m1pn06oeno.fsf@fess.ebiederm.org>
        <87mtva4l6o.fsf@nanos.tec.linutronix.de>
Date:   Thu, 11 Mar 2021 10:32:49 -0600
In-Reply-To: <87mtva4l6o.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Thu, 11 Mar 2021 00:56:47 +0100")
Message-ID: <m18s6tlkge.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lKOEu-00053m-2T;;;mid=<m18s6tlkge.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Sv6HxXWepRSdHMfjCIs3c9IJnTUYHIkY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 508 ms - load_scoreonly_sql: 0.16 (0.0%),
        signal_user_changed: 15 (2.9%), b_tie_ro: 12 (2.3%), parse: 1.87
        (0.4%), extract_message_metadata: 23 (4.4%), get_uri_detail_list: 3.6
        (0.7%), tests_pri_-1000: 12 (2.3%), tests_pri_-950: 1.46 (0.3%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 101 (19.8%), check_bayes:
        99 (19.5%), b_tokenize: 9 (1.7%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 3.3 (0.6%), b_tok_touch_all: 73 (14.3%), b_finish: 0.94
        (0.2%), tests_pri_0: 336 (66.0%), check_dkim_signature: 0.85 (0.2%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.47 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 12 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Mar 10 2021 at 15:57, Eric W. Biederman wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>> IMO, not bothering with an extra counter and rlimit plus the required
>>> atomic operations is just fine and having this for all tasks
>>> unconditionally looks like a clear win.
>>>
>>> I'll post an updated version of this soonish.
>>
>> That looks like a good analysis.
>>
>> I see that there is a sigqueue_cachep.  As I recall there are per cpu
>> caches and all kinds of other good stuff when using kmem_cache_alloc.
>>
>> Are those goodies falling down?
>>
>> I am just a little unclear on why a slab allocation is sufficiently
>> problematic that we want to avoid it.
>
> In the normal case it's not problematic at all. i.e. when the per cpu
> cache can directly fullfil the allocation in the fast path. Once that
> fails you're off into latency land...
>
> For the usual setup probably not an issue at all, but for real time
> processing it matters.
>
> Vs. the dedicated kmem cache for sigqueue. That's a red herring. By
> default kmem caches are shared/merged as I learned today and if you want
> dedicated ones you need to boot with 'slab_nomerge' on the command line.
>
> So without that option (which is of course not backwards compatible
> because the original behaviour was the other way around) your signal
> kmem cache might end up in a shared/merged kmem cache. Just do:
>
>   cat /proc/slabinfo | grep sig
>
> and the default will find:
>
> signal_cache        6440   6440   1152   28    8 : tunables    0    0    0 : slabdata    230    230      0
> sighand_cache       3952   4035   2112   15    8 : tunables    0    0    0 : slabdata    269    269      0
>
> But of course there is no way to figure out where your cache actually
> landed and then with with 'slab_nomerge' you'll get:
>
> sigqueue            3264   3264     80   51    1 : tunables    0    0    0 : slabdata     64     64      0
> signal_cache        6440   6440   1152   28    8 : tunables    0    0    0 : slabdata    230    230      0
> sighand_cache       3952   4035   2112   15    8 : tunables    0    0    0 : slabdata    269    269      0
>
> Don't worry about the 'active objects' field. That's just bonkers
> because SLUB has no proper accounting for active objects. That number is
> useless ...
>
> Not even CONFIG_SLUB_STATS=y will give you anything useful. I had to
> hack my own statistics into the signal code to gather these numbers
> !$@**!^?#!
>
> But why I'm not surprised? This stuff is optimized for High Frequency
> Trading which is useless by definition. Oh well...
>
> Rant aside, there is no massive benefit of doing that caching in
> general, but there is not much of a downside either and for particular
> use cases it's useful even outside of PREEMPT_RT.
>
> IMO, having it there unconditionally is better than yet another special
> cased hackery.

Sounds reasonable, and thank you for actually looking into it.  I think
a comment saying this gives a strong guarantee that as long as userspace
plays by the rules (aka max one outstanding signal per process)
userspace gets a low latency guarantee.

Eric
