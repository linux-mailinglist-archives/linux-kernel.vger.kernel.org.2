Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2730E34525D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCVWVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:21:34 -0400
Received: from foss.arm.com ([217.140.110.172]:38558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhCVWVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:21:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 651DE1042;
        Mon, 22 Mar 2021 15:21:11 -0700 (PDT)
Received: from [10.57.55.187] (unknown [10.57.55.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D35DE3F719;
        Mon, 22 Mar 2021 15:21:09 -0700 (PDT)
Subject: Re: [PATCH v4 03/19] kvm: arm64: Hide system instruction access to
 Trace registers
To:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-4-suzuki.poulose@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6b8dbaed-654f-3079-bc38-ef18c0effd79@arm.com>
Date:   Mon, 22 Mar 2021 22:21:08 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210225193543.2920532-4-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will, Catalin,

On 25/02/2021 19:35, Suzuki K Poulose wrote:
> Currently we advertise the ID_AA6DFR0_EL1.TRACEVER for the guest,
> when the trace register accesses are trapped (CPTR_EL2.TTA == 1).
> So, the guest will get an undefined instruction, if trusts the
> ID registers and access one of the trace registers.
> Lets be nice to the guest and hide the feature to avoid
> unexpected behavior.
> 
> Even though this can be done at KVM sysreg emulation layer,
> we do this by removing the TRACEVER from the sanitised feature
> register field. This is fine as long as the ETM drivers
> can handle the individual trace units separately, even
> when there are differences among the CPUs.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> New patch
> ---
>   arch/arm64/kernel/cpufeature.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 066030717a4c..a4698f09bf32 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -383,7 +383,6 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>   	 * of support.
>   	 */
>   	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64DFR0_TRACEVER_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64DFR0_DEBUGVER_SHIFT, 4, 0x6),
>   	ARM64_FTR_END,
>   };
> 

Are you happy to pick this patch for 5.12 as a fix ?

Suzuki
