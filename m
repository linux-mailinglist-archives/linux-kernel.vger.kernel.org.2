Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14A944EA99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhKLPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:43:24 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:41674 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhKLPnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:43:04 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:39966)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mlYex-00HRjL-OZ; Fri, 12 Nov 2021 08:40:11 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60472 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mlYev-00CI2X-6y; Fri, 12 Nov 2021 08:40:11 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, H Peter Anvin <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-9-ebiederm@xmission.com>
Date:   Fri, 12 Nov 2021 09:40:01 -0600
In-Reply-To: <20211020174406.17889-9-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Wed, 20 Oct 2021 12:43:55 -0500")
Message-ID: <874k8htmb2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mlYev-00CI2X-6y;;;mid=<874k8htmb2.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/KsN+DLpDCN8Kpyddi7rOkerSB6iMUT1U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1976 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 19 (1.0%), b_tie_ro: 17 (0.9%), parse: 1.94
        (0.1%), extract_message_metadata: 28 (1.4%), get_uri_detail_list: 2.7
        (0.1%), tests_pri_-1000: 32 (1.6%), tests_pri_-950: 1.51 (0.1%),
        tests_pri_-900: 1.16 (0.1%), tests_pri_-90: 95 (4.8%), check_bayes: 91
        (4.6%), b_tokenize: 9 (0.4%), b_tok_get_all: 8 (0.4%), b_comp_prob:
        2.8 (0.1%), b_tok_touch_all: 67 (3.4%), b_finish: 1.06 (0.1%),
        tests_pri_0: 1267 (64.1%), check_dkim_signature: 0.69 (0.0%),
        check_dkim_adsp: 2.9 (0.1%), poll_dns_idle: 506 (25.6%), tests_pri_10:
        2.2 (0.1%), tests_pri_500: 524 (26.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 09/20] signal/vm86_32: Replace open coded BUG_ON with an actual BUG_ON
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> The function save_v86_state is only called when userspace was
> operating in vm86 mode before entering the kernel.  Not having vm86
> state in the task_struct should never happen.  So transform the hand
> rolled BUG_ON into an actual BUG_ON to make it clear what is
> happening.

Now that this change has been merged into Linus' tree I have a report
that it is possible to trigger this new BUG_ON.  Which obviously is not
good.

We could revert the change but I think that would just be shooting the
messenger.

Does anyone have an idea where to start to track down what is going on?

A very quick skim through the code suggests that the only code path
that calls save_v86_state that has not already accessed is
current->thread.vm86 is handle_signal.

Another quick look suggests that the only place where X86_VM_MASK gets
set in eflags is in do_sys_vm86.  So it appears do_sys_vm86 must
be called before v8086_mode returns true in handle_signal.

Which seems to suggest that the bug on can't trigger.

But that is obviously wrong.

I will keep digging but if anyone has some ideas that would be appreciated.

Eric


> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: H Peter Anvin <hpa@zytor.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/x86/kernel/vm86_32.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
> index e5a7a10a0164..63486da77272 100644
> --- a/arch/x86/kernel/vm86_32.c
> +++ b/arch/x86/kernel/vm86_32.c
> @@ -106,10 +106,8 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
>  	 */
>  	local_irq_enable();
>  
> -	if (!vm86 || !vm86->user_vm86) {
> -		pr_alert("no user_vm86: BAD\n");
> -		do_exit(SIGSEGV);
> -	}
> +	BUG_ON(!vm86 || !vm86->user_vm86);
> +
>  	set_flags(regs->pt.flags, VEFLAGS, X86_EFLAGS_VIF | vm86->veflags_mask);
>  	user = vm86->user_vm86;
