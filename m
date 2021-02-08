Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B45931404E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbhBHUWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:22:01 -0500
Received: from foss.arm.com ([217.140.110.172]:40446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235940AbhBHS52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:57:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A471D1042;
        Mon,  8 Feb 2021 10:56:42 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCE713F73D;
        Mon,  8 Feb 2021 10:56:40 -0800 (PST)
Date:   Mon, 8 Feb 2021 18:56:35 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v12 6/7] arm64: mte: Save/Restore TFSR_EL1 during suspend
Message-ID: <20210208185635.GA13187@e121166-lin.cambridge.arm.com>
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-7-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208165617.9977-7-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 04:56:16PM +0000, Vincenzo Frascino wrote:
> When MTE async mode is enabled TFSR_EL1 contains the accumulative
> asynchronous tag check faults for EL1 and EL0.
> 
> During the suspend/resume operations the firmware might perform some
> operations that could change the state of the register resulting in
> a spurious tag check fault report.
> 
> Save/restore the state of the TFSR_EL1 register during the
> suspend/resume operations to prevent this to happen.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/mte.h |  4 ++++
>  arch/arm64/kernel/mte.c      | 22 ++++++++++++++++++++++
>  arch/arm64/kernel/suspend.c  |  3 +++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 237bb2f7309d..2d79bcaaeb30 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -43,6 +43,7 @@ void mte_sync_tags(pte_t *ptep, pte_t pte);
>  void mte_copy_page_tags(void *kto, const void *kfrom);
>  void flush_mte_state(void);
>  void mte_thread_switch(struct task_struct *next);
> +void mte_suspend_enter(void);
>  void mte_suspend_exit(void);
>  long set_mte_ctrl(struct task_struct *task, unsigned long arg);
>  long get_mte_ctrl(struct task_struct *task);
> @@ -68,6 +69,9 @@ static inline void flush_mte_state(void)
>  static inline void mte_thread_switch(struct task_struct *next)
>  {
>  }
> +static inline void mte_suspend_enter(void)
> +{
> +}
>  static inline void mte_suspend_exit(void)
>  {
>  }
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 3332aabda466..5c440967721b 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -25,6 +25,7 @@
>  
>  u64 gcr_kernel_excl __ro_after_init;
>  
> +static u64 mte_suspend_tfsr_el1;

IIUC you need this per-CPU (core loses context on suspend-to-RAM but also
CPUidle, S2R is single threaded but CPUidle runs on every core idle
thread).

Unless you sync/report it on enter/exit (please note: I am not familiar
with MTE so it is just a, perhaps silly, suggestion to avoid
saving/restoring it).

Lorenzo

>  static bool report_fault_once = true;
>  
>  /* Whether the MTE asynchronous mode is enabled. */
> @@ -295,12 +296,33 @@ void mte_thread_switch(struct task_struct *next)
>  	mte_check_tfsr_el1();
>  }
>  
> +void mte_suspend_enter(void)
> +{
> +	if (!system_supports_mte())
> +		return;
> +
> +	/*
> +	 * The barriers are required to guarantee that the indirect writes
> +	 * to TFSR_EL1 are synchronized before we save the state.
> +	 */
> +	dsb(nsh);
> +	isb();
> +
> +	/* Save SYS_TFSR_EL1 before suspend entry */
> +	mte_suspend_tfsr_el1 = read_sysreg_s(SYS_TFSR_EL1);
> +}
> +
>  void mte_suspend_exit(void)
>  {
>  	if (!system_supports_mte())
>  		return;
>  
>  	update_gcr_el1_excl(gcr_kernel_excl);
> +
> +	/* Resume SYS_TFSR_EL1 after suspend exit */
> +	write_sysreg_s(mte_suspend_tfsr_el1, SYS_TFSR_EL1);
> +
> +	mte_check_tfsr_el1();
>  }
>  
>  long set_mte_ctrl(struct task_struct *task, unsigned long arg)
> diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
> index a67b37a7a47e..16caa9b32dae 100644
> --- a/arch/arm64/kernel/suspend.c
> +++ b/arch/arm64/kernel/suspend.c
> @@ -91,6 +91,9 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
>  	unsigned long flags;
>  	struct sleep_stack_data state;
>  
> +	/* Report any MTE async fault before going to suspend. */
> +	mte_suspend_enter();
> +
>  	/*
>  	 * From this point debug exceptions are disabled to prevent
>  	 * updates to mdscr register (saved and restored along with
> -- 
> 2.30.0
> 
