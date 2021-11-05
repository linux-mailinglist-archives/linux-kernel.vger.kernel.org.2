Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7E4445E1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 03:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhKEC5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 22:57:13 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44358 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231496AbhKEC5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 22:57:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yaohongbo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uv6Iufq_1636080871;
Received: from B-W10NMD6R-0647.local(mailfrom:yaohongbo@linux.alibaba.com fp:SMTPD_---0Uv6Iufq_1636080871)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Nov 2021 10:54:32 +0800
Subject: Re: [PATCH] ACPI/IORT: Add 'smmu=off' command line option
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, will@kernel.org,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210915120046.62936-1-yaohongbo@linux.alibaba.com>
 <c243d909-b442-02ae-a05c-1a59a5e950d5@arm.com>
From:   Yao Hongbo <yaohongbo@linux.alibaba.com>
Message-ID: <a3b4f6d5-3fee-cad1-fb9c-382de86aae13@linux.alibaba.com>
Date:   Fri, 5 Nov 2021 10:54:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c243d909-b442-02ae-a05c-1a59a5e950d5@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/9/16 上午4:12, Robin Murphy 写道:
> On 2021-09-15 13:00, Yao Hongbo wrote:
>> Add a generic command line option to disable arm smmu drivers.
>> iommu.passthrough can only bypass the IOMMU for DMA, but
>> sometimes we need to ignore all available SMMUs.
>
> Please elaborate on "sometimes" - what's the use-case for this which 
> can't already be achieved by other means like module_blacklist, 
> switching kernel images, ACPI table overrides, and so on?

     Hi, robin. sorry for the late response.

     I think this option is necessary:

     1. I often meet such problems that the kernel(such as linux-stable 
5.2.y, 5.4.y, 5.6.y and etc..) could not boot normally because of smmu 
initialization failure.

     [   36.176484] arm-smmu-v3: probe of arm-smmu-v3.2.auto failed 
with  error -16
     [   36.185906] probe of arm-smmu-v3.2.auto returned 0 after 31867 usecs
     [   36.194809] arm-smmu-v3 arm-smmu-v3.3.auto: option mask 0x0
     [   36.202945] arm-smmu-v3 arm-smmu-v3.3.auto: can't request region 
for resource [mem 0x3fc00000-0x3fc1ffff]

       Even setting iommu.passthrough=1 will not work.

      TBH, Scenes that do not require virtualization can completely 
ignore all available smmus, instead of wasting time to invest in these 
less maintained versions.

     2.  In the kdump kernel, it's not necessary to initialize smmu. Add 
'smmu=off' cmd option can provide an opportunity for kdump to choose.

     3. we can completely disable the smmu through bios.  but i think it 
would be  more convenient if os can have such a function.

>> This patch is only used for acpi on arm64.
>
> And yet the documentation implies that it works for all arm64 systems :/
>
> And furthermore, why? If it's genuinely useful to disable SMMUs on 
> ACPI-based systems, surely it must be equally useful to disable SMMUs 
> on DT-based systems?

   I have also thought about how to implement it generically in a way， 
but i find it a little diffcult.

   if i want to support both dt and acpi systems, i should parse the 
commnd line option in a public file.

    But  it's not suitable to do that in drivers/iommu/iommu.c, unless I 
make a general interface like iommu.passthrough.

    Can i may  create a file named drivers/iommu/arm/iommu.c , and then 
parse smmu=off , force_isolation or other options in this newly created 
file?

>
>> Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>>   drivers/acpi/arm64/iort.c                       | 18 
>> +++++++++++++++++-
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index 91ba391f..6cffd91 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5198,6 +5198,10 @@
>>       smart2=        [HW]
>>               Format: <io1>[,<io2>[,...,<io8>]]
>>   +    smmu=           [ARM64]
>> +            Format: {off}
>> +            off: Disable arm smmu driver.
>
> There are at least two Arm SMMU drivers; as a user I might be 
> wondering about the ambiguity there.
>
>> +
>>       smsc-ircc2.nopnp    [HW] Don't use PNP to discover SMC devices
>>       smsc-ircc2.ircc_cfg=    [HW] Device configuration I/O port
>>       smsc-ircc2.ircc_sir=    [HW] SIR base I/O port
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 3b23fb7..70f92e7 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -40,6 +40,22 @@ struct iort_fwnode {
>>   static LIST_HEAD(iort_fwnode_list);
>>   static DEFINE_SPINLOCK(iort_fwnode_lock);
>>   +static bool acpi_smmu_disabled;
>> +
>> +static int __init acpi_smmu_parse(char *str)
>> +{
>> +    if (!str)
>> +        return -EINVAL;
>> +
>> +    if (!strncmp(str, "off", 3)) {
>> +        acpi_smmu_disabled = true;
>> +        pr_info("SMMU disabled\n");
>> +    }
>> +
>> +    return 0;
>> +}
>> +__setup("smmu=", acpi_smmu_parse);
>> +
>>   /**
>>    * iort_set_fwnode() - Create iort_fwnode and use it to register
>>    *               iommu data in the iort_fwnode_list
>> @@ -1596,7 +1612,7 @@ static void __init 
>> iort_init_platform_devices(void)
>>           iort_enable_acs(iort_node);
>>             ops = iort_get_dev_cfg(iort_node);
>> -        if (ops) {
>> +        if (ops && !acpi_smmu_disabled) {
>
> This will also effectively disable PMCGs, which is an undocumented 
> side-effect, and not necessarily desirable - PMCG functionality is 
> largely orthogonal, and may potentially be used to monitor traffic 
> even when the associated SMMU instance is disabled.
>
> TBH there's really nothing SMMU-specific about this at all. I know 
> I've had a number of debugging situations where it would have been 
> handy to have a way to prevent a specific built-in driver from binding 
> automatically during boot, so if you really have got a compelling 
> reason to need it for SMMU, then you could still implement it 
> generically in a way that everyone could benefit from.
>
> Thanks,
> Robin.
>
>>               fwnode = acpi_alloc_fwnode_static();
>>               if (!fwnode)
>>                   return;
>>
