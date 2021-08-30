Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D5D3FB0DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhH3Fp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhH3Fpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:45:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C38FD60F57;
        Mon, 30 Aug 2021 05:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630302301;
        bh=LU8rgY0nlcLGJ0Odp4fZfzKGSi2dMFgS4N01IWoDkt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HayGxGtZ83S7vi18Gk6XUrcgt28QrdBKOAD024qt/XbwSyxM4105omlig777Sf/6K
         7Dtv2P+YWO4u9FaOwjIFpaGJdGTWbDfbo2Ooy17hqbRftxkrfZ+fSvC8q5RDxgfCer
         LGEQKYd/ylznu56w1ZhtnU2weyK+B0e+mBsAQINc=
Date:   Mon, 30 Aug 2021 07:44:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     tcs.kernel@gmail.com
Cc:     daniel.vetter@ffwll.ch, willy@infradead.org,
        george.kennedy@oracle.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, penguin-kernel@i-love.sakura.ne.jp,
        Haimin Zhang <tcs_kernel@tencent.com>
Subject: Re: [PATCH V4] fbcon: fix fbcon out-of-bounds write in sys_imageblit
Message-ID: <YSxwWcvyNtu2QtJ5@kroah.com>
References: <1630294223-7225-1-git-send-email-tcs_kernel@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630294223-7225-1-git-send-email-tcs_kernel@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 11:30:23AM +0800, tcs.kernel@gmail.com wrote:
> From: Haimin Zhang <tcs_kernel@tencent.com>
> 
> yres and vyres can be controlled by user mode parameters, and cause
> p->vrows to become a negative value. While this value be passed to real_y
> function, the ypos will be out of screen range.This is an out-of-bounds
> write bug.
> some driver will check xres and yres in fb_check_var callback,but some not
> so we add a common check after that callback.
> 
> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> ---
>  drivers/video/fbdev/core/fbmem.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 1c85514..5599372 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1013,6 +1013,10 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
>  	if (ret)
>  		return ret;
>  
> +	/* virtual resolution cannot be smaller than visible resolution. */
> +	if (var->yres_virtual < var->yres || var->xres_virtual < var->xres)
> +		return -EINVAL;
> +
>  	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
>  		return 0;
>  
> -- 
> 1.8.3.1
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
