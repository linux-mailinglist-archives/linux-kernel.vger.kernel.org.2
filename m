Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6C345267
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVWYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:24:43 -0400
Received: from foss.arm.com ([217.140.110.172]:38590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhCVWYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:24:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B0671042;
        Mon, 22 Mar 2021 15:24:22 -0700 (PDT)
Received: from [10.57.55.187] (unknown [10.57.55.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEDE83F719;
        Mon, 22 Mar 2021 15:24:20 -0700 (PDT)
Subject: Re: [PATCH v4 05/19] kvm: arm64: Disable guest access to trace filter
 controls
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-6-suzuki.poulose@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <cbe4ef17-38f9-c555-d838-796be752d4a3@arm.com>
Date:   Mon, 22 Mar 2021 22:24:19 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210225193543.2920532-6-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 25/02/2021 19:35, Suzuki K Poulose wrote:
> Disable guest access to the Trace Filter control registers.
> We do not advertise the Trace filter feature to the guest
> (ID_AA64DFR0_EL1: TRACE_FILT is cleared) already, but the guest
> can still access the TRFCR_EL1 unless we trap it.
> 
> This will also make sure that the guest cannot fiddle with
> the filtering controls set by a nvhe host.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

We have already have the v8.4 self hosted tracing support in 5.12-rcX.
Do you think you can pick this up for this 5.12 ?

Cheers
Suzuki

> ---
> New patch
> ---
>   arch/arm64/include/asm/kvm_arm.h | 1 +
>   arch/arm64/kvm/debug.c           | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 4e90c2debf70..94d4025acc0b 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -278,6 +278,7 @@
>   #define CPTR_EL2_DEFAULT	CPTR_EL2_RES1
>   
>   /* Hyp Debug Configuration Register bits */
> +#define MDCR_EL2_TTRF		(1 << 19)
>   #define MDCR_EL2_TPMS		(1 << 14)
>   #define MDCR_EL2_E2PB_MASK	(UL(0x3))
>   #define MDCR_EL2_E2PB_SHIFT	(UL(12))
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 7a7e425616b5..dbc890511631 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -89,6 +89,7 @@ void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu)
>    *  - Debug ROM Address (MDCR_EL2_TDRA)
>    *  - OS related registers (MDCR_EL2_TDOSA)
>    *  - Statistical profiler (MDCR_EL2_TPMS/MDCR_EL2_E2PB)
> + *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
>    *
>    * Additionally, KVM only traps guest accesses to the debug registers if
>    * the guest is not actively using them (see the KVM_ARM64_DEBUG_DIRTY
> @@ -112,6 +113,7 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
>   	vcpu->arch.mdcr_el2 = __this_cpu_read(mdcr_el2) & MDCR_EL2_HPMN_MASK;
>   	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
>   				MDCR_EL2_TPMS |
> +				MDCR_EL2_TTRF |
>   				MDCR_EL2_TPMCR |
>   				MDCR_EL2_TDRA |
>   				MDCR_EL2_TDOSA);
> 

