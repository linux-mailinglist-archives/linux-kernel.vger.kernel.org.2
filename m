Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7193EED4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbhHQNY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:24:59 -0400
Received: from foss.arm.com ([217.140.110.172]:55232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236398AbhHQNY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:24:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7862C101E;
        Tue, 17 Aug 2021 06:24:23 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54B0F3F70D;
        Tue, 17 Aug 2021 06:24:22 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Simplify useless instructions in
 arm_smmu_cmdq_build_cmd()
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>
References: <20210817113450.2026-1-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6fea9ce0-7b8d-bd46-6b85-f3f9ba3ddd48@arm.com>
Date:   Tue, 17 Aug 2021 14:23:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817113450.2026-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 12:34, Zhen Lei wrote:
> Although the parameter 'cmd' is always passed by a local array variable,
> and only this function modifies it, the compiler does not know this. The
> compiler almost always reads the value of cmd[i] from memory rather than
> directly using the value cached in the register. This generates many
> useless instruction operations and affects the performance to some extent.

Which compiler? GCC 4.9 does not make the same codegen decisions that 
GCC 10 does; Clang is different again. There are also various config 
options which affect a compiler's inlining/optimisation choices either 
directly or indirectly.

If it's something that newer compilers can get right anyway, then 
micro-optimising just for older ones might warrant a bit more justification.

> To guide the compiler for proper optimization, 'cmd' is defined as a local
> array variable, marked as register, and copied to the output parameter at
> a time when the function is returned.
> 
> The optimization effect can be viewed by running the "size arm-smmu-v3.o"
> command.
> 
> Before:
>     text    data     bss     dec     hex
>    27602    1348      56   29006    714e
> 
> After:
>     text    data     bss     dec     hex
>    27402    1348      56   28806    7086
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d76bbbde558b776..50a9db5bac466c7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -233,11 +233,19 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>   	return 0;
>   }
>   
> +#define arm_smmu_cmdq_copy_cmd(dst, src)	\
> +	do {					\
> +		dst[0] = src[0];		\
> +		dst[1] = src[1];		\
> +	} while (0)
> +
>   /* High-level queue accessors */
> -static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> +static int arm_smmu_cmdq_build_cmd(u64 *out_cmd, struct arm_smmu_cmdq_ent *ent)
>   {
> -	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
> -	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> +	register u64 cmd[CMDQ_ENT_DWORDS];
> +
> +	cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
> +	cmd[1] = 0;
>   
>   	switch (ent->opcode) {
>   	case CMDQ_OP_TLBI_EL2_ALL:
> @@ -309,6 +317,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   		case PRI_RESP_SUCC:
>   			break;
>   		default:
> +			arm_smmu_cmdq_copy_cmd(out_cmd, cmd);

Why bother writing back a partial command when we're telling the caller 
it's invalid anyway?

>   			return -EINVAL;
>   		}
>   		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_RESP, ent->pri.resp);
> @@ -329,9 +338,12 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
>   		break;
>   	default:
> +		arm_smmu_cmdq_copy_cmd(out_cmd, cmd);

Ditto.

>   		return -ENOENT;
>   	}
>   
> +	arm_smmu_cmdq_copy_cmd(out_cmd, cmd);

...and then it would be simpler to open-code the assignment here.

I guess if you're really concerned with avoiding temporary commands 
being written back to the stack and reloaded, it might be worth 
experimenting with wrapping them in a struct which can be passed around 
by value - AAPCS64 allows passing a 16-byte composite type purely in 
registers.

Robin.

> +
>   	return 0;
>   }
>   
> 
