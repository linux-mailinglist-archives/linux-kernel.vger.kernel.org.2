Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B631C3ABADC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhFQRvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhFQRvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:51:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E782C613CB;
        Thu, 17 Jun 2021 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623952145;
        bh=PEswRSOUEybmrluFbTBGtoEux41ybWZrhm0/5ADHUig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SRgVQddYQNsX/0bSReJIMePYroJG5R758EyKUDaj8Yz83/tvT+yuc4bWIU/ujjZkt
         Wv55bqQNR+hlU1Aa1D7IEWIsDpPiiwYdRd4YifEV78OcGVjqb6ftUvgL1xW4Xst4rE
         lt2+XMMUhQW9cMW7acVtOTW1j4Yt0ClW/MyxIzGi6FBPEB9mR+UUzq8SVbxABPYO9/
         LUxHiW+DrPi1FzOA5zInVb9Mf3e9kDZJ7jlt2Y+w/4VfLWqptN5V/w5pe7W1kNejYa
         efDZ4y9uRMklWBPAjOsYVNLPhdqc4sDj13XfdBDfn6V+BLJqMZixAQM14wU2KTbha6
         /SmYiHn8JO0fA==
Date:   Thu, 17 Jun 2021 18:49:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, vdumpa@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] iommu: Fix race condition during default domain
 allocation
Message-ID: <20210617174859.GD24813@willie-the-truck>
References: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
 <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
 <20210611104524.GD15274@willie-the-truck>
 <faf4504c-43f2-f68e-9a00-5e450dd7f352@arm.com>
 <315fe1c5-2685-6ee3-2aa4-35a27233127b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315fe1c5-2685-6ee3-2aa4-35a27233127b@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:21:39AM +0530, Ashish Mhetre wrote:
> 
> 
> On 6/11/2021 6:19 PM, Robin Murphy wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 2021-06-11 11:45, Will Deacon wrote:
> > > On Thu, Jun 10, 2021 at 09:46:53AM +0530, Ashish Mhetre wrote:
> > > > Domain is getting created more than once during asynchronous multiple
> > > > display heads(devices) probe. All the display heads share same SID and
> > > > are expected to be in same domain. As iommu_alloc_default_domain() call
> > > > is not protected, the group->default_domain and group->domain are ending
> > > > up with different domains and leading to subsequent IOMMU faults.
> > > > Fix this by protecting iommu_alloc_default_domain() call with
> > > > group->mutex.
> > > 
> > > Can you provide some more information about exactly what the h/w
> > > configuration is, and the callstack which exhibits the race, please?
> > 
> > It'll be basically the same as the issue reported long ago with PCI
> > groups in the absence of ACS not being constructed correctly. Triggering
> > the iommu_probe_device() replay in of_iommu_configure() off the back of
> > driver probe is way too late and allows calls to happen in the wrong
> > order, or indeed race in parallel as here. Fixing that is still on my
> > radar, but will not be simple, and will probably go hand-in-hand with
> > phasing out the bus ops (for the multiple-driver-coexistence problem).
> > 
> For iommu group creation, the stack flow during race is like:
> Display device 1:
> iommu_probe_device -> iommu_group_get_for_dev -> arm_smmu_device_group
> Display device 2:
> iommu_probe_device -> iommu_group_get_for_dev -> arm_smmu_device_group
> 
> And this way it ends up in creating 2 groups for 2 display devices sharing
> same SID.
> Ideally for 2nd display device, iommu_group_get call from
> iommu_group_get_for_dev should return same group as 1st display device. But
> due to the race, it ends up with 2 groups.
> 
> For default domain, the stack flow during race is like:
> Display device 1:
> iommu_probe_device -> iommu_alloc_default_domain -> arm_smmu_domain_alloc
> Display device 2:
> iommu_probe_device -> iommu_alloc_default_domain -> arm_smmu_domain_alloc
> 
> Here also 2nd device should already have domain allocated and
> 'if(group->default_domain)' condition from iommu_alloc_default_domain should
> be true for 2nd device.
> 
> Issue with this is IOVA accesses from 2nd device results in context faults.

Thanks for the explanation (also Robin and Krishna). Please put some of this
in the commit message for the next version.

Will
