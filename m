Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C013D5886
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhGZKvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:51:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:16342 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233450AbhGZKvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:51:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="211931777"
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="211931777"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 04:31:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="504862219"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.209]) ([10.254.214.209])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 04:31:33 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org
Subject: Re: [PATCH 18/23] iommu: Express DMA strictness via the domain type
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1626888444.git.robin.murphy@arm.com>
 <37708e21b55e17eb074ef145afc2157cd0192abe.1626888445.git.robin.murphy@arm.com>
 <f5e902ce-54a2-af7b-b42e-f61f7f96c68e@linux.intel.com>
 <77057c4b-479b-c5b8-4666-f16e294552d1@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <832b7db0-4eb2-9151-c2b3-db709aee3230@linux.intel.com>
Date:   Mon, 26 Jul 2021 19:31:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <77057c4b-479b-c5b8-4666-f16e294552d1@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/26 16:27, Robin Murphy wrote:
> On 2021-07-24 06:29, Lu Baolu wrote:
>> Hi Robin,
>>
>> On 2021/7/22 2:20, Robin Murphy wrote:
>>> Eliminate the iommu_get_dma_strict() indirection and pipe the
>>> information through the domain type from the beginning. Besides
>>> the flow simplification this also has several nice side-effects:
>>>
>>>   - Automatically implies strict mode for untrusted devices by
>>>     virtue of their IOMMU_DOMAIN_DMA override.
>>>   - Ensures that we only ends up using flush queues for drivers
>>>     which are aware of them and can actually benefit.
>>
>> Is this expressed by vendor iommu driver has ops->flush_iotlb_all?
> 
> No, it's literally whether ->domain_alloc accepts the DMA_DOMAIN_FQ type 
> or not.

Get it. Thank you!

Best regards,
baolu
