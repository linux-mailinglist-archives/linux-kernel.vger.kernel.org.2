Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D520E31D55C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 07:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhBQGYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 01:24:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhBQGYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:24:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B59E164DA8;
        Wed, 17 Feb 2021 06:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613543019;
        bh=yX/7/3bFLSm2Jk5E6YO64C5LOVj96jDGfspBFl7zRF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klrxJlIpxsW64P9YIT9jIgtPLYIstnGXot33SibeaeTTFGEUTvNB6lilRKIFgQHNy
         wRngNQ6uFePWXWVXjpXQUyuGbD32a6FVfT3SAK6gD7A41HHn9OZqYeXpe4/2kMBJRf
         zZXG5qgTKVQkjUPrEWAXTs09oQ5uLQgZiKD22W5Q=
Date:   Wed, 17 Feb 2021 07:23:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Behan <codebam@riseup.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Alex Dewar <alex.dewar90@gmail.com>
Subject: Re: [PATCH] remove unused variable driver_desc
Message-ID: <YCy2aIText4lGmPF@kroah.com>
References: <20210217035953.192959-1-codebam@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217035953.192959-1-codebam@riseup.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 10:59:51PM -0500, Sean Behan wrote:
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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
