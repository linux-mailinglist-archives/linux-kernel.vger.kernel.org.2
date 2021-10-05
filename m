Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CA4223B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhJEKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:43:31 -0400
Received: from foss.arm.com ([217.140.110.172]:43248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233077AbhJEKna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:43:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E00CD6D;
        Tue,  5 Oct 2021 03:41:39 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C56AF3F766;
        Tue,  5 Oct 2021 03:41:34 -0700 (PDT)
Date:   Tue, 5 Oct 2021 11:41:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        samitolvanen@google.com, ben.dai@unisoc.com, nathan@kernel.org,
        keescook@chromium.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ftrace: use function_nocfi for _mcount as well
Message-ID: <20211005104131.GB1664@C02TD0UTHF1T.local>
References: <20211005103208.2763305-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005103208.2763305-1-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 04:02:08PM +0530, Sumit Garg wrote:
> Commit 800618f955a9 ("arm64: ftrace: use function_nocfi for ftrace_call")
> only fixed address of ftrace_call but address of _mcount needs to be
> fixed as well. Use function_nocfi() to get the actual address of _mcount
> function as with CONFIG_CFI_CLANG, the compiler replaces function pointers
> with jump table addresses which breaks dynamic ftrace as the address of
> _mcount is replaced with the address of _mcount.cfi_jt.

It might be worth noting that where the toolchain implements
patchable-function-entry, we'll use that in preference to regular -pg,
and this problem won't apply. i.e. this won't show with recent versions
of clang.

> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

This probably wants:

Fixes: 9186ad8e66bab6a1 ("arm64: allow CONFIG_CFI_CLANG to be selected")

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/ftrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 91fa4baa1a93..347b0cc68f07 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -15,7 +15,7 @@
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  #define ARCH_SUPPORTS_FTRACE_OPS 1
>  #else
> -#define MCOUNT_ADDR		((unsigned long)_mcount)
> +#define MCOUNT_ADDR		((unsigned long)function_nocfi(_mcount))
>  #endif
>  
>  /* The BL at the callsite's adjusted rec->ip */
> -- 
> 2.17.1
> 
