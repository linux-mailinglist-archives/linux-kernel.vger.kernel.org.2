Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23035ED3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347930AbhDNGco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:32:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:25036 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231831AbhDNGc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:32:26 -0400
IronPort-SDR: XhwycpHN6oHcXIMOs2W5zE7xuKkVZyVdu2kwZ3FMGG+QdG3vNijWAP8+gQa/T80Afb30sKKzh5
 KoPxaFjncsIg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194603677"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="194603677"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 23:31:49 -0700
IronPort-SDR: jtTk4WrJ1bqaHDp2OMiOJLdZVz7CpNjV6TV1Sg570t5Pli+ReRHeJNydL3jvtdloMOYZwH7tn6
 r2LcAEzJYvOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="443703998"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2021 23:31:45 -0700
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YHAoY9+w2ebYZ7VV@myrica> <20210409110305.6b0471d9@jacob-builder>
 <20210413170947.35ba9267@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <41433d99-e413-f5bf-5279-695dae6c58ba@linux.intel.com>
Date:   Wed, 14 Apr 2021 14:22:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210413170947.35ba9267@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/14/21 8:09 AM, Jacob Pan wrote:
> Hi Jean,
> 
> On Fri, 9 Apr 2021 11:03:05 -0700, Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
> 
>>> problems:
>>>
>>> * We don't have a use-case for binding the mm of a remote process (and
>>>    it's supposedly difficult for device drivers to do it securely). So
>>> OK, we remove the mm argument from iommu_sva_bind_device() and use the
>>>    current mm. But the IOMMU driver isn't going to do
>>> get_task_mm(current) every time it needs the mm being bound, it will
>>> take it from iommu_sva_bind_device(). Likewise iommu_sva_alloc_pasid()
>>> shouldn't need to bother with get_task_mm().
>>>
>>> * cgroup accounting for IOASIDs needs to be on the current task.
>>> Removing the mm parameter from iommu_sva_alloc_pasid() doesn't help
>>> with that. Sure it indicates that iommu_sva_alloc_pasid() needs a
>>> specific task context but that's only for cgroup purpose, and I'd
>>> rather pass the cgroup down from iommu_sva_bind_device() anyway (but am
>>> fine with keeping it within ioasid_alloc() for now). Plus it's an
>>> internal helper, easy for us to check that the callers are doing the
>>> right thing.
>> With the above split, we really just have one allocation function:
>> ioasid_alloc(), so it can manage current cgroup accounting within. Would
>> this work?
> After a few attempts, I don't think the split can work better. I will
> restore the mm parameter and add a warning if mm != current->mm.

I still worry about supervisor pasid allocation.

If we use iommu_sva_alloc_pasid() to allocate a supervisor pasid, which
mm should the pasid be set? I've ever thought about passing &init_mm to
iommu_sva_alloc_pasid(). But if you add "mm != current->mm", this seems
not to work. Or do you prefer a separated interface for supervisor pasid
allocation/free?

Best regards,
baolu

> 
> Thanks,
> 
> Jacob
> 
