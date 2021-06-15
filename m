Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289C23A7F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhFONaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhFONaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:30:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6CA261468;
        Tue, 15 Jun 2021 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623763684;
        bh=s4DCRr6gd8QdC/cIRhXmf9yOcNT5lHnTgdw2ssrVcfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eS3N8PXWeiD9ris3hzIoJuLWn2NGjTdShLrljniwaPU6/GCsQx081P3i9GY/GGoi0
         1QZbWqrKpygg5tCF3Jxy2C6o6uSt6t2e0Ijc+IQ2MNOKlCurBgbGtnjdcpVouHaw2o
         srePOQA4J+SyUl/UYh5XamQCK8rigmbn50YQdt1U=
Date:   Tue, 15 Jun 2021 15:28:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] tty: Fix out-of-bound vmalloc access in imageblit
Message-ID: <YMiq4eucvkSGgSCp@kroah.com>
References: <20210614131859.9511-1-igormtorrente@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614131859.9511-1-igormtorrente@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 10:18:59AM -0300, Igor Matheus Andrade Torrente wrote:
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
> ---
>  drivers/tty/vt/vt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index fa1548d4f94b..e522f9b249e5 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1219,8 +1219,10 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>  	new_row_size = new_cols << 1;
>  	new_screen_size = new_row_size * new_rows;
>  
> -	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
> -		return 0;
> +	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows) {
> +		err = resize_screen(vc, new_cols, new_rows, user);
> +		return err;

Shouldn't this just be a single line change to:
		return resize_screen(vc, new_cols, new_rows, user);
?

But this also should get a big comment, as it looks odd that if the size
isn't changing, why this function should be called at all.  At first
glance at just the code, this looks wrong, so please document this
really well here.

thanks,

greg k-h

