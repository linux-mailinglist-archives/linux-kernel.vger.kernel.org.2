Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5719738E158
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhEXHKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232128AbhEXHKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:10:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B44A7610A2;
        Mon, 24 May 2021 07:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621840145;
        bh=ZTCeoX6bI6iK6W1/fcR9kYUyPM3BV209WtHYQ4y47Qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bi4lQpjeFtSZnlSpYfhXlIqeDl408KVXI7zYuk6KU/LdX+uoD0QFDRIOnCkLT1Buf
         0Wm0FO3PlgN896McWQ3J9PoPw/ZGXKlr1Dy+f6Ntqodz9rzHs9lk9SYJ4B5A8rOo/H
         lY6oYIduGTCRQMYJr3MXNGM+5SOfXBq1kniD5rlY=
Date:   Mon, 24 May 2021 09:09:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nizamhaider786@gmail.com
Cc:     laforge@gnumonks.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] char: pcmcia: cm4040_cs: Fix failure handling
 Handled failure cases of device_create()
Message-ID: <YKtRDwOOSxSdbtD7@kroah.com>
References: <20210523193029.3178-1-nizamhaider786@gmail.com>
 <20210523193029.3178-2-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523193029.3178-2-nizamhaider786@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 01:00:29AM +0530, nizamhaider786@gmail.com wrote:
> From: Nijam Haider <nizamhaider786@gmail.com>
> 
> Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
> ---
>  drivers/char/pcmcia/cm4040_cs.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
> index d5e4360..30bb977 100644
> --- a/drivers/char/pcmcia/cm4040_cs.c
> +++ b/drivers/char/pcmcia/cm4040_cs.c
> @@ -558,6 +558,7 @@ static void reader_release(struct pcmcia_device *link)
>  static int reader_probe(struct pcmcia_device *link)
>  {
>  	struct reader_dev *dev;
> +	struct device *dev_ret;
>  	int i, ret;
>  
>  	for (i = 0; i < CM_MAX_DEV; i++) {
> @@ -593,8 +594,15 @@ static int reader_probe(struct pcmcia_device *link)
>  		return ret;
>  	}
>  
> -	device_create(cmx_class, NULL, MKDEV(major, i), NULL, "cmx%d", i);
> -
> +	dev_ret = device_create(cmx_class, NULL, MKDEV(major, i), NULL, "cmx%d", i);
> +        if (IS_ERR(dev_ret)) {
> +                printk(KERN_ERR "device_create failed for %d\n",
> +                               i);
> +                reader_release(link);
> +                dev_table[i] = NULL;
> +                kfree(dev);
> +                return -ENODEV;
> +        }
>  	return 0;
>  }
>  
> -- 
> 2.7.4
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
