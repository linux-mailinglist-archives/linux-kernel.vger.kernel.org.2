Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3E73D1EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 09:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGVGq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 02:46:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15046 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhGVGqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:46:23 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GVkT06F5CzZrdy;
        Thu, 22 Jul 2021 15:23:32 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 15:26:52 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 15:26:51 +0800
Subject: Re: [PATCH -next] iommu/arm-smmu-v3: Add suspend and resume support
To:     Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <will@kernel.org>, <weiyongjun1@huawei.com>,
        <john.wanghui@huawei.com>, <dingtianhong@huawei.com>,
        <thunder.leizhen@huawei.com>, <guohanjun@huawei.com>,
        <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210721013350.17664-1-cuibixuan@huawei.com>
 <4e506481-5f6c-9c5e-eda3-300861581080@arm.com> <878s1z3j68.wl-maz@kernel.org>
 <848befb0-7a9a-0b2b-8be9-3dfa02919488@arm.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <9c268adf-5d11-1854-583f-c9e88636cf09@huawei.com>
Date:   Thu, 22 Jul 2021 15:26:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <848befb0-7a9a-0b2b-8be9-3dfa02919488@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/7/21 21:59, Robin Murphy wrote:
>> On Wed, 21 Jul 2021 12:42:14 +0100,
>> Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> [ +Marc for MSI bits ]
>>>
>>> On 2021-07-21 02:33, Bixuan Cui wrote:
>>>> Add suspend and resume support for arm-smmu-v3 by low-power mode.
>>>>
>>>> When the smmu is suspended, it is powered off and the registers are
>>>> cleared. So saves the msi_msg context during msi interrupt initialization
>>>> of smmu. When resume happens it calls arm_smmu_device_reset() to restore
>>>> the registers.
>>>>
>>>> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
>>>> Reviewed-by: Wei Yongjun <weiyongjun1@huawei.com>
>>>> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> Reviewed-by: Ding Tianhong <dingtianhong@huawei.com>
>>>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
>>>> ---
>>>>
>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 72 ++++++++++++++++++---
>>>>    1 file changed, 64 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> index 235f9bdaeaf2..bf1163acbcb1 100644
>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> @@ -40,6 +40,7 @@ MODULE_PARM_DESC(disable_bypass,
>>>>      static bool disable_msipolling;
>>>>    module_param(disable_msipolling, bool, 0444);
>>>> +static bool bypass;
>>>>    MODULE_PARM_DESC(disable_msipolling,
>>>>        "Disable MSI-based polling for CMD_SYNC completion.");
>>>>    @@ -3129,11 +3130,37 @@ static void arm_smmu_write_msi_msg(struct
>>>> msi_desc *desc, struct msi_msg *msg)
>>>>        doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
>>>>        doorbell &= MSI_CFG0_ADDR_MASK;
>>>>    +    /* Saves the msg context for resume if desc->msg is empty */
>>>> +    if (desc->msg.address_lo == 0 && desc->msg.address_hi == 0) {
>>>> +        desc->msg.address_lo = msg->address_lo;
>>>> +        desc->msg.address_hi = msg->address_hi;
>>>> +        desc->msg.data = msg->data;
>>>> +    }
>>>
>>> My gut feeling is that this is something a device driver maybe
>>> shouldn't be poking into, but I'm not entirely familiar with the area
>>> :/
>>
>> Certainly not. If you rely on the message being stored into the
>> descriptors, then implement this in the core code, like we do for PCI.
> 
> Ah, so it would be an acceptable compromise to *read* desc->msg (and thus avoid having to store our own copy of the message) if the core was guaranteed to cache it? That's good to know, thanks.
> 
>>>> +
>>>>        writeq_relaxed(doorbell, smmu->base + cfg[0]);
>>>>        writel_relaxed(msg->data, smmu->base + cfg[1]);
>>>>        writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
>>>>    }
>>>>    +static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
>>>> +{
>>>> +    struct msi_desc *desc;
>>>> +    struct device *dev = smmu->dev;
>>>> +
>>>> +    for_each_msi_entry(desc, dev) {
>>>> +        switch (desc->platform.msi_index) {
>>>> +        case EVTQ_MSI_INDEX:
>>>> +        case GERROR_MSI_INDEX:
>>>> +        case PRIQ_MSI_INDEX:
>>>> +            arm_smmu_write_msi_msg(desc, &(desc->msg));
>>
>> Consider using get_cached_msi_msg() instead of using the internals of
>> the descriptor.
> 
> Oh, there's even a proper API for it, marvellous! I hadn't managed to dig that far myself :)
Thanks for your suggestion, I'll use get_cached_msi_msg() instead.

> 
>>>> +            break;
>>>> +        default:
>>>> +            continue;
>>>> +
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>>    static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>>>>    {
>>>>        struct msi_desc *desc;
>>>> @@ -3184,11 +3211,17 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>>>>        devm_add_action(dev, arm_smmu_free_msis, dev);
>>>>    }
>>>>    -static void arm_smmu_setup_unique_irqs(struct arm_smmu_device
>>>> *smmu)
>>>> +static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu, bool resume_mode)
>>>>    {
>>>>        int irq, ret;
>>>>    -    arm_smmu_setup_msis(smmu);
>>>> +    if (!resume_mode)
>>>> +        arm_smmu_setup_msis(smmu);
>>>> +    else {
>>>> +        /* The irq doesn't need to be re-requested during resume */
>>>> +        arm_smmu_resume_msis(smmu);
>>>> +        return;
>>>
>>> What about wired IRQs?
>>
>> Yeah. I assume the SMMU needs to be told which event gets signalled
>> using MSIs or IRQs? Or is that implied by the MSI being configured or
>> not (I used to know the answer to that, but I have long paged it out).
> 
> My mistake there - I misread the rather convoluted existing flow to think that bailing here would fail to enable wired IRQs, but of course the signalling decision is based on whether the MSI address is non-zero, and the enables in ARM_SMMU_IRQ_CTRL still apply either way>
> Given that, I think this is that point at which to refactor this whole part so that logically requesting and physically programming the interrupts are split into distinct stages, which can then be called seperately as appropriate. Personally I have a particular dislike of this general anti-patten
> 
>     int do_a_thing(bool but_only_do_part_of_it)
I have verified this patch on the board in arm64, and the MSI interrupt can work properly after resume.
The important work is to restore ARM_SMMU_EVTQ_IRQ_CFGn/ARM_SMMU_GERROR_IRQ_CFGn/ARM_SMMU_PRIQ_IRQ_CFG0 register after the resume.

When adding the suspend/resume, I try to change the original code as little as possible.

Thanks
Bixuan Cui
> 
>>>> +    }
>>>>          /* Request interrupt lines */
>>>>        irq = smmu->evtq.q.irq;
>>>> @@ -3230,7 +3263,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>>>>        }
>>>>    }
>>>>    -static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>>>> +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu, bool resume_mode)
>>>>    {
>>>>        int ret, irq;
>>>>        u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
>>>> @@ -3257,7 +3290,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>>>>            if (ret < 0)
>>>>                dev_warn(smmu->dev, "failed to enable combined irq\n");
>>>>        } else
>>>> -        arm_smmu_setup_unique_irqs(smmu);
>>>> +        arm_smmu_setup_unique_irqs(smmu, resume_mode);
>>>>          if (smmu->features & ARM_SMMU_FEAT_PRI)
>>>>            irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
>>>> @@ -3282,7 +3315,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
>>>>        return ret;
>>>>    }
>>>>    -static int arm_smmu_device_reset(struct arm_smmu_device *smmu,
>>>> bool bypass)
>>>> +static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool resume_mode)
>>>
>>> Er, what about the use of "bypass" towards the end of the
>>> function. Have you even compiled this?
>>
>> The author of the patch has conveniently made it a global value (see
>> line 3 of the patch). I'm sure it doesn't break anything... :-(
> 
> Oh blimey, I hadn't even turned on my "things that make no flippin' sense" radar to notice that, thanks for the correction. Indeed that's pretty busted for SMMU instances probing concurrently.
> 
> As with interrupts, reset probably wants a bit of refactoring to separate out the probe-time concerns of cleaning up any left-over configuration from firmware/kdump/whatever, and the act of putting the hardware into the operational state we want. For instance, if it happens that state is *not* lost on suspend, subsequently warning about CR0_SMMUEN being enabled on resume would be bad.
> 
>>>>    {
>>>>        int ret;
>>>>        u32 reg, enables;
>>>> @@ -3392,7 +3425,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>>>>            }
>>>>        }
>>>>    -    ret = arm_smmu_setup_irqs(smmu);
>>>> +    ret = arm_smmu_setup_irqs(smmu, resume_mode);
>>>>        if (ret) {
>>>>            dev_err(smmu->dev, "failed to setup irqs\n");
>>>>            return ret;
>>>> @@ -3749,6 +3782,24 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
>>>>        return devm_ioremap_resource(dev, &res);
>>>>    }
>>>>    +static int __maybe_unused arm_smmu_suspend(struct device *dev)
>>>> +{
>>>> +    /*
>>>> +     * The smmu is powered off and related registers are automatically
>>>> +     * cleared when suspend. No need to do anything.
>>>> +     */
>>>
>>> Is that guaranteed? What if suspend is only implemented by external
>>> clock-gating?
>>
>> +1. This seems awfully implementation/integration specific. I'd be
>> more in favour of a controlled teardown.
Indeed, The current code applies to the scenario where the SMMU is directly powered off.
I'm not sure what other implementation/integration are. :(

>>
>>>
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int __maybe_unused arm_smmu_resume(struct device *dev)
>>>> +{
>>>> +    struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>> +
>>>> +    arm_smmu_device_reset(smmu, true);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    static int arm_smmu_device_probe(struct platform_device *pdev)
>>>>    {
>>>>        int irq, ret;
>>>> @@ -3756,7 +3807,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>>        resource_size_t ioaddr;
>>>>        struct arm_smmu_device *smmu;
>>>>        struct device *dev = &pdev->dev;
>>>> -    bool bypass;
>>>
>>> Once again...
>>>
>>>>        smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
>>>>        if (!smmu)
>>>> @@ -3831,7 +3881,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>>        platform_set_drvdata(pdev, smmu);
>>>>          /* Reset the device */
>>>> -    ret = arm_smmu_device_reset(smmu, bypass);
>>>
>>> ...either this is based on some out-of-tree hack which introduced its
>>> own uninitialised-usage bug here, or it doesn't even compile.
> 
> As above, apologies for the oversight there. It's not as badly wrong as I thought, but it's still not right.
> 
> Thanks,
> Robin.
> 
>>>
>>>> +    ret = arm_smmu_device_reset(smmu, false);
>>>>        if (ret)
>>>>            return ret;
>>>>    @@ -3884,6 +3934,11 @@ static const struct of_device_id
>>>> arm_smmu_of_match[] = {
>>>>    };
>>>>    MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>>>>    +static const struct dev_pm_ops arm_smmu_pm_ops = {
>>>> +    .suspend = arm_smmu_suspend,
>>>> +    .resume = arm_smmu_resume,
>>>
>>> Either use SET_SYSTEM_SLEEP_PM_OPS() here or drop the __maybe_unused
>>> annmotations above - they're pointless if the callbacks are referenced
>>> unconditionally.
Thank you for the advice here.



Thanks,
Bixuan Cui

>>
>> Thanks,
>>
>>     M.
>>
> .
