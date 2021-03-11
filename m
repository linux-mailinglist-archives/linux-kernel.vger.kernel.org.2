Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6988233795F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCKQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:30:38 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:50230 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhCKQaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:30:07 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKOCK-006Yp6-ET; Thu, 11 Mar 2021 09:30:05 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKOCJ-002zwx-DR; Thu, 11 Mar 2021 09:30:04 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210309203919.15920-1-jnewsome@torproject.org>
        <m1blbqmy2u.fsf@fess.ebiederm.org>
        <4d9006b4-b65a-6ce0-b367-971f29de1f21@torproject.org>
Date:   Thu, 11 Mar 2021 10:30:08 -0600
In-Reply-To: <4d9006b4-b65a-6ce0-b367-971f29de1f21@torproject.org> (Jim
        Newsome's message of "Wed, 10 Mar 2021 18:14:44 -0600")
Message-ID: <m1lfatlkkv.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lKOCJ-002zwx-DR;;;mid=<m1lfatlkkv.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+m8dO/ge78RntGs8rj8stSQIb2dmMTiio=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Jim Newsome <jnewsome@torproject.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 376 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (3.0%), b_tie_ro: 10 (2.6%), parse: 1.31
        (0.3%), extract_message_metadata: 12 (3.2%), get_uri_detail_list: 1.20
        (0.3%), tests_pri_-1000: 16 (4.2%), tests_pri_-950: 1.72 (0.5%),
        tests_pri_-900: 1.40 (0.4%), tests_pri_-90: 100 (26.7%), check_bayes:
        98 (26.0%), b_tokenize: 9 (2.4%), b_tok_get_all: 7 (1.9%),
        b_comp_prob: 3.5 (0.9%), b_tok_touch_all: 74 (19.8%), b_finish: 0.98
        (0.3%), tests_pri_0: 220 (58.4%), check_dkim_signature: 0.74 (0.2%),
        check_dkim_adsp: 7 (2.0%), poll_dns_idle: 0.44 (0.1%), tests_pri_10:
        1.94 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Newsome <jnewsome@torproject.org> writes:

> On 3/10/21 16:40, Eric W. Biederman wrote:
>>> +// Optimization for waiting on PIDTYPE_PID. No need to iterate
> through child
>>> +// and tracee lists to find the target task.
>>
>> Minor nit:  C++ style comments look very out of place in this file
>>             which uses old school C /* */ comment delimiters for
>>             all of it's block comments.
>
> Will do
>
>>> +static int do_wait_pid(struct wait_opts *wo)
>>> +{
>>> +	struct task_struct *target = pid_task(wo->wo_pid, PIDTYPE_PID);
>>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> This is subtle change in behavior.
>> 
>> Today on the task->children list we only place thread group leaders.
>
> Shouldn't we allow waiting on clone children if __WALL or __WCLONE is set?
>
> This is already checked later in `eligible_child`, called from
> `wait_consider_task`, so I *think* the current form should already do
> the right thing. Now I'm confused though how the general path (through
> `do_wait_thread`) works if clone children aren't on the task->children
> list...?
>
> (In any case it seems this will need another version with at least an
> explanatory comment here)

What I am worried about are not clone children.  AKA ordinary children
that have a different exit signal but CLONE_THREAD children that are
never put on the children list so are naturally excluded from today's
do_wait (except in the case of ptrace). These are also known as threads.

Maybe I am missing it but I don't see anything in wait_consider_task
or in the way that you are calling it that would exclude CLONE_THREAD
children for the non-ptrace case.

Eric
