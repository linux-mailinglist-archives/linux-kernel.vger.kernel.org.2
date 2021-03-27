Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B5634B480
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 06:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhC0FiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 01:38:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:30596 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhC0Fha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 01:37:30 -0400
IronPort-SDR: aTHJdsemKV15oiJ4Y/fPioBcbS0JLVgnJjzKRSvQ9ecL5XhGGnSN0n8ibqCAa4iNW2kFRspztp
 ZG830kCtzutw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211439953"
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="211439953"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 22:37:27 -0700
IronPort-SDR: bgF6J/eTFtCsGnhomTqp8fKEOdrPLkhq+Gv4zxNugwHsoY99GhSq49Lz7y9Tvi3KwXbRYRNjDD
 9Z+7P4gvWVHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="437134133"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2021 22:37:24 -0700
Cc:     baolu.lu@linux.intel.com,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, chenjiashang <chenjiashang@huawei.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: =?UTF-8?Q?Re=3a_A_problem_of_Intel_IOMMU_hardware_=ef=bc=9f?=
To:     Nadav Amit <nadav.amit@gmail.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
 <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <e5b262c1ee14481ab68074be2a76b9d9@huawei.com>
 <55E334BA-C6D2-4892-9207-32654FBF4360@gmail.com>
 <14fe0083-cbff-884c-34db-ce3227e026f5@linux.intel.com>
 <55A4B205-BC38-4F16-9EB9-54026C326E60@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a49ec650-5dae-0045-1ea3-1978009b3b1f@linux.intel.com>
Date:   Sat, 27 Mar 2021 13:27:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <55A4B205-BC38-4F16-9EB9-54026C326E60@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadav,

On 3/27/21 12:36 PM, Nadav Amit wrote:
> 
> 
>> On Mar 26, 2021, at 7:31 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi Nadav,
>>
>> On 3/19/21 12:46 AM, Nadav Amit wrote:
>>> So here is my guess:
>>> Intel probably used as a basis for the IOTLB an implementation of
>>> some other (regular) TLB design.
>>> Intel SDM says regarding TLBs (4.10.4.2 “Recommended Invalidation”):
>>> "Software wishing to prevent this uncertainty should not write to
>>> a paging-structure entry in a way that would change, for any linear
>>> address, both the page size and either the page frame, access rights,
>>> or other attributes.”
>>> Now the aforementioned uncertainty is a bit different (multiple
>>> *valid*  translations of a single address). Yet, perhaps this is
>>> yet another thing that might happen.
>>>  From a brief look on the handling of MMU (not IOMMU) hugepages
>>> in Linux, indeed the PMD is first cleared and flushed before a
>>> new valid PMD is set. This is possible for MMUs since they
>>> allow the software to handle spurious page-faults gracefully.
>>> This is not the case for the IOMMU though (without PRI).
>>> Not sure this explains everything though. If that is the problem,
>>> then during a mapping that changes page-sizes, a TLB flush is
>>> needed, similarly to the one Longpeng did manually.
>>
>> I have been working with Longpeng on this issue these days. It turned
>> out that your guess is right. The PMD is first cleared but not flushed
>> before a new valid one is set. The previous entry might be cached in the
>> paging structure caches hence leads to disaster.
>>
>> In __domain_mapping():
>>
>> 2352                                 /*
>> 2353                                  * Ensure that old small page tables are
>> 2354                                  * removed to make room for superpage(s).
>> 2355                                  * We're adding new large pages, so make sure
>> 2356                                  * we don't remove their parent tables.
>> 2357                                  */
>> 2358                                 dma_pte_free_pagetable(domain, iov_pfn, end_pfn,
>> 2359 largepage_lvl + 1);
>>
>> I guess adding a cache flush operation after PMD switching should solve
>> the problem.
>>
>> I am still not clear about this comment:
>>
>> "
>> This is possible for MMUs since they allow the software to handle
>> spurious page-faults gracefully. This is not the case for the IOMMU
>> though (without PRI).
>> "
>>
>> Can you please shed more light on this?
> 
> I was looking at the code in more detail, and apparently my concern
> is incorrect.
> 
> I was under the assumption that the IOMMU map/unmap can merge/split
> (specifically split) huge-pages. For instance, if you map 2MB and
> then unmap 4KB out of the 2MB, then you would split the hugepage
> and keep the rest of the mappings alive. This is the way MMU is
> usually managed. To my defense, I also saw such partial unmappings
> in Longpeng’s first scenario.
> 
> If this was possible, then you would have a case in which out of 2MB
> (for instance), 4KB were unmapped, and you need to split the 2MB
> hugepage into 4KB pages. If you try to clear the PMD, flush, and then
> set the PMD to point to table with live 4KB PTES, you can have
> an interim state in which the PMD is not present. DMAs that arrive
> at this stage might fault, and without PRI (and device support)
> you do not have a way of restarting the DMA after the hugepage split
> is completed.

Get you and thanks a lot for sharing.

For current IOMMU usage, I can't see any case to split a huge page into
4KB pages, but in the near future, we do have a need of splitting huge
pages. For example, when we want to use the A/D bit to track the DMA
dirty pages during VM migration, it's an optimization if we could split
a huge page into 4K ones. So far, the solution I have considered is:

1) Prepare the split subtables in advance;
    [it's identical to the existing one only use 4k pages instead of huge
     page.]
2) Switch the super (huge) page's leaf entry;
    [at this point, hardware could use both subtables. I am not sure
     whether the hardware allows a dynamic switch of page table entry
     from on valid entry to another valid one.]
3) Flush the cache.
    [hardware will use the new subtable]

As long as we can make sure that the old subtable won't be used by
hardware, we can safely release the old table.

> 
> Anyhow, this concern is apparently not relevant. I guess I was too
> naive to assume the IOMMU management is similar to the MMU. I now
> see that there is a comment in intel_iommu_unmap() saying:
> 
>          /* Cope with horrid API which requires us to unmap more than the
>             size argument if it happens to be a large-page mapping. */
> 
> Regards,
> Nadav
> 

Best regards,
baolu
