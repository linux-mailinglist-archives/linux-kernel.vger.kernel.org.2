Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AE6426A55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbhJHMBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:01:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:33463 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhJHMBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:01:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226392004"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="226392004"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 04:59:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="489436095"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.185]) ([10.254.215.185])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 04:59:27 -0700
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
Message-ID: <6cb6f2eb-700a-fbc9-2b3f-cca95c8db64d@linux.intel.com>
Date:   Fri, 8 Oct 2021 19:59:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YV3LYqmsijqVAa5Y@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2021/10/7 0:14, Andy Shevchenko wrote:
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

This patch will cause below build error:

drivers/iommu/intel/dmar.c: In function ‘alloc_iommu’:
drivers/iommu/intel/dmar.c:1140:47: error: ‘intel_iommu_ops’ undeclared 
(first use in this function); did you mean ‘intel_iommu_groups’?
  1140 |   err = iommu_device_register(&iommu->iommu, &intel_iommu_ops, 
NULL);
       |                                               ^~~~~~~~~~~~~~~
       |                                               intel_iommu_groups
drivers/iommu/intel/dmar.c:1140:47: note: each undeclared identifier is 
reported only once for each function it appears in
make[3]: *** [scripts/Makefile.build:277: drivers/iommu/intel/dmar.o] Error

if

# CONFIG_INTEL_IOMMU is not set
CONFIG_IRQ_REMAP=y

Best regards,
baolu
