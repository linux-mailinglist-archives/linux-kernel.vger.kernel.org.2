Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FF033C1FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhCOQdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233570AbhCOQdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:33:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1A4664E42;
        Mon, 15 Mar 2021 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615826008;
        bh=f4K1PQi5GoA8DyancBzvuA/NuLTUjdftl7M7gxwy1No=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjR/pS1cN3N97EsHHqVbRHIBpoeGPaSsRmHGYdei+80OM7tDfbC1i28OhSuN6mh3e
         el0hMbHrqnIr7uMJfvqUWvkl6ZWIsYs7xuEvtZA+virmRuz8lnOTQDvyi4Bz3iB1PU
         sb8UCVALUTP17F3wvYYCzD/GfJpxTi3tiPShtzvB6jKwi/GJFp0fGwRvOzacFJQWLG
         cdwk6YxVlVYVtn0c6AaW99h4Ccx0UvP4R40QO03FMjcwqYHdvXusB5yWCemYBotqCy
         fJQHP4Wd7rrcs6Rjfqp7Xc9Gb2uKyN1H1ckKf1Lf4Y86ol/YwKwUZisOzJy3fPZ/uP
         wsfFBPi3b+O2A==
Date:   Mon, 15 Mar 2021 16:33:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v5 14/36] KVM: arm64: Provide __flush_dcache_area at EL2
Message-ID: <20210315163322.GE3430@willie-the-truck>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-15-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315143536.214621-15-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 02:35:14PM +0000, Quentin Perret wrote:
> We will need to do cache maintenance at EL2 soon, so compile a copy of
> __flush_dcache_area at EL2, and provide a copy of arm64_ftr_reg_ctrel0
> as it is needed by the read_ctr macro.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_cpufeature.h |  2 ++
>  arch/arm64/kvm/hyp/nvhe/Makefile        |  3 ++-
>  arch/arm64/kvm/hyp/nvhe/cache.S         | 13 +++++++++++++
>  arch/arm64/kvm/sys_regs.c               |  1 +
>  4 files changed, 18 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S
> 
> diff --git a/arch/arm64/include/asm/kvm_cpufeature.h b/arch/arm64/include/asm/kvm_cpufeature.h
> index 3fd9f60d2180..efba1b89b8a4 100644
> --- a/arch/arm64/include/asm/kvm_cpufeature.h
> +++ b/arch/arm64/include/asm/kvm_cpufeature.h
> @@ -13,3 +13,5 @@
>  #define KVM_HYP_CPU_FTR_REG(name) extern struct arm64_ftr_reg kvm_nvhe_sym(name)
>  #endif
>  #endif
> +
> +KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_ctrel0);

I still think this is a bit weird. If you really want to macro-ise stuff,
then why not follow the sort of thing we do for e.g. per-cpu variables and
have separate DECLARE_HYP_CPU_FTR_REG and DEFINE_HYP_CPU_FTR_REG macros.

That way kvm_cpufeature.h can have header guards like a normal header and
we can drop the '#ifndef KVM_HYP_CPU_FTR_REG' altogether. I don't think
the duplication of the symbol name really matters -- it should fail at
build time if something is missing.

Will
