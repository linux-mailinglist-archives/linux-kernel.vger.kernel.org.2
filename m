Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4400939A90D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhFCRUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233554AbhFCRRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:17:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95F3961420;
        Thu,  3 Jun 2021 17:13:39 +0000 (UTC)
Date:   Thu, 3 Jun 2021 18:13:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v13 7/8] KVM: arm64: ioctl to fetch/store tags in a guest
Message-ID: <20210603171336.GH20338@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
 <20210524104513.13258-8-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524104513.13258-8-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 11:45:12AM +0100, Steven Price wrote:
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 24223adae150..b3edde68bc3e 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -184,6 +184,17 @@ struct kvm_vcpu_events {
>  	__u32 reserved[12];
>  };
>  
> +struct kvm_arm_copy_mte_tags {
> +	__u64 guest_ipa;
> +	__u64 length;
> +	void __user *addr;
> +	__u64 flags;
> +	__u64 reserved[2];
> +};
> +
> +#define KVM_ARM_TAGS_TO_GUEST		0
> +#define KVM_ARM_TAGS_FROM_GUEST		1
> +
>  /* If you need to interpret the index values, here is the key: */
>  #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
>  #define KVM_REG_ARM_COPROC_SHIFT	16
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e89a5e275e25..baa33359e477 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1345,6 +1345,13 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  
>  		return 0;
>  	}
> +	case KVM_ARM_MTE_COPY_TAGS: {
> +		struct kvm_arm_copy_mte_tags copy_tags;
> +
> +		if (copy_from_user(&copy_tags, argp, sizeof(copy_tags)))
> +			return -EFAULT;
> +		return kvm_vm_ioctl_mte_copy_tags(kvm, &copy_tags);
> +	}

I wonder whether we need an update of the user structure following a
fault, like how much was copied etc. In case of an error, some tags were
copied and the VMM may want to skip the page before continuing. But here
there's no such information provided.

On the ptrace interface, we return 0 on the syscall if any bytes were
copied and update iov_len to such number. Maybe you want to still return
an error here but updating copy_tags.length would be nice (and, of
course, a copy_to_user() back).

-- 
Catalin
