Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C9334BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhCJWlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:41:25 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:35854 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCJWky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:40:54 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK7Vd-005CHo-Bb; Wed, 10 Mar 2021 15:40:53 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK7Vc-001Hso-6z; Wed, 10 Mar 2021 15:40:53 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210309203919.15920-1-jnewsome@torproject.org>
Date:   Wed, 10 Mar 2021 16:40:57 -0600
In-Reply-To: <20210309203919.15920-1-jnewsome@torproject.org> (Jim Newsome's
        message of "Tue, 9 Mar 2021 14:39:19 -0600")
Message-ID: <m1blbqmy2u.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lK7Vc-001Hso-6z;;;mid=<m1blbqmy2u.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/9+06NnPpPegzVSwsK95sEnyhmNU8Jfqk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,XMGppyBdWords,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  2.5 XMGppyBdWords BODY: Gappy or l33t words
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Jim Newsome <jnewsome@torproject.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 524 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 15 (2.9%), b_tie_ro: 13 (2.4%), parse: 1.06
        (0.2%), extract_message_metadata: 14 (2.7%), get_uri_detail_list: 2.2
        (0.4%), tests_pri_-1000: 15 (2.8%), tests_pri_-950: 1.39 (0.3%),
        tests_pri_-900: 1.19 (0.2%), tests_pri_-90: 175 (33.3%), check_bayes:
        166 (31.7%), b_tokenize: 8 (1.5%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 142 (27.1%), b_finish: 1.44
        (0.3%), tests_pri_0: 288 (55.0%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.9 (0.6%), poll_dns_idle: 1.12 (0.2%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Newsome <jnewsome@torproject.org> writes:

> do_wait is an internal function used to implement waitpid, waitid,
> wait4, etc. To handle the general case, it does an O(n) linear scan of
> the thread group's children and tracees.
>
> This patch adds a special-case when waiting on a pid to skip these scans
> and instead do an O(1) lookup. This improves performance when waiting on
> a pid from a thread group with many children and/or tracees.
>
> Signed-off-by: James Newsome <jnewsome@torproject.org>
> ---
>  kernel/exit.c | 53 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 04029e35e69a..c2438d4ba262 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1439,9 +1439,34 @@ void __wake_up_parent(struct task_struct *p, struct task_struct *parent)
>  			   TASK_INTERRUPTIBLE, p);
>  }
>  
> +// Optimization for waiting on PIDTYPE_PID. No need to iterate through child
> +// and tracee lists to find the target task.

Minor nit:  C++ style comments look very out of place in this file
            which uses old school C /* */ comment delimiters for
            all of it's block comments.
                      
> +static int do_wait_pid(struct wait_opts *wo)
> +{
> +	struct task_struct *target = pid_task(wo->wo_pid, PIDTYPE_PID);
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is subtle change in behavior.

Today on the task->children list we only place thread group leaders.

Which means that your do_wait_pid wait for thread of someone else's
process and that is a change in behavior.

So the code either needs a thread_group_leader filter on target before
the ptrace=0 case or we need to use "pid_task(wo->wo_pid, PIDTYPE_TGID)"
and "pid_task(wo->wo_pid, PIDTYPE_PID)" for the "ptrace=1" case.

I would like to make thread_group_leaders go away so I would favor two
pid_task calls.  But either will work right now.

Eric

                                     
> +	int retval;
> +
> +	if (!target)
> +		return 0;
> +	if (current == target->real_parent ||
> +	    (!(wo->wo_flags & __WNOTHREAD) &&
> +	     same_thread_group(current, target->real_parent))) {
> +		retval = wait_consider_task(wo, /* ptrace= */ 0, target);
> +		if (retval)
> +			return retval;
> +	}
> +	if (target->ptrace && (current == target->parent ||
> +			       (!(wo->wo_flags & __WNOTHREAD) &&
> +				same_thread_group(current, target->parent)))) {
> +		retval = wait_consider_task(wo, /* ptrace= */ 1, target);
> +		if (retval)
> +			return retval;
> +	}
> +	return 0;
> +}
> +
>  static long do_wait(struct wait_opts *wo)
>  {
> -	struct task_struct *tsk;
>  	int retval;
>  
>  	trace_sched_process_wait(wo->wo_pid);
> @@ -1463,19 +1488,27 @@ static long do_wait(struct wait_opts *wo)
>  
>  	set_current_state(TASK_INTERRUPTIBLE);
>  	read_lock(&tasklist_lock);
> -	tsk = current;
> -	do {
> -		retval = do_wait_thread(wo, tsk);
> -		if (retval)
> -			goto end;
>  
> -		retval = ptrace_do_wait(wo, tsk);
> +	if (wo->wo_type == PIDTYPE_PID) {
> +		retval = do_wait_pid(wo);
>  		if (retval)
>  			goto end;
> +	} else {
> +		struct task_struct *tsk = current;
>  
> -		if (wo->wo_flags & __WNOTHREAD)
> -			break;
> -	} while_each_thread(current, tsk);
> +		do {
> +			retval = do_wait_thread(wo, tsk);
> +			if (retval)
> +				goto end;
> +
> +			retval = ptrace_do_wait(wo, tsk);
> +			if (retval)
> +				goto end;
> +
> +			if (wo->wo_flags & __WNOTHREAD)
> +				break;
> +		} while_each_thread(current, tsk);
> +	}
>  	read_unlock(&tasklist_lock);
>  
>  notask:
