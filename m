Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF4343FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCVLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhCVLd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:33:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC56061984;
        Mon, 22 Mar 2021 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616412806;
        bh=6NU8CoeVuy+xBCKoKihnD9B6AGKpzEVVYiFH3UaLDyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcbvPInN/ygnKoUF6quhfsskpgiEr0UaC3QmE06DLMyacDxFWj+MwPETGfaf9kYGu
         zDo7TsVsbSvfUWsGBeSSHa9NyS/b4HH7jpnn3sLEfg//A5Eu11MfxLgCgLccuEy8l9
         HHFt9/qD3rDSNTFpTLaVB0DvvTqwAYO0/OH5HnZk97F8bkKwggzVb/95O5141sXFfJ
         ZsHoZoZBw546UT6xSQXDl3llEHxCXeuKrqtmzQP9SeREnlannavgbOwyGo22j6F608
         mMAMYez9XflctPuRnTyskBuBxYBCX38k0pvKQVqVymzOsx6ApySA67mKOWOgLMYPBh
         7lY6nKkCYnOXw==
Date:   Mon, 22 Mar 2021 11:33:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v6 33/38] KVM: arm64: Introduce KVM_PGTABLE_S2_IDMAP
 stage 2 flag
Message-ID: <20210322113320.GD10318@willie-the-truck>
References: <20210319100146.1149909-1-qperret@google.com>
 <20210319100146.1149909-34-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319100146.1149909-34-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:01:41AM +0000, Quentin Perret wrote:
> Introduce a new stage 2 configuration flag to specify that all mappings
> in a given page-table will be identity-mapped, as will be the case for
> the host. This allows to introduce sanity checks in the map path and to
> avoid programming errors.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 2 ++
>  arch/arm64/kvm/hyp/pgtable.c         | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 55452f4831d2..c3674c47d48c 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -60,9 +60,11 @@ struct kvm_pgtable_mm_ops {
>   * enum kvm_pgtable_stage2_flags - Stage-2 page-table flags.
>   * @KVM_PGTABLE_S2_NOFWB:	Don't enforce Normal-WB even if the CPUs have
>   *				ARM64_HAS_STAGE2_FWB.
> + * @KVM_PGTABLE_S2_IDMAP:	Only use identity mappings.
>   */
>  enum kvm_pgtable_stage2_flags {
>  	KVM_PGTABLE_S2_NOFWB			= BIT(0),
> +	KVM_PGTABLE_S2_IDMAP			= BIT(1),
>  };
>  
>  /**
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index b22b4860630c..c37c1dc4feaf 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -760,6 +760,9 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
>  		.arg		= &map_data,
>  	};
>  
> +	if (WARN_ON((pgt->flags & KVM_PGTABLE_S2_IDMAP) && (addr != phys)))
> +		return -EINVAL;

Acked-by: Will Deacon <will@kernel.org>

Will
