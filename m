Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E547039A69C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFCRGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:06:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3151 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFCRGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:06:34 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FwsXl6FVKz6V03M;
        Fri,  4 Jun 2021 00:58:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 19:04:48 +0200
Received: from [10.47.80.115] (10.47.80.115) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 18:04:47 +0100
Subject: Re: [PATCH v10 1/3] iommu: Enhance IOMMU default DMA mode build
 options
To:     Randy Dunlap <rdunlap@infradead.org>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1622728715-209296-1-git-send-email-john.garry@huawei.com>
 <1622728715-209296-2-git-send-email-john.garry@huawei.com>
 <c8107ae9-b099-459f-eea4-b9b5a0929ee2@infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <18764b43-6c60-eb6d-783f-b7d4fe146b8e@huawei.com>
Date:   Thu, 3 Jun 2021 18:04:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c8107ae9-b099-459f-eea4-b9b5a0929ee2@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.115]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2021 18:00, Randy Dunlap wrote:
>> +config IOMMU_DEFAULT_STRICT
>> +	bool "strict"
>> +	help
>> +	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
>> +	  the free operation of IOVA are guaranteed to be done in the unmap
>> +	  function.
>> +
>> +	  This mode is safer than the two above, but it maybe slower in some
> There don't seem to be two above?
> 

Right, it's a remnant from a previous version - will fix, pending other 
reviews

>> +	  high performace scenarios.
> 	       performance
> 

ok

>> +
>> +endchoice

Thanks!
