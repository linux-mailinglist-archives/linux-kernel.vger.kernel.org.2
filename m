Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AA83A3E62
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhFKI6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhFKI6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:58:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE330611CD;
        Fri, 11 Jun 2021 08:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623401800;
        bh=IqopDrFGsvb4rPZxJiISgbpAzFwp/C6hrEv/3tEmyK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d13ws91xNcCoKSq3J1g2eGf8XssZOGEHNNQo7FK0020eP3jMw8JtNSUNCd/Pg4IWL
         VvbtZZCkqgNX0zwdl4rTKHtOGxi/EutxDP03ai+KLkg/g/EUWRoLuKZCHoFJqd3x4T
         wf6WN0t1owC+yeR28R1r8ZHMDLEUEbhTc0Qe9gqA=
Date:   Fri, 11 Jun 2021 10:56:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 4/9] nvmem: sprd: Fix an error message
Message-ID: <YMMlRq250A53CDaM@kroah.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611083348.20170-5-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 09:33:43AM +0100, Srinivas Kandagatla wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> 'ret' is known to be 0 here.
> The expected error status is stored in 'status', so use it instead.
> 
> Also change %d in %u, because status is an u32, not a int.
> 
> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/sprd-efuse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
> index 5d394559edf2..e3e721d4c205 100644
> --- a/drivers/nvmem/sprd-efuse.c
> +++ b/drivers/nvmem/sprd-efuse.c
> @@ -234,7 +234,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
>  	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
>  	if (status) {
>  		dev_err(efuse->dev,
> -			"write error status %d of block %d\n", ret, blk);
> +			"write error status %u of block %d\n", status, blk);

Shouldn't this be %pe and not %u?

thanks,

greg k-h
