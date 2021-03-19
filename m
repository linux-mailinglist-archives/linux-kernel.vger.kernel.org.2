Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4A1341173
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 01:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhCSAZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 20:25:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:21205 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233372AbhCSAYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 20:24:50 -0400
IronPort-SDR: aKHZSF2tFhYZSLFiZdc8jxASu21WXcGRfiQQpdO5HWlM/B9t1PWLhXweJg06H8fhty4CyapaFJ
 izAO3PCYBnFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="187438966"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="187438966"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 17:24:50 -0700
IronPort-SDR: hIfyJd7NfvDTTF3A6e+o+p8zQyLtBTT4BdwNItraxk8PSUnAQQhxJLUXsdljRCukjriW1W6az0
 5x0Yw9TM75tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="434067658"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2021 17:24:47 -0700
Cc:     baolu.lu@linux.intel.com, chenjiashang <chenjiashang@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: =?UTF-8?Q?Re=3a_A_problem_of_Intel_IOMMU_hardware_=ef=bc=9f?=
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Nadav Amit <nadav.amit@gmail.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
 <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <aa8b989d-458b-92a3-627b-0a88e430934d@linux.intel.com>
Date:   Fri, 19 Mar 2021 08:15:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 4:56 PM, Tian, Kevin wrote:
>> From: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
>> <longpeng2@huawei.com>
>>
>>> -----Original Message-----
>>> From: Tian, Kevin [mailto:kevin.tian@intel.com]
>>> Sent: Thursday, March 18, 2021 4:27 PM
>>> To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
>>> <longpeng2@huawei.com>; Nadav Amit <nadav.amit@gmail.com>
>>> Cc: chenjiashang <chenjiashang@huawei.com>; David Woodhouse
>>> <dwmw2@infradead.org>; iommu@lists.linux-foundation.org; LKML
>>> <linux-kernel@vger.kernel.org>; alex.williamson@redhat.com; Gonglei
>> (Arei)
>>> <arei.gonglei@huawei.com>; will@kernel.org
>>> Subject: RE: A problem of Intel IOMMU hardware ？
>>>
>>>> From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of
>>>> Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
>>>>
>>>>> 2. Consider ensuring that the problem is not somehow related to
>>>>> queued invalidations. Try to use __iommu_flush_iotlb() instead of
>>> qi_flush_iotlb().
>>>>>
>>>>
>>>> I tried to force to use __iommu_flush_iotlb(), but maybe something
>>>> wrong, the system crashed, so I prefer to lower the priority of this
>> operation.
>>>>
>>>
>>> The VT-d spec clearly says that register-based invalidation can be used only
>> when
>>> queued-invalidations are not enabled. Intel-IOMMU driver doesn't provide
>> an
>>> option to disable queued-invalidation though, when the hardware is
>> capable. If you
>>> really want to try, tweak the code in intel_iommu_init_qi.
>>>
>>
>> Hi Kevin,
>>
>> Thanks to point out this. Do you have any ideas about this problem ? I tried
>> to descript the problem much clear in my reply to Alex, hope you could have
>> a look if you're interested.
>>
> 
> btw I saw you used 4.18 kernel in this test. What about latest kernel?
> 
> Also one way to separate sw/hw bug is to trace the low level interface (e.g.,
> qi_flush_iotlb) which actually sends invalidation descriptors to the IOMMU
> hardware. Check the window between b) and c) and see whether the
> software does the right thing as expected there.

Yes. It's better if we can reproduce this with the latest kernel which
has debugfs files to expose page tables and the invalidation queues etc.

Best regards,
baolu
