Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA7936FFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 19:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhD3RtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 13:49:03 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58152 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhD3RtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:49:02 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcXFL-00C1aC-DO; Fri, 30 Apr 2021 11:48:11 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcXFK-00054O-GW; Fri, 30 Apr 2021 11:48:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Minchan Kim <minchan@kernel.org>
References: <20210430142223.25500-1-peter.enderborg@sony.com>
        <20210430142223.25500-2-peter.enderborg@sony.com>
Date:   Fri, 30 Apr 2021 12:48:06 -0500
In-Reply-To: <20210430142223.25500-2-peter.enderborg@sony.com> (Peter
        Enderborg's message of "Fri, 30 Apr 2021 16:22:22 +0200")
Message-ID: <m14kfnzmsp.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lcXFK-00054O-GW;;;mid=<m14kfnzmsp.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/enQOc0MGlBQxkqwCDNSajCkyZXxd/oKc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4915]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Peter Enderborg <peter.enderborg@sony.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 601 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 10 (1.6%), parse: 1.02
        (0.2%), extract_message_metadata: 12 (2.1%), get_uri_detail_list: 1.79
        (0.3%), tests_pri_-1000: 5 (0.9%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 1.06 (0.2%), tests_pri_-90: 58 (9.7%), check_bayes: 57
        (9.5%), b_tokenize: 9 (1.5%), b_tok_get_all: 8 (1.3%), b_comp_prob:
        2.2 (0.4%), b_tok_touch_all: 35 (5.8%), b_finish: 0.85 (0.1%),
        tests_pri_0: 456 (75.9%), check_dkim_signature: 0.67 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.56 (0.1%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 48 (8.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] tracing: Add a trace for task_exit
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Enderborg <peter.enderborg@sony.com> writes:

> This is the peer functions to task_rename and task_newtask.
> With this we get hole "life-cycle" of task and can easily
> see short livied task and their exit status.

This patch is incorrect.  The location you are dealing with is not part
of task exit.  The location you have instrumented is part of reaping a
task which can come arbitrarily long after the task exits.

There are some special rules associated with task_comm so I don't know
if your change to __string from a fixed size character array is safe.

Certainly something like that needs an explanation of why such a type
change is safe.

Eric


> Format might look like:
>             bash-1144    [006] ....  1306.601707: task_newtask: pid=1181 comm=bash clone_flags=1200000 oom_score_adj=0
>            <...>-1181    [007] ....  1306.602080: task_rename: pid=1181 oldcomm=bash newcomm=ls oom_score_adj=0
>             bash-1144    [006] d...  1306.785960: task_exit: pid=1181 oom_score_adj=0 exit_signal=17 exit_code=0 exit_state=0x10 comm=ls
>
> For a sequence when a bash shell runs the ls command.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  include/trace/events/task.h | 32 ++++++++++++++++++++++++++++++++
>  kernel/exit.c               |  3 +++
>  2 files changed, 35 insertions(+)
>
> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index 64d160930b0d..2e977d2935e1 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -56,6 +56,38 @@ TRACE_EVENT(task_rename,
>  		__entry->newcomm, __entry->oom_score_adj)
>  );
>  
> +TRACE_EVENT(task_exit,
> +
> +	TP_PROTO(struct task_struct *task),
> +
> +	TP_ARGS(task),
> +
> +	TP_STRUCT__entry(
> +		__field(pid_t,	pid)
> +		__field(short,	oom_score_adj)
> +		__field(int,	exit_signal)
> +		__field(int,	exit_code)
> +		__field(int,	exit_state)
> +		__string(comm, task->comm)
> +
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pid = task->pid;
> +		__entry->oom_score_adj = task->signal->oom_score_adj;
> +		__entry->exit_signal = task->exit_signal;
> +		__entry->exit_code = task->exit_code;
> +		__entry->exit_state = task->exit_state;
> +		__assign_str(comm, task->comm);
> +	),
> +
> +	TP_printk("pid=%d oom_score_adj=%hd exit_signal=%d exit_code=%d exit_state=0x%x comm=%s",
> +		  __entry->pid,
> +		  __entry->oom_score_adj, __entry->exit_signal,
> +		  __entry->exit_code, __entry->exit_state,
> +		  __get_str(comm))
> +);
> +
>  #endif
>  
>  /* This part must be outside protection */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 04029e35e69a..3ab0944e5dfc 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -68,6 +68,7 @@
>  #include <linux/uaccess.h>
>  #include <asm/unistd.h>
>  #include <asm/mmu_context.h>
> +#include <trace/events/task.h>
>  
>  static void __unhash_process(struct task_struct *p, bool group_dead)
>  {
> @@ -107,6 +108,8 @@ static void __exit_signal(struct task_struct *tsk)
>  		posix_cpu_timers_exit_group(tsk);
>  #endif
>  
> +	trace_task_exit(tsk);
> +
>  	if (group_dead) {
>  		tty = sig->tty;
>  		sig->tty = NULL;
