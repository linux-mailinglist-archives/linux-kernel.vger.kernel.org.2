Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C34C33990F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhCLVZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:25:57 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:51258 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbhCLVZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:25:53 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKpI7-008z6D-Qb; Fri, 12 Mar 2021 14:25:51 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKpI6-0006pZ-U7; Fri, 12 Mar 2021 14:25:51 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210312173855.24843-1-jnewsome@torproject.org>
        <m1k0qcglol.fsf@fess.ebiederm.org>
        <d7f5d5fa-87ed-c95a-eca2-44e750b6e78d@torproject.org>
Date:   Fri, 12 Mar 2021 15:25:56 -0600
In-Reply-To: <d7f5d5fa-87ed-c95a-eca2-44e750b6e78d@torproject.org> (Jim
        Newsome's message of "Fri, 12 Mar 2021 15:05:16 -0600")
Message-ID: <m1sg50f4ij.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lKpI6-0006pZ-U7;;;mid=<m1sg50f4ij.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18u2BA0eeUG39rmxl9H+zFfEItifezblC8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4983]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Jim Newsome <jnewsome@torproject.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 387 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.5 (0.9%), b_tie_ro: 2.4 (0.6%), parse: 0.72
        (0.2%), extract_message_metadata: 8 (2.1%), get_uri_detail_list: 1.08
        (0.3%), tests_pri_-1000: 11 (2.9%), tests_pri_-950: 1.01 (0.3%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 132 (34.2%), check_bayes:
        128 (33.2%), b_tokenize: 4.8 (1.2%), b_tok_get_all: 8 (2.0%),
        b_comp_prob: 1.59 (0.4%), b_tok_touch_all: 112 (28.9%), b_finish: 0.63
        (0.2%), tests_pri_0: 219 (56.7%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.78 (0.2%), tests_pri_10:
        1.76 (0.5%), tests_pri_500: 6 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Newsome <jnewsome@torproject.org> writes:

> On 3/12/21 14:29, Eric W. Biederman wrote:
>> When I looked at this a second time it became apparent that using
>> pid_task twice should actually be faster as it removes a dependent load
>> caused by thread_group_leader, and replaces it by accessing two adjacent
>> pointers in the same cache line.
>> 
>> I know the algorithmic improvement is the main advantage, but removing
>> 60ns or so for a dependent load can't hurt.
>> 
>> Plus I think using the two pid types really makes it clear that one
>> is always a process and the other is always potentially a thread.
>> 
>> /*
>>  * Optimization for waiting on PIDTYPE_PID. No need to iterate through child
>>  * and tracee lists to find the target task.
>>  */
>> static int do_wait_pid(struct wait_opts *wo)
>> {
>> 	bool ptrace;
>> 	struct task_struct *target;
>> 	int retval;
>> 
>> 	ptrace = false;
>> 	target = pid_task(wo->wo_pid, PIDTYPE_TGID);
>> 	if (target && is_effectively_child(wo, ptrace, target)) {
>> 		retval = wait_consider_task(wo, ptrace, target);
>> 		if (retval)
>> 			return retval;
>> 	}
>> 
>> 	ptrace = true;
>> 	target = pid_task(wo->wo_pid, PIDTYPE_PID);
>> 	if (target && target->ptrace &&
>>             is_effectively_child(wo, ptrace, target)) {
>> 		retval = wait_consider_task(wo, ptrace, target);
>> 		if (retval)
>> 			return retval;
>> 	}
>> 
>> 	return 0;
>> }
>
> I'm fine with either way.
>
> Part of what made my earlier version with the double-lookup a bit
> awkward was only doing the second lookup if the first lookup failed. I'm
> happy to take your word though that making the second lookup conditional
> is unnecessary or even detrimental :).

Oh absolutely.  The two lookups are independent.

> It did cross my mind that it
> might not be a very consistent branch for a branch-predictor, but I also
> figured pid_task's synchronization might outweigh that.

pid_task has a lot of verbiage but it is only reading a pointer,
verifying the pointer is not NULL and calling container_of on the result
of the pointer read.

Eric

