Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8545B3DB7CA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 13:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbhG3LZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 07:25:54 -0400
Received: from foss.arm.com ([217.140.110.172]:40650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238784AbhG3LZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:25:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CFDB1FB;
        Fri, 30 Jul 2021 04:25:42 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1AEE3F73D;
        Fri, 30 Jul 2021 04:25:38 -0700 (PDT)
Subject: Re: [PATCH 06/10] arm64: Add Neoverse-N2, Cortex-A710 CPU part
 definition
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-7-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <191ec253-d507-1994-ea95-fc4902629708@arm.com>
Date:   Fri, 30 Jul 2021 16:56:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210728135217.591173-7-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/21 7:22 PM, Suzuki K Poulose wrote:
> Add the CPU Partnumbers for the new Arm designs.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cputype.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 6231e1f0abe7..b71bd6c176c2 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -73,6 +73,8 @@
>  #define ARM_CPU_PART_CORTEX_A76		0xD0B
>  #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
>  #define ARM_CPU_PART_CORTEX_A77		0xD0D
> +#define ARM_CPU_PART_CORTEX_A710	0xD47
> +#define ARM_CPU_PART_NEOVERSE_N2	0xD49
>  
>  #define APM_CPU_PART_POTENZA		0x000
>  
> @@ -112,6 +114,8 @@
>  #define MIDR_CORTEX_A55 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A55)
>  #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
>  #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
> +#define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
> +#define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)

Should not the new ones be added after MIDR_CORTEX_A77 below to preserve the order ?

>  #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
>  #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
>  #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX
