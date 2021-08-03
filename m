Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8B3DEC51
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhHCLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235596AbhHCLkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:40:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 632C360560;
        Tue,  3 Aug 2021 11:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627990840;
        bh=mhnDfFaIKPn448+Hzr7J/F52MA/wURi3AmBUrc9MzNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zj4llxImzKOK9cEzegvwPN2NBPwisdhtYpA1j5AgJ8D2jEE7/gxS0TS0FkuEwQZ7R
         83SUbVEhrC1tFtUyUjzK317HW/Lx3zN8wPbmV2PJzgRrcg3rcoCGLPlXJEz+rosmqt
         DZP4ohPJbT84euNBOJh0V3HCEHG6d+MoNJ85AmIpbv4kJkj1Nqt+rTS13aff3PbRO3
         O1fydtpSN8vxykjPHEOOPZ24UEbYZ887KqQHNAGuupEz/zce1hQ0G3wgSX5Mb/es5j
         zMQ7L/GUBrJ1KTbOPyz/gXqPTA10BBWKVtedXq6HjA2333Kxn/IenbeVd/Nhd+USYd
         aEULpIFx8iEiw==
Date:   Tue, 3 Aug 2021 12:40:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        jean-philippe@linaro.org, Alexandru.Elisei@arm.com,
        qperret@google.com, linuxarm@huawei.com
Subject: Re: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU schedule
 out
Message-ID: <20210803114034.GB30853@willie-the-truck>
References: <20210729104009.382-1-shameerali.kolothum.thodi@huawei.com>
 <20210729104009.382-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210729104009.382-5-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 11:40:09AM +0100, Shameer Kolothum wrote:
> Like ASID allocator, we copy the active_vmids into the
> reserved_vmids on a rollover. But it's unlikely that
> every CPU will have a vCPU as current task and we may
> end up unnecessarily reserving the VMID space.
> 
> Hence, clear active_vmids when scheduling out a vCPU.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 1 +
>  arch/arm64/kvm/arm.c              | 1 +
>  arch/arm64/kvm/vmid.c             | 6 ++++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index bb993bce1363..d93141cb8d16 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -687,6 +687,7 @@ extern unsigned int kvm_arm_vmid_bits;
>  int kvm_arm_vmid_alloc_init(void);
>  void kvm_arm_vmid_alloc_free(void);
>  void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid);
> +void kvm_arm_vmid_clear_active(void);
>  
>  static inline void kvm_arm_pvtime_vcpu_init(struct kvm_vcpu_arch *vcpu_arch)
>  {
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 077e55a511a9..b134a1b89c84 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -435,6 +435,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  	kvm_timer_vcpu_put(vcpu);
>  	kvm_vgic_put(vcpu);
>  	kvm_vcpu_pmu_restore_host(vcpu);
> +	kvm_arm_vmid_clear_active();
>  
>  	vcpu->cpu = -1;
>  }
> diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
> index 5584e84aed95..5fd51f5445c1 100644
> --- a/arch/arm64/kvm/vmid.c
> +++ b/arch/arm64/kvm/vmid.c
> @@ -116,6 +116,12 @@ static u64 new_vmid(struct kvm_vmid *kvm_vmid)
>  	return idx2vmid(vmid) | generation;
>  }
>  
> +/* Call with preemption disabled */
> +void kvm_arm_vmid_clear_active(void)
> +{
> +	atomic64_set(this_cpu_ptr(&active_vmids), 0);
> +}

I think this is very broken, as it will force everybody to take the
slow-path when they see an active_vmid of 0.

It also doesn't solve the issue I mentioned before, as an active_vmid of 0
means that the reserved vmid is preserved.

Needs more thought...

Will
