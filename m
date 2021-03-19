Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63AA341CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhCSM1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCSM0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:26:48 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748EAC06174A;
        Fri, 19 Mar 2021 05:26:44 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 732662DA; Fri, 19 Mar 2021 13:26:42 +0100 (CET)
Date:   Fri, 19 Mar 2021 13:26:40 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Will Deacon <will@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iommu: Fix spelling mistake "sixe" -> "size"
Message-ID: <YFSYgNiQP7HOWS2i@8bytes.org>
References: <20210319095750.5624-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319095750.5624-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 09:57:50AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/iommu/sprd-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> 
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index 7100ed17dcce..e1dc2f7d5639 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -297,7 +297,7 @@ static int sprd_iommu_map(struct iommu_domain *domain, unsigned long iova,
>  	}
>  
>  	if (iova < start || (iova + size) > (end + 1)) {
> -		dev_err(dom->sdev->dev, "(iova(0x%lx) + sixe(%zx)) are not in the range!\n",
> +		dev_err(dom->sdev->dev, "(iova(0x%lx) + size(%zx)) are not in the range!\n",
>  			iova, size);
>  		return -EINVAL;
>  	}
> -- 
> 2.30.2
