Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F7544EDA0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 20:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhKLUAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:00:30 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:32808 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhKLUA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:00:29 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:48836)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mlcg4-000QrO-Em; Fri, 12 Nov 2021 12:57:36 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:40172 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mlcg3-005hJW-74; Fri, 12 Nov 2021 12:57:35 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Date:   Fri, 12 Nov 2021 13:57:02 -0600
In-Reply-To: <CAMzpN2jkK5sAv-Kg_kVnCEyVySiqeTdUORcC=AdG1gV6r8nUew@mail.gmail.com>
        (Brian Gerst's message of "Fri, 12 Nov 2021 12:51:32 -0500")
Message-ID: <87ilwxrvu9.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mlcg3-005hJW-74;;;mid=<87ilwxrvu9.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19XfSxruRf8CAAJlBQOOZWkHIpRzckguFY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_12,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4985]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Brian Gerst <brgerst@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 494 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 16 (3.1%), b_tie_ro: 13 (2.6%), parse: 1.26
        (0.3%), extract_message_metadata: 14 (2.7%), get_uri_detail_list: 1.93
        (0.4%), tests_pri_-1000: 14 (2.8%), tests_pri_-950: 1.67 (0.3%),
        tests_pri_-900: 1.26 (0.3%), tests_pri_-90: 66 (13.4%), check_bayes:
        64 (13.0%), b_tokenize: 7 (1.3%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 3.3 (0.7%), b_tok_touch_all: 39 (7.8%), b_finish: 1.53
        (0.3%), tests_pri_0: 365 (73.9%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 3.5 (0.7%), poll_dns_idle: 1.58 (0.3%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 9 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 09/20] signal/vm86_32: Replace open coded BUG_ON with an actual BUG_ON
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <brgerst@gmail.com> writes:

> On Fri, Nov 12, 2021 at 10:41 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>
>> > The function save_v86_state is only called when userspace was
>> > operating in vm86 mode before entering the kernel.  Not having vm86
>> > state in the task_struct should never happen.  So transform the hand
>> > rolled BUG_ON into an actual BUG_ON to make it clear what is
>> > happening.
>>
>> Now that this change has been merged into Linus' tree I have a report
>> that it is possible to trigger this new BUG_ON.  Which obviously is not
>> good.
>>
>> We could revert the change but I think that would just be shooting the
>> messenger.
>>
>> Does anyone have an idea where to start to track down what is going on?
>>
>> A very quick skim through the code suggests that the only code path
>> that calls save_v86_state that has not already accessed is
>> current->thread.vm86 is handle_signal.
>>
>> Another quick look suggests that the only place where X86_VM_MASK gets
>> set in eflags is in do_sys_vm86.  So it appears do_sys_vm86 must
>> be called before v8086_mode returns true in handle_signal.
>>
>> Which seems to suggest that the bug on can't trigger.
>>
>> But that is obviously wrong.
>>
>> I will keep digging but if anyone has some ideas that would be appreciated.
>>
>> Eric
>
> It's possible that a null pointer was passed to the vm86 syscall.
> Since vm86 mode usually requires memory to be mapped at address 0 this
> wouldn't trigger a fault when reading the vm86_struct data.  It should
> be fine to remove !vm86->user_vm86 from the BUG_ON(), since the write
> to userspace can handle a fault.

Agreed, and that is plausible.

Still user space would have had to have mapped address 0 to get that
value set in do_sys_vm86.

I will see about cooking up a patch for that case regardless.  I am not
quite convinced, but perhaps the easiest way to tell is to simply remove
the unnecessary test and ask the fuzzer folks to see if they can still
hit the BUG_ON.

Eric

