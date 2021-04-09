Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E66935A52B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhDISFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:05:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:51248 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234316AbhDISFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:05:46 -0400
IronPort-SDR: 324gwhcxogtKvaBv9iom/07m4ZRGZQenOXQ729d00eTc2MQx5lGLq0FIxidsvtPdeLl4y8cStQ
 cul3Jgi9TJHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="193364216"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="193364216"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 11:05:33 -0700
IronPort-SDR: L1/U4YPgSSizYdUR951ccnL+di8YpAqnU3aL/5HnFUPuDbedxXKf+CzAXn80Pc2Z6qs/YcH+Y4
 If7uo2XhNMRQ==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="449158863"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 11:05:33 -0700
Date:   Fri, 9 Apr 2021 11:08:08 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <20210409110808.58f22606@jacob-builder>
In-Reply-To: <f29495e1-e3a0-8c45-bfca-067c1e996eca@linux.intel.com>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <f29495e1-e3a0-8c45-bfca-067c1e996eca@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On Fri, 9 Apr 2021 20:45:22 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> > -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
> > max) +int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max)
> >   {
> >   	int ret = 0;
> >   	ioasid_t pasid;
> > +	struct mm_struct *mm;
> >   
> >   	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> >   	    min == 0 || max < min)
> >   		return -EINVAL;
> >   
> >   	mutex_lock(&iommu_sva_lock);
> > +	mm = get_task_mm(current);  
> 
> How could we allocate a supervisor PASID through iommu_sva_alloc_pasid()
> if we always use current->mm here?
I don't think you can. But I guess the current callers of this function do
not need supervisor PASID.
In reply to Jean, I suggest we split this function into mm->pasid
assignment and keep using ioasid_alloc() directly, then supervisor PASID is
caller's bind choice.

Thanks,

Jacob
