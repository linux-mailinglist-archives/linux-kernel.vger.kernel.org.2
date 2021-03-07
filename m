Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4626832FEAD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 05:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCGEgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 23:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhCGEfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 23:35:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56F4A650B1;
        Sun,  7 Mar 2021 04:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615091750;
        bh=bGnLAzbseG7Hvf7WtaKuqW98AvCQaRA0f3+tjl5et9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFwb35J2J3JEUCV2LRfNrkdeFOfSy4v9lut+kKnrsezWVzqi7r4QweZekd8H9ONh5
         Cn6vKiY2baFCmc18EBSCXD1sfuitp7kpTY5IOMdDQ449mxPdO6OrOemiSREy0cQT7f
         11MkmSdeLdGyO5WiAv/NBsolD6PLwg8fm4DVlzmHwQtQ3ZlyOk2K2O7LYuf5QpYRP0
         9DAA2Kahj0yKcN+hCBl81TFzC6qgWmyqe/8qgYooCNNtSRw/jOetQXT/LbzSzNpuSh
         0TIvkSblicdnSpUtsr4ZYqfBiuMfd8P4Wmh+he7JxvDHNL5YxWfy6NY8zKWtuLTc13
         oO7CIDNN2otAg==
Date:   Sat, 6 Mar 2021 21:35:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Don't use cbz/adr with external symbols
Message-ID: <20210307043545.pyxy22z3rktgof4m@archlinux-ax161>
References: <20210305202124.3768527-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305202124.3768527-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 12:21:24PM -0800, Sami Tolvanen wrote:
> allmodconfig + CONFIG_LTO_CLANG_THIN=y fails to build due to following
> linker errors:
> 
>   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21CC):
>   relocation R_AARCH64_CONDBR19 out of range: 2031220 is not in
>   [-1048576, 1048575]; references hyp_panic
>   >>> defined in vmlinux.o
> 
>   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21E0):
>   relocation R_AARCH64_ADR_PREL_LO21 out of range: 2031200 is not in
>   [-1048576, 1048575]; references hyp_panic
>   >>> defined in vmlinux.o
> 
> This is because with LTO, the compiler ends up placing hyp_panic()
> more than 1MB away from __guest_enter(). Use an unconditional branch
> and adr_l instead to fix the issue.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1317
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I booted an kernel with this patch in it on my Raspberry Pi 4 and booted
a kernel under KVM without any issues.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/arm64/kvm/hyp/entry.S | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
> index b0afad7a99c6..c62265951467 100644
> --- a/arch/arm64/kvm/hyp/entry.S
> +++ b/arch/arm64/kvm/hyp/entry.S
> @@ -85,8 +85,10 @@ SYM_INNER_LABEL(__guest_exit_panic, SYM_L_GLOBAL)
>  
>  	// If the hyp context is loaded, go straight to hyp_panic
>  	get_loaded_vcpu x0, x1
> -	cbz	x0, hyp_panic
> +	cbnz	x0, 1f
> +	b	hyp_panic
>  
> +1:
>  	// The hyp context is saved so make sure it is restored to allow
>  	// hyp_panic to run at hyp and, subsequently, panic to run in the host.
>  	// This makes use of __guest_exit to avoid duplication but sets the
> @@ -94,7 +96,7 @@ SYM_INNER_LABEL(__guest_exit_panic, SYM_L_GLOBAL)
>  	// current state is saved to the guest context but it will only be
>  	// accurate if the guest had been completely restored.
>  	adr_this_cpu x0, kvm_hyp_ctxt, x1
> -	adr	x1, hyp_panic
> +	adr_l	x1, hyp_panic
>  	str	x1, [x0, #CPU_XREG_OFFSET(30)]
>  
>  	get_vcpu_ptr	x1, x0
> 
> base-commit: 280d542f6ffac0e6d65dc267f92191d509b13b64
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
