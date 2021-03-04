Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A867232DACF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbhCDUEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:04:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238058AbhCDUEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:04:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 352FE64F65;
        Thu,  4 Mar 2021 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614888221;
        bh=U98Si46P9QGICBUxtNMdo2gi+WMxJtL8qV9OiXNLz/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4gN8l38meTixs38uXpwshwzF5+yHfcTiLAS+WdCPLbxYXrlkbU8LnAcwsYLd8HZn
         FPczhctWD+SdQO4jwsx5UhtC2onXyL5dt/nrLzLpt4CMLx+RTCAMK++uqcogKDeaPe
         kqynj+Kb7qnAO7rJjCWuPASACOtt2/Q0m7aQSKKuBf5VvZxBh5Dl0DstNLJtBcMhJl
         21a5SCZ83VWuZ/8+eOtKUadSKTbDPzJK7iIrYAKl2hRvY+CAmiz0wj7y+uiGLgn1VQ
         62YQbH0sgziQWESXpm/kU5XlICQSWxeFyPeS71LfQ8uf82+/Qaj4Pco/qlfRx5dBff
         2NqXoQCem14IA==
Date:   Thu, 4 Mar 2021 20:03:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 27/32] KVM: arm64: Refactor stage2_map_set_prot_attr()
Message-ID: <20210304200335.GG21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-28-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-28-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:57PM +0000, Quentin Perret wrote:
> In order to ease its re-use in other code paths, refactor
> stage2_map_set_prot_attr() to not depend on a stage2_map_data struct.
> No functional change intended.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 8e7059fcfd40..8aa01a9e2603 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -494,8 +494,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
>  	return vtcr;
>  }
>  
> -static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
> -				    struct stage2_map_data *data)
> +static kvm_pte_t stage2_get_prot_attr(enum kvm_pgtable_prot prot)
>  {
>  	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
>  	kvm_pte_t attr = device ? PAGE_S2_MEMATTR(DEVICE_nGnRE) :
> @@ -504,15 +503,15 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
>  
>  	if (prot & KVM_PGTABLE_PROT_NONE) {
>  		if (prot != KVM_PGTABLE_PROT_NONE)
> -			return -EINVAL;
> +			return 0;

Hmm, does the architecture actually say that having all these attributes
as 0 is illegal? If not, I think it would be better to keep the int return
code and replace the 'data' parameter with a pointer to a kvm_pte_t.

Does that work?

Will
