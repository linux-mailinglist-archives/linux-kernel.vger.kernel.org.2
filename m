Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6136FFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhD3RnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 13:43:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56792 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3RnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:43:14 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcX9h-00C12U-B1; Fri, 30 Apr 2021 11:42:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcX9f-006Y7x-7J; Fri, 30 Apr 2021 11:42:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Marco Elver <elver@google.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        davem@davemloft.net, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20210429190734.624918-1-elver@google.com>
Date:   Fri, 30 Apr 2021 12:42:15 -0500
In-Reply-To: <20210429190734.624918-1-elver@google.com> (Marco Elver's message
        of "Thu, 29 Apr 2021 21:07:32 +0200")
Message-ID: <m1im43zn2g.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lcX9f-006Y7x-7J;;;mid=<m1im43zn2g.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xpTyeVtWIoPQ2FBsR3t2FfJi/LIl7zG4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1496 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 15 (1.0%), b_tie_ro: 13 (0.9%), parse: 1.15
        (0.1%), extract_message_metadata: 14 (0.9%), get_uri_detail_list: 3.4
        (0.2%), tests_pri_-1000: 12 (0.8%), tests_pri_-950: 1.34 (0.1%),
        tests_pri_-900: 1.15 (0.1%), tests_pri_-90: 117 (7.8%), check_bayes:
        115 (7.7%), b_tokenize: 9 (0.6%), b_tok_get_all: 10 (0.7%),
        b_comp_prob: 2.7 (0.2%), b_tok_touch_all: 88 (5.9%), b_finish: 1.41
        (0.1%), tests_pri_0: 1318 (88.1%), check_dkim_signature: 0.52 (0.0%),
        check_dkim_adsp: 3.0 (0.2%), poll_dns_idle: 1.33 (0.1%), tests_pri_10:
        4.0 (0.3%), tests_pri_500: 9 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] sparc64: Add compile-time asserts for siginfo_t offsets
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:

> To help catch ABI breaks at compile-time, add compile-time assertions to
> verify the siginfo_t layout. Unlike other architectures, sparc64 is
> special, because it is one of few architectures requiring si_trapno.
> ABI breaks around that field would only be caught here.

Arnd Bergman recently pointed out that we can move si_trapno into the
union and make it specific to a handful of signals.  Like we do other
items in the union.

Given that the code of perf_sigtrap is pretty much broken if si_trapno
needs to be filled out.  I think we should make that change before
we set this ABI in stone like this.

Otherwise this looks good.

Eric

> Link: https://lkml.kernel.org/r/m11rat9f85.fsf@fess.ebiederm.org
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  arch/sparc/kernel/signal32.c  | 34 ++++++++++++++++++++++++++++++++++
>  arch/sparc/kernel/signal_64.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
> index e9695a06492f..778ed5c26d4a 100644
> --- a/arch/sparc/kernel/signal32.c
> +++ b/arch/sparc/kernel/signal32.c
> @@ -745,3 +745,37 @@ asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp)
>  out:
>  	return ret;
>  }
> +
> +/*
> + * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
> + * changes likely come with new fields that should be added below.
> + */
> +static_assert(NSIGILL	== 11);
> +static_assert(NSIGFPE	== 15);
> +static_assert(NSIGSEGV	== 9);
> +static_assert(NSIGBUS	== 5);
> +static_assert(NSIGTRAP	== 6);
> +static_assert(NSIGCHLD	== 6);
> +static_assert(NSIGSYS	== 2);
> +static_assert(offsetof(compat_siginfo_t, si_signo)	== 0x00);
> +static_assert(offsetof(compat_siginfo_t, si_errno)	== 0x04);
> +static_assert(offsetof(compat_siginfo_t, si_code)	== 0x08);
> +static_assert(offsetof(compat_siginfo_t, si_pid)	== 0x0c);
> +static_assert(offsetof(compat_siginfo_t, si_uid)	== 0x10);
> +static_assert(offsetof(compat_siginfo_t, si_tid)	== 0x0c);
> +static_assert(offsetof(compat_siginfo_t, si_overrun)	== 0x10);
> +static_assert(offsetof(compat_siginfo_t, si_status)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_utime)	== 0x18);
> +static_assert(offsetof(compat_siginfo_t, si_stime)	== 0x1c);
> +static_assert(offsetof(compat_siginfo_t, si_value)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_int)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_ptr)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_addr)	== 0x0c);
> +static_assert(offsetof(compat_siginfo_t, si_trapno)	== 0x10);
> +static_assert(offsetof(compat_siginfo_t, si_addr_lsb)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_lower)	== 0x18);
> +static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x1c);
> +static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x18);
> +static_assert(offsetof(compat_siginfo_t, si_perf)	== 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
> +static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
> diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
> index a0eec62c825d..c9bbf5f29078 100644
> --- a/arch/sparc/kernel/signal_64.c
> +++ b/arch/sparc/kernel/signal_64.c
> @@ -556,3 +556,36 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
>  	user_enter();
>  }
>  
> +/*
> + * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
> + * changes likely come with new fields that should be added below.
> + */
> +static_assert(NSIGILL	== 11);
> +static_assert(NSIGFPE	== 15);
> +static_assert(NSIGSEGV	== 9);
> +static_assert(NSIGBUS	== 5);
> +static_assert(NSIGTRAP	== 6);
> +static_assert(NSIGCHLD	== 6);
> +static_assert(NSIGSYS	== 2);
> +static_assert(offsetof(siginfo_t, si_signo)	== 0x00);
> +static_assert(offsetof(siginfo_t, si_errno)	== 0x04);
> +static_assert(offsetof(siginfo_t, si_code)	== 0x08);
> +static_assert(offsetof(siginfo_t, si_pid)	== 0x10);
> +static_assert(offsetof(siginfo_t, si_uid)	== 0x14);
> +static_assert(offsetof(siginfo_t, si_tid)	== 0x10);
> +static_assert(offsetof(siginfo_t, si_overrun)	== 0x14);
> +static_assert(offsetof(siginfo_t, si_status)	== 0x18);
> +static_assert(offsetof(siginfo_t, si_utime)	== 0x20);
> +static_assert(offsetof(siginfo_t, si_stime)	== 0x28);
> +static_assert(offsetof(siginfo_t, si_value)	== 0x18);
> +static_assert(offsetof(siginfo_t, si_int)	== 0x18);
> +static_assert(offsetof(siginfo_t, si_ptr)	== 0x18);
> +static_assert(offsetof(siginfo_t, si_addr)	== 0x10);
> +static_assert(offsetof(siginfo_t, si_trapno)	== 0x18);
> +static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x20);
> +static_assert(offsetof(siginfo_t, si_lower)	== 0x28);
> +static_assert(offsetof(siginfo_t, si_upper)	== 0x30);
> +static_assert(offsetof(siginfo_t, si_pkey)	== 0x28);
> +static_assert(offsetof(siginfo_t, si_perf)	== 0x20);
> +static_assert(offsetof(siginfo_t, si_band)	== 0x10);
> +static_assert(offsetof(siginfo_t, si_fd)	== 0x14);
