Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140843AE891
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFUMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:02:13 -0400
Received: from foss.arm.com ([217.140.110.172]:33540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhFUMCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:02:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92EF51FB;
        Mon, 21 Jun 2021 04:59:57 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA86F3F718;
        Mon, 21 Jun 2021 04:59:55 -0700 (PDT)
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     John Garry <john.garry@huawei.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, thunder.leizhen@huawei.com,
        chenxiang66@hisilicon.com, linux-doc@vger.kernel.org
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
 <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
 <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
Date:   Mon, 21 Jun 2021 12:59:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-21 11:34, John Garry wrote:
> On 21/06/2021 11:00, Lu Baolu wrote:
>>> void iommu_set_dma_strict(bool force)
>>> {
>>>           if (force == true)
>>>          iommu_dma_strict = true;
>>>      else if (!(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>>>          iommu_dma_strict = true;
>>> }
>>>
>>> So we would use iommu_set_dma_strict(true) for a) and b), but 
>>> iommu_set_dma_strict(false) for c).
>>
>> Yes. We need to distinguish the "must" and "nice-to-have" cases of
>> setting strict mode.
>>
>>>
>>> Then I am not sure what you want to do with the accompanying print 
>>> for c). It was:
>>> "IOMMU batching is disabled due to virtualization"
>>>
>>> And now is from this series:
>>> "IOMMU batching disallowed due to virtualization"
>>>
>>> Using iommu_get_dma_strict(domain) is not appropriate here to know 
>>> the current mode (so we know whether to print).
>>>
>>> Note that this change would mean that the current series would 
>>> require non-trivial rework, which would be unfortunate so late in the 
>>> cycle.
>>
>> This patch series looks good to me and I have added by reviewed-by.
>> Probably we could make another patch series to improve it so that the
>> kernel optimization should not override the user setting.
> 
> On a personal level I would be happy with that approach, but I think 
> it's better to not start changing things right away in a follow-up series.
> 
> So how about we add this patch (which replaces 6/6 "iommu: Remove mode 
> argument from iommu_set_dma_strict()")?
> 
> Robin, any opinion?

For me it boils down to whether there are any realistic workloads where 
non-strict mode *would* still perform better under virtualisation. The 
only reason for the user to explicitly pass "iommu.strict=0" is because 
they expect it to increase unmap performance; if it's only ever going to 
lead to an unexpected performance loss, I don't see any value in 
overriding the kernel's decision purely for the sake of subservience.

If there *are* certain valid cases for allowing it for people who really 
know what they're doing, then we should arguably also log a counterpart 
message to say "we're honouring your override but beware it may have the 
opposite effect to what you expect" for the benefit of other users who 
assume it's a generic go-faster knob. At that point it starts getting 
non-trivial enough that I'd want to know for sure it's worthwhile.

The other reason this might be better to revisit later is that an AMD 
equivalent is still in flight[1], and there might be more that can 
eventually be factored out. I think both series are pretty much good to 
merge for 5.14, but time's already tight to sort out the conflicts which 
exist as-is, without making them any worse.

Robin.

[1] 
https://lore.kernel.org/linux-iommu/20210616100500.174507-3-namit@vmware.com/

> 
> ------->8---------
> 
> [PATCH] iommu/vt-d: Make "iommu.strict" override batching due to
>   virtualization
> 
> As a change in policy, make iommu.strict cmdline argument override 
> whether we disable batching due to virtualization.
> 
> The API of iommu_set_dma_strict() is changed to accept a "force" 
> argument, which means that we always set iommu_dma_strict true, 
> regardless of whether we already set via cmdline. Also return a boolean, 
> to tell whether iommu_dma_strict was set or not.
> 
> Note that in all pre-existing callsites of iommu_set_dma_strict(), 
> argument strict was true, so this argument is dropped.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 06666f9d8116..e8d65239b359 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4380,10 +4380,8 @@ int __init intel_iommu_init(void)
>            * is likely to be much lower than the overhead of synchronizing
>            * the virtual and physical IOMMU page-tables.
>            */
> -        if (cap_caching_mode(iommu->cap)) {
> +        if (cap_caching_mode(iommu->cap) && iommu_set_dma_strict(false))
>               pr_info_once("IOMMU batching disallowed due to 
> virtualization\n");
> -            iommu_set_dma_strict(true);
> -        }
>           iommu_device_sysfs_add(&iommu->iommu, NULL,
>                          intel_iommu_groups,
>                          "%s", iommu->name);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 60b1ec42e73b..1434bee64af3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -349,10 +349,14 @@ static int __init iommu_dma_setup(char *str)
>   }
>   early_param("iommu.strict", iommu_dma_setup);
> 
> -void iommu_set_dma_strict(bool strict)
> +/* Return true if we set iommu_dma_strict */
> +bool iommu_set_dma_strict(bool force)
>   {
> -    if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
> -        iommu_dma_strict = strict;
> +    if (force || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT)) {
> +        iommu_dma_strict = true;
> +        return true;
> +    }
> +    return false;
>   }
> 
>   bool iommu_get_dma_strict(struct iommu_domain *domain)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..f17b20234296 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -476,7 +476,7 @@ int iommu_enable_nesting(struct iommu_domain *domain);
>   int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>           unsigned long quirks);
> 
> -void iommu_set_dma_strict(bool val);
> +bool iommu_set_dma_strict(bool force);
>   bool iommu_get_dma_strict(struct iommu_domain *domain);
> 
>   extern int report_iommu_fault(struct iommu_domain *domain, struct 
> device *dev,
