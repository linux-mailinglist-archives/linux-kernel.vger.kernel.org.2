Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F523B2F77
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhFXNAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhFXNAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:00:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38793613C3;
        Thu, 24 Jun 2021 12:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624539461;
        bh=HjaVdHowmGn+bxqs/WsvX1B9BQgWJs+HkHjrRTRg8Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vi+R578DRyMLSh7YeVvlf8/MfgXWcvIHagCrJTwLTw/5gn5iRFjvk22tRaan2cfIP
         NlzEh4YvosgFBuI20+wDNMXzbXVc84sJDt7sY81h7zVoVYa8v1vzXksLF2CCAmP3nt
         9bo9T1EsRRY4G0e6YoZSw2Pu2uV0kyRbwWRxYTvg=
Date:   Thu, 24 Jun 2021 14:57:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] tty: Fix out-of-bound vmalloc access in imageblit
Message-ID: <YNSBQxVidmlZz5YM@kroah.com>
References: <20210617223720.29378-1-igormtorrente@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617223720.29378-1-igormtorrente@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 07:37:20PM -0300, Igor Matheus Andrade Torrente wrote:
> This issue happens when a userspace program does an ioctl
> FBIOPUT_VSCREENINFO passing the fb_var_screeninfo struct
> containing only the fields xres, yres, and bits_per_pixel
> with values.
> 
> If this struct is the same as the previous ioctl, the
> vc_resize() detects it and doesn't call the resize_screen(),
> leaving the fb_var_screeninfo incomplete. And this leads to
> the updatescrollmode() calculates a wrong value to
> fbcon_display->vrows, which makes the real_y() return a
> wrong value of y, and that value, eventually, causes
> the imageblit to access an out-of-bound address value.
> 
> To solve this issue I made the resize_screen() be called
> even if the screen does not need any resizing, so it will
> "fix and fill" the fb_var_screeninfo independently.
> 
> Reported-and-tested-by: syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> ---
> v2: It Tries to avoid the problem found by Greg in the previous
>     patch.
> 
> v3: Add a big comment explaining why this is being done the way
>     it is.
> ---
>  drivers/tty/vt/vt.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index fa1548d4f94b..a0207525a945 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1220,7 +1220,20 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>  	new_screen_size = new_row_size * new_rows;
>  
>  	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
> -		return 0;
> +		/* This function is being called here to cover the case

Please do not use networking style comments, use normal ones:
		/*
		 * This function...

> +		 * where the userspace calls the FBIOPUT_VSCREENINFO twice,
> +		 * passing the same fb_var_screeninfo containing only the
> +		 * fields xres, yres, and bits_per_pixel with yeird(but valid)

"yeird"?

And put a space after that word please.

thanks,

greg k-h
