Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7096A436455
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhJUOfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:35:24 -0400
Received: from foss.arm.com ([217.140.110.172]:43422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231404AbhJUOfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:35:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90B06D6E;
        Thu, 21 Oct 2021 07:33:06 -0700 (PDT)
Received: from [10.57.22.27] (unknown [10.57.22.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 524323F73D;
        Thu, 21 Oct 2021 07:33:04 -0700 (PDT)
Subject: Re: [RFCv1 1/4] arm64: Use static key for tracing PID in CONTEXTIDR
To:     Leo Yan <leo.yan@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-2-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <53962765-53b9-dfdc-a5b2-a3133a924c12@arm.com>
Date:   Thu, 21 Oct 2021 15:33:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021134530.206216-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/10/2021 14:45, Leo Yan wrote:
> The kernel provides CONFIG_PID_IN_CONTEXTIDR for tracing PID into system
> register CONTEXTIDR; we need to statically enable this configuration
> when build kernel image to use this feature.
> 
> On the other hand, hardware tracing modules (e.g. Arm CoreSight, SPE,
> etc) rely on this feature to provide context info in their tracing data.
> If kernel has not enabled configuration CONFIG_PID_IN_CONTEXTIDR, then
> tracing modules have no chance to capture PID related info.
> 
> This patch introduces static key for tracing PID in CONTEXTIDR, it
> provides a possibility for device driver to dynamically enable and
> disable tracing PID into CONTEXTIDR as needed.
> 
> As the first step, the kernel increases the static key if
> CONFIG_PID_IN_CONTEXTIDR is enabled when booting kernel, in this case
> kernel will always trace PID into CONTEXTIDR at the runtime.  This means
> before and after applying this patch, the semantics for
> CONFIG_PID_IN_CONTEXTIDR are consistent.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/include/asm/mmu_context.h |  4 +++-
>  arch/arm64/kernel/process.c          | 11 +++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index f4ba93d4ffeb..e1f33616f83a 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -26,9 +26,11 @@
>  
>  extern bool rodata_full;
>  
> +DECLARE_STATIC_KEY_FALSE(contextidr_in_use);
> +
>  static inline void contextidr_thread_switch(struct task_struct *next)
>  {
> -	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
> +	if (!static_branch_unlikely(&contextidr_in_use))
>  		return;
>  
>  	write_sysreg(task_pid_nr(next), contextidr_el1);
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 40adb8cdbf5a..d744c0c7e4c4 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -61,6 +61,9 @@ unsigned long __stack_chk_guard __ro_after_init;
>  EXPORT_SYMBOL(__stack_chk_guard);
>  #endif
>  
> +DEFINE_STATIC_KEY_FALSE(contextidr_in_use);
> +EXPORT_SYMBOL_GPL(contextidr_in_use);
> +
>  /*
>   * Function pointers to optional machine specific functions
>   */
> @@ -721,3 +724,11 @@ int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
>  	return prot;
>  }
>  #endif
> +
> +static int __init contextidr_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
> +		static_branch_inc(&contextidr_in_use);
> +	return 0;
> +}
> +early_initcall(contextidr_init);

Hi Leo,

Can you skip this early_initcall() part if you do something like this:

    DECLARE_STATIC_KEY_MAYBE(CONFIG_PID_IN_CONTEXTIDR, contextidr_in_use)

It seems like there is a way to conditionally initialise it to true.

James

