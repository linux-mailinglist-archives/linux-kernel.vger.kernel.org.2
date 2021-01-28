Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5583072CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhA1JfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:35:22 -0500
Received: from foss.arm.com ([217.140.110.172]:55196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232566AbhA1Jc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:32:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C7F01042;
        Thu, 28 Jan 2021 01:31:42 -0800 (PST)
Received: from [10.57.45.249] (unknown [10.57.45.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 318AA3F766;
        Thu, 28 Jan 2021 01:31:40 -0800 (PST)
Subject: Re: [PATCH V3 09/14] arm64: Add TRBE definitions
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-10-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <bb249b84-cafd-b65c-118d-34322c1aabac@arm.com>
Date:   Thu, 28 Jan 2021 09:31:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1611737738-1493-10-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 8:55 AM, Anshuman Khandual wrote:
> This adds TRBE related registers and corresponding feature macros.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
> Changes in V3:
> 
> - ID_AA64DFR0_TRBE_SHIFT has been moved here from the TRBE driver
> - Changed TRBLIMITR_TRIG_MODE_SHIFT as 3
> 
>   arch/arm64/include/asm/sysreg.h | 50 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 4acff97..85ae4db 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -329,6 +329,55 @@
>   
>   /*** End of Statistical Profiling Extension ***/
>   
> +/*
> + * TRBE Registers
> + */
> +#define SYS_TRBLIMITR_EL1		sys_reg(3, 0, 9, 11, 0)
> +#define SYS_TRBPTR_EL1			sys_reg(3, 0, 9, 11, 1)
> +#define SYS_TRBBASER_EL1		sys_reg(3, 0, 9, 11, 2)
> +#define SYS_TRBSR_EL1			sys_reg(3, 0, 9, 11, 3)
> +#define SYS_TRBMAR_EL1			sys_reg(3, 0, 9, 11, 4)
> +#define SYS_TRBTRG_EL1			sys_reg(3, 0, 9, 11, 6)
> +#define SYS_TRBIDR_EL1			sys_reg(3, 0, 9, 11, 7)
> +
> +#define TRBLIMITR_LIMIT_MASK		GENMASK_ULL(51, 0)
> +#define TRBLIMITR_LIMIT_SHIFT		12
> +#define TRBLIMITR_NVM			BIT(5)
> +#define TRBLIMITR_TRIG_MODE_MASK	GENMASK(1, 0)
> +#define TRBLIMITR_TRIG_MODE_SHIFT	3
> +#define TRBLIMITR_FILL_MODE_MASK	GENMASK(1, 0)
> +#define TRBLIMITR_FILL_MODE_SHIFT	1
> +#define TRBLIMITR_ENABLE		BIT(0)
> +#define TRBPTR_PTR_MASK			GENMASK_ULL(63, 0)
> +#define TRBPTR_PTR_SHIFT		0
> +#define TRBBASER_BASE_MASK		GENMASK_ULL(51, 0)
> +#define TRBBASER_BASE_SHIFT		12
> +#define TRBSR_EC_MASK			GENMASK(5, 0)
> +#define TRBSR_EC_SHIFT			26
> +#define TRBSR_IRQ			BIT(22)
> +#define TRBSR_TRG			BIT(21)
> +#define TRBSR_WRAP			BIT(20)
> +#define TRBSR_ABORT			BIT(18)
> +#define TRBSR_STOP			BIT(17)
> +#define TRBSR_MSS_MASK			GENMASK(15, 0)
> +#define TRBSR_MSS_SHIFT			0
> +#define TRBSR_BSC_MASK			GENMASK(5, 0)
> +#define TRBSR_BSC_SHIFT			0
> +#define TRBSR_FSC_MASK			GENMASK(5, 0)
> +#define TRBSR_FSC_SHIFT			0
> +#define TRBMAR_SHARE_MASK		GENMASK(1, 0)
> +#define TRBMAR_SHARE_SHIFT		8
> +#define TRBMAR_OUTER_MASK		GENMASK(3, 0)
> +#define TRBMAR_OUTER_SHIFT		4
> +#define TRBMAR_INNER_MASK		GENMASK(3, 0)
> +#define TRBMAR_INNER_SHIFT		0
> +#define TRBTRG_TRG_MASK			GENMASK(31, 0)
> +#define TRBTRG_TRG_SHIFT		0
> +#define TRBIDR_FLAG			BIT(5)
> +#define TRBIDR_PROG			BIT(4)
> +#define TRBIDR_ALIGN_MASK		GENMASK(3, 0)
> +#define TRBIDR_ALIGN_SHIFT		0
> +
>   #define SYS_PMINTENSET_EL1		sys_reg(3, 0, 9, 14, 1)
>   #define SYS_PMINTENCLR_EL1		sys_reg(3, 0, 9, 14, 2)
>   
> @@ -831,6 +880,7 @@
>   #define ID_AA64MMFR2_CNP_SHIFT		0
>   
>   /* id_aa64dfr0 */
> +#define ID_AA64DFR0_TRBE_SHIFT		44
>   #define ID_AA64DFR0_TRACE_FILT_SHIFT	40
>   #define ID_AA64DFR0_DOUBLELOCK_SHIFT	36
>   #define ID_AA64DFR0_PMSVER_SHIFT	32
> 

