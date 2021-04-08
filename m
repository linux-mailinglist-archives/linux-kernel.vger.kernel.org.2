Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02293587A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhDHO40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232009AbhDHO4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:56:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92784610F9;
        Thu,  8 Apr 2021 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617893768;
        bh=dRsg/D7XwR/Opxe8txb8yjZZERiYX9xCaPVknGOYM/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tl0OUXv79OcKikGGlNJj2e8yH3bMvRkH0zAVA5oaugYzD0d5iht0PzMb6yUGqwPKO
         DGb2+LJp9YQ0vSwttlDrL96mvidHI4XikDZfJLQ9yAggFwGsVoYGM/oAq8B48v1Uxp
         Xeu8SSezDPyc0m6z+m9ILzR1RHpAcXwYVhWynJeQKr+V1Q96qsO/Dp4W8jN7K4ae+z
         0qOzWEGKIcCn3FUk17iE4XupAf+PMZFR7vnFBiTfvPguisBBjmCahSWKq1pC3LtTVN
         KyI1uUcMOMaGNNvjCVQq5wsPRV7cN9XzDIkMNvpEuhyKoW+eFIWIkKWh8ISAXToJJ9
         Gixm1cMRz+72g==
Date:   Thu, 8 Apr 2021 15:56:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: mte: Move MTE TCF0 check in entry-common
Message-ID: <20210408145604.GB18211@willie-the-truck>
References: <20210408143723.13024-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408143723.13024-1-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 03:37:23PM +0100, Vincenzo Frascino wrote:
> The check_mte_async_tcf macro sets the TIF flag non-atomically. This can
> race with another CPU doing a set_tsk_thread_flag() and the flag can be
> lost in the process.

Actually, it's all the *other* flags that get lost!

> Move the tcf0 check to enter_from_user_mode() and clear tcf0 in
> exit_to_user_mode() to address the problem.
> 
> Note: Moving the check in entry-common allows to use set_thread_flag()
> which is safe.
> 
> Fixes: 637ec831ea4f ("arm64: mte: Handle synchronous and asynchronous
> tag check faults")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/mte.h     |  8 ++++++++
>  arch/arm64/kernel/entry-common.c |  6 ++++++
>  arch/arm64/kernel/entry.S        | 30 ------------------------------
>  arch/arm64/kernel/mte.c          | 25 +++++++++++++++++++++++--
>  4 files changed, 37 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 9b557a457f24..188f778c6f7b 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -31,6 +31,8 @@ void mte_invalidate_tags(int type, pgoff_t offset);
>  void mte_invalidate_tags_area(int type);
>  void *mte_allocate_tag_storage(void);
>  void mte_free_tag_storage(char *storage);
> +void check_mte_async_tcf0(void);
> +void clear_mte_async_tcf0(void);
>  
>  #ifdef CONFIG_ARM64_MTE
>  
> @@ -83,6 +85,12 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
>  {
>  	return -EIO;
>  }
> +void check_mte_async_tcf0(void)
> +{
> +}
> +void clear_mte_async_tcf0(void)
> +{
> +}
>  
>  static inline void mte_assign_mem_tag_range(void *addr, size_t size)
>  {
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 9d3588450473..837d3624a1d5 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -289,10 +289,16 @@ asmlinkage void noinstr enter_from_user_mode(void)
>  	CT_WARN_ON(ct_state() != CONTEXT_USER);
>  	user_exit_irqoff();
>  	trace_hardirqs_off_finish();
> +
> +	/* Check for asynchronous tag check faults in user space */
> +	check_mte_async_tcf0();
>  }

Is enter_from_user_mode() always called when we enter the kernel from EL0?
afaict, some paths (e.g. el0_irq()) only end up calling it if
CONTEXT_TRACKING or TRACE_IRQFLAGS are enabled.

>  
>  asmlinkage void noinstr exit_to_user_mode(void)
>  {
> +	/* Ignore asynchronous tag check faults in the uaccess routines */
> +	clear_mte_async_tcf0();
> +

and this one seems to be called even less often.

Will
