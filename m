Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2151333E916
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCQF0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:26:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:18632 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhCQF0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:26:13 -0400
IronPort-SDR: zfcDJGCeXw8RcMpmgQUAB4YDdhrGxzaNG+m7XaIttT6m1m/DHeJjQ/lmtIk5ypDOz5MLgVhORf
 z3FdJS7w/p0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="168667102"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="168667102"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 22:26:12 -0700
IronPort-SDR: pP2Ftc14oJmJzDdv3e0Lpze7LE3K7W50dR1K6vJZG7oxorwpgDDiAAHo0l7q8/mz3X8X4gkqQv
 P5by0FTZB6eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="433266629"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2021 22:26:10 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, chenjiashang@huawei.com
Subject: =?UTF-8?Q?Re=3a_A_problem_of_Intel_IOMMU_hardware_=ef=bc=9f?=
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, dwmw2@infradead.org, joro@8bytes.org,
        will@kernel.org, alex.williamson@redhat.com
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <692186fd-42b8-4054-ead2-f6c6b1bf5b2d@linux.intel.com>
Date:   Wed, 17 Mar 2021 13:16:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Longpeng,

On 3/17/21 11:16 AM, Longpeng (Mike, Cloud Infrastructure Service 
Product Dept.) wrote:
> Hi guys,
> 
> We find the Intel iommu cache (i.e. iotlb) maybe works wrong in a special
> situation, it would cause DMA fails or get wrong data.
> 
> The reproducer (based on Alex's vfio testsuite[1]) is in attachment, it can
> reproduce the problem with high probability (~50%).
> 
> The machine we used is:
> processor	: 47
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 85
> model name	: Intel(R) Xeon(R) Gold 6146 CPU @ 3.20GHz
> stepping	: 4
> microcode	: 0x2000069
> 
> And the iommu capability reported is:
> ver 1:0 cap 8d2078c106f0466 ecap f020df
> (caching mode = 0 , page-selective invalidation = 1)
> 
> (The problem is also on 'Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz' and
> 'Intel(R) Xeon(R) Platinum 8378A CPU @ 3.00GHz')
> 
> We run the reproducer on Linux 4.18 and it works as follow:
> 
> Step 1. alloc 4G *2M-hugetlb* memory (N.B. no problem with 4K-page mapping)

I don't understand 2M-hugetlb here means exactly. The IOMMU hardware
supports both 2M and 1G super page. The mapping physical memory is 4G.
Why couldn't it use 1G super page?

> Step 2. DMA Map 4G memory
> Step 3.
>      while (1) {
>          {UNMAP, 0x0, 0xa0000}, ------------------------------------ (a)
>          {UNMAP, 0xc0000, 0xbff40000},

Have these two ranges been mapped before? Does the IOMMU driver
complains when you trying to unmap a range which has never been
mapped? The IOMMU driver implicitly assumes that mapping and
unmapping are paired.

>          {MAP,   0x0, 0xc0000000}, --------------------------------- (b)
>                  use GDB to pause at here, and then DMA read IOVA=0,

IOVA 0 seems to be a special one. Have you verified with other addresses
than IOVA 0?

>                  sometimes DMA success (as expected),
>                  but sometimes DMA error (report not-present).
>          {UNMAP, 0x0, 0xc0000000}, --------------------------------- (c)
>          {MAP,   0x0, 0xa0000},
>          {MAP,   0xc0000, 0xbff40000},
>      }
> 
> The DMA read operations sholud success between (b) and (c), it should NOT report
> not-present at least!
> 
> After analysis the problem, we think maybe it's caused by the Intel iommu iotlb.
> It seems the DMA Remapping hardware still uses the IOTLB or other caches of (a).
> 
> When do DMA unmap at (a), the iotlb will be flush:
>      intel_iommu_unmap
>          domain_unmap
>              iommu_flush_iotlb_psi
> 
> When do DMA map at (b), no need to flush the iotlb according to the capability
> of this iommu:
>      intel_iommu_map
>          domain_pfn_mapping
>              domain_mapping
>                  __mapping_notify_one
>                      if (cap_caching_mode(iommu->cap)) // FALSE
>                          iommu_flush_iotlb_psi

That's true. The iotlb flushing is not needed in case of PTE been
changed from non-present to present unless caching mode.

> But the problem will disappear if we FORCE flush here. So we suspect the iommu
> hardware.
> 
> Do you have any suggestion ?

Best regards,
baolu
