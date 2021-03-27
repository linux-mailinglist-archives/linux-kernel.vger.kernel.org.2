Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1672A34B3DB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 03:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhC0Cl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 22:41:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:6157 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhC0Ck7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 22:40:59 -0400
IronPort-SDR: c8jdTvNTNqIAz8Y+A9kzFLjrJtd8+X4jLtaz46lGSN4OrDvxyz4qpymn0n/10mlqVw2NAT8UUM
 03XsQRO6Ctlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191348188"
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="191348188"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 19:40:58 -0700
IronPort-SDR: d14WaLxija5o/8mdOjY92Du6phvwkx02sNxLC9N44mZPFZ5Qeue1PGPo1BzjlsuRO9687m6Qjm
 JH+71DgQhY7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="437098251"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2021 19:40:55 -0700
Cc:     baolu.lu@linux.intel.com, chenjiashang <chenjiashang@huawei.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: =?UTF-8?Q?Re=3a_A_problem_of_Intel_IOMMU_hardware_=ef=bc=9f?=
To:     Nadav Amit <nadav.amit@gmail.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
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
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <14fe0083-cbff-884c-34db-ce3227e026f5@linux.intel.com>
Date:   Sat, 27 Mar 2021 10:31:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <55E334BA-C6D2-4892-9207-32654FBF4360@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadav,

On 3/19/21 12:46 AM, Nadav Amit wrote:
> So here is my guess:
> 
> Intel probably used as a basis for the IOTLB an implementation of
> some other (regular) TLB design.
> 
> Intel SDM says regarding TLBs (4.10.4.2 “Recommended Invalidation”):
> 
> "Software wishing to prevent this uncertainty should not write to
> a paging-structure entry in a way that would change, for any linear
> address, both the page size and either the page frame, access rights,
> or other attributes.”
> 
> 
> Now the aforementioned uncertainty is a bit different (multiple
> *valid*  translations of a single address). Yet, perhaps this is
> yet another thing that might happen.
> 
>  From a brief look on the handling of MMU (not IOMMU) hugepages
> in Linux, indeed the PMD is first cleared and flushed before a
> new valid PMD is set. This is possible for MMUs since they
> allow the software to handle spurious page-faults gracefully.
> This is not the case for the IOMMU though (without PRI).
> 
> Not sure this explains everything though. If that is the problem,
> then during a mapping that changes page-sizes, a TLB flush is
> needed, similarly to the one Longpeng did manually.

I have been working with Longpeng on this issue these days. It turned
out that your guess is right. The PMD is first cleared but not flushed
before a new valid one is set. The previous entry might be cached in the
paging structure caches hence leads to disaster.

In __domain_mapping():

2352                                 /*
2353                                  * Ensure that old small page 
tables are
2354                                  * removed to make room for 
superpage(s).
2355                                  * We're adding new large pages, so 
make sure
2356                                  * we don't remove their parent tables.
2357                                  */
2358                                 dma_pte_free_pagetable(domain, 
iov_pfn, end_pfn,
2359 
largepage_lvl + 1);

I guess adding a cache flush operation after PMD switching should solve
the problem.

I am still not clear about this comment:

"
  This is possible for MMUs since they allow the software to handle
  spurious page-faults gracefully. This is not the case for the IOMMU
  though (without PRI).
"

Can you please shed more light on this?

Best regards,
baolu
