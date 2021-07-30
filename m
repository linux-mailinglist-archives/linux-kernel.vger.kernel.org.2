Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD03DB8FD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbhG3NBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:01:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:7276 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhG3NBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:01:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="200265139"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="200265139"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 06:01:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="476949523"
Received: from jxie1-mobl.ccr.corp.intel.com (HELO [10.254.211.228]) ([10.254.211.228])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 06:01:43 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 1/2] iommu/vt-d: Move intel_iommu_ops to header file
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210729163538.40101-1-andriy.shevchenko@linux.intel.com>
 <3c7663db-5b1e-3e00-3ff1-381c7a107ac9@linux.intel.com>
 <YQOyzka9VDJU3NhU@smile.fi.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <17a2b3f2-747d-2798-7fea-5846eec0b1fe@linux.intel.com>
Date:   Fri, 30 Jul 2021 21:01:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQOyzka9VDJU3NhU@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/30 16:05, Andy Shevchenko wrote:
> On Fri, Jul 30, 2021 at 10:20:08AM +0800, Lu Baolu wrote:
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
> Whatever suits the purpose.
> Can you apply patch 2 of this series, please?
> 

Yes, I will. Thanks!

Best regards,
baolu
