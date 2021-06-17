Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD93AADF3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhFQHtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:49:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3259 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQHtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:49:46 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5DRj6q8Rz6L7kw;
        Thu, 17 Jun 2021 15:37:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 09:47:36 +0200
Received: from [10.47.95.81] (10.47.95.81) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 08:47:36 +0100
Subject: Re: [PATCH v13 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>, <robin.murphy@arm.com>,
        <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, <linux-doc@vger.kernel.org>
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-7-git-send-email-john.garry@huawei.com>
 <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c61376c8-5285-1121-046f-3ab12eee9902@huawei.com>
Date:   Thu, 17 Jun 2021 08:41:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.95.81]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> @@ -349,10 +349,9 @@ static int __init iommu_dma_setup(char *str)
>>   }
>>   early_param("iommu.strict", iommu_dma_setup);
>> -void iommu_set_dma_strict(bool strict)
>> +void iommu_set_dma_strict(void)
>>   {
>> -    if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>> -        iommu_dma_strict = strict;
>> +    iommu_dma_strict = true;
> 
> Sorry, I still can't get how iommu.strict kernel option works.
> 
> static int __init iommu_dma_setup(char *str)
> {
>          int ret = kstrtobool(str, &iommu_dma_strict);
> 
>          if (!ret)
>                  iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
>          return ret;
> }
> early_param("iommu.strict", iommu_dma_setup);
> 
> The bit IOMMU_CMD_LINE_STRICT is only set, but not used anywhere.

It is used in patch 2/6:

+	pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
+		iommu_dma_strict ? "strict" : "lazy",
+		(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
+			"(set via kernel command line)" : "");

> Hence,
> I am wondering how could it work? A bug or I missed anything?

It is really just used for informative purpose now.

Thanks,
john
