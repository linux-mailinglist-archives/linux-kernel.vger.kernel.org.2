Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AFD37194D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhECQcJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 May 2021 12:32:09 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51504 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhECQcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:32:06 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldbTI-00Guxb-V2; Mon, 03 May 2021 10:31:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldbTH-00DUxX-C4; Mon, 03 May 2021 10:31:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <Peter.Enderborg@sony.com>
Cc:     <mathieu.desnoyers@efficios.com>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <akpm@linux-foundation.org>, <peterz@infradead.org>,
        <ast@kernel.org>, <christian.brauner@ubuntu.com>,
        <dave@stgolabs.net>, <walken@google.com>, <jannh@google.com>,
        <christophe.leroy@c-s.fr>, <minchan@kernel.org>
References: <20210430142223.25500-1-peter.enderborg@sony.com>
        <20210430142223.25500-2-peter.enderborg@sony.com>
        <m14kfnzmsp.fsf@fess.ebiederm.org>
        <4bb24db4-f720-f5e7-9054-36bdeaee1d79@sony.com>
        <20210501091104.418765bd@oasis.local.home>
        <1214833117.22933.1620049830326.JavaMail.zimbra@efficios.com>
        <769a00d2-a76d-62d2-aa56-5a107dfdc53d@sony.com>
Date:   Mon, 03 May 2021 11:30:55 -0500
In-Reply-To: <769a00d2-a76d-62d2-aa56-5a107dfdc53d@sony.com> (Peter
        Enderborg's message of "Mon, 3 May 2021 14:48:33 +0000")
Message-ID: <m1sg33lqyo.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1ldbTH-00DUxX-C4;;;mid=<m1sg33lqyo.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cM5lP+LtEYh/PUB7WEiMxI5uS5CjEhCQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<Peter.Enderborg@sony.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 637 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (1.8%), b_tie_ro: 10 (1.6%), parse: 1.21
        (0.2%), extract_message_metadata: 18 (2.8%), get_uri_detail_list: 2.4
        (0.4%), tests_pri_-1000: 6 (1.0%), tests_pri_-950: 1.29 (0.2%),
        tests_pri_-900: 1.18 (0.2%), tests_pri_-90: 87 (13.6%), check_bayes:
        85 (13.3%), b_tokenize: 12 (1.9%), b_tok_get_all: 25 (3.9%),
        b_comp_prob: 3.1 (0.5%), b_tok_touch_all: 40 (6.4%), b_finish: 1.01
        (0.2%), tests_pri_0: 493 (77.5%), check_dkim_signature: 0.68 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.69 (0.1%), tests_pri_10:
        2.5 (0.4%), tests_pri_500: 11 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] tracing: Add a trace for task_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<Peter.Enderborg@sony.com> writes:

> On 5/3/21 3:50 PM, Mathieu Desnoyers wrote:
>> ----- On May 1, 2021, at 9:11 AM, rostedt rostedt@goodmis.org wrote:
>>
>>> On Sat, 1 May 2021 09:29:41 +0000
>>> <Peter.Enderborg@sony.com> wrote:
>>>
>>>> On 4/30/21 7:48 PM, Eric W. Biederman wrote:
>>>>> Peter Enderborg <peter.enderborg@sony.com> writes:
>>>>>  
>>>>>> This is the peer functions to task_rename and task_newtask.
>>>>>> With this we get hole "life-cycle" of task and can easily
>>>>>> see short livied task and their exit status.
>>>>> This patch is incorrect.  The location you are dealing with is not part
>>>>> of task exit.  The location you have instrumented is part of reaping a
>>>>> task which can come arbitrarily long after the task exits.
>>>> That is what it aiming. When using this as tool for userspace you
>>>> would like to know when the task is done. When it no longer
>>>> holds any thing that might have any impact. If you think the
>>>> exit imply something more specific I can change the name.
>>>>
>>>> I thought exit was a good name, it is in in exit.c.
>>>>
>>>> Will the name task_done, task_finished or task_reaped work for you?
>>> I think "task_reaped" is probably the best name, and the most
>>> descriptive of what happened.
>> What would it provide that is not already available through the "sched_process_free"
>> tracepoint in delayed_put_task_struct ?
>
> For task_exit (or task_reaped)
>
>         field:pid_t pid;        offset:8;       size:4; signed:1;
>         field:short oom_score_adj;      offset:12;      size:2; signed:1;
>         field:int exit_signal;  offset:16;      size:4; signed:1;
>         field:int exit_code;    offset:20;      size:4; signed:1;
>         field:int exit_state;   offset:24;      size:4; signed:1;
>         field:__data_loc char[] comm;   offset:28;      size:4; signed:1;
>
> sched_process_free
>         field:char comm[16];    offset:8;       size:16;        signed:1;
>         field:pid_t pid;        offset:24;      size:4; signed:1;
>         field:int prio; offset:28;      size:4; signed:1;
>
> So information about oom_score_adj, and it's exit parameters.


For the record returning oom_score_adj that late is not appropriate for
any kernel/user API.  It is perfectly valid for the kernel to optimize
out anything that wait(2) does not return.

If you want oom_score_adj you probably need to sample it in
sched_process_exit.

I periodically move things from the point a process is reaped to the
point where a task stops running, for both correctness and for simpler
maintenance.  When threads were added a bunch of cleanup was added
to the wrong place.  I certainly would not hesitate to mess with
oom_score_adj if changing something would make the code simpler.

With both sched_process_free and sched_process_exit it looks like we
already have tracepoints everywhere they could be needed.
task exit.

Eric
