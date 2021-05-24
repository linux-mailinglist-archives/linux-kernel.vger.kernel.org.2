Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B6F38E157
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhEXHKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232128AbhEXHKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:10:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34F3D610CE;
        Mon, 24 May 2021 07:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621840133;
        bh=N/wmL1izOWFBX45cb3+2irEIzjKwywWa5AleGWSWhKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mu9lm2JigOtbWSxC8rHlzPlzg087o33dR+xsx6XIOC3m88d2AfS1uSOZV16J4tWD2
         7408SdtlM2sgy/4eaXhGiYbcFNqDI1uftiHCr4fPStgMGkq8XXucqehylwntNi3QoA
         DXBoiucPTviIaCK8Qq44rYaX9SYd5SRSKf4fPo+E=
Date:   Mon, 24 May 2021 09:08:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nizamhaider786@gmail.com
Cc:     laforge@gnumonks.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] char: pcmcia: cm4000_cs: Fix failure handling
 Handled failure cases of device_create()
Message-ID: <YKtRBesu8wImPa1c@kroah.com>
References: <20210523193029.3178-1-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523193029.3178-1-nizamhaider786@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 01:00:28AM +0530, nizamhaider786@gmail.com wrote:
> From: Nijam Haider <nizamhaider786@gmail.com>
> 
> Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
> ---
>  drivers/char/pcmcia/cm4000_cs.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
> index 89681f0..d6f5598 100644
> --- a/drivers/char/pcmcia/cm4000_cs.c
> +++ b/drivers/char/pcmcia/cm4000_cs.c
> @@ -1783,6 +1783,7 @@ static int cm4000_probe(struct pcmcia_device *link)
>  {
>  	struct cm4000_dev *dev;
>  	int i, ret;
> +	struct device *dev_ret;
>  
>  	for (i = 0; i < CM4000_MAX_DEV; i++)
>  		if (dev_table[i] == NULL)
> @@ -1814,8 +1815,15 @@ static int cm4000_probe(struct pcmcia_device *link)
>  		return ret;
>  	}
>  
> -	device_create(cmm_class, NULL, MKDEV(major, i), NULL, "cmm%d", i);
> -
> +	dev_ret = device_create(cmm_class, NULL, MKDEV(major, i), NULL, "cmm%d", i);
> +        if (IS_ERR(dev_ret)) {
> +               	printk(KERN_ERR "device_create failed for %d\n",
> +                       	       i);
> +		cm4000_release(link);
> +                dev_table[i] = NULL;
> +		kfree(dev);
> +		return -ENODEV;
> +	}
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
