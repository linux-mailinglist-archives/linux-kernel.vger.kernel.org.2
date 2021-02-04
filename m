Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29D830EFAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhBDJ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:26:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234620AbhBDJ0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:26:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B8A964F48;
        Thu,  4 Feb 2021 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612430764;
        bh=iPr0CA2pIHDHh2dXkae4rNvFekouTDxQFLqezinvrzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pWSNLJIttnbgsu3Ltschs2qhIDAn3WsWGlCpTGDn5YCZSXTbF+ZoZJYp0uzRXGLOU
         tEkRiLiu80c4yGmWLO8kZbRsZ+ye9vUeOtYUWDa1aDk11OOplr9Z86NsjPVDmZlVFV
         62t8B3MrYdVi37kaqdN5IqTn8aVW6QFgVn6hlKoeiEKsQGjw+RNmZtUdsac/7qvYsG
         AHseRnGyZ9DloI+Ng/A6MPwGv6q8duHiDS5+0rIOv2Bj5rWl+XqbxC5pmGwORXlqkY
         dHcM2nOLZyKERvGRzkEWss4zBUQe6q9y7H4Oca3P3p2GswRWxJfqy5QbZG6UmA3syV
         7BbxUlIPU5i+w==
Date:   Thu, 4 Feb 2021 09:25:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Anan sun <anan.sun@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iommu/mediatek: Fix unsigned domid comparison with
 less than zero
Message-ID: <20210204092558.GA20244@willie-the-truck>
References: <20210203135936.23016-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203135936.23016-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:59:36PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the check for domid < 0 is always false because domid
> is unsigned.  Fix this by making it signed.
> 
> Addresses-CoverityL ("Unsigned comparison against 0")

Typo here ('L' instead of ':')

> Fixes: ab1d5281a62b ("iommu/mediatek: Add iova reserved function")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/iommu/mtk_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 0ad14a7604b1..823d719945b2 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -640,7 +640,7 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
>  				       struct list_head *head)
>  {
>  	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
> -	unsigned int domid = mtk_iommu_get_domain_id(dev, data->plat_data), i;
> +	int domid = mtk_iommu_get_domain_id(dev, data->plat_data), i;

Not sure if it's intentional, but this also makes 'i' signed. It probably
should remain 'unsigned' to match 'iova_region_nr' in
'struct mtk_iommu_plat_data'.

Will
