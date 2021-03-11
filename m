Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3849337989
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhCKQhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:37:36 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:52756 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhCKQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:37:24 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKOJP-006ZlW-QV; Thu, 11 Mar 2021 09:37:23 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKOJP-0031iH-0U; Thu, 11 Mar 2021 09:37:23 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jim Newsome <jnewsome@torproject.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210309203919.15920-1-jnewsome@torproject.org>
        <m1blbqmy2u.fsf@fess.ebiederm.org> <20210311150820.GA15552@redhat.com>
Date:   Thu, 11 Mar 2021 10:37:27 -0600
In-Reply-To: <20210311150820.GA15552@redhat.com> (Oleg Nesterov's message of
        "Thu, 11 Mar 2021 16:08:21 +0100")
Message-ID: <m1sg51k5o8.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lKOJP-0031iH-0U;;;mid=<m1sg51k5o8.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18DeM/j9n2X2ms1qI2KqEBrWyWfZAhqUGo=
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
        *      [score: 0.4939]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 308 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (3.7%), b_tie_ro: 10 (3.1%), parse: 1.40
        (0.5%), extract_message_metadata: 23 (7.4%), get_uri_detail_list: 1.57
        (0.5%), tests_pri_-1000: 22 (7.3%), tests_pri_-950: 1.88 (0.6%),
        tests_pri_-900: 1.01 (0.3%), tests_pri_-90: 65 (21.1%), check_bayes:
        63 (20.6%), b_tokenize: 5 (1.6%), b_tok_get_all: 6 (1.9%),
        b_comp_prob: 1.81 (0.6%), b_tok_touch_all: 47 (15.3%), b_finish: 0.96
        (0.3%), tests_pri_0: 167 (54.4%), check_dkim_signature: 0.66 (0.2%),
        check_dkim_adsp: 2.2 (0.7%), poll_dns_idle: 0.49 (0.2%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 8 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 03/10, Eric W. Biederman wrote:
>>
>> Jim Newsome <jnewsome@torproject.org> writes:
>>
>> > +static int do_wait_pid(struct wait_opts *wo)
>> > +{
>> > +	struct task_struct *target = pid_task(wo->wo_pid, PIDTYPE_PID);
>>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> This is subtle change in behavior.
>>
>> Today on the task->children list we only place thread group leaders.
>
> Aaah, yes, thanks Eric!
>
>> So the code either needs a thread_group_leader filter on target before
>> the ptrace=0 case or we need to use "pid_task(wo->wo_pid, PIDTYPE_TGID)"
>> and "pid_task(wo->wo_pid, PIDTYPE_PID)" for the "ptrace=1" case.
>
> Agreed,
>
>> I would like to make thread_group_leaders go away
>
> Hmm, why?

Mostly because we have class of very nasty bugs to fix because code
thinks one thread is special.

There has been and I think still is code that mishandles zombie thread
group leaders.

Particularly nasty are zombie thread group leaders after userspace has
called setresuid in a way that changes signal permissions.

Eric
