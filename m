Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1E32CE9D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhCDIiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:38:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235938AbhCDIhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:37:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE66C64EFE;
        Thu,  4 Mar 2021 08:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614847030;
        bh=QT2ORfbTBUd5cxY+IDZbENy/xwp9khoZXS4cpegFUak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvdOBBkBBhyRVWE2g/99cH+tHjhf1vd0QIKJdYhQgHPxIQHxx/qgZbzaUXfM0n9/l
         cx86nfcgfooxXdYSmMn7meKQUJnJivFuG7nBqKzzyw5yC44M9sdVROGay1SzO6RMh6
         UPiJnk1CS/gQD7fh/BN1GeJkp+m7dfHe1Ge6YbgE=
Date:   Thu, 4 Mar 2021 09:37:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiang Ma <maqianga@uniontech.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: lp: remove redundant space
Message-ID: <YECcMwNJiXo5D7Do@kroah.com>
References: <20210304081752.23986-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304081752.23986-1-maqianga@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 04:17:52PM +0800, Qiang Ma wrote:
> These two lines of code don't meet the kernel coding style,
> so remove the redundant space.
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  drivers/char/lp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
> index 862c2fd933c7..0e22e3b0a04e 100644
> --- a/drivers/char/lp.c
> +++ b/drivers/char/lp.c
> @@ -546,7 +546,7 @@ static int lp_open(struct inode *inode, struct file *file)
>  	}
>  	/* Determine if the peripheral supports ECP mode */
>  	lp_claim_parport_or_block(&lp_table[minor]);
> -	if ( (lp_table[minor].dev->port->modes & PARPORT_MODE_ECP) &&
> +	if ((lp_table[minor].dev->port->modes & PARPORT_MODE_ECP) &&
>  	     !parport_negotiate(lp_table[minor].dev->port,
>  				 IEEE1284_MODE_ECP)) {
>  		printk(KERN_INFO "lp%d: ECP mode\n", minor);
> @@ -590,7 +590,7 @@ static int lp_do_ioctl(unsigned int minor, unsigned int cmd,
>  		return -ENODEV;
>  	if ((LP_F(minor) & LP_EXIST) == 0)
>  		return -ENODEV;
> -	switch ( cmd ) {
> +	switch (cmd) {
>  		case LPTIME:
>  			if (arg > UINT_MAX / HZ)
>  				return -EINVAL;
> -- 
> 2.20.1
> 
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
