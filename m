Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7C401931
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbhIFJtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237787AbhIFJtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:49:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F51D60E76;
        Mon,  6 Sep 2021 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630921725;
        bh=GTm4LMyrJO46jZPaunW0iPmpuOeJCENNG+sx2uRU49Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NrvDF2ekfcbcC9a/TU3cntSt0gmZ03oxna0cIgbwgjZlloPIpY5oDNVrmTjmk1YAd
         RJLdu67Z90D2G0JsVKtGGEKSpuASIUQbTVoh6xdQlrCqiMijmTOqoUpg/u1C+9DiEV
         vWnDjb4ss+LyDkjQJgFS1K0EpJvf/d3Q4/gViVDA=
Date:   Mon, 6 Sep 2021 11:48:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: include: remove duplicate declaration.
Message-ID: <YTXj+6QU10tYmec7@kroah.com>
References: <YTRuXTu/kePBDwAF@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTRuXTu/kePBDwAF@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 12:44:37PM +0530, Saurav Girepunje wrote:
> Remove below duplicate declaration from rtl8188e_led.h file
> 
> void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
> void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/include/rtl8188e_led.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_led.h b/drivers/staging/r8188eu/include/rtl8188e_led.h
> index b00954198764..02cdc970bb17 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_led.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_led.h
> @@ -12,7 +12,5 @@
>  /*  */
>  void rtl8188eu_InitSwLeds(struct adapter *padapter);
>  void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
> -void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
> -void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);
> 
>  #endif
> --
> 2.32.0
> 

This email did not make it to lore.kernel.org again:
	https://lore.kernel.org/r/YTRuXTu/kePBDwAF@user

Any ideas what is happening?

thanks,

greg k-h
