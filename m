Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389DC441B74
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhKANED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231493AbhKANEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22ED6610CB;
        Mon,  1 Nov 2021 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635771687;
        bh=BnvAlu2La+WcsQ9YbWNSwcRtBUFoQ6NF91J/WMIhk2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCAbVo1fhBICtG4Fxnkyt8PmWvLNDqCjDK53PhBY6myVuI7c+F5UzQm/vB5T3KPMi
         f/CxPaMsVwuIpFeuxQbRmrN3THACcxmuZAg7vObL8+ipDyOtIoVCJqJVsDifiPIBQr
         75zqS/WMNXczB4MLtB4R9hLa1PHCZMpyOrxxeNto=
Date:   Mon, 1 Nov 2021 14:01:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: os_dep: remove the goto statement
Message-ID: <YX/lJMEfqXqlserL@kroah.com>
References: <YX7cCtVss2RWOJ/a@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YX7cCtVss2RWOJ/a@Sauravs-MacBook-Air.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2021 at 11:40:18PM +0530, Saurav Girepunje wrote:
> Remove the goto statement from rtw_init_drv_sw(). In this function goto
> can be replace by return statement. As on goto label exit, function
> only return it is not performing any cleanup. Avoiding goto will
> improve the function readability.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/os_intfs.c | 39 +++++++----------------
>  1 file changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 1418c9c4916c..4b409479108e 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -480,48 +480,34 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>  {
>  	u8	ret8 = _SUCCESS;
> 
> -	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL) {
> -		ret8 = _FAIL;
> -		goto exit;
> -	}
> +	if (!rtw_init_cmd_priv(&padapter->cmdpriv))
> +		return _FAIL;
> 
>  	padapter->cmdpriv.padapter = padapter;
> 
> -	if ((rtw_init_evt_priv(&padapter->evtpriv)) == _FAIL) {
> -		ret8 = _FAIL;
> -		goto exit;
> -	}
> -
> -	if (rtw_init_mlme_priv(padapter) == _FAIL) {
> -		ret8 = _FAIL;
> -		goto exit;
> -	}
> +	if (!rtw_init_evt_priv(&padapter->evtpriv) || !rtw_init_mlme_priv(padapter))
> +		return _FAIL;

These are functions that are being called so keeping them separate as
the code you removed did makes it "obvious" what is happening here.

So can you keep it that way please?

But my larger question is do these functions create state or allocate
memory that needs to be unwound properly if an error does happen?  Right
now the function seems to not be doing that at all, but that does not
mean it is correct as-is...

thanks,

greg k-h
