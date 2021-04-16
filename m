Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE399361FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhDPMdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234291AbhDPMdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:33:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67EF2610E6;
        Fri, 16 Apr 2021 12:33:25 +0000 (UTC)
Date:   Fri, 16 Apr 2021 13:33:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     oleg@redhat.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/3] arm64: ptrace: Add is_syscall_success to handle
 compat
Message-ID: <20210416123322.GA23184@arm.com>
References: <20210416075533.7720-1-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416075533.7720-1-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:55:31PM +0800, He Zhe wrote:
> The general version of is_syscall_success does not handle 32-bit
> compatible case, which would cause 32-bit negative return code to be
> recoganized as a positive number later and seen as a "success".
> 
> Since is_compat_thread is defined in compat.h, implementing
> is_syscall_success in ptrace.h would introduce build failure due to
> recursive inclusion of some basic headers like mutex.h. We put the
> implementation to ptrace.c
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  arch/arm64/include/asm/ptrace.h |  3 +++
>  arch/arm64/kernel/ptrace.c      | 10 ++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index e58bca832dff..3c415e9e5d85 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -328,6 +328,9 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
>  	regs->regs[0] = rc;
>  }
>  
> +extern inline int is_syscall_success(struct pt_regs *regs);
> +#define is_syscall_success(regs) is_syscall_success(regs)
> +
>  /**
>   * regs_get_kernel_argument() - get Nth function argument in kernel
>   * @regs:	pt_regs of that context
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 170f42fd6101..3266201f8c60 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -1909,3 +1909,13 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
>  	else
>  		return valid_native_regs(regs);
>  }
> +
> +inline int is_syscall_success(struct pt_regs *regs)
> +{
> +	unsigned long val = regs->regs[0];
> +
> +	if (is_compat_thread(task_thread_info(current)))
> +		val = sign_extend64(val, 31);
> +
> +	return !IS_ERR_VALUE(val);
> +}

It's better to use compat_user_mode(regs) here instead of
is_compat_thread(). It saves us from worrying whether regs are for the
current context.

I think we should change regs_return_value() instead. This function
seems to be called from several other places and it has the same
potential problems if called on compat pt_regs.

-- 
Catalin
