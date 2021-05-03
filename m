Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9513E37201B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhECTD4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 May 2021 15:03:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40052 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:03:49 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lddqH-00GqQ5-CB; Mon, 03 May 2021 13:02:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lddqG-0006NO-9F; Mon, 03 May 2021 13:02:53 -0600
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
        <m1sg33lqyo.fsf@fess.ebiederm.org>
        <663fc7fa-e7fc-7d63-9de8-91b5f6fe4f06@sony.com>
Date:   Mon, 03 May 2021 14:02:48 -0500
In-Reply-To: <663fc7fa-e7fc-7d63-9de8-91b5f6fe4f06@sony.com> (Peter
        Enderborg's message of "Mon, 3 May 2021 18:04:34 +0000")
Message-ID: <m1a6pbk5d3.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1lddqG-0006NO-9F;;;mid=<m1a6pbk5d3.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Q2XxeWF9q5MKZ0tk0JMEmKJyUV6FPCZk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<Peter.Enderborg@sony.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 725 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.1 (0.4%), b_tie_ro: 2.2 (0.3%), parse: 0.79
        (0.1%), extract_message_metadata: 13 (1.7%), get_uri_detail_list: 2.6
        (0.4%), tests_pri_-1000: 4.7 (0.7%), tests_pri_-950: 1.01 (0.1%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 259 (35.8%), check_bayes:
        253 (34.9%), b_tokenize: 9 (1.2%), b_tok_get_all: 8 (1.2%),
        b_comp_prob: 2.3 (0.3%), b_tok_touch_all: 231 (31.8%), b_finish: 0.71
        (0.1%), tests_pri_0: 430 (59.4%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.4 (0.3%), poll_dns_idle: 0.66 (0.1%), tests_pri_10:
        2.6 (0.4%), tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] tracing: Add a trace for task_exit
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<Peter.Enderborg@sony.com> writes:

> On 5/3/21 6:30 PM, Eric W. Biederman wrote:
>> <Peter.Enderborg@sony.com> writes:
>>
>>> On 5/3/21 3:50 PM, Mathieu Desnoyers wrote:
>>>> ----- On May 1, 2021, at 9:11 AM, rostedt rostedt@goodmis.org wrote:
>>>>
>>>>> On Sat, 1 May 2021 09:29:41 +0000
>>>>> <Peter.Enderborg@sony.com> wrote:
>>>>>
>>>>>> On 4/30/21 7:48 PM, Eric W. Biederman wrote:
>>>>>>> Peter Enderborg <peter.enderborg@sony.com> writes:
>>>>>>>  
>>>>>>>> This is the peer functions to task_rename and task_newtask.
>>>>>>>> With this we get hole "life-cycle" of task and can easily
>>>>>>>> see short livied task and their exit status.
>>>>>>> This patch is incorrect.  The location you are dealing with is not part
>>>>>>> of task exit.  The location you have instrumented is part of reaping a
>>>>>>> task which can come arbitrarily long after the task exits.
>>>>>> That is what it aiming. When using this as tool for userspace you
>>>>>> would like to know when the task is done. When it no longer
>>>>>> holds any thing that might have any impact. If you think the
>>>>>> exit imply something more specific I can change the name.
>>>>>>
>>>>>> I thought exit was a good name, it is in in exit.c.
>>>>>>
>>>>>> Will the name task_done, task_finished or task_reaped work for you?
>>>>> I think "task_reaped" is probably the best name, and the most
>>>>> descriptive of what happened.
>>>> What would it provide that is not already available through the "sched_process_free"
>>>> tracepoint in delayed_put_task_struct ?
>>> For task_exit (or task_reaped)
>>>
>>>         field:pid_t pid;        offset:8;       size:4; signed:1;
>>>         field:short oom_score_adj;      offset:12;      size:2; signed:1;
>>>         field:int exit_signal;  offset:16;      size:4; signed:1;
>>>         field:int exit_code;    offset:20;      size:4; signed:1;
>>>         field:int exit_state;   offset:24;      size:4; signed:1;
>>>         field:__data_loc char[] comm;   offset:28;      size:4; signed:1;
>>>
>>> sched_process_free
>>>         field:char comm[16];    offset:8;       size:16;        signed:1;
>>>         field:pid_t pid;        offset:24;      size:4; signed:1;
>>>         field:int prio; offset:28;      size:4; signed:1;
>>>
>>> So information about oom_score_adj, and it's exit parameters.
>>
>> For the record returning oom_score_adj that late is not appropriate for
>> any kernel/user API.  It is perfectly valid for the kernel to optimize
>> out anything that wait(2) does not return.
>>
>> If you want oom_score_adj you probably need to sample it in
>> sched_process_exit.
> That I don't understand why?  oom_score_adj is part of the signal,
> why is that not intact when we run __exit_signal ?

Yes oom_score_adj lives in struct signal.  The naming of __exit_signal
is simply historical at this point, not descriptive.

The function of oom_score_adj is to tell the oom kill how aggressive to
be when oom_killing functions.  That stops being relevant as soon as
PF_EXITING gets set.

An optimization I have toyed with that would be completely relevant
is to have a very minimal struct zombie that would contain just the
information that wait(2) needs.  Everything else about the process
can be freed when the process actually stops running.

It would make no sense to include oom_score_adj in such a struct zombie.

As such it makes it very bad choice to place oom_score_adj userspace API
that triggers when a task is reaped.

>> I periodically move things from the point a process is reaped to the
>> point where a task stops running, for both correctness and for simpler
>> maintenance.  When threads were added a bunch of cleanup was added
>> to the wrong place.  I certainly would not hesitate to mess with
>> oom_score_adj if changing something would make the code simpler.
>>
>> With both sched_process_free and sched_process_exit it looks like we
>> already have tracepoints everywhere they could be needed.
>> task exit.
>
> It might be where we it is needed, but it does not contain information that
> are needed for userspace. I don't see this as tool for sched issues,
> but ading information to existing ones is of course a option.
>
> However current traces is template based, and I assume it wont be
> popular to add new fields to the template, and exit reasons is not
> right for the other template use cases.
>
> I still see a "new" task moving it to do_exit make trace name more
> correct?  Or is trace_task_do_exit better?

I really can't say, as I don't know much of anything about the tracing
infrastructure.  I would assume in most cases with a tracepoint in place
other kinds of tracing (like bpf programs) could come into play and read
out pieces of information that are not commonly wanted.

All I really know something about is the exit code path, as I keep
slowly trying to clean it up.  I plan on ignoring any tracepoint that
makes that gets in the way.

Eric
