Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ACC3497AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCYRMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhCYRMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:12:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC1C861A16;
        Thu, 25 Mar 2021 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616692350;
        bh=aqaTJDnsiWJX1tcMgPNk2oK/dylyp4jFTDSiVv4TkL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e8s9UlmvUgL8hsE8u0OJZZIEfxRCZpwfagHYQPLEy+4E05INhNQxkc1j33kXKp3uk
         lDpWZ1TrzmwVcY+dfTqNjGmIeCyZfrzJGz1YZJcrge7sFegetsVF5tOpT8aG3zuhxU
         tyVcYA2PF9EdUkkHX5q2lwcnZNOzG6XXUJXwqCe15f12Q3HdxF94CEjj9PX0SHSB0C
         JZFe+yI/rogzFYBc9vmVKw2xibZGvpwF528+cuz9+/tCBM8cAvuaasRH7fVz3pg8FE
         v6FrCi+2yOkTT/pG1GoZ6glBMJy9grkgV7jOTbwLtTNh+lF0jx8vIWjs2yBr6ZU3ll
         5tDMPRoFL+fdg==
Date:   Thu, 25 Mar 2021 17:12:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu: Streamline registration interface
Message-ID: <20210325171226.GB15337@willie-the-truck>
References: <f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com>
 <95f69c593aa9dd57a5333e490dc06b8bae27fedf.1616157612.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f69c593aa9dd57a5333e490dc06b8bae27fedf.1616157612.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 12:52:02PM +0000, Robin Murphy wrote:
> Rather than have separate opaque setter functions that are easy to
> overlook and lead to repetitive boilerplate in drivers, let's pass the
> relevant initialisation parameters directly to iommu_device_register().
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/amd/init.c                    |  3 +--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  5 +---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  5 +---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  5 +---
>  drivers/iommu/exynos-iommu.c                |  5 +---
>  drivers/iommu/fsl_pamu_domain.c             |  4 +--
>  drivers/iommu/intel/dmar.c                  |  4 +--
>  drivers/iommu/intel/iommu.c                 |  3 +--
>  drivers/iommu/iommu.c                       |  7 ++++-
>  drivers/iommu/ipmmu-vmsa.c                  |  6 +----
>  drivers/iommu/msm_iommu.c                   |  5 +---
>  drivers/iommu/mtk_iommu.c                   |  5 +---
>  drivers/iommu/mtk_iommu_v1.c                |  4 +--
>  drivers/iommu/omap-iommu.c                  |  5 +---
>  drivers/iommu/rockchip-iommu.c              |  5 +---
>  drivers/iommu/s390-iommu.c                  |  4 +--
>  drivers/iommu/sprd-iommu.c                  |  5 +---
>  drivers/iommu/sun50i-iommu.c                |  5 +---
>  drivers/iommu/tegra-gart.c                  |  5 +---
>  drivers/iommu/tegra-smmu.c                  |  5 +---
>  drivers/iommu/virtio-iommu.c                |  5 +---
>  include/linux/iommu.h                       | 29 ++++-----------------
>  22 files changed, 31 insertions(+), 98 deletions(-)

I was worried this might blow up with !CONFIG_IOMMU_API, but actually
it all looks fine and is much cleaner imo so:

Acked-by: Will Deacon <will@kernel.org>

Will
