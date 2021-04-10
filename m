Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40FA35ADB5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhDJNgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJNgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:36:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CDB561028;
        Sat, 10 Apr 2021 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618061789;
        bh=zE7oyEro2yopPuqtrMWUastuB5GsnGSa2kFwaliFI+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZd+dbEc2KjV7az/jFra6hv3ug19y69DHBRGAPNR9UyQl/dyjwxpj/iI5pjptgALN
         XFdnJsIigrHm3zBy/aG9kzTH03yWB6M76S5pfMT0RZiCIzLBIeNkV8GyeU+fEExl90
         17ohOMVlJDImnxysLOo9OKU5hOoSWJYqzdPzsmto=
Date:   Sat, 10 Apr 2021 15:36:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove unnecessary goto jumps
Message-ID: <YHGp2yd1b9E1JTFI@kroah.com>
References: <20210410133212.422929-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410133212.422929-1-hello@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 01:33:09PM +0000, Bryan Brattlof wrote:
> The next instruction for both 'goto exit' jump statements is to
> execute the exit jump instructions regardless. We can safely
> remove all jump statements from __init rtw_drv_entry()
> 
> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index 9fd926e1698f..84ac81d19746 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -517,13 +517,9 @@ static int __init rtw_drv_entry(void)
>  	if (ret != 0) {
>  		sdio_drvpriv.drv_registered = false;
>  		rtw_ndev_notifier_unregister();
> -		goto exit;
>  	}
>  
> -	goto exit;
> -
> -exit:
> -	DBG_871X_LEVEL(_drv_always_, "module init ret =%d\n", ret);
> +	DBG_870X_LEVEL(_drv_always_, "module init ret =%d\n", ret);

Why did you change this line?

thanks,

greg k-h
