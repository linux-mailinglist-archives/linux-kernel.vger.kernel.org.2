Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30379372DDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhEDQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 12:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231635AbhEDQSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 12:18:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24BD6611AD;
        Tue,  4 May 2021 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620145037;
        bh=5iqslF9Ox5+6piOrlgLcA9pBk2hRz/fYWDXpJnNRAgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrWKbXNUmyeEvTiJ8kpXvrwolwGcpIzYHuC/CgbJhUN8dEJFoHorrHoP1l5O6AFgH
         z8NmAzQ0TBLovEYuuwPaJX+D33i+pLq560Mx7Wrpeq7OnZ5OPblXXPOui/inPSyWvf
         Rw2kIcEt0tycmNacxCV8UuDQ+XZNUmpMMsmHD85A=
Date:   Tue, 4 May 2021 18:17:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: use generic kernel error codes
Message-ID: <YJFziyZHnbsWdTFn@kroah.com>
References: <c94e5865e59d35fe0e39d5cd46d71ad4a752ddd4.1620144194.git-series.hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c94e5865e59d35fe0e39d5cd46d71ad4a752ddd4.1620144194.git-series.hello@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 04:07:48PM +0000, Bryan Brattlof wrote:
> The current _FAIL and _SUCCESS error codes are defined as:
> 
>         #define _FAIL    0
> 	#define _SUCCESS 1
> 
> which adds complexity (and confusion) when interacting with other
> submodules in the kernel. These definitions can be removed and replaced
> with the kernel's generic error codes.
> 
> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> ---
>  drivers/staging/rtl8723bs/include/drv_types.h |  2 +-
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> index 83d43e5726dd..5b702ff432ae 100644
> --- a/drivers/staging/rtl8723bs/include/drv_types.h
> +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> @@ -385,7 +385,7 @@ struct adapter {
>  	void *xmitThread;
>  	void *recvThread;
> 
> -	u32 (*intf_init)(struct dvobj_priv *dvobj);
> +	int (*intf_init)(struct dvobj_priv *dvobj);
>  	void (*intf_deinit)(struct dvobj_priv *dvobj);
>  	int (*intf_alloc_irq)(struct dvobj_priv *dvobj);
>  	void (*intf_free_irq)(struct dvobj_priv *dvobj);
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index d2bf444117b8..e26c51d847b6 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -112,7 +112,7 @@ static void sdio_free_irq(struct dvobj_priv *dvobj)
>  	}
>  }
> 
> -static u32 sdio_init(struct dvobj_priv *dvobj)
> +static int sdio_init(struct dvobj_priv *dvobj)
>  {
>  	struct sdio_data *psdio_data;
>  	struct sdio_func *func;
> @@ -139,12 +139,11 @@ static u32 sdio_init(struct dvobj_priv *dvobj)
>  	psdio_data->tx_block_mode = 1;
>  	psdio_data->rx_block_mode = 1;
> 
> +	return err;
> +
>  release:
>  	sdio_release_host(func);
> -
> -	if (err)
> -		return _FAIL;
> -	return _SUCCESS;
> +	return err;
>  }

You just changed the logic here, are you SURE that was ok to do?


> 
>  static void sdio_deinit(struct dvobj_priv *dvobj)
> @@ -186,7 +185,7 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
>  	psdio = &dvobj->intf_data;
>  	psdio->func = func;
> 
> -	if (sdio_init(dvobj) != _SUCCESS)
> +	if (sdio_init(dvobj) < 0)
>  		goto free_dvobj;
> 
>  	rtw_reset_continual_io_error(dvobj);
> 
> base-commit: 9ccce092fc64d19504fa54de4fd659e279cc92e7
> --
> git-series 0.9.1
> 
> 

And that's all to remove the need for these crazy error values?  If so,
why not also remove the #defines for them as well?

thanks,

greg k-h
