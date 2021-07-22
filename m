Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF013D1E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGVFyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:54:02 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12235 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhGVFyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:54:01 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GVjFp12yFz1CM75;
        Thu, 22 Jul 2021 14:28:46 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 14:34:33 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 14:34:33 +0800
Subject: Re: [PATCH -next] iommu/arm-smmu-v3: Add suspend and resume support
To:     Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <will@kernel.org>, <weiyongjun1@huawei.com>,
        <john.wanghui@huawei.com>, <dingtianhong@huawei.com>,
        <thunder.leizhen@huawei.com>, <guohanjun@huawei.com>,
        <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210721013350.17664-1-cuibixuan@huawei.com>
 <4e506481-5f6c-9c5e-eda3-300861581080@arm.com> <878s1z3j68.wl-maz@kernel.org>
 <848befb0-7a9a-0b2b-8be9-3dfa02919488@arm.com> <877dhj3e4b.wl-maz@kernel.org>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <5054a5cd-579f-3fe9-1884-5219c8d13531@huawei.com>
Date:   Thu, 22 Jul 2021 14:34:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <877dhj3e4b.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/7/21 23:01, Marc Zyngier wrote:
> On Wed, 21 Jul 2021 14:59:47 +0100,
> Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-07-21 14:12, Marc Zyngier wrote:
>>> On Wed, 21 Jul 2021 12:42:14 +0100,
>>> Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> [ +Marc for MSI bits ]
>>>>
>>>> On 2021-07-21 02:33, Bixuan Cui wrote:
>>>>> Add suspend and resume support for arm-smmu-v3 by low-power mode.
>>>>>
>>>>> When the smmu is suspended, it is powered off and the registers are
>>>>> cleared. So saves the msi_msg context during msi interrupt initialization
>>>>> of smmu. When resume happens it calls arm_smmu_device_reset() to restore
>>>>> the registers.
>>>>>
>>>>> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
>>>>> Reviewed-by: Wei Yongjun <weiyongjun1@huawei.com>
>>>>> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>> Reviewed-by: Ding Tianhong <dingtianhong@huawei.com>
>>>>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
>>>>> ---
>>>>>
>>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 72 ++++++++++++++++++---
>>>>>    1 file changed, 64 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> index 235f9bdaeaf2..bf1163acbcb1 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> @@ -40,6 +40,7 @@ MODULE_PARM_DESC(disable_bypass,
>>>>>      static bool disable_msipolling;
>>>>>    module_param(disable_msipolling, bool, 0444);
>>>>> +static bool bypass;
>>>>>    MODULE_PARM_DESC(disable_msipolling,
>>>>>    	"Disable MSI-based polling for CMD_SYNC completion.");
>>>>>    @@ -3129,11 +3130,37 @@ static void arm_smmu_write_msi_msg(struct
>>>>> msi_desc *desc, struct msi_msg *msg)
>>>>>    	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
>>>>>    	doorbell &= MSI_CFG0_ADDR_MASK;
>>>>>    +	/* Saves the msg context for resume if desc->msg is empty */
>>>>> +	if (desc->msg.address_lo == 0 && desc->msg.address_hi == 0) {
>>>>> +		desc->msg.address_lo = msg->address_lo;
>>>>> +		desc->msg.address_hi = msg->address_hi;
>>>>> +		desc->msg.data = msg->data;
>>>>> +	}
>>>>
>>>> My gut feeling is that this is something a device driver maybe
>>>> shouldn't be poking into, but I'm not entirely familiar with the area
>>>> :/
>>>
>>> Certainly not. If you rely on the message being stored into the
>>> descriptors, then implement this in the core code, like we do for PCI.
>>
>> Ah, so it would be an acceptable compromise to *read* desc->msg (and
>> thus avoid having to store our own copy of the message) if the core
>> was guaranteed to cache it? That's good to know, thanks.
> 
> Yeah, vfio, a couple of other weird drivers and (*surprise!*) ia64 are
> using this kind of trick. I don't see a reason not to implement that
> for platform-MSI (although level signalling may be interesting...), or
> even to move it into the core MSI code.
Agree. If msg is saved to desc->msg in MSI core, the code here will not need.
During the initialization of the MSI interrupt of the SMMU, the desc->msg
is never used. So I save msg to desc->msg for resume use.


>>
>>>>> +
>>>>>    	writeq_relaxed(doorbell, smmu->base + cfg[0]);
>>>>>    	writel_relaxed(msg->data, smmu->base + cfg[1]);
>>>>>    	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
>>>>>    }
>>>>>    +static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
>>>>> +{
>>>>> +	struct msi_desc *desc;
>>>>> +	struct device *dev = smmu->dev;
>>>>> +
>>>>> +	for_each_msi_entry(desc, dev) {
>>>>> +		switch (desc->platform.msi_index) {
>>>>> +		case EVTQ_MSI_INDEX:
>>>>> +		case GERROR_MSI_INDEX:
>>>>> +		case PRIQ_MSI_INDEX:
>>>>> +			arm_smmu_write_msi_msg(desc, &(desc->msg));
>>>
>>> Consider using get_cached_msi_msg() instead of using the internals of
>>> the descriptor.
>>
>> Oh, there's even a proper API for it, marvellous! I hadn't managed to
>> dig that far myself :)
> 
> It is a bit odd in the sense that it takes a copy of the message
> instead of returning a pointer, but at least this solves lifetime
> issues.
The code of arm_smmu_write_msi_msg() is multiplexed to restore the register. Therefore,
the parameter must be supplemented. Generally, desc is sufficient as an input parameter..
:)

Thanks,
Bixuan Cui
> 
> Thanks,
> 
> 	M.
> 
