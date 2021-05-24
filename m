Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B038DF2D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 04:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhEXCSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 22:18:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:3330 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232124AbhEXCSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 22:18:46 -0400
IronPort-SDR: /5PsOSlnkcM77zm5P2vzJ+Xnud16lR3KGaNZh/kwXCkgGcbP3JXNQgiet/dYXECGGy1K1PHy6K
 Qk0/N17ctT4g==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="222987765"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="222987765"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 19:17:19 -0700
IronPort-SDR: 7SMFPUlYsxODckSA8W+JRGKXO9N/ABdGUtRQD3O0Wc4Oxhqc7lfJOmlKS6L5fv/AwCN6tL7RvK
 GmrFqoa2dpwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="629456472"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105]) ([10.239.159.105])
  by fmsmga006.fm.intel.com with ESMTP; 23 May 2021 19:17:16 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        ashok.raj@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] iommu/vt-d: Add pasid private data helpers
To:     Jacob Pan <jacob.jun.pan@intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
 <20210520031531.712333-2-baolu.lu@linux.intel.com>
 <20210521142518.25087d34@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <15bdf989-40c9-2b45-0fb6-273a43479789@linux.intel.com>
Date:   Mon, 24 May 2021 10:16:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521142518.25087d34@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

Thanks for reviewing my patch.

On 5/22/21 5:25 AM, Jacob Pan wrote:
> Hi BaoLu,
> 
> On Thu, 20 May 2021 11:15:21 +0800, Lu Baolu <baolu.lu@linux.intel.com>
> wrote:
> 
>> We are about to use iommu_sva_alloc/free_pasid() helpers in iommu core.
>> That means the pasid life cycle will be managed by iommu core. Use a
>> local array to save the per pasid private data instead of attaching it
>> the real pasid.
>>
> I feel a little awkward to have a separate xarray for storing per IOASID
> data. Seems duplicated.
> Jason suggested in another thread that we can make ioasid_data public
> and embeded in struct intel_svm, then we can get rid of the private data
> pointer. ioasid_find will return the ioasid_data, then we can retrieve the
> private data with container_of.

The problem that this patch wants to solve is that the
iommu_sva_alloc_pasid() will attach the mm pointer to the sva pasid.

         pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);

Assuming that each sva pasid can have only a single private data
pointer, the vendor iommu driver shouldn't set the private data again.

> 
> roughly,
> 
> struct intel_svm {
> 	...
> 	struct ioasid_data;
> };
> 
> struct ioasid_data {
> 	ioasid_t id;
> 	refcount_t refs;
> 	struct mm_struct *mm;
> };
> 
> This can be a separate patch/effort if it make sense to you.

Yes if we have a better solution.

Best regards,
baolu
