Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED4414170
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhIVGCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231908AbhIVGCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:02:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11574611B0;
        Wed, 22 Sep 2021 06:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632290468;
        bh=k+FxRtvekpLiB0ACIVoYSK78GE/ER5x9/8OVydWJTvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yn42Ei1QQrtRo57JULwwLMWRtb+gCmRYfL1ha+NZ44nTL8sf5fk5H+NkCJCmmRj6o
         ijlhhgOnoILIkTXQQwnWqIhrOUkuXFhHYw+5GRiiLhhTdp6/6yYc55Si0TmcXJ5i3c
         kor86ZgOONpoNi1ifKVV8r1ZlaXy6wCSP+PVtFDQ=
Date:   Wed, 22 Sep 2021 08:01:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: usb-skeleton: Update min() to min_t()
Message-ID: <YUrGoQsreezij1C9@kroah.com>
References: <20210921205212.GA8669@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921205212.GA8669@matrix-ESPRIMO-P710>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 10:52:12PM +0200, Philipp Hortmann wrote:
> This patch fixes the checkpatch.pl warning:
> WARNING: min() should probably be min_t(size_t, count, MAX_TRANSFER)
> +	size_t writesize = min(count, (size_t)MAX_TRANSFER);
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/usb/usb-skeleton.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
> index 2dc58766273a..d87deee3e26e 100644
> --- a/drivers/usb/usb-skeleton.c
> +++ b/drivers/usb/usb-skeleton.c
> @@ -363,7 +363,7 @@ static ssize_t skel_write(struct file *file, const char *user_buffer,
>  	int retval = 0;
>  	struct urb *urb = NULL;
>  	char *buf = NULL;
> -	size_t writesize = min(count, (size_t)MAX_TRANSFER);
> +	size_t writesize = min_t(size_t, count, MAX_TRANSFER);
>  
>  	dev = file->private_data;
>  
> -- 
> 2.25.1
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
