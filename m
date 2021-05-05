Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616D93746EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbhEERdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:33:25 -0400
Received: from foss.arm.com ([217.140.110.172]:49074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238688AbhEERbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:31:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E25811FB;
        Wed,  5 May 2021 10:30:19 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.28.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0D03F70D;
        Wed,  5 May 2021 10:30:17 -0700 (PDT)
Date:   Wed, 5 May 2021 18:30:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: syscall.h: Add sign extension handling in
 syscall_get_return_value for compat
Message-ID: <20210505173014.GE5605@C02TD0UTHF1T.local>
References: <20210423103533.30121-1-zhe.he@windriver.com>
 <20210423103533.30121-2-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423103533.30121-2-zhe.he@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 23, 2021 at 06:35:32PM +0800, He Zhe wrote:
> Add sign extension handling in syscall_get_return_value so that it can
> handle 32-bit compatible case and can be used by for example audit, just
> like what syscall_get_error does.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v1 to v2: Improve error code check suggested by Mark
> 
>  arch/arm64/include/asm/syscall.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> index cfc0672013f6..c3b5fca82ff4 100644
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -44,7 +44,20 @@ static inline long syscall_get_error(struct task_struct *task,
>  static inline long syscall_get_return_value(struct task_struct *task,
>  					    struct pt_regs *regs)
>  {
> -	return regs->regs[0];
> +	long val = regs->regs[0];
> +	long error = val;
> +
> +	if (compat_user_mode(regs))
> +		error = sign_extend64(error, 31);
> +
> +	/*
> +	 * Return codes with bit 31 set may or may not be an error code.
> +	 * For example, mmap may return a legal 32 bit address with bit 31 set
> +	 * for 32 bit thread, in which case the untouched val should be
> +	 * returned. Otherwise, the sign-extended error should be returned if
> +	 * it still falls in error number range.
> +	 */
> +	return IS_ERR_VALUE(error) ? error : val;

I'm afraid I have misled you here.

I wrote up a test that uses PTRACE_GET_SYSCALL_INFO, and I found that on
a 32-bit arm (v5.12) kernel, *all* syscall return values get
sign-extended after all. For example, if (on a 32-bit kernel) I use
MAP_FIXED to mmap() at address 0x8bad0000, the return value reported in
ptrace_syscall_info::exit::rval is 0xffffffff8bad0000.

So for that we shoudn't have the IS_ERR_VALUE() check after all, but I'm
not currently sure whether there are other cases where 32-bit arm
wouldn't sign-extend, and I think we'll need to dig into this some more.

Thanks,
Mark.
