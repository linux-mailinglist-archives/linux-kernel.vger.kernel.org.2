Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3D30D908
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhBCLn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:43:29 -0500
Received: from foss.arm.com ([217.140.110.172]:38462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234461AbhBCLmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:42:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23E9ED6E;
        Wed,  3 Feb 2021 03:42:04 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.11.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C57863F719;
        Wed,  3 Feb 2021 03:42:01 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:41:58 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        jeyu@kernel.org, keescook@chromium.org, vincenzo.frascino@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64/kernel: improve the coding style
Message-ID: <20210203114158.GD55896@C02TD0UTHF1T.local>
References: <1612331299-21127-1-git-send-email-daizhiyuan@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612331299-21127-1-git-send-email-daizhiyuan@phytium.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:48:19PM +0800, Zhiyuan Dai wrote:
> Just improve the coding style.
> 
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>

This is terse and doesn't tell the reader what to expect. It would be
better to say something more specific, e.g.

| arm64: improve whitespace
|
| In a few places we don't have whitespace between macro parameters,
| which makes them hard to read. This patch adds whitespace to clearly
| separate the parameters.
|
| In a few places we have unnecessary whitespace around unary operators,
| which is confusing, This patch removes the unnecessary whitespace.

... which more clearly justifies the change.

The patch itself looks sane to me (and the unary operator cleanup is
certianly nice), so with that wording:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/kernel/alternative.c | 2 +-
>  arch/arm64/kernel/module-plts.c | 2 +-
>  arch/arm64/kernel/perf_event.c  | 2 +-
>  arch/arm64/kernel/process.c     | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index a57cffb..1184c44 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -17,7 +17,7 @@
>  #include <asm/sections.h>
>  #include <linux/stop_machine.h>
>  
> -#define __ALT_PTR(a,f)		((void *)&(a)->f + (a)->f)
> +#define __ALT_PTR(a, f)		((void *)&(a)->f + (a)->f)
>  #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
>  #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
>  
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 2e22443..e53493d 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -131,7 +131,7 @@ u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
>  }
>  #endif
>  
> -#define cmp_3way(a,b)	((a) < (b) ? -1 : (a) > (b))
> +#define cmp_3way(a, b)	((a) < (b) ? -1 : (a) > (b))
>  
>  static int cmp_rela(const void *a, const void *b)
>  {
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 3605f77a..d1fec4a 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -810,7 +810,7 @@ static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
>  {
>  	int idx;
>  
> -	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; idx ++) {
> +	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; idx++) {
>  		if (!test_and_set_bit(idx, cpuc->used_mask))
>  			return idx;
>  	}
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 6616486..4cc1ccc 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -304,7 +304,7 @@ void __show_regs(struct pt_regs *regs)
>  	}
>  }
>  
> -void show_regs(struct pt_regs * regs)
> +void show_regs(struct pt_regs *regs)
>  {
>  	__show_regs(regs);
>  	dump_backtrace(regs, NULL, KERN_DEFAULT);
> @@ -587,7 +587,7 @@ unsigned long get_wchan(struct task_struct *p)
>  			ret = frame.pc;
>  			goto out;
>  		}
> -	} while (count ++ < 16);
> +	} while (count++ < 16);
>  
>  out:
>  	put_task_stack(p);
> -- 
> 1.8.3.1
> 
