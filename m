Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDE333D2DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhCPLVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhCPLUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:20:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DC1064FEA;
        Tue, 16 Mar 2021 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615893623;
        bh=D6f8tjvbgJIXpXFmRD31+PRWxZs/vvlPH8arEhFZenw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DrwWlcCiNwQ6h6a2fQsXPHNxbNkiy+iDHkN8Nu/2Q8jvdnD6cy9V0ur/Dsvuep4NP
         1BDSUi1xuS+3PtFv5IMPC3QA5NrdB3LaquG7XFExtoeoGRfBM2cn8ANGo+p5BnQkCE
         r4/Ufnq3EF2/Ve03ifdAku338+fs32MadZ8kezHs=
Date:   Tue, 16 Mar 2021 12:20:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        serrazimone@gmail.com, lu@pplo.net, dan.carpenter@oracle.com
Subject: Re: [PATCH] staging: rtl8192u: remove extra lines
Message-ID: <YFCUdTxq/eguUvSA@kroah.com>
References: <20210316095922.21123-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316095922.21123-1-zhaoxiao@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 05:59:22PM +0800, zhaoxiao wrote:
> Remove extra lines in the struct r8192_private_args.
> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  drivers/staging/rtl8192u/r8192U_wx.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
> index 6ead461e3279..e9de7dc8f049 100644
> --- a/drivers/staging/rtl8192u/r8192U_wx.c
> +++ b/drivers/staging/rtl8192u/r8192U_wx.c
> @@ -879,12 +879,10 @@ static iw_handler r8192_wx_handlers[] = {
>  
>  
>  static const struct iw_priv_args r8192_private_args[] = {
> -
>  	{
>  		SIOCIWFIRSTPRIV + 0x0,
>  		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "badcrc"
>  	},
> -
>  	{
>  		SIOCIWFIRSTPRIV + 0x1,
>  		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "activescan"
> @@ -897,7 +895,6 @@ static const struct iw_priv_args r8192_private_args[] = {
>  	{
>  		SIOCIWFIRSTPRIV + 0x3,
>  		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "forcereset"
> -
>  	}
>  
>  };
> -- 
> 2.20.1

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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

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
