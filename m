Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C53E32D9E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbhCDTCN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 Mar 2021 14:02:13 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:60962 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbhCDTBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:01:55 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHtDh-00162g-HP; Thu, 04 Mar 2021 12:01:09 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHtDc-000869-Kd; Thu, 04 Mar 2021 12:01:09 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
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
Date:   Thu, 04 Mar 2021 13:01:04 -0600
In-Reply-To: <20210304081142.digtkddajkadwwq5@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Thu, 4 Mar 2021 09:11:42 +0100")
Message-ID: <m1czwe7ngv.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1lHtDc-000869-Kd;;;mid=<m1czwe7ngv.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19FylJH7fH0IlwEew6Xhnp2mnptXINtycQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_Unicode,
        XM_B_Unicode3 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4931]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode3 BODY: Testing for specific types of unicode
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4584 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.4 (0.1%), b_tie_ro: 3.0 (0.1%), parse: 1.12
        (0.0%), extract_message_metadata: 11 (0.2%), get_uri_detail_list: 1.83
        (0.0%), tests_pri_-1000: 4.3 (0.1%), tests_pri_-950: 1.14 (0.0%),
        tests_pri_-900: 0.85 (0.0%), tests_pri_-90: 142 (3.1%), check_bayes:
        140 (3.0%), b_tokenize: 5 (0.1%), b_tok_get_all: 7 (0.1%),
        b_comp_prob: 1.62 (0.0%), b_tok_touch_all: 123 (2.7%), b_finish: 0.94
        (0.0%), tests_pri_0: 4402 (96.0%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 2.4 (0.1%), poll_dns_idle: 1.06 (0.0%), tests_pri_10:
        2.6 (0.1%), tests_pri_500: 12 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2021-03-03 16:09:05 [-0600], Eric W. Biederman wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> 
>> > From: Thomas Gleixner <tglx@linutronix.de>
>> >
>> > Allow realtime tasks to cache one sigqueue in task struct. This avoids an
>> > allocation which can increase the latency or fail.
>> > Ideally the sigqueue is cached after first successful delivery and will be
>> > available for next signal delivery. This works under the assumption that the RT
>> > task has never an unprocessed signal while a one is about to be queued.
>> >
>> > The caching is not used for SIGQUEUE_PREALLOC because this kind of sigqueue is
>> > handled differently (and not used for regular signal delivery).
>> 
>> What part of this is about real time tasks?  This allows any task
>> to cache a sigqueue entry.
>
> It is limited to realtime tasks (SCHED_FIFO/RR/DL):
>
> +static void __sigqueue_cache_or_free(struct sigqueue *q)
> +{
> …
> +	if (!task_is_realtime(current) || !sigqueue_add_cache(current, q))
> +		kmem_cache_free(sigqueue_cachep, q);
> +}

I see now.  I was looking for it somewhere in the allocation side.
Oleg's suggestion of simply adding a few additional lines to
__sigqueue_free would have made this stand out more.

A __sigqueue_free that takes the relevant task_struct instead of always
assuming current would be nice here.


>> Either the patch is buggy or the description is.  Overall caching one
>> sigqueue entry doesn't look insane. But it would help to have a clear
>> description of what is going on.
>
> Does this clear things up or is my logic somehow broken here?

No I just missed the task_is_realtime limitation.

Eric

