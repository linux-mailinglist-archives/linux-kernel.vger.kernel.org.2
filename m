Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B3130F6B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbhBDPqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237446AbhBDPqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:46:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39B5864F4A;
        Thu,  4 Feb 2021 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612453527;
        bh=lI0HC3GQbRFgXxSEIB/73Da0jQE/c8jAVtTEPB7vO28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hw7jGjaOFkLAvQ61LL+VxqPi61iCFS1TZYi2B+cwgM1q3w4+wR4x7emm3TtBViZSm
         2GrhUdgflJlyA+3u1JkgT7g8skKX5b+ttzIYkKYfQUS0BUV02aYO6Vu9aMuWtT+a/J
         HYXBSDBHv3esRV8xFzPZ0ZZsEwLG6E7+g0tJKRYthwIUBadcNIZ4Nl+Fc5PzKNxBkS
         P4ep96lwNbV642I7ry+o7/5eT0bzGj2Is8PseM6TWB5lR91u2uVlVK+KG6Guhsy/Mx
         FHr2kz+NeXH4zrLOD04Eq42qyz8QOF9S1LNXYEOhfHwN0aDczIa6cgbUbFdj5jW86r
         Sgee71aeHeEGQ==
Date:   Thu, 4 Feb 2021 15:45:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] iommu/mediatek: Fix unsigned domid comparison
 with less than zero
Message-ID: <20210204154522.GD21058@willie-the-truck>
References: <20210204150001.102672-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204150001.102672-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 03:00:01PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the check for domid < 0 is always false because domid
> is unsigned. Fix this by casting domid to an int before making
> the comparison.
> 
> Addresses-Coverity: ("Unsigned comparison against 0")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: cast domid rather than making it an int. Replace L with : in
>     the commit message.
> 
> ---
>  drivers/iommu/mtk_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 0ad14a7604b1..1f262621ef19 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -645,7 +645,7 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
>  	struct iommu_resv_region *region;
>  	int prot = IOMMU_WRITE | IOMMU_READ;
>  
> -	if (domid < 0)
> +	if ((int)domid < 0)
>  		return;
>  	curdom = data->plat_data->iova_region + domid;
>  	for (i = 0; i < data->plat_data->iova_region_nr; i++) {

Thanks, Colin.

Acked-by: Will Deacon <will@kernel.org>

Will
