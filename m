Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D63601CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhDOFnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:43:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:42578 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhDOFn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:43:28 -0400
IronPort-SDR: USESvSCLFKEurnpcSUNwMEDJsQWqPHkinuYOj3CKDSxi5zt/1t5oYScleiXoCAsRb1LIqi7kVP
 aVcEfH20kkwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="215293714"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="215293714"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 22:43:05 -0700
IronPort-SDR: qEktfdrmGT45qn1aebxUB/pJx/fKbBwcm0+niphEjWBJrJDcuLrO5f66T2wQ+beTfa0wFwnYSB
 426qxLrFMI5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="444065380"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2021 22:43:02 -0700
Cc:     baolu.lu@linux.intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YHAoY9+w2ebYZ7VV@myrica> <20210409110305.6b0471d9@jacob-builder>
 <20210413170947.35ba9267@jacob-builder>
 <41433d99-e413-f5bf-5279-695dae6c58ba@linux.intel.com>
 <20210414112602.GA1370958@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <eb700675-f698-62e5-bbab-3d199ff58dcb@linux.intel.com>
Date:   Thu, 15 Apr 2021 13:33:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210414112602.GA1370958@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 4/14/21 7:26 PM, Jason Gunthorpe wrote:
> On Wed, Apr 14, 2021 at 02:22:09PM +0800, Lu Baolu wrote:
> 
>> I still worry about supervisor pasid allocation.
>>
>> If we use iommu_sva_alloc_pasid() to allocate a supervisor pasid, which
>> mm should the pasid be set? I've ever thought about passing &init_mm to
>> iommu_sva_alloc_pasid(). But if you add "mm != current->mm", this seems
>> not to work. Or do you prefer a separated interface for supervisor pasid
>> allocation/free?
> 
> Without a mm_struct it is not SVA, so don't use SVA APIs for whatever
> a 'supervisor pasid' is

The supervisor PASID has its mm_struct. The only difference is that the
device will set priv=1 in its DMA transactions with the PASID.

Best regards,
baolu
