Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CBA39B450
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhFDHxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhFDHxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:53:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAB6361411;
        Fri,  4 Jun 2021 07:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622793092;
        bh=XknpTdRALjODEseoLFd/CWgE9dln8BAlCe9q8toibx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGNPli79xTBcjBpN+HQKAiJcX8iDJdUFIiXvz6A6V4+dxqM7HTT1DuQzR92r6w05o
         A5FckZ2eBTA+jnfjBER5xkXqhdX6JqzVhw8m/JS7hVkAmWiarE45A30PTEwou5mBJx
         82uOFgKaNC+K78yLy8crJTjg5W9lPvEbI2dmgqqU=
Date:   Fri, 4 Jun 2021 09:51:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH] uacce: add print information if not enable sva
Message-ID: <YLnbgcJmQZChx1WV@kroah.com>
References: <1622792769-28017-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622792769-28017-1-git-send-email-yekai13@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 03:46:09PM +0800, Kai Ye wrote:
> Add print information necessary if user not enable sva.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  drivers/misc/uacce/uacce.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index bae18ef0..fe38af8 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -387,15 +387,22 @@ static void uacce_release(struct device *dev)
>  
>  static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
>  {
> +	int ret;
> +
>  	if (!(flags & UACCE_DEV_SVA))
>  		return flags;
>  
>  	flags &= ~UACCE_DEV_SVA;
>  
> -	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
> +	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF);
> +	if (ret) {
> +		dev_err(parent, "failed to enable IOPF feature! ret = %d\n", ret);

Why is this needed?  Has this ever happened in real life such that the
log message is now required?



>  		return flags;
> +	}
>  
> -	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
> +	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
> +	if (ret) {
> +		dev_err(parent, "failed to enable SVA feature! ret = %d\n", ret);

Same here, does this happen in real systems?

thanks,

greg k-h
