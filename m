Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46BB32D9F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbhCDTFY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 Mar 2021 14:05:24 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:55716 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbhCDTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:04:54 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHtGb-00ASEp-EP; Thu, 04 Mar 2021 12:04:09 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHtGa-002EOH-DL; Thu, 04 Mar 2021 12:04:09 -0700
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
Date:   Thu, 04 Mar 2021 13:04:08 -0600
In-Reply-To: <87tupr55ea.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Thu, 04 Mar 2021 16:02:05 +0100")
Message-ID: <m11rcu7nbr.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1lHtGa-002EOH-DL;;;mid=<m11rcu7nbr.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18R52oqQneu5np0N/5Uc8Jp1bSLt8e3Wso=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_Unicode,
        XM_B_Unicode3 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        *  0.7 XMSubLong Long Subject
        *  0.0 XM_B_Unicode3 BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 511 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.46
        (0.3%), extract_message_metadata: 17 (3.4%), get_uri_detail_list: 1.90
        (0.4%), tests_pri_-1000: 15 (2.8%), tests_pri_-950: 1.29 (0.3%),
        tests_pri_-900: 1.05 (0.2%), tests_pri_-90: 210 (41.2%), check_bayes:
        209 (40.8%), b_tokenize: 11 (2.1%), b_tok_get_all: 7 (1.4%),
        b_comp_prob: 3.6 (0.7%), b_tok_touch_all: 183 (35.8%), b_finish: 1.08
        (0.2%), tests_pri_0: 240 (46.9%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 0.50 (0.1%), tests_pri_10:
        1.97 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Thu, Mar 04 2021 at 09:11, Sebastian Andrzej Siewior wrote:
>> On 2021-03-03 16:09:05 [-0600], Eric W. Biederman wrote:
>>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>>> 
>>> > From: Thomas Gleixner <tglx@linutronix.de>
>>> >
>>> > Allow realtime tasks to cache one sigqueue in task struct. This avoids an
>>> > allocation which can increase the latency or fail.
>>> > Ideally the sigqueue is cached after first successful delivery and will be
>>> > available for next signal delivery. This works under the assumption that the RT
>>> > task has never an unprocessed signal while a one is about to be queued.
>>> >
>>> > The caching is not used for SIGQUEUE_PREALLOC because this kind of sigqueue is
>>> > handled differently (and not used for regular signal delivery).
>>> 
>>> What part of this is about real time tasks?  This allows any task
>>> to cache a sigqueue entry.
>>
>> It is limited to realtime tasks (SCHED_FIFO/RR/DL):
>>
>> +static void __sigqueue_cache_or_free(struct sigqueue *q)
>> +{
>> …
>> +	if (!task_is_realtime(current) || !sigqueue_add_cache(current, q))
>> +		kmem_cache_free(sigqueue_cachep, q);
>> +}
>
> We could of course do the caching unconditionally for all tasks.

Is there any advantage to only doing this for realtime tasks?

If not it probably makes sense to do the caching for all tasks.

I am wondering if we want to count the cached sigqueue structure to the
users rt signal rlimit?

Eric
