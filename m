Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DF630EA1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhBDCYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:24:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:51988 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233319AbhBDCYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:24:15 -0500
IronPort-SDR: cac9dxpttsxUYNzNDrdgslplhayXDO+/OvVz4wyEOkYwQzljwT+OwKxu6EtRQgLAzjZiT/NxxK
 jXKnvjWFpCDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="178595165"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="178595165"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 18:22:23 -0800
IronPort-SDR: bfbJNbtpCiAp/iCc1C/HPmhsgk4/5FQGkCyHNxR8SYEXxAb9XGI7ytsS2m7O8uAoua5+CwCQ08
 K31AJ9mFy35g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="406918072"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 18:22:21 -0800
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 3/3] iommu/vt-d: Apply SATC policy
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
 <20210203093329.1617808-4-baolu.lu@linux.intel.com>
 <MWHPR11MB1886133A35BA369F7EF3014A8CB39@MWHPR11MB1886.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c6956ddc-31d8-33dd-f99d-63d0ac006b8e@linux.intel.com>
Date:   Thu, 4 Feb 2021 10:13:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886133A35BA369F7EF3014A8CB39@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2/4/21 9:59 AM, Tian, Kevin wrote:
>> From: Lu Baolu
>> Sent: Wednesday, February 3, 2021 5:33 PM
>>
>> From: Yian Chen<yian.chen@intel.com>
>>
>> Starting from Intel VT-d v3.2, Intel platform BIOS can provide a new SATC
>> table structure. SATC table lists a set of SoC integrated devices that
>> require ATC to work (VT-d specification v3.2, section 8.8). Furthermore,
> This statement is not accurate. The purpose of SATC is to tell whether a
> SoC integrated device has been validated to meet the isolation requirements
> of using device TLB. All devices listed in SATC can have ATC safely enabled by
> OS. In addition, there is a flag for each listed device for whether ATC is a
> functional requirement. However, above description only captured the last
> point.

You are right. This series only addresses the devices with the flag set
which have functional requirement for ATS.

> 
>> the new version of IOMMU supports SoC device ATS in both its Scalable
>> mode
>> and legacy mode.
>>
>> When IOMMU is working in scalable mode, software must enable device ATS
>> support.
> "must enable" is misleading here. You need describe the policies for three
> categories:
> 
> - SATC devices with ATC_REQUIRED=1
> - SATC devices with ATC_REQUIRED=0
> - devices not listed in SATC, or when SATC is missing

Yian is working on this part. We planed it for v5.13. He will bring it
up for discussion later.

> 
>> On the other hand, when IOMMU is in legacy mode for whatever
>> reason, the hardware managed ATS will automatically take effect and the
>> SATC required devices can work transparently to the software. As the
> No background about hardware-managed ATS.
> 
>> result, software shouldn't enable ATS on that device, otherwise duplicate
>> device TLB invalidations will occur.
> This description draws a equation between legacy mode and hardware
> managed ATS. Do we care about the scenario where there is no hardware
> managed ATS but people also want to turn on ATC in legacy mode?

The hardware managed ATS is defined in the platform specific
specification. The purpose of this hardware design is backward
compatibility - legacy OSes with no SM or ATS awareness still running
well on them.

> 
> Thanks
> Kevin
> 

Best regards,
baolu
