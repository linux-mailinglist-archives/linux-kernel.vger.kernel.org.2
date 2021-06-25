Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954373B490D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 20:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFYTBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 15:01:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57474 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYTBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 15:01:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwr35-000f6c-RJ; Fri, 25 Jun 2021 12:59:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:53632 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwr33-00718c-IM; Fri, 25 Jun 2021 12:59:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+b80bbdcca4c4dfaa189e@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, ast@kernel.org, christian@brauner.io,
        jnewsome@torproject.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, oleg@redhat.com,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <000000000000ef5d1b05c57c2262@google.com>
        <87fsx7akyf.fsf@disp2133>
        <CACT4Y+YM8wONCrOq75-TFwA86Sg5gRHDK81LQH_O_+yWsdTr=g@mail.gmail.com>
Date:   Fri, 25 Jun 2021 13:59:22 -0500
In-Reply-To: <CACT4Y+YM8wONCrOq75-TFwA86Sg5gRHDK81LQH_O_+yWsdTr=g@mail.gmail.com>
        (Dmitry Vyukov's message of "Fri, 25 Jun 2021 16:39:46 +0200")
Message-ID: <87lf6x4vp1.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lwr33-00718c-IM;;;mid=<87lf6x4vp1.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/6K7QSNjyoSlC4Vghb9ddd0B5Hb2/12rg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4985]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Dmitry Vyukov <dvyukov@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1452 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (0.3%), b_tie_ro: 3.1 (0.2%), parse: 1.07
        (0.1%), extract_message_metadata: 14 (0.9%), get_uri_detail_list: 2.0
        (0.1%), tests_pri_-1000: 17 (1.2%), tests_pri_-950: 1.05 (0.1%),
        tests_pri_-900: 0.84 (0.1%), tests_pri_-90: 144 (9.9%), check_bayes:
        142 (9.8%), b_tokenize: 5 (0.4%), b_tok_get_all: 7 (0.5%),
        b_comp_prob: 1.60 (0.1%), b_tok_touch_all: 126 (8.6%), b_finish: 0.76
        (0.1%), tests_pri_0: 1257 (86.5%), check_dkim_signature: 0.38 (0.0%),
        check_dkim_adsp: 2.6 (0.2%), poll_dns_idle: 1.25 (0.1%), tests_pri_10:
        2.9 (0.2%), tests_pri_500: 7 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [syzbot] KASAN: out-of-bounds Read in do_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Thu, Jun 24, 2021 at 7:31 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> syzbot <syzbot+b80bbdcca4c4dfaa189e@syzkaller.appspotmail.com> writes:
>>
>> > Hello,
>> >
>> > syzbot found the following issue on:
>>
>> This looks like dueling debug mechanism.  At a quick glance
>> stack_no_used is deliberately looking for an uninitialized part of the
>> stack.
>>
>> Perhaps the fix is to make KASAN and DEBUG_STACK_USAGE impossible to
>> select at the same time in Kconfig?
>
> +kasan-dev
>
> Hi Eric,
>
> Thanks for looking into this.
>
> I see several strange things about this KASAN report:
> 1. KASAN is not supposed to leave unused stack memory as "poisoned".
> Function entry poisons its own frame and function exit unpoisions it.
> Longjmp-like things can leave unused stack poisoned. We have
> kasan_unpoison_task_stack_below() for these, so maybe we are missing
> this annotation somewhere.
>
> 2. This stand-alone shadow pattern "07 07 07 07 07 07 07 07" looks fishy.
> It means there are 7 good bytes, then 1 poisoned byte, then 7 good
> bytes and so on. I am not sure what can leave such a pattern. Both
> heap and stack objects have larger redzones in between. I am not sure
> about globals, but stack should not overlap with globals (and there
> are no modules on syzbot).
>
> So far this happened only once and no reproducer. If nobody sees
> anything obvious, I would say we just wait for more info.


I may be mixing things up but on second glance this entire setup
feels very familiar.  I think this is the second time I have made
this request that the two pieces of debugging code play nice.

Perhaps it is a different piece of debugging code and KASAN that
I am remembering but I think this is the second time this issue has come
up.

Eric
