Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833B23FA97E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 08:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhH2GdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 02:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhH2GdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 02:33:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71DE860F25;
        Sun, 29 Aug 2021 06:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630218748;
        bh=9WoeREgQDoa++TTSBGwxbm8Eom0G+AloHwO/mnc4fao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFLBfN+N/G50kteXygCag4tY25j0vvaOJNOxXXktHNnX2VqgDx+qerNopkPGjGGVE
         ITQO3fUYIMYVsjzLJUFKMnN0aEYb7VmCmjFJAH9VcXqNdxFc1jMPVHZ5EmKDllcOT5
         kSsKNyDInhnauXzlkXnlsHqx0ydSgP/TN2TlJBGs=
Date:   Sun, 29 Aug 2021 08:32:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        fabioaiuto83@gmail.com, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH v2] staging: r8188eu: core: remove null check before vfree
Message-ID: <YSsp98CJVHLR7vQB@kroah.com>
References: <YSsnK7Wepn1Dv+oy@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSsnK7Wepn1Dv+oy@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 11:50:27AM +0530, Saurav Girepunje wrote:
> Remove NULL check. NULL check before freeing function is not needed.
> Correct the indentation.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_sta_mgt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> index f6dffed53a60..c3600cb1790a 100644
> --- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> +++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> @@ -155,9 +155,8 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
>  		spin_unlock_bh(&pstapriv->sta_hash_lock);
>  		/*===============================*/
> 
> -		if (pstapriv->pallocated_stainfo_buf)
> -			vfree(pstapriv->pallocated_stainfo_buf);
> -		}
> +		vfree(pstapriv->pallocated_stainfo_buf);
> +	}
> 
>  	return _SUCCESS;
>  }
> --
> 2.32.0
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
