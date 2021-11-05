Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0064461A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 10:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhKEJ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 05:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhKEJ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 05:56:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1DD461244;
        Fri,  5 Nov 2021 09:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636106033;
        bh=5RdPzmhEi9UGFy1N1lSJbvOafX7Kib58Ryh0KfB7qpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w9q6h+8gYltRRJehXaFdCAyfAPgUErn2mYR6GISPhWWjqRSmAeuT0Oy1YB0aZV5zp
         e8EENDyGeNAihk3iPS0N5eMwLx/5oBSATnN3JmVAUz9IaRjqzUnIB/KMkcq7cRcGDJ
         L6Bi1SYF2T3QAgYg/Dm5A2uL9kW4sC++O6fmb3kw=
Date:   Fri, 5 Nov 2021 10:53:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH v2] staging: r8188eu: os_dep: remove the goto statement
Message-ID: <YYT/LibxFzssNUJN@kroah.com>
References: <YYKvWeyqd71pYSqM@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYKvWeyqd71pYSqM@Sauravs-MacBook-Air.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 09:18:41PM +0530, Saurav Girepunje wrote:
> Remove the goto statement from rtw_init_drv_sw(). In this function goto
> can be replace by return statement. As on goto label exit, function
> only return it is not performing any cleanup. Avoiding goto will
> improve the function readability.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
> 
> ChangelogV2:
> 
> 	-On V1 combined the if condition check for functions as below
> 
> 	 if (!rtw_init_evt_priv(&padapter->evtpriv) || !rtw_init_mlme_priv(padapter))
> 		return _FAIL;
> 	reverting these changes and keeping them as-is. It will make more clear on
> 	individual function call if something need to handle for error case.
> 
> ChangelogV1:
> 
> 	-Remove the goto statement from rtw_init_drv_sw(). In this function goto
> 	 can be replace by return statement. As on goto label exit, function
> 	 only return it is not performing any cleanup. Avoiding goto will
> 	 improve the function readability.
> 
>  drivers/staging/r8188eu/os_dep/os_intfs.c | 34 ++++++++---------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 1418c9c4916c..ec96e837ab88 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -480,48 +480,37 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>  {
>  	u8	ret8 = _SUCCESS;
> 
> -	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL) {
> -		ret8 = _FAIL;
> -		goto exit;
> -	}
> +	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL)
> +		return _FAIL;
> 
>  	padapter->cmdpriv.padapter = padapter;
> 
> -	if ((rtw_init_evt_priv(&padapter->evtpriv)) == _FAIL) {
> -		ret8 = _FAIL;
> -		goto exit;
> -	}
> +	if ((rtw_init_evt_priv(&padapter->evtpriv)) == _FAIL)
> +		return _FAIL;
> 
> -	if (rtw_init_mlme_priv(padapter) == _FAIL) {
> -		ret8 = _FAIL;
> -		goto exit;
> -	}
> +	if (rtw_init_mlme_priv(padapter) == _FAIL)
> +		return _FAIL;
> 
>  	rtw_init_wifidirect_timers(padapter);
>  	init_wifidirect_info(padapter, P2P_ROLE_DISABLE);
>  	reset_global_wifidirect_info(padapter);
> 
> -	if (init_mlme_ext_priv(padapter) == _FAIL) {
> -		ret8 = _FAIL;
> -		goto exit;
> -	}
> +	if (init_mlme_ext_priv(padapter) == _FAIL)
> +		return _FAIL;
> 
>  	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
>  		DBG_88E("Can't _rtw_init_xmit_priv\n");
> -		ret8 = _FAIL;
> -		goto exit;
> +		return _FAIL;
>  	}
> 
>  	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
>  		DBG_88E("Can't _rtw_init_recv_priv\n");
> -		ret8 = _FAIL;
> -		goto exit;
> +		return _FAIL;
>  	}
> 
>  	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
>  		DBG_88E("Can't _rtw_init_sta_priv\n");
> -		ret8 = _FAIL;
> -		goto exit;
> +		return _FAIL;
>  	}
> 
>  	padapter->stapriv.padapter = padapter;

Right after this, ret8 is set, but never checked, which looks like a bug
to me.  Can you work on fixing that after I take this patch?

thanks,

greg k-h
