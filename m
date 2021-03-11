Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7D5337CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhCKSsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhCKSsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:48:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDD2C64FE0;
        Thu, 11 Mar 2021 18:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615488523;
        bh=jfHJ6GOVhZbFPLB88QSrQHoY4MrIIb7+F7at5DPxqfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKq3LDOC6iUDoX4UfIVEKIMc4PLQXkbXbD0c0GfgtcYH97EDMe1hFsWaGx3W6WiJE
         oyd3jp8e4QHLIf3ZnsS0Sp4ClcCEFwzI1bFrZduWlcC5cs6pNv3CQAzw5ZfkTIxv5Y
         L6JohplRajSKs2nJGlaFWZjIhLSwb6Vc8QMjRs4h8uVxwpBMs35KqnMx4yWCP3emfF
         CCPs/cyNOEKyF/RqxhceU/w28G7yZlvr7kBe1H4FaUr/OM298ZNXgbQ4Qz4AIbVHqZ
         jN3bmP6QR/fvcbPLpUfhbyXthseEmB2D3vgkSAopIpYIEdmTwdjyX5KQpb6hy/8g6+
         H1XwUr1dbURhg==
Date:   Thu, 11 Mar 2021 18:48:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 29/34] KVM: arm64: Refactor stage2_map_set_prot_attr()
Message-ID: <20210311184836.GA31586@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-30-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-30-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:57:46PM +0000, Quentin Perret wrote:
> In order to ease its re-use in other code paths, refactor
> stage2_map_set_prot_attr() to not depend on a stage2_map_data struct.
> No functional change intended.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index e4670b639726..c16e0306dd9a 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -489,8 +489,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
>  	return vtcr;
>  }
>  
> -static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
> -				    struct stage2_map_data *data)
> +static int stage2_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
>  {
>  	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
>  	kvm_pte_t attr = device ? PAGE_S2_MEMATTR(DEVICE_nGnRE) :
> @@ -510,7 +509,8 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
>  
>  	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
>  	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
> -	data->attr = attr;
> +	*ptep = attr;
> +
>  	return 0;
>  }
>  
> @@ -728,7 +728,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
>  		.arg		= &map_data,
>  	};
>  
> -	ret = stage2_map_set_prot_attr(prot, &map_data);
> +	ret = stage2_set_prot_attr(prot, &map_data.attr);
>  	if (ret)
>  		return ret;

(nit: this is now different to hyp_map_set_prot_attr() -- can we do the same
thing there, please?)

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
