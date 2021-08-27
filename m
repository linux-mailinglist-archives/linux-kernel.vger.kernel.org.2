Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E2B3FA161
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhH0WHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:07:34 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38236 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhH0WH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:07:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:40080)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mJjzi-002cBF-Ue; Fri, 27 Aug 2021 16:06:38 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:36032 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mJjzg-00FMrf-W8; Fri, 27 Aug 2021 16:06:38 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YRrdvKEu2JQxLI5n@zeniv-ca.linux.org.uk> <877dgkvsog.fsf@disp2133>
        <YSXRL4Gt4SVLa+Hl@zeniv-ca.linux.org.uk>
        <CAHk-=whnUy1UHTt6dpgCdBgz4tu1JCVmrN8ouJ==fpDkT+kwpw@mail.gmail.com>
Date:   Fri, 27 Aug 2021 17:05:57 -0500
In-Reply-To: <CAHk-=whnUy1UHTt6dpgCdBgz4tu1JCVmrN8ouJ==fpDkT+kwpw@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 27 Aug 2021 11:54:57 -0700")
Message-ID: <87r1eea6gq.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mJjzg-00FMrf-W8;;;mid=<87r1eea6gq.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18zLpVFkSgbwCuxPI+BbycUB16I3x4a0Xk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TR_XM_Base64_M1,
        T_TM2_M_HEADER_IN_MSG,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.5 TR_XM_Base64_M1 Base64 Encoded Content with common spam flags
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1380 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 9 (0.7%), parse: 0.84 (0.1%),
         extract_message_metadata: 13 (1.0%), get_uri_detail_list: 1.82 (0.1%),
         tests_pri_-1000: 9 (0.7%), tests_pri_-950: 1.10 (0.1%),
        tests_pri_-900: 0.88 (0.1%), tests_pri_-90: 84 (6.1%), check_bayes: 83
        (6.0%), b_tokenize: 7 (0.5%), b_tok_get_all: 8 (0.6%), b_comp_prob:
        2.4 (0.2%), b_tok_touch_all: 62 (4.5%), b_finish: 0.88 (0.1%),
        tests_pri_0: 1241 (89.9%), check_dkim_signature: 0.49 (0.0%),
        check_dkim_adsp: 2.5 (0.2%), poll_dns_idle: 1.14 (0.1%), tests_pri_10:
        4.0 (0.3%), tests_pri_500: 11 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH][RFC] fix PTRACE_KILL
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> [ Sorry, this got missed by other stuff in my inbox ]
>
> On Tue, Aug 24, 2021 at 10:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> The change I'd proposed makes PTRACE_KILL deliver SIGKILL regardless of
>> the target state; yours is arguably what we should've done from the very
>> beginning (what we used to have prior to 0.99pl14 and what all other
>> Unices had been doing all along), but it's a visible change wrt error
>> returns and I don't see any sane way to paper over that part.
>>
>> Linus, what would you prefer?  I've no strong preferences here...
>
> Honestly, I have no huge preferences either, simply because this has
> clearly been broken so long that people who care have worked around
> the breakage already, or it just didn't matter enough.

The two choices are change PTRACE_KILL into:
"kill(SIGKILL)" or "ptrace(PTRACE_CONT, SIGKILL)".

When trying to figure out how userspace understands PTRACE_KILL
today, I have found at least one piece of userspace that
figures the definition of PTRACE_KILL is PTRACE_CONT with the signal
SIGKILL.

Frankly I find that a fair characterization, because except for the
return code when the task is not stopped PTRACE_KILL works exactly
like PTRACE_CONT with signal SIGKILL.

As there are real userspace visible differences between PTRACE_CONT and
kill(SIGKILL) I think we should go with the PTRACE_CONT definition
as that is the least likely to break userspace, and the only thing we
really care about here is making it so that malicious userspace can
not cause the kernel to misbehave.

> I don't think Eric's patch works, because if I read that one right, it
> would actually do that "wait_task_inactive()" which is very much
> against the whole point of PTRACE_KILL.  We want to kill the target
> asap, and regardless of where it is stuck.

It will do wait_task_inactive in one of the cases where PTRACE_KILL is
broken today.  But since the cost of a wait_task_inactive looks very
much like the cost of a spin_lock I don't see the problem.  The code in
ptrace_check_attach already waits on several other spin locks.

The code in ptrace_attach verifies that the target task in in state
TASK_TRACED.  Which means that the target task is in ptrace_stop
and has already done "set_special_state(TASK_TRACED)".  At that point
there are two possibilities.  Either the target task will have
reached freezable_schedule in ptrace_stop and wait_task_inactive won't
block at all, or wait_task_inactive will need to spin waiting for
the target task to reach freezable_schedule.

There is nothing in ptrace_stop that can sleep as all of the work
happens under a spin lock so the worst case wait in wait_task_inactive
should be quite short.


All of that said it is probably worth adding to my patch the logic so
that when ptrace_freeze_traced fails or wait_task_inactive fails the
code bails out immediately and returns 0 instead of -ESRCH.  Just to
avoid any userspace behavioral differences in PTRACE_KILL.  So we don't
even need to consider regressions.

Eric
