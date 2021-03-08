Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697BA330AD2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhCHKGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:06:38 -0500
Received: from foss.arm.com ([217.140.110.172]:35286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231664AbhCHKGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:06:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12FCD31B;
        Mon,  8 Mar 2021 02:06:06 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C5E43F73C;
        Mon,  8 Mar 2021 02:06:04 -0800 (PST)
Date:   Mon, 8 Mar 2021 10:06:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/11] kentry: Make entry/exit_to_user_mode()
 arm64-only
Message-ID: <20210308100602.GC7951@C02TD0UTHF1T.local>
References: <cover.1614884673.git.luto@kernel.org>
 <e8ad39b0e268caec5cc9ff52371438badedd0737.1614884673.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ad39b0e268caec5cc9ff52371438badedd0737.1614884673.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 11:06:00AM -0800, Andy Lutomirski wrote:
> exit_to_user_mode() does part, but not all, of the exit-to-user-mode work.
> It's used only by arm64, and arm64 should stop using it (hint, hint!).
> Compile it out on other architectures to minimize the chance of error.

For context, I do plan to move over, but there's a reasonable amount of
preparatory work needed first (e.g. factoring out the remaining asm
entry points, and reworking our pseudo-NMI management to play nicely
with the common entry code).

> enter_from_user_mode() is a legacy way to spell
> kentry_enter_from_user_mode().  It's also only used by arm64.  Give it
> the same treatment.

I think you can remove these entirely, no ifdeferry necessary.

Currently arm64 cannot select CONFIG_GENERIC_ENTRY, so we open-code
copies of these in arch/arm64/kernel/entry-common.c, and doesn't use
these common versions at all. When we move over to the common code we
can move directly to the kentry_* versions. If we are relying on the
prototypes anywhere, that's a bug as of itself.

In retrospect I probably should have given our local copies an arm64_*
prefix. If I can't get rid of them soon I'll add that to lessen the
scope for confusion.

Mark.

> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  include/linux/entry-common.h | 34 ++++++----------------------------
>  kernel/entry/common.c        |  4 ++++
>  2 files changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 5287c6c15a66..a75374f87258 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -97,26 +97,15 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
>  }
>  #endif
>  
> +#ifdef CONFIG_ARM64
>  /**
>   * enter_from_user_mode - Establish state when coming from user mode
>   *
> - * Syscall/interrupt entry disables interrupts, but user mode is traced as
> - * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
> + * Legacy variant of kentry_enter_from_user_mode().  Used only by arm64.
>   *
> - * 1) Tell lockdep that interrupts are disabled
> - * 2) Invoke context tracking if enabled to reactivate RCU
> - * 3) Trace interrupts off state
> - *
> - * Invoked from architecture specific syscall entry code with interrupts
> - * disabled. The calling code has to be non-instrumentable. When the
> - * function returns all state is correct and interrupts are still
> - * disabled. The subsequent functions can be instrumented.
> - *
> - * This is invoked when there is architecture specific functionality to be
> - * done between establishing state and enabling interrupts. The caller must
> - * enable interrupts before invoking syscall_enter_from_user_mode_work().
>   */
>  void enter_from_user_mode(struct pt_regs *regs);
> +#endif
>  
>  /**
>   * kentry_syscall_begin - Prepare to invoke a syscall handler
> @@ -261,25 +250,14 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
>  }
>  #endif
>  
> +#ifdef CONFIG_ARM64
>  /**
>   * exit_to_user_mode - Fixup state when exiting to user mode
>   *
> - * Syscall/interrupt exit enables interrupts, but the kernel state is
> - * interrupts disabled when this is invoked. Also tell RCU about it.
> - *
> - * 1) Trace interrupts on state
> - * 2) Invoke context tracking if enabled to adjust RCU state
> - * 3) Invoke architecture specific last minute exit code, e.g. speculation
> - *    mitigations, etc.: arch_exit_to_user_mode()
> - * 4) Tell lockdep that interrupts are enabled
> - *
> - * Invoked from architecture specific code when syscall_exit_to_user_mode()
> - * is not suitable as the last step before returning to userspace. Must be
> - * invoked with interrupts disabled and the caller must be
> - * non-instrumentable.
> - * The caller has to invoke syscall_exit_to_user_mode_work() before this.
> + * Does the latter part of irqentry_exit_to_user_mode().  Only used by arm64.
>   */
>  void exit_to_user_mode(void);
> +#endif
>  
>  /**
>   * kentry_syscall_end - Finish syscall processing
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 800ad406431b..4ba82c684189 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -25,10 +25,12 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
>  	instrumentation_end();
>  }
>  
> +#ifdef CONFIG_ARM64
>  void noinstr enter_from_user_mode(struct pt_regs *regs)
>  {
>  	__enter_from_user_mode(regs);
>  }
> +#endif
>  
>  static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
>  {
> @@ -106,10 +108,12 @@ static __always_inline void __exit_to_user_mode(void)
>  	lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  
> +#ifdef CONFIG_ARM64
>  void noinstr exit_to_user_mode(void)
>  {
>  	__exit_to_user_mode();
>  }
> +#endif
>  
>  /* Workaround to allow gradual conversion of architecture code */
>  void __weak arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal) { }
> -- 
> 2.29.2
> 
