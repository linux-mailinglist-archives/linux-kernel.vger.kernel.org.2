Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04453DA054
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhG2JhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:37:10 -0400
Received: from foss.arm.com ([217.140.110.172]:43394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235633AbhG2JhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:37:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7761D1FB;
        Thu, 29 Jul 2021 02:37:04 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B5533F73D;
        Thu, 29 Jul 2021 02:37:02 -0700 (PDT)
Subject: Re: [PATCH v2 18/24] iommu: Express DMA strictness via the domain
 type
To:     Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <50bee17e9248ccfccb33a10238210d4ff4f4cf4d.1627468309.git.robin.murphy@arm.com>
 <b479f1f9-ecf2-2798-2df8-ae3d4c06bc63@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f2858a7f-e665-ff6a-38d6-b9d591287fac@arm.com>
Date:   Thu, 29 Jul 2021 10:36:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b479f1f9-ecf2-2798-2df8-ae3d4c06bc63@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-29 08:13, Lu Baolu wrote:
> Hi Robin,
> 
> On 7/28/21 11:58 PM, Robin Murphy wrote:
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 982545234cf3..eecb5657de69 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -136,6 +136,9 @@ static int __init iommu_subsys_init(void)
>>           }
>>       }
>> +    if (!iommu_default_passthrough() && !iommu_dma_strict)
>> +        iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;
> 
> iommu_dma_strict could be changed later by the vendor iommu driver via
> iommu_set_dma_strict(). This seems not to be the right place to set
> iommu_def_domain_type.

Ah yes, good catch once again, thanks!

I think this *is* the right place to initially set it to honour the 
command-line option, since that matches what we do for passthrough. 
However also like passthrough we'll need to keep things in sync if it's 
updated later, like this:


diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 87d7b299436e..593d4555bc57 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -359,6 +359,8 @@ early_param("iommu.strict", iommu_dma_setup);
  void iommu_set_dma_strict(void)
  {
         iommu_dma_strict = true;
+       if (iommu_def_domain_type == IOMMU_DOMAIN_DMA_FQ)
+               iommu_def_domain_type = IOMMU_DOMAIN_DMA;
  }

  static ssize_t iommu_group_attr_show(struct kobject *kobj,


Does that seem reasonable? I'm not sure there's any cleaner way to do it 
since we don't want to inadvertently clobber the default type if the 
user has given us something funky like "intel_iommu=strict 
iommu.passthrough=1".

Cheers,
Robin.

> 
>> +
>>       pr_info("Default domain type: %s %s\n",
>>           iommu_domain_type_str(iommu_def_domain_type),
>>           (iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
> 
> Best regards,
> baolu
