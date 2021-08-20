Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E4E3F2A36
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbhHTKlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237925AbhHTKlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:41:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AF466056C;
        Fri, 20 Aug 2021 10:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629456076;
        bh=j9scAOD9ml/UjU+E7F1nVCcyussEtA5A5JvgyeOg91I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6qBWNapTru/r/hZvx1kh/qOf/LUCLhCu+jyhg6U+6/bwDsZbjR7nT9h6Tr8q/8DK
         QbC4uy2mDwgJl9FJ1RI8PM7U1FwCCV1ee+XecftAd0Py2JnLGfmOUfe3sKDM0EQUMq
         BXIYkgvwg1xwrgxyq6FIty9wQ07yVCVpsNeppcXLMFh+fv0loDJP3a0XpOxxd5myz7
         lkH0LQ7DMRmXlG9sgXfzvC5Js4emGsgzmYnLleREtLbix9RHlkS6UR22T6LNDO9DVP
         PPzp2WriBpjMxtMe+MyGGWgtLf9xxSwqfEWQBFQGHUo/vwxG03U5u+bdKuudswtz+j
         Lw621ZrsPzhvw==
Date:   Fri, 20 Aug 2021 11:41:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>, joro@8bytes.org
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, vdumpa@nvidia.com
Subject: Re: [PATCH -next] iommu/arm-smmu: Fix missing unlock on error in
 arm_smmu_device_group()
Message-ID: <20210820104111.GC17267@willie-the-truck>
References: <20210820074949.1946576-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820074949.1946576-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 03:49:49PM +0800, Yang Yingliang wrote:
> Add the missing unlock before return from function arm_smmu_device_group()
> in the error handling case.
> 
> Fixes: b1a1347912a7 ("iommu/arm-smmu: Fix race condition during iommu_group creation")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 73893180ec7e..4bc75c4ce402 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1478,8 +1478,10 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>  	mutex_lock(&smmu->stream_map_mutex);
>  	for_each_cfg_sme(cfg, fwspec, i, idx) {
>  		if (group && smmu->s2crs[idx].group &&
> -		    group != smmu->s2crs[idx].group)
> +		    group != smmu->s2crs[idx].group) {
> +			mutex_unlock(&smmu->stream_map_mutex);
>  			return ERR_PTR(-EINVAL);
> +		}

Urgh, I should really have spotted that in review. Thanks:

Acked-by: Will Deacon <will@kernel.org>

Joerg -- please can you throw this on top?

Will
