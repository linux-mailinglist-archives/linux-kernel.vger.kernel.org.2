Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F1131F4FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBSGEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBSGES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:04:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9A7364EC0;
        Fri, 19 Feb 2021 06:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613714616;
        bh=M/NSt/uVyYCFS6X/5+ex0ePXM2G5FYgRdFgYQlDGBf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXgfd+z34G2W/MkbpQM/DcljD3tm1k5cr7/frOMDPpkx3KLvSmHJsA9MMrGjQry/d
         2/gCAH60G6NLK/tdiL4KzzR+v1fKWZQXPXocwnQh3lG3dBtJJ0NkCcQh/IGwO+W5dm
         X3ZwGG4En5l3dTlWFYFfVtfCua2zt4JAxW2c+3DQ=
Date:   Fri, 19 Feb 2021 07:03:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Behan <codebam@riseup.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Alex Dewar <alex.dewar90@gmail.com>
Subject: Re: [PATCH] staging: emxx_udc: remove unused variable driver_desc
Message-ID: <YC9UtQ743HBMIp6f@kroah.com>
References: <20210219034109.13036-1-codebam@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219034109.13036-1-codebam@riseup.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:41:07PM -0500, Sean Behan wrote:
> Signed-off-by: Sean Behan <codebam@riseup.net>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index 3536c03ff523..741147a4f0fe 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -38,7 +38,6 @@ static struct gpio_desc *vbus_gpio;
>  static int vbus_irq;
>  
>  static const char	driver_name[] = "emxx_udc";
> -static const char	driver_desc[] = DRIVER_DESC;
>  
>  /*===========================================================================*/
>  /* Prototype */
> -- 
> 2.29.2

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
