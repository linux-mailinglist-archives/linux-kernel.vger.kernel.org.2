Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA174447DEE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhKHK33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:29:29 -0500
Received: from foss.arm.com ([217.140.110.172]:48434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237935AbhKHK3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:29:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14DE9D6E;
        Mon,  8 Nov 2021 02:26:39 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7133B3F800;
        Mon,  8 Nov 2021 02:26:37 -0800 (PST)
Date:   Mon, 8 Nov 2021 10:28:25 +0000
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] KVM: arm64: change the return type of
 kvm_vcpu_preferred_target()
Message-ID: <YYj7yZ6+N3NA15Hj@monolith.localdoman>
References: <20211105011500.16280-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105011500.16280-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 05, 2021 at 09:15:00AM +0800, YueHaibing wrote:
> kvm_vcpu_preferred_target() always return 0 because kvm_target_cpu()
> never returns a negative error code.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 2 +-
>  arch/arm64/kvm/arm.c              | 5 +----
>  arch/arm64/kvm/guest.c            | 7 +------
>  3 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 4be8486042a7..2a5f7f38006f 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -584,7 +584,7 @@ struct kvm_vcpu_stat {
>  	u64 exits;
>  };
>  
> -int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init);
> +void kvm_vcpu_preferred_target(struct kvm_vcpu_init *init);
>  unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
>  int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
>  int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index f5490afe1ebf..2f03cbfefe67 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1389,12 +1389,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		return kvm_vm_ioctl_set_device_addr(kvm, &dev_addr);
>  	}
>  	case KVM_ARM_PREFERRED_TARGET: {
> -		int err;
>  		struct kvm_vcpu_init init;
>  
> -		err = kvm_vcpu_preferred_target(&init);
> -		if (err)
> -			return err;
> +		kvm_vcpu_preferred_target(&init);
>  
>  		if (copy_to_user(argp, &init, sizeof(init)))
>  			return -EFAULT;
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 5ce26bedf23c..e116c7767730 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -869,13 +869,10 @@ u32 __attribute_const__ kvm_target_cpu(void)
>  	return KVM_ARM_TARGET_GENERIC_V8;
>  }
>  
> -int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
> +void kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
>  {
>  	u32 target = kvm_target_cpu();

Checked and kvm_target_cpu() never returns a negative value (the target values
are from 0 to 5, inclusive), which matches the type of the return value from the
function, which is unsigned. The patch look correct to me:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,
Alex

>  
> -	if (target < 0)
> -		return -ENODEV;
> -
>  	memset(init, 0, sizeof(*init));
>  
>  	/*
> @@ -885,8 +882,6 @@ int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
>  	 * target type.
>  	 */
>  	init->target = (__u32)target;
> -
> -	return 0;
>  }
>  
>  int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
> -- 
> 2.17.1
> 
