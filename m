Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67490396618
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhEaQ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233887AbhEaPAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:00:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E810C61008;
        Mon, 31 May 2021 14:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622470343;
        bh=6phEk+ehrI5BiIFe56Xo9m3IfTqZABrVqSkbDpqT1Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KViMVZXNZei9ejipTULHGckwGGUDsqIuMRNXZqhMx6LjgYXstOegXPC5RlvNdFmUk
         fqeRmUNKQcGuenzYWATka0dAAwvE48/odrJc3e7G4sbPqtopW1FXBME0h5oblSyH1T
         n/zLSDNR8HAQKIg0q9wT9RP9QFZ48fd3SZGC8ioM=
Date:   Mon, 31 May 2021 15:18:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
Subject: Re: [PATCH RFC] tty: Fix out-of-bound vmalloc access in imageblit
Message-ID: <YLTiD489JoUiYt8J@kroah.com>
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

Why is this "RFC"?
