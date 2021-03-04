Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB61332DAC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhCDUB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237503AbhCDUBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:01:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5010A64F65;
        Thu,  4 Mar 2021 20:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614888051;
        bh=UH/6WrQiM34nfHG2XS5TT/G5/0kfI/kksSdM/0P/Kfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYR6f8cxrOMRb34jioQTsd1SLiLYV1KrLhOxoa/UFlla225aOMoeU9KLwametgZGX
         e5UxygIrCjFHk727snrTlAC+zc1THCyYWXRHNW6bhw920Ttnj9NCS5X2Ih+o5ALWVK
         8bzcdOJECfCuzr/vbSR1rZ8v1jVXMhWhNw+DbirPaQMEpoASd9ZqARx+ehcehxJknU
         SpENUYmOkDJnSdSwOWCMFlHYV9oxLgBfqvI9lx0K5oHBwfTbiME3Cs5py0GaxJAIlR
         biv8pRass1hSrt2fSlv8I3qPqJs7DpFaEMb2CjobCejwGpfx5/2Bf8XJ5QX/3hqHDq
         ZjtqlYWz2nibg==
Date:   Thu, 4 Mar 2021 20:00:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 26/32] KVM: arm64: Introduce PROT_NONE mappings for
 stage 2
Message-ID: <20210304200044.GF21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-27-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-27-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:56PM +0000, Quentin Perret wrote:
> Once we start unmapping portions of memory from the host stage 2 (such
> as e.g. the hypervisor memory sections, or pages that belong to
> protected guests), we will need a way to track page ownership. And
> given that all mappings in the host stage 2 will be identity-mapped, we
> can use the host stage 2 page-table itself as a simplistic rmap.
> 
> As a first step towards this, introduce a new protection attribute
> in the stage 2 page table code, called KVM_PGTABLE_PROT_NONE, which
> allows to annotate portions of the IPA space as inaccessible. For
> simplicity, PROT_NONE mappings are created as invalid mappings with a
> software bit set.

Just as an observation, but given that they're invalid we can use any bit
from [63:2] to indicate that it's a PROT_NONE mapping, and that way we
can keep the real "software bits" for live mappings.

But we can of course change that later when we need the bit for something
else.

> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h |  2 ++
>  arch/arm64/kvm/hyp/pgtable.c         | 26 ++++++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 9935dbae2cc1..c9f6ed76e0ad 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -80,6 +80,7 @@ struct kvm_pgtable {
>   * @KVM_PGTABLE_PROT_W:		Write permission.
>   * @KVM_PGTABLE_PROT_R:		Read permission.
>   * @KVM_PGTABLE_PROT_DEVICE:	Device attributes.
> + * @KVM_PGTABLE_PROT_NONE:	No permission.
>   */
>  enum kvm_pgtable_prot {
>  	KVM_PGTABLE_PROT_X			= BIT(0),
> @@ -87,6 +88,7 @@ enum kvm_pgtable_prot {
>  	KVM_PGTABLE_PROT_R			= BIT(2),
>  
>  	KVM_PGTABLE_PROT_DEVICE			= BIT(3),
> +	KVM_PGTABLE_PROT_NONE			= BIT(4),

Why do we need an extra entry here? Couldn't we just create PROT_NONE
entries when none of R,W or X are set?

>  };
>  
>  #define PAGE_HYP		(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index bdd6e3d4eeb6..8e7059fcfd40 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -48,6 +48,8 @@
>  					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
>  					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
>  
> +#define KVM_PTE_LEAF_SW_BIT_PROT_NONE	BIT(55)
> +
>  struct kvm_pgtable_walk_data {
>  	struct kvm_pgtable		*pgt;
>  	struct kvm_pgtable_walker	*walker;
> @@ -120,6 +122,16 @@ static bool kvm_pte_valid(kvm_pte_t pte)
>  	return pte & KVM_PTE_VALID;
>  }
>  
> +static bool kvm_pte_prot_none(kvm_pte_t pte)
> +{
> +	return pte & KVM_PTE_LEAF_SW_BIT_PROT_NONE;
> +}

I think it would be a good idea to check !kvm_pte_valid() in here too,
since it doesn't make sense to report true for valid (or table) entries.

Will
