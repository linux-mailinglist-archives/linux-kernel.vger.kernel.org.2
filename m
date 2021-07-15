Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EE03C9593
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhGOB2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:28:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:37682 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhGOB2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:28:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197721681"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="197721681"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 18:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="466322019"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2021 18:25:23 -0700
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, isaacm@codeaurora.org,
        pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/15] Optimizing iommu_[map/unmap] performance
To:     Georgi Djakov <djakov@kernel.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <e6c8993e-353e-6a05-9b6d-9a49de471cb6@kernel.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4d466ea9-2c1a-2e19-af5b-0434441ee7cb@linux.intel.com>
Date:   Thu, 15 Jul 2021 09:23:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e6c8993e-353e-6a05-9b6d-9a49de471cb6@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/21 10:24 PM, Georgi Djakov wrote:
> On 16.06.21 16:38, Georgi Djakov wrote:
>> When unmapping a buffer from an IOMMU domain, the IOMMU framework unmaps
>> the buffer at a granule of the largest page size that is supported by
>> the IOMMU hardware and fits within the buffer. For every block that
>> is unmapped, the IOMMU framework will call into the IOMMU driver, and
>> then the io-pgtable framework to walk the page tables to find the entry
>> that corresponds to the IOVA, and then unmaps the entry.
>>
>> This can be suboptimal in scenarios where a buffer or a piece of a
>> buffer can be split into several contiguous page blocks of the same size.
>> For example, consider an IOMMU that supports 4 KB page blocks, 2 MB page
>> blocks, and 1 GB page blocks, and a buffer that is 4 MB in size is being
>> unmapped at IOVA 0. The current call-flow will result in 4 indirect 
>> calls,
>> and 2 page table walks, to unmap 2 entries that are next to each other in
>> the page-tables, when both entries could have been unmapped in one shot
>> by clearing both page table entries in the same call.
>>
>> The same optimization is applicable to mapping buffers as well, so
>> these patches implement a set of callbacks called unmap_pages and
>> map_pages to the io-pgtable code and IOMMU drivers which unmaps or maps
>> an IOVA range that consists of a number of pages of the same
>> page size that is supported by the IOMMU hardware, and allows for
>> manipulating multiple page table entries in the same set of indirect
>> calls. The reason for introducing these callbacks is to give other IOMMU
>> drivers/io-pgtable formats time to change to using the new callbacks, so
>> that the transition to using this approach can be done piecemeal.
> 
> Hi Will,
> 
> Did you get a chance to look at this patchset? Most patches are already
> acked/reviewed and all still applies clean on rc1.

I also have the ops->[un]map_pages implementation for the Intel IOMMU
driver. I will post them once the iommu/core part get applied.

Best regards,
baolu
