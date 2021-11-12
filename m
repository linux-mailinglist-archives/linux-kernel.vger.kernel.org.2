Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD8844EE4F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhKLVGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 16:06:50 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55972 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhKLVGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:06:49 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:60772)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mldiG-000PLF-Ip; Fri, 12 Nov 2021 14:03:57 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:42346 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mldiE-005q4x-MH; Fri, 12 Nov 2021 14:03:55 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brian Gerst <brgerst@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-9-ebiederm@xmission.com>
        <874k8htmb2.fsf@email.froward.int.ebiederm.org>
        <CAMzpN2jkK5sAv-Kg_kVnCEyVySiqeTdUORcC=AdG1gV6r8nUew@mail.gmail.com>
        <87ilwxrvu9.fsf@email.froward.int.ebiederm.org>
        <CAHk-=widK1vko2EN9PtV3jTo02u-expXxozui-fsK-0uKrcGHg@mail.gmail.com>
Date:   Fri, 12 Nov 2021 15:03:47 -0600
In-Reply-To: <CAHk-=widK1vko2EN9PtV3jTo02u-expXxozui-fsK-0uKrcGHg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 12 Nov 2021 12:40:48 -0800")
Message-ID: <87ee7lqe6k.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mldiE-005q4x-MH;;;mid=<87ee7lqe6k.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/0weWzQHy+vPmnfGK2Bbf/rbjlXYKZyIU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 539 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 9 (1.7%), b_tie_ro: 8 (1.5%), parse: 0.76 (0.1%),
        extract_message_metadata: 14 (2.5%), get_uri_detail_list: 0.93 (0.2%),
        tests_pri_-1000: 24 (4.5%), tests_pri_-950: 1.22 (0.2%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 261 (48.5%), check_bayes:
        260 (48.2%), b_tokenize: 6 (1.1%), b_tok_get_all: 6 (1.1%),
        b_comp_prob: 1.95 (0.4%), b_tok_touch_all: 243 (45.1%), b_finish: 0.78
        (0.1%), tests_pri_0: 216 (40.0%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.62 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 09/20] signal/vm86_32: Replace open coded BUG_ON with an actual BUG_ON
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Nov 12, 2021 at 11:57 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Still user space would have had to have mapped address 0 to get that
>> value set in do_sys_vm86.
>
> You have to map address 0 anyway just to get vm86 mode to work.
>
> vm86 mode fundamentally requires the low 1MB of virtual memory to be
> mapped, since there is no virtual memory offset in the vm86 model.

True.

However that also means if struct vm86plus_struct is at address 0
instead of the 16bit interrupt table something is badly wrong.

Still if we are going to check for userspace being silly that it should
be in do_sys_vm86.

I have managed to get the fuzzer that hit the problem to run and with
the test for !vm86->user_vm86 removed the BUG_ON is not being hit.

I am going to keep running it for a bit just to make certain, and
then I will put together a proper patch.

Eric
