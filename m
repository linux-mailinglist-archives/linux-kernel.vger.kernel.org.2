Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B95632F39D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCETN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:13:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhCETNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:13:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE2F4650A0;
        Fri,  5 Mar 2021 19:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614971613;
        bh=cmU1v4HxoU7I1TscIKOCjbmB6ohA+V07l9MWa8IiQYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQ7xvZ8m48Y3m8nLo8R4/145zV++RcmVEQTpO5sNUIxRg2MwSaq0Jr0khLnSMW9nv
         U2nVsTOqrA+myTkN4udZxTTKPQCgSil1cwOEPGK1Lm92QJMSvZP2Tm5fqS/ixLKMM6
         cLBn1Xw4NTDlc+iJYfsOY4qP+ZPd3Niu4vDddQdL0j3qA5hTeOUpkq2XNGf1KewlXv
         InlVKSEKrUFn6KBdQq3JRjRaOzty7YM8GHux/ewmDd8Q55kQIyGUMPlX50L6DVW2FW
         f5FI8ZAnA1jBr/sNKI2Njp+pJtx4nApDezuqwMQhkO6jdStUWZfoOvWr+ACcRF1J7G
         kM56jq46kIHRQ==
Date:   Fri, 5 Mar 2021 19:13:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 32/32] KVM: arm64: Protect the .hyp sections from the
 host
Message-ID: <20210305191327.GD23633@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-33-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-33-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 03:00:02PM +0000, Quentin Perret wrote:
> When KVM runs in nVHE protected mode, use the host stage 2 to unmap the
> hypervisor sections. The long-term goal is to ensure the EL2 code can
> remain robust regardless of the host's state, so this starts by making
> sure the host cannot e.g. write to the .hyp sections directly.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/arm.c                          | 46 +++++++++++++++++++
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  9 ++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 22 +++++++++
>  5 files changed, 80 insertions(+)

[...]

>  static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 2252ad1a8945..ed480facdc88 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -196,6 +196,28 @@ static int host_stage2_idmap(u64 addr)
>  	return ret;
>  }
>  
> +int __pkvm_host_unmap(phys_addr_t start, phys_addr_t end)
> +{
> +	struct kvm_mem_range r1, r2;
> +	int ret;
> +
> +	/*
> +	 * host_stage2_unmap_dev_all() currently relies on MMIO mappings being
> +	 * non-persistent, so don't allow PROT_NONE in MMIO range.
> +	 */
> +	if (!find_mem_range(start, &r1) || !find_mem_range(end, &r2))
> +		return -EINVAL;
> +	if (r1.start != r2.start)
> +		return -EINVAL;


Feels like this should be in a helper to determine whether or not a range is
solely covered by memory.

Either way:

Acked-by: Will Deacon <will@kernel.org>

Will
