Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B7A428BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbhJKLCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235971AbhJKLCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:02:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72D4360EB4;
        Mon, 11 Oct 2021 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633950014;
        bh=vQIFuyPINjrBi0fIpVIivAP7Ib5rZs4uIJ6rAcpaTwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDqTb4Z1xe9+3UDiejqPqrsL04x+glEXFzdE7lgx1II8LiLA6PyJAjVinBCee/tWF
         Tb/0dn4/0yDEsO1vlnorgpxAJHaJOqWZDiHRbiaNZx3Lh3UsIHcCj51AfH9Yyg1vIf
         dSNplmLI6C2ziwrQZHTWQHdipz6SjMe5G94+MHbRkHuW1L8g8LdIewkhFJahS5Jnoh
         0Q6zvkWfJ/iLK1XOlEllbcwk2NKjpVTxOjuH8syvN3GMaYp5R6Yiv5h7C7YwRN3ye5
         6MSaC4iJj683V0JFcQnWbId7JcrdTv8OFabmeORKE63JDBewPdPxdnzkYchw7oyU7W
         gbSRyJiBfpNyg==
Date:   Mon, 11 Oct 2021 12:00:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 17/17] arm64: Add HWCAP for self-synchronising virtual
 counter
Message-ID: <20211011110008.GA4068@willie-the-truck>
References: <20211010114306.2910453-1-maz@kernel.org>
 <20211010114306.2910453-18-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010114306.2910453-18-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 12:43:06PM +0100, Marc Zyngier wrote:
> Since userspace can make use of the CNTVSS_EL0 instruction, expose
> it via a HWCAP.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  Documentation/arm64/elf_hwcaps.rst  | 4 ++++
>  arch/arm64/include/asm/hwcap.h      | 1 +
>  arch/arm64/include/uapi/asm/hwcap.h | 1 +
>  arch/arm64/kernel/cpufeature.c      | 3 ++-
>  arch/arm64/kernel/cpuinfo.c         | 1 +
>  5 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> index ec1a5a63c1d0..af106af8e1c0 100644
> --- a/Documentation/arm64/elf_hwcaps.rst
> +++ b/Documentation/arm64/elf_hwcaps.rst
> @@ -247,6 +247,10 @@ HWCAP2_MTE
>      Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
>      by Documentation/arm64/memory-tagging-extension.rst.
>  
> +HWCAP2_ECV
> +
> +    Functionality implied by ID_AA64MMFR0_EL1.ECV == 0b0001.
> +
>  4. Unused AT_HWCAP bits
>  -----------------------
>  
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 8c129db8232a..b100e0055eab 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -105,6 +105,7 @@
>  #define KERNEL_HWCAP_RNG		__khwcap2_feature(RNG)
>  #define KERNEL_HWCAP_BTI		__khwcap2_feature(BTI)
>  #define KERNEL_HWCAP_MTE		__khwcap2_feature(MTE)
> +#define KERNEL_HWCAP_ECV		__khwcap2_feature(ECV)
>  
>  /*
>   * This yields a mask that user programs can use to figure out what
> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
> index b8f41aa234ee..7b23b16f21ce 100644
> --- a/arch/arm64/include/uapi/asm/hwcap.h
> +++ b/arch/arm64/include/uapi/asm/hwcap.h
> @@ -75,5 +75,6 @@
>  #define HWCAP2_RNG		(1 << 16)
>  #define HWCAP2_BTI		(1 << 17)
>  #define HWCAP2_MTE		(1 << 18)
> +#define HWCAP2_ECV		(1 << 19)
>  
>  #endif /* _UAPI__ASM_HWCAP_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 26b11ce8fff6..97ed37c6ce5e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -279,7 +279,7 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ECV_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ECV_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_FGT_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_EXS_SHIFT, 4, 0),

This needs an update to Documentation/arm64/cpu-feature-registers.rst.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
