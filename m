Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5939639BAF0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFDOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:35:17 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58936 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFDOfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:35:12 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lpAsz-00AYcY-6V; Fri, 04 Jun 2021 08:33:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lpAsx-003ohO-PT; Fri, 04 Jun 2021 08:33:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jiashuo Liang <liangjs@pku.edu.cn>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20210601085203.40214-1-liangjs@pku.edu.cn>
        <YLkhV+lSqXlcfUc5@zn.tnic> <87lf7qocsd.fsf@disp2133>
        <YLolc7z64h9yHNao@zn.tnic>
Date:   Fri, 04 Jun 2021 09:33:12 -0500
In-Reply-To: <YLolc7z64h9yHNao@zn.tnic> (Borislav Petkov's message of "Fri, 4
        Jun 2021 15:06:59 +0200")
Message-ID: <878s3plmxj.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lpAsx-003ohO-PT;;;mid=<878s3plmxj.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/W0KjWVkzEriQCg2OLrnADsP+D+vNme+Q=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0892]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Borislav Petkov <bp@alien8.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 854 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.1 (0.5%), b_tie_ro: 2.9 (0.3%), parse: 0.77
        (0.1%), extract_message_metadata: 8 (1.0%), get_uri_detail_list: 1.25
        (0.1%), tests_pri_-1000: 4.2 (0.5%), tests_pri_-950: 1.01 (0.1%),
        tests_pri_-900: 0.82 (0.1%), tests_pri_-90: 62 (7.3%), check_bayes: 61
        (7.2%), b_tokenize: 6 (0.6%), b_tok_get_all: 7 (0.8%), b_comp_prob:
        1.66 (0.2%), b_tok_touch_all: 44 (5.2%), b_finish: 0.56 (0.1%),
        tests_pri_0: 271 (31.7%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 2.5 (0.3%), poll_dns_idle: 483 (56.6%), tests_pri_10:
        2.6 (0.3%), tests_pri_500: 497 (58.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal/x86: Don't send SIGSEGV twice on SEGV_PKUERR
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Thu, Jun 03, 2021 at 04:31:46PM -0500, Eric W. Biederman wrote:
>> There are two ways signals get delivered.  The old fashioned way in the
>> signal bitmap, and the new fangled way by queuing sigqueue_info.
>
> By that you mean that third arg siginfo_t to
>
> SYSCALL_DEFINE3(rt_sigqueueinfo, pid_t, pid, int, sig,
>                 siginfo_t __user *, uinfo)
>
> I presume?

Oh yes.  siginfo_t.  I don't know why I was thinking sigqueue_info.


> Which, as sigqueue(3) says, is what is called on Linux.
>
>> In the old fashioned way there is no information except that the
>> signal itself was delivered, and if the signal is sent twice it
>> is impossible to find out. In the new fangled way because the
>> sigqueue_info can vary between different times a signal is sent you
>> can both see that a signal was delivered twice (because there are two
>> distinct entries in the queue), but also possibly tell those two times
>> a signal was sent apart.
>>
>> The new real time signals can queue as many sigqueue_info's as their
>> rlimit allows.  The old signals are limited to exactly one sigqueue_info
>> per signal number.
>
> Aha.
>
>> In this case the legacy_queue check tests to see if the signal is
>> already pending (present in the signal bitmap) and not a new real time
>> signal (which means only one sigqueue_info entry is allowed in the
>> signal queue).
>
> Aha, that sigismember() call in legacy_queue().
>
>> Or in short I think everything turns out ok because the first signal is
>> delivered, and the second just happens to get dropped as a duplicate by
>> __send_signal.
>
> Right, it is a SIGSEGV in both cases. So it is a legacy signal, and
> that'll get marked in that sigset->sig array. Which is per task... ok.
>
>> That is fragile and confusing to depend on so we should just fix the
>> code to not send the wrong signal.
>
> Yap.
>
>> I hope that clears things up.
>
> Very much so, thanks for taking the time!

No worries.  It was my bug in the first place.

At some point I just figured someone needs to take the time to
understand the linux signal handling and get as many bugs out as we
can.  It may not be flashy but it is one of those core things
that everything is built on so we need code that works.

Eric

