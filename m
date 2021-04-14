Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E59935E9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 02:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhDNAHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 20:07:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:42281 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhDNAHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 20:07:31 -0400
IronPort-SDR: AfFx6q/Te3qg7RmDF9I3bEAJ8zViktndb4XZlcLMzg32YC8tfYlY/UXdAjM59dMVbPAunhTDnR
 3tMRh30fTqbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="255844718"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="255844718"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 17:07:10 -0700
IronPort-SDR: FW1+JDWFnnCJ0F8zcxYqh84SmkButXavMRcYvhG1wXMabDT20sJ6bofo8dJAA+BWwsfPAENdxM
 KRJBoeT0uySg==
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="424475892"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 17:07:09 -0700
Date:   Tue, 13 Apr 2021 17:09:47 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <20210413170947.35ba9267@jacob-builder>
In-Reply-To: <20210409110305.6b0471d9@jacob-builder>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <YHAoY9+w2ebYZ7VV@myrica>
        <20210409110305.6b0471d9@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Fri, 9 Apr 2021 11:03:05 -0700, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> > problems:
> > 
> > * We don't have a use-case for binding the mm of a remote process (and
> >   it's supposedly difficult for device drivers to do it securely). So
> > OK, we remove the mm argument from iommu_sva_bind_device() and use the
> >   current mm. But the IOMMU driver isn't going to do
> > get_task_mm(current) every time it needs the mm being bound, it will
> > take it from iommu_sva_bind_device(). Likewise iommu_sva_alloc_pasid()
> > shouldn't need to bother with get_task_mm().
> > 
> > * cgroup accounting for IOASIDs needs to be on the current task.
> > Removing the mm parameter from iommu_sva_alloc_pasid() doesn't help
> > with that. Sure it indicates that iommu_sva_alloc_pasid() needs a
> > specific task context but that's only for cgroup purpose, and I'd
> > rather pass the cgroup down from iommu_sva_bind_device() anyway (but am
> > fine with keeping it within ioasid_alloc() for now). Plus it's an
> > internal helper, easy for us to check that the callers are doing the
> > right thing. 
> With the above split, we really just have one allocation function:
> ioasid_alloc(), so it can manage current cgroup accounting within. Would
> this work?
After a few attempts, I don't think the split can work better. I will
restore the mm parameter and add a warning if mm != current->mm.

Thanks,

Jacob
