Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFBF3E9335
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhHKODR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:03:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:44021 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231799AbhHKODQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:03:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="214859605"
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="214859605"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:02:53 -0700
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="516745657"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.159]) ([10.254.213.159])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:02:51 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 1/2] iommu/vt-d: Move intel_iommu_ops to header file
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210729163538.40101-1-andriy.shevchenko@linux.intel.com>
 <3c7663db-5b1e-3e00-3ff1-381c7a107ac9@linux.intel.com>
 <YQOyzka9VDJU3NhU@smile.fi.intel.com>
 <17a2b3f2-747d-2798-7fea-5846eec0b1fe@linux.intel.com>
 <YRPVfES0aTbfaHES@smile.fi.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f0f98e37-2486-fe79-7950-0a117a59b303@linux.intel.com>
Date:   Wed, 11 Aug 2021 22:02:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRPVfES0aTbfaHES@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/11 21:49, Andy Shevchenko wrote:
> On Fri, Jul 30, 2021 at 09:01:41PM +0800, Lu Baolu wrote:
>> On 2021/7/30 16:05, Andy Shevchenko wrote:
>>> On Fri, Jul 30, 2021 at 10:20:08AM +0800, Lu Baolu wrote:
>>>> On 7/30/21 12:35 AM, Andy Shevchenko wrote:
>>>>> Compiler is not happy about hidden declaration of intel_iommu_ops.
>>>>>
>>>>> .../drivers/iommu/intel/iommu.c:414:24: warning: symbol 'intel_iommu_ops' was not declared. Should it be static?
>>>>>
>>>>> Move declaration to header file to make compiler happy.
>>>>
>>>> Thanks for the cleanup. Sharing data structures between different files
>>>> doesn't seem to be a good design. How about adding a helper so that the
>>>> intel_iommu_ops could be a static one?
>>>
>>> Whatever suits the purpose.
>>> Can you apply patch 2 of this series, please?
>>>
>>
>> Yes, I will. Thanks!
> 
> Gentle reminder.
> 

Thanks. Normally I will queue the vt-d patches to Joerg in the rc6 week.

Best regards,
baolu
