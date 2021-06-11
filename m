Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45103A405F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFKKrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhFKKr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF60C613F1;
        Fri, 11 Jun 2021 10:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623408329;
        bh=H7N82STuZf67I/B25zQwHnR1wGeHBVcwA153V8xgMsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBZx9meYLkVr5ydc7IymbBE1oQiQ1bbdKUe3MI5cqxiyStn7E8h3540mPdeFhQkWM
         AhitpJZgHzGLqcW6alsccgNdUuLlKD2G9xyUu13i9BSwVCAtH3eu0s/FsX5iCfUbT1
         rnmwpY/lYAajYmvDqpnZf9+gYo+kHeebSoN6RdYch7hQYHe700m95FmwO0HnN+yWWb
         IOZ1p/8/glLiUmlga1DXEVLyS3s64ns/3mTh2uwmYBte0T7WtphOj/x+uo4Q5HPdEI
         GA1BVDFmQzC/LCLmCGfZGPgu2Snd3vCaJ2HQ2ic1h44pLduLScxNFpcbBVm3+NjTkN
         6P+smXdy03jRw==
Date:   Fri, 11 Jun 2021 11:45:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com, vdumpa@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] iommu: Fix race condition during default domain
 allocation
Message-ID: <20210611104524.GD15274@willie-the-truck>
References: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
 <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 09:46:53AM +0530, Ashish Mhetre wrote:
> Domain is getting created more than once during asynchronous multiple
> display heads(devices) probe. All the display heads share same SID and
> are expected to be in same domain. As iommu_alloc_default_domain() call
> is not protected, the group->default_domain and group->domain are ending
> up with different domains and leading to subsequent IOMMU faults.
> Fix this by protecting iommu_alloc_default_domain() call with group->mutex.

Can you provide some more information about exactly what the h/w
configuration is, and the callstack which exhibits the race, please?

> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 808ab70..2700500 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -273,7 +273,9 @@ int iommu_probe_device(struct device *dev)
>  	 * support default domains, so the return value is not yet
>  	 * checked.
>  	 */
> +	mutex_lock(&group->mutex);
>  	iommu_alloc_default_domain(group, dev);
> +	mutex_unlock(&group->mutex);

It feels wrong to serialise this for everybody just to cater for systems
with aliasing SIDs between devices.

Will
