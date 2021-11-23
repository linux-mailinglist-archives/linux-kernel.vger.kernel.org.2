Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7380745A423
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbhKWN5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:57:01 -0500
Received: from foss.arm.com ([217.140.110.172]:52886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231603AbhKWN5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:57:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ACC11042;
        Tue, 23 Nov 2021 05:53:52 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4855D3F66F;
        Tue, 23 Nov 2021 05:53:51 -0800 (PST)
Date:   Tue, 23 Nov 2021 13:53:49 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com
Subject: Re: [RFC][PATCH 1/6] x86: Annotate _THIS_IP_
Message-ID: <20211123135348.GE37253@lakrids.cambridge.arm.com>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.025419814@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122170805.025419814@infradead.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 06:03:02PM +0100, Peter Zijlstra wrote:
> In order to find _THIS_IP_ code references in objtool, annotate them.

Just to check my understanding, IIUC this is because in later patches
you'll look at text relocations to spot missing ENDBRs, and when doing
so you need to filter out _THIS_IP_ instances, since those don't need an
ENDBR. Is that right?

Just checking I haven't missed some other concern that might apply to
arm64's BTI (Branch Target Identifier), which are analagous to ENDBR.

Thanks,
Mark.

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/linkage.h      |   11 +++++++++++
>  include/linux/instruction_pointer.h |    5 +++++
>  2 files changed, 16 insertions(+)
> 
> --- a/arch/x86/include/asm/linkage.h
> +++ b/arch/x86/include/asm/linkage.h
> @@ -3,10 +3,21 @@
>  #define _ASM_X86_LINKAGE_H
>  
>  #include <linux/stringify.h>
> +#include <asm/asm.h>
>  
>  #undef notrace
>  #define notrace __attribute__((no_instrument_function))
>  
> +#define _THIS_IP_						\
> +	({	__label__ __here;				\
> +		__here:						\
> +		asm_volatile_goto (				\
> +		    ".pushsection .discard.this_ip\n\t"		\
> +		    _ASM_PTR " %l[__here]\n\t"			\
> +		    ".popsection\n\t"				\
> +		    : : : : __here);				\
> +		(unsigned long)&&__here; })
> +
>  #ifdef CONFIG_X86_32
>  #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
>  #endif /* CONFIG_X86_32 */
> --- a/include/linux/instruction_pointer.h
> +++ b/include/linux/instruction_pointer.h
> @@ -2,7 +2,12 @@
>  #ifndef _LINUX_INSTRUCTION_POINTER_H
>  #define _LINUX_INSTRUCTION_POINTER_H
>  
> +#include <asm/linkage.h>
> +
>  #define _RET_IP_		(unsigned long)__builtin_return_address(0)
> +
> +#ifndef _THIS_IP_
>  #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
> +#endif
>  
>  #endif /* _LINUX_INSTRUCTION_POINTER_H */
> 
> 
