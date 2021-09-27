Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADC44197F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhI0Pau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235071AbhI0Pas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:30:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8879B60E9C;
        Mon, 27 Sep 2021 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632756550;
        bh=kG/iknAa5rpAY9fcL0ytCaWoQVp6JsUQfB3W3OMYCtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCQ0QBQRjLOYoi6nLaEipfqTjUn7ki1VbdR5rbg6tlxzUd2V8ZAfhj1ExvsD3HyfK
         TTpL3l4hgcPEn/VUA7eCqhHNil2B4eazwfclTjk3sUlHR14j47zsW+ty0pYx0CR2iw
         UCxNbubz5vQ6dwpOPO+ZkWFOzQpZxXtS2DJdB/0E=
Date:   Mon, 27 Sep 2021 17:29:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: dim2: force fcnt=3 on Renesas GEN3
Message-ID: <YVHjQ95lbDjvVR73@kroah.com>
References: <20210921165130.24178-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921165130.24178-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 07:51:30PM +0300, Nikita Yushchenko wrote:
> Per Renesas datasheet, MLBC0 register's fcnt field in the embedded
> dim2 module must be never set to value different from 3.
> 
> Enforce that, via an optional field in struct dim2_platform_data.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  drivers/staging/most/dim2/dim2.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> index 093ef9a2b291..d90284d79621 100644
> --- a/drivers/staging/most/dim2/dim2.c
> +++ b/drivers/staging/most/dim2/dim2.c
> @@ -108,6 +108,7 @@ struct dim2_hdm {
>  struct dim2_platform_data {
>  	int (*enable)(struct platform_device *pdev);
>  	void (*disable)(struct platform_device *pdev);
> +	u8 fcnt;
>  };
>  
>  #define iface_to_hdm(iface) container_of(iface, struct dim2_hdm, most_iface)
> @@ -731,7 +732,7 @@ static int dim2_probe(struct platform_device *pdev)
>  	struct dim2_hdm *dev;
>  	struct resource *res;
>  	int ret, i;
> -	u8 hal_ret;
> +	u8 dev_fcnt, hal_ret;
>  	int irq;
>  
>  	enum { MLB_INT_IDX, AHB0_INT_IDX };
> @@ -770,8 +771,10 @@ static int dim2_probe(struct platform_device *pdev)
>  
>  	dev->disable_platform = pdata ? pdata->disable : NULL;
>  
> -	dev_info(&pdev->dev, "sync: num of frames per sub-buffer: %u\n", fcnt);
> -	hal_ret = dim_startup(dev->io_base, dev->clk_speed, fcnt);
> +	dev_fcnt = pdata && pdata->fcnt ? pdata->fcnt : fcnt;

Please use a real if () statement here and do not bury real logic in a
crazy line like this one, as that is all but impossible to maintain over
time.

thanks,

greg k-h
