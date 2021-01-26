Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A049F305012
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhA0DoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:44:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbhAZWXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:23:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D75302065D;
        Tue, 26 Jan 2021 22:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611699792;
        bh=fdRIENxKcgc5beyovt2puqoCoi+rEtNpR+KyZhmJt9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=achoEHu8k4uN8E83dNG429NPT1uvW4BKjuDha0qFlXbMfhUNqyWIOkGFmn5FIYQjx
         AAQs2T+cmT/3KagO8qWzYc02+OPzJ8Y0qoV6PONAnxAgS75ryj9A2u9zfPw9P6NK8M
         cHG5i9P/T7hfT5C7tU+Gu5rsDwAD1jYs0hcLmgrgWzCKcc2j5HXL5Tr/whN3VyMMdQ
         bx4w3RT7i0ULUk3PrLkCR1ZpN3A9ZiqNQD7ru816XaXg4IngNyw1pIqGVHsHxZ/upn
         BHC4hf5TqThjyZuxdwR0BPmGGFv4S+W11JMY00+TYtCZw7qigBK4Q9XevrSXLk7/eK
         peDrVc1pqOHww==
Date:   Tue, 26 Jan 2021 22:23:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
Subject: Re: [PATCH v6 07/33] iommu: Avoid reallocate default domain for a
 group
Message-ID: <20210126222305.GB30460@willie-the-truck>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-8-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111111914.22211-8-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 07:18:48PM +0800, Yong Wu wrote:
> If group->default_domain exists, avoid reallocate it.
> 
> In some iommu drivers, there may be several devices share a group. Avoid
> realloc the default domain for this case.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3d099a31ddca..f4b87e6abe80 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -266,7 +266,8 @@ int iommu_probe_device(struct device *dev)
>  	 * support default domains, so the return value is not yet
>  	 * checked.
>  	 */
> -	iommu_alloc_default_domain(group, dev);
> +	if (!group->default_domain)
> +		iommu_alloc_default_domain(group, dev);

I don't really get what this achieves, since iommu_alloc_default_domain()
looks like this:

static int iommu_alloc_default_domain(struct iommu_group *group,
				      struct device *dev)
{
	unsigned int type;

	if (group->default_domain)
		return 0;

	...

in which case, it should be fine?

Will
