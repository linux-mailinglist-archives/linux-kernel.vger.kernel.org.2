Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136843A3E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhFKI52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231191AbhFKI5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:57:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86BC5613C3;
        Fri, 11 Jun 2021 08:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623401712;
        bh=7y3c2umdmrm7dYoTAKQg9HHAvb1xKES58xh/t9aHSFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLjd4LMalfNs+xA//zu0vrIAATcqKlsu4FqXkzmLeu4Ll7fGFkMDIlvuutcG0CKti
         2w/nMLqlrL2afhv4ZSyD+xuu/onxDS44f7yghOkE7fA/RUcgDQyUIKcjPUvf8NeFBj
         ck2l3wjftJhFpmYNfYgIg4Kfqkq6ZsQrPr4McJes=
Date:   Fri, 11 Jun 2021 10:55:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Bixuan Cui <cuibixuan@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH 1/9] nvmem: sprd: Add missing MODULE_DEVICE_TABLE
Message-ID: <YMMk7dr1dKyO1JyZ@kroah.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611083348.20170-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 09:33:40AM +0100, Srinivas Kandagatla wrote:
> From: Bixuan Cui <cuibixuan@huawei.com>
> 
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/sprd-efuse.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
> index 59523245db8a..5d394559edf2 100644
> --- a/drivers/nvmem/sprd-efuse.c
> +++ b/drivers/nvmem/sprd-efuse.c
> @@ -425,6 +425,7 @@ static const struct of_device_id sprd_efuse_of_match[] = {
>  	{ .compatible = "sprd,ums312-efuse", .data = &ums312_data },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, sprd_efuse_of_match);

Why is this needed?  Do you have reports of this module not being
properly auto-loaded?

I have been rejecting these types of patches from the "Hulk Robot" as
they were just blindly going through the tree and not determining if
this actually is a thing that needed to be fixed.

Also, if it is a real fix, shouldn't it also go to the stable kernel
trees?  If so, you didn't mark it as such :(

thanks,

greg k-h
