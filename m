Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4403AC0A6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhFRBz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:55:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:26655 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhFRBz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:55:27 -0400
IronPort-SDR: fw1zNkt50bmiJR4APLQY6qLvaqHBaUyebh142HBugncQuw+pkYY2A29mFXhWoIoZWQhinRVrhX
 bp+Q+a7URkhg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270328631"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="270328631"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 18:53:18 -0700
IronPort-SDR: Q5vu6PcEGBkldERazoleVuGDdZijSRvTVciKwDk0WAnv8lUAoPMVEHc8AnTcAQzhMepbLoAcKJ
 DIMIojw+Gw+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="472612920"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 18:53:16 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v13 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-7-git-send-email-john.garry@huawei.com>
 <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
 <7d0fb0e2-4671-16db-6963-b0493d7a549b@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b6484679-0950-8c8e-98c5-da0e4c1d97e2@linux.intel.com>
Date:   Fri, 18 Jun 2021 09:51:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7d0fb0e2-4671-16db-6963-b0493d7a549b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 6/18/21 2:56 AM, Robin Murphy wrote:
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 60b1ec42e73b..ff221d3ddcbc 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -349,10 +349,9 @@ static int __init iommu_dma_setup(char *str)
>>>   }
>>>   early_param("iommu.strict", iommu_dma_setup);
>>> -void iommu_set_dma_strict(bool strict)
>>> +void iommu_set_dma_strict(void)
>>>   {
>>> -    if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>>> -        iommu_dma_strict = strict;
>>> +    iommu_dma_strict = true;
>>
>> Sorry, I still can't get how iommu.strict kernel option works.
>>
>> static int __init iommu_dma_setup(char *str)
>> {
>>          int ret = kstrtobool(str, &iommu_dma_strict);
> 
> Note that this is the bit that does the real work - if the argument 
> parses OK then iommu_dma_strict is reassigned with the appropriate 
> value. The iommu_cmd_line stuff is a bit of additional bookkeeping, 
> basically just so we can see whether default values have been overridden.

Ah, get it. Thanks a lot. I missed this part and naively thought it just
converts a string to integer.

Best regards,
baolu
