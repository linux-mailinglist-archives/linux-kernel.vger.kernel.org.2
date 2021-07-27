Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BC93D7705
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhG0Noo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:44:44 -0400
Received: from foss.arm.com ([217.140.110.172]:39160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhG0Non (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:44:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 145041FB;
        Tue, 27 Jul 2021 06:44:43 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 969BE3F66F;
        Tue, 27 Jul 2021 06:44:40 -0700 (PDT)
Subject: Re: [PATCH -next v2] iommu/arm-smmu-v3: Add suspend and resume
 support
To:     Bixuan Cui <cuibixuan@huawei.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        will@kernel.org
Cc:     weiyongjun1@huawei.com, john.wanghui@huawei.com,
        dingtianhong@huawei.com, thunder.leizhen@huawei.com,
        guohanjun@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
        Jonathan.Cameron@huawei.com, song.bao.hua@hisilicon.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210727121408.81883-1-cuibixuan@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6b959d09-936a-cee2-02f4-376d74efa417@arm.com>
Date:   Tue, 27 Jul 2021 14:44:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727121408.81883-1-cuibixuan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-27 13:14, Bixuan Cui wrote:
> Add suspend and resume support for arm-smmu-v3 by low-power mode.
> 
> When the smmu is suspended, it is powered off and the registers are
> cleared. So saves the msi_msg context during msi interrupt initialization
> of smmu. When resume happens it calls arm_smmu_device_reset() to restore
> the registers.
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> Reviewed-by: Wei Yongjun <weiyongjun1@huawei.com>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reviewed-by: Ding Tianhong <dingtianhong@huawei.com>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> ---
> Changes in v2:
> * Using get_cached_msi_msg() instead of the descriptor to resume msi_msg
>    in arm_smmu_resume_msis();
> 
> * Move arm_smmu_resume_msis() from arm_smmu_setup_unique_irqs() into
>    arm_smmu_setup_irqs() and rename it to arm_smmu_resume_unique_irqs();
> 
>    Call arm_smmu_setup_unique_irqs() to configure the IRQ during probe and
>    call arm_smmu_resume_unique_irqs() in resume mode to restore the IRQ
>    registers to make the code more reasonable.
> 
> * Call arm_smmu_device_disable() to disable smmu and clear CR0_SMMUEN on
>    suspend. Then the warning about CR0_SMMUEN being enabled can be cleared
>    on resume.
> 
> * Using SET_SYSTEM_SLEEP_PM_OPS();
> 
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 69 ++++++++++++++++++---
>   1 file changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 235f9bdaeaf2..66f35d5c7a70 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -40,6 +40,7 @@ MODULE_PARM_DESC(disable_bypass,
>   
>   static bool disable_msipolling;
>   module_param(disable_msipolling, bool, 0444);
> +static bool bypass;

This is still broken.

>   MODULE_PARM_DESC(disable_msipolling,
>   	"Disable MSI-based polling for CMD_SYNC completion.");
>   
> @@ -3129,11 +3130,38 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>   	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
>   	doorbell &= MSI_CFG0_ADDR_MASK;
>   
> +	/* Saves the msg context for resume if desc->msg is empty */
> +	if (desc->msg.address_lo == 0x0 && desc->msg.address_hi == 0x0) {
> +		desc->msg.address_lo = msg->address_lo;
> +		desc->msg.address_hi = msg->address_hi;
> +		desc->msg.data = msg->data;
> +	}
> +
>   	writeq_relaxed(doorbell, smmu->base + cfg[0]);
>   	writel_relaxed(msg->data, smmu->base + cfg[1]);
>   	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
>   }
>   
> +static void arm_smmu_resume_unique_irqs(struct arm_smmu_device *smmu)
> +{
> +	struct msi_desc *desc;
> +	struct msi_msg msg;
> +
> +	desc = irq_get_msi_desc(smmu->evtq.q.irq);
> +	get_cached_msi_msg(smmu->evtq.q.irq, &msg);
> +	arm_smmu_write_msi_msg(desc, &msg);

OK, now I think you actually *have* broken wired interrupts. What if 
desc is NULL here?

> +	desc = irq_get_msi_desc(smmu->gerr_irq);
> +	get_cached_msi_msg(smmu->gerr_irq, &msg);
> +	arm_smmu_write_msi_msg(desc, &msg);
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI) {
> +		desc = irq_get_msi_desc(smmu->priq.q.irq);
> +		get_cached_msi_msg(smmu->priq.q.irq, &msg);
> +		arm_smmu_write_msi_msg(desc, &msg);
> +	}
> +}
> +
>   static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>   {
>   	struct msi_desc *desc;
> @@ -3230,7 +3258,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>   	}
>   }
>   
> -static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu, bool resume_mode)
>   {
>   	int ret, irq;
>   	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> @@ -3256,8 +3284,12 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>   					"arm-smmu-v3-combined-irq", smmu);
>   		if (ret < 0)
>   			dev_warn(smmu->dev, "failed to enable combined irq\n");
> -	} else
> -		arm_smmu_setup_unique_irqs(smmu);
> +	} else {
> +		if (!resume_mode)
> +			arm_smmu_setup_unique_irqs(smmu);
> +		else
> +			arm_smmu_resume_unique_irqs(smmu);
> +	}

This is still pretty much unreadable. As I said, a clear refactoring to 
logically separate requesting the IRQs from programming the registers 
would be the preferred way forward.

>   
>   	if (smmu->features & ARM_SMMU_FEAT_PRI)
>   		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> @@ -3282,7 +3314,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
>   	return ret;
>   }
>   
> -static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
> +static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool resume_mode)
>   {
>   	int ret;
>   	u32 reg, enables;
> @@ -3392,7 +3424,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>   		}
>   	}
>   
> -	ret = arm_smmu_setup_irqs(smmu);
> +	ret = arm_smmu_setup_irqs(smmu, resume_mode);
>   	if (ret) {
>   		dev_err(smmu->dev, "failed to setup irqs\n");
>   		return ret;
> @@ -3749,6 +3781,25 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
>   	return devm_ioremap_resource(dev, &res);
>   }
>   
> +static int __maybe_unused arm_smmu_suspend(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	/* disable smmu to clear CR0 */
> +	arm_smmu_device_disable(smmu);

Why? At worst this might actually cause more problems if there are any 
client devices which have not been quiesced due to non-PM-aware drivers. 
AFAICS this is just doing unnecessary work in the wrong place in an 
attempt to avoid refactoring the reset routine. Don't do that, do it 
properly.

It is the nature of kernel development that small changes build up over 
time to a point where code starts to become unwieldy and deserves 
refactoring. This code happens to be at that point - if making a small 
logical change ends up needing a large invasive patch, that's usually a 
sign that the code no longer has the best design for what it needs to 
do, and *should* have the large invasive refactor for the sake of future 
maintenance and development. Wanting to make the existing mess even more 
convoluted because it's already enough of a mess that you're scared to 
touch it too much is a self-defeating argument.

I ended up rewriting half of the SMMUv2 driver in the name of adding 
suspend/resume support, precisely because doing so was also beneficial 
in several other ways - what looks to want doing in this case is nowhere 
near as involved as that was.

Robin.

> +	return 0;
> +}
> +
> +static int __maybe_unused arm_smmu_resume(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	arm_smmu_device_reset(smmu, true);
> +
> +	return 0;
> +}
> +
>   static int arm_smmu_device_probe(struct platform_device *pdev)
>   {
>   	int irq, ret;
> @@ -3756,7 +3807,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	resource_size_t ioaddr;
>   	struct arm_smmu_device *smmu;
>   	struct device *dev = &pdev->dev;
> -	bool bypass;
>   
>   	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
>   	if (!smmu)
> @@ -3831,7 +3881,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, smmu);
>   
>   	/* Reset the device */
> -	ret = arm_smmu_device_reset(smmu, bypass);
> +	ret = arm_smmu_device_reset(smmu, false);
>   	if (ret)
>   		return ret;
>   
> @@ -3884,6 +3934,10 @@ static const struct of_device_id arm_smmu_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>   
> +static const struct dev_pm_ops arm_smmu_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_suspend, arm_smmu_resume)
> +};
> +
>   static void arm_smmu_driver_unregister(struct platform_driver *drv)
>   {
>   	arm_smmu_sva_notifier_synchronize();
> @@ -3895,6 +3949,7 @@ static struct platform_driver arm_smmu_driver = {
>   		.name			= "arm-smmu-v3",
>   		.of_match_table		= arm_smmu_of_match,
>   		.suppress_bind_attrs	= true,
> +		.pm			= &arm_smmu_pm_ops,
>   	},
>   	.probe	= arm_smmu_device_probe,
>   	.remove	= arm_smmu_device_remove,
> 
