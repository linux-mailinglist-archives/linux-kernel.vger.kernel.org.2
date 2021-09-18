Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C9C41047C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbhIRGxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 02:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232721AbhIRGxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:53:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ABFA61212;
        Sat, 18 Sep 2021 06:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631947897;
        bh=85j315zLca+Ym0UL7sOa1rTwJAIBi4hPaT0qc+V/Lvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lO2lXPILxHGZdwcdGKMkCqT88TjuSY0mfznJJk3eSjn/bvQMatr+/A8cn1fL22yOO
         un2DhP5YDV2G4ADMeGrie/7yxFMuMDxiuwLaKiPZcgRzV6zVtUCnBEkJAwLylGO/vn
         ymtml4iscXJee1OIYqobqSvoFLbWYhotdiolcj8k=
Date:   Sat, 18 Sep 2021 08:51:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH V2] staging: r8188eu: Use kzalloc() instead of
 kmalloc()+memset()
Message-ID: <YUWMZt81nViI7KiQ@kroah.com>
References: <20210918035141.237455-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918035141.237455-1-deng.changcheng@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 03:51:41AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> This place can use kzalloc() directly instead of calling kmalloc() then
> memset(). Replace them.
> At the same time,error code that is "ret = -ENOMEM;" should be added
> here.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index ac218da94ce5..2fb34964f8c8 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -463,11 +463,12 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  		if (wep_key_len > 0) {
>  			wep_key_len = wep_key_len <= 5 ? 5 : 13;
>  			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
> -			pwep = kmalloc(wep_total_len, GFP_KERNEL);
> -			if (!pwep)
> +			pwep = kzalloc(wep_total_len, GFP_KERNEL);
> +			if (!pwep) {
> +				ret = -ENOMEM;
>  				goto exit;
> +			}
>  
> -			memset(pwep, 0, wep_total_len);
>  			pwep->KeyLength = wep_key_len;
>  			pwep->Length = wep_total_len;
>  			if (wep_key_len == 13) {
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
