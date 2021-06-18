Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDFF3AC518
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhFRHjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 03:39:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3265 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhFRHjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:39:35 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5r5Q1d3Jz6GB6f;
        Fri, 18 Jun 2021 15:24:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 09:37:22 +0200
Received: from [10.47.95.81] (10.47.95.81) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 08:37:21 +0100
Subject: Re: [PATCH v13 4/6] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>, <robin.murphy@arm.com>,
        <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, <linux-doc@vger.kernel.org>
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-5-git-send-email-john.garry@huawei.com>
 <46dbce5c-1c2b-60d4-df56-d2b95a959425@linux.intel.com>
 <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
 <d53a6472-4628-313e-30a5-f76e016c9cb9@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b654480e-d5ac-9e4c-1074-1158cccc5806@huawei.com>
Date:   Fri, 18 Jun 2021 08:31:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <d53a6472-4628-313e-30a5-f76e016c9cb9@linux.intel.com>
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

On 18/06/2021 02:46, Lu Baolu wrote:

Hi baolu,

>> I need to change that. How about this:
>>
>> bool print_warning = false;
>>
>> for_each_active_iommu(iommu, drhd) {
>>      /*
>>       * The flush queue implementation does not perform
>>       * page-selective invalidations that are required for efficient
>>       * TLB flushes in virtual environments.  The benefit of batching
>>       * is likely to be much lower than the overhead of synchronizing
>>       * the virtual and physical IOMMU page-tables.
>>       */
>>      if (!print_warning && cap_caching_mode(iommu->cap)) {
>>          pr_warn("IOMMU batching disallowed due to virtualization\n");
>>          iommu_set_dma_strict(true);
>>          print_warning = true;
>>      }
>>      ...
>> }
>>
>> or use pr_warn_once().
> 
>  From my p.o.v, pr_xxxx_once() is better.
> 
> How about using a pr_info_once()? I don't think it's a warning, it's
> just a policy choice in VM environment.

ok, I can go with that, which Robin mostly agrees with.

Thanks,
John
