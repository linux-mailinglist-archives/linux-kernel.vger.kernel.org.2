Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B518E357E47
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhDHIjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhDHIjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:39:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9BB361165;
        Thu,  8 Apr 2021 08:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617871129;
        bh=K8sVpV5r3BqS9hmPn96824THlYvOfMr5q5GJIDgHY1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GfrbDht54m5KwRiHWtaxkbORpy4uJG7AQrqM5OGHoOiKmfNM7o0cN5thOuJWALCuX
         IaYTVxPGscaZaQTxHC9aKsEyb7b9jvyWF9M/GvmI8PomlwYUXpPFjv/kh3kjL7dGlJ
         DnsuI9YIB/cHqJLGGnXIMnX02mOAl810Zp+aTPdM=
Date:   Thu, 8 Apr 2021 10:38:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergei Krainov <sergei.krainov.lkd@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: remove unused variable from
 rtl871x_mlme.c
Message-ID: <YG7BF8Z1/gC1r8AP@kroah.com>
References: <20210408083312.GA3118@test-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408083312.GA3118@test-VirtualBox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:33:12AM +0200, Sergei Krainov wrote:
> Remove unused variable from rtl871x_mlme.c.
> 
> No side effects can be seen locally or in r8712_find_network()
> 
> Signed-off-by: Sergei Krainov <sergei.krainov.lkd@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_mlme.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
> index 8a97307fbbd6..4f41e321ea63 100644
> --- a/drivers/staging/rtl8712/rtl871x_mlme.c
> +++ b/drivers/staging/rtl8712/rtl871x_mlme.c
> @@ -656,7 +656,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
>  	struct sta_priv	*pstapriv = &adapter->stapriv;
>  	struct mlme_priv	*pmlmepriv = &adapter->mlmepriv;
>  	struct wlan_network	*cur_network = &pmlmepriv->cur_network;
> -	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
> +	struct wlan_network	*ptarget_wlan = NULL;
>  	unsigned int		the_same_macaddr = false;
>  	struct wlan_network *pnetwork;
>  
> @@ -721,13 +721,6 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
>  					    scanned_queue,
>  					    cur_network->network.MacAddress);
>  				} else {
> -					pcur_wlan =
> -					     r8712_find_network(&pmlmepriv->
> -					     scanned_queue,
> -					     cur_network->network.MacAddress);
> -					if (pcur_wlan)
> -						pcur_wlan->fixed = false;
> -
>  					pcur_sta = r8712_get_stainfo(pstapriv,
>  					     cur_network->network.MacAddress);
>  					spin_lock_irqsave(&pstapriv->
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
