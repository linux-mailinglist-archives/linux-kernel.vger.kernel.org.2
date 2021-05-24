Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5C738F34C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhEXSw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:52:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:59146 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232803AbhEXSw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:52:58 -0400
IronPort-SDR: iYCIIjaymPnozQdVbEbxtnsoopmNQIl0lNrWFPF5XuiIMqEKWCpxHipUJywLumugKEtqKCQb5y
 m0WP08RKo6pw==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="287575831"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="287575831"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 11:51:29 -0700
IronPort-SDR: RNZ8k4y7Dqu3VMsWlUlKIJhsjK32Ac+Vjq5htQ4XbAxZ7FPuAoF4iIVMPRWMABZtl/e+i4ERa4
 xDq5jozJnwAg==
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="546467113"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 11:51:28 -0700
Date:   Mon, 24 May 2021 11:54:00 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, <ashok.raj@intel.com>,
        <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH 01/11] iommu/vt-d: Add pasid private data helpers
Message-ID: <20210524115400.52df4d97@jacob-builder>
In-Reply-To: <15bdf989-40c9-2b45-0fb6-273a43479789@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
        <20210520031531.712333-2-baolu.lu@linux.intel.com>
        <20210521142518.25087d34@jacob-builder>
        <15bdf989-40c9-2b45-0fb6-273a43479789@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On Mon, 24 May 2021 10:16:18 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> Hi Jacob,
> 
> Thanks for reviewing my patch.
> 
> On 5/22/21 5:25 AM, Jacob Pan wrote:
> > Hi BaoLu,
> > 
> > On Thu, 20 May 2021 11:15:21 +0800, Lu Baolu <baolu.lu@linux.intel.com>
> > wrote:
> >   
> >> We are about to use iommu_sva_alloc/free_pasid() helpers in iommu core.
> >> That means the pasid life cycle will be managed by iommu core. Use a
> >> local array to save the per pasid private data instead of attaching it
> >> the real pasid.
> >>  
> > I feel a little awkward to have a separate xarray for storing per IOASID
> > data. Seems duplicated.
> > Jason suggested in another thread that we can make ioasid_data public
> > and embeded in struct intel_svm, then we can get rid of the private data
> > pointer. ioasid_find will return the ioasid_data, then we can retrieve
> > the private data with container_of.  
> 
> The problem that this patch wants to solve is that the
> iommu_sva_alloc_pasid() will attach the mm pointer to the sva pasid.
> 
>          pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> 
> Assuming that each sva pasid can have only a single private data
> pointer, the vendor iommu driver shouldn't set the private data again.
> 
You are right. I got confused with vSVM, the guest will have the private
data assigned after the bind.

> > 
> > roughly,
> > 
> > struct intel_svm {
> > 	...
> > 	struct ioasid_data;
> > };
> > 
> > struct ioasid_data {
> > 	ioasid_t id;
> > 	refcount_t refs;
> > 	struct mm_struct *mm;
> > };
> > 
> > This can be a separate patch/effort if it make sense to you.  
> 
> Yes if we have a better solution.
> 
Will be part of the IOASID core change.

Thanks,
> Best regards,
> baolu


Thanks,

Jacob
