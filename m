Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22E44379C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhJVPXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:23:01 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42194 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhJVPXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:23:00 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:58686)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdwLY-007xeD-QX; Fri, 22 Oct 2021 09:20:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:35524 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdwLW-006CVb-NO; Fri, 22 Oct 2021 09:20:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, arjan@linux.intel.com,
        ravi.v.shankar@intel.com, Oleg Nesterov <ole@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
        <20211021225527.10184-2-chang.seok.bae@intel.com>
Date:   Fri, 22 Oct 2021 10:20:31 -0500
In-Reply-To: <20211021225527.10184-2-chang.seok.bae@intel.com> (Chang S. Bae's
        message of "Thu, 21 Oct 2021 15:55:05 -0700")
Message-ID: <87h7d95bnk.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdwLW-006CVb-NO;;;mid=<87h7d95bnk.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/GKf14OFmFmBpZN36M+vn0tDruavaC/UE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;"Chang S. Bae" <chang.seok.bae@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1505 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (0.8%), b_tie_ro: 10 (0.7%), parse: 1.13
        (0.1%), extract_message_metadata: 19 (1.2%), get_uri_detail_list: 2.9
        (0.2%), tests_pri_-1000: 26 (1.7%), tests_pri_-950: 1.31 (0.1%),
        tests_pri_-900: 1.00 (0.1%), tests_pri_-90: 78 (5.2%), check_bayes: 76
        (5.0%), b_tokenize: 10 (0.7%), b_tok_get_all: 10 (0.7%), b_comp_prob:
        2.8 (0.2%), b_tok_touch_all: 49 (3.2%), b_finish: 0.82 (0.1%),
        tests_pri_0: 439 (29.2%), check_dkim_signature: 0.58 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 907 (60.2%), tests_pri_10:
        2.1 (0.1%), tests_pri_500: 922 (61.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 01/23] signal: Add an optional check for altstack size
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Chang S. Bae" <chang.seok.bae@intel.com> writes:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> The upcoming support for dynamically enabled FPU features on x86 requires
> an architecture specific sanity check and serialization of the store to
> task::sas_ss_size. The check is required to ensure that:
>
>    - Enabling of a dynamic feature, which changes the sigframe size fits
>      into an enabled sigaltstack
>
>    - Installing a too small sigaltstack after a dynamic feature has been
>      added is not possible.
>
> It needs serialization to prevent race conditions of all sorts in the
> feature enable code as that has to walk the thread list of the process.
>
> Add the infrastructure in form of a config option and provide empty stubs
> for architectures which do not need that.

Last I looked Al Viro was doing a lot of work on sigframes, adding him
to the cc.


That said description in the patch is very sorely lacking.

First the reason for the new locking is not really explained, it talks
about serialization but it does not talk about what is protected.
Especially given that the signal delivery code already has to check if
the signal frame on the stack when pushing a new signal I don't
understand what the code is trying to prevent.

Second the reason that 2K is not enough mentioned.  The current value of
MINSIGSTKSZ on x86 is 2K.

Third the issues with modifying the userspace ABI are not discussed.
Frankly that is a pretty big consideration.  MINSIGSTKSZ is exported to
userspace and userspace fundamentally needs to allocate the alternate
signal frame.

Forth the sigframe size on x86 is already dynamic and is already
computed by get_sigframe_size.

So can we please please please have a better description of what
is going on and the trade offs that are being made.

Thank you,
Eric




> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Oleg Nesterov <ole@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  arch/Kconfig           |  3 +++
>  include/linux/signal.h |  6 ++++++
>  kernel/signal.c        | 35 +++++++++++++++++++++++++++++------
>  3 files changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8df1c7102643..af5cf3009b4f 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1288,6 +1288,9 @@ config ARCH_HAS_ELFCORE_COMPAT
>  config ARCH_HAS_PARANOID_L1D_FLUSH
>  	bool
>  
> +config DYNAMIC_SIGFRAME
> +	bool
> +
>  source "kernel/gcov/Kconfig"
>  
>  source "scripts/gcc-plugins/Kconfig"
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 3f96a6374e4f..7d34105e20c6 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -464,6 +464,12 @@ int __save_altstack(stack_t __user *, unsigned long);
>  	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
>  } while (0);
>  
> +#ifdef CONFIG_DYNAMIC_SIGFRAME
> +bool sigaltstack_size_valid(size_t ss_size);
> +#else
> +static inline bool sigaltstack_size_valid(size_t size) { return true; }
> +#endif /* !CONFIG_DYNAMIC_SIGFRAME */
> +
>  #ifdef CONFIG_PROC_FS
>  struct seq_file;
>  extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 952741f6d0f9..9278f5291ed6 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4151,11 +4151,29 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_DYNAMIC_SIGFRAME
> +static inline void sigaltstack_lock(void)
> +	__acquires(&current->sighand->siglock)
> +{
> +	spin_lock_irq(&current->sighand->siglock);
> +}
> +
> +static inline void sigaltstack_unlock(void)
> +	__releases(&current->sighand->siglock)
> +{
> +	spin_unlock_irq(&current->sighand->siglock);
> +}
> +#else
> +static inline void sigaltstack_lock(void) { }
> +static inline void sigaltstack_unlock(void) { }
> +#endif
> +
>  static int
>  do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
>  		size_t min_ss_size)
>  {
>  	struct task_struct *t = current;
> +	int ret = 0;
>  
>  	if (oss) {
>  		memset(oss, 0, sizeof(stack_t));
> @@ -4179,19 +4197,24 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
>  				ss_mode != 0))
>  			return -EINVAL;
>  
> +		sigaltstack_lock();
>  		if (ss_mode == SS_DISABLE) {
>  			ss_size = 0;
>  			ss_sp = NULL;
>  		} else {
>  			if (unlikely(ss_size < min_ss_size))
> -				return -ENOMEM;
> +				ret = -ENOMEM;
> +			if (!sigaltstack_size_valid(ss_size))
> +				ret = -ENOMEM;
>  		}
> -
> -		t->sas_ss_sp = (unsigned long) ss_sp;
> -		t->sas_ss_size = ss_size;
> -		t->sas_ss_flags = ss_flags;
> +		if (!ret) {
> +			t->sas_ss_sp = (unsigned long) ss_sp;
> +			t->sas_ss_size = ss_size;
> +			t->sas_ss_flags = ss_flags;
> +		}
> +		sigaltstack_unlock();
>  	}
> -	return 0;
> +	return ret;
>  }
>  
>  SYSCALL_DEFINE2(sigaltstack,const stack_t __user *,uss, stack_t __user *,uoss)
