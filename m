Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C334263DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 06:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhJHEkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 00:40:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:51469 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhJHEkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 00:40:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226720127"
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="226720127"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 21:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="478834275"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2021 21:38:45 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 1/2] iommu/vt-d: Move intel_iommu_ops to header file
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210729163538.40101-1-andriy.shevchenko@linux.intel.com>
 <3c7663db-5b1e-3e00-3ff1-381c7a107ac9@linux.intel.com>
 <YV3LYqmsijqVAa5Y@smile.fi.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <82f7dc54-2f34-7f69-add6-fca929d1acd1@linux.intel.com>
Date:   Fri, 8 Oct 2021 12:34:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YV3LYqmsijqVAa5Y@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 10/7/21 12:14 AM, Andy Shevchenko wrote:
> On Fri, Jul 30, 2021 at 10:20:08AM +0800, Lu Baolu wrote:
>> Hi Andy,
>>
>> On 7/30/21 12:35 AM, Andy Shevchenko wrote:
>>> Compiler is not happy about hidden declaration of intel_iommu_ops.
>>>
>>> .../drivers/iommu/intel/iommu.c:414:24: warning: symbol 'intel_iommu_ops' was not declared. Should it be static?
>>>
>>> Move declaration to header file to make compiler happy.
>>
>> Thanks for the cleanup. Sharing data structures between different files
>> doesn't seem to be a good design. How about adding a helper so that the
>> intel_iommu_ops could be a static one?
> 
> I don't see any change in the upstream. What's the plan?
> Can we take my patch as a quick fix?
> 

Thanks for the reminding.

Can you please tell in which kernel configuration could above warning
be triggered?

Best regards,
baolu
