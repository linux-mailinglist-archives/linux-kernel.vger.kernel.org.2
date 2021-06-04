Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F4D39B9B4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFDNVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhFDNVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:21:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 794E9613DE;
        Fri,  4 Jun 2021 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622812791;
        bh=74LOlmBA6nBCcsHqoSpsW9MYDwdS4flEvJZPaEiNQvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNq4z+EpVvlKKvWtNTK0R1a1VEAMZNR5HJygxiMwTj3jISUpAxMzF8KTlTlHuzsbk
         ucBTJG6KTRxhvtqtwb9IO5z1QSYL+jrQUWRQ1Bga4rKWdrsSmeN0TZf/OQSEL+SKJZ
         jgneCliXk3GIBSNDqicXaNbOIOArLJhZceCfjbho=
Date:   Fri, 4 Jun 2021 15:19:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
Subject: Re: [PATCH RFC] tty: Fix out-of-bound vmalloc access in imageblit
Message-ID: <YLoob2rm3isTp+ln@kroah.com>
References: <20210531124713.9048-1-igormtorrente@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531124713.9048-1-igormtorrente@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 09:47:13AM -0300, Igor Matheus Andrade Torrente wrote:
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
> To solve this issue I brougth the resize_screen() the
> beginning of vc_do_resize(), so it will "fix and fill"
> the fb_var_screeninfo even if the screen does not need any
> resizing.
> 
> Reported-and-tested-by: syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index fa1548d4f94b..1b90758d8893 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1219,6 +1219,10 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>  	new_row_size = new_cols << 1;
>  	new_screen_size = new_row_size * new_rows;
>  
> +	err = resize_screen(vc, new_cols, new_rows, user);
> +	if (err)
> +		return err;
> +
>  	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
>  		return 0;
>  

But now if any of the checks below this call fail, the screen will be
resized and not "put back" to the original size, right?  That could
cause a mis-match of what is expected here.

thanks,

greg k-h
