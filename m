Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192F4350576
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhCaRch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhCaRcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:32:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65B3F6100A;
        Wed, 31 Mar 2021 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617211929;
        bh=R6hdUWDOSIo+l+ZPLsXFD7/GO3a//15OerumDzH+MCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ws4NneA9cCNtMpAPsh7LyxzNjHyj7eH5GVbMpg1JHtA+fzG1naeJYuaYEgdW+HDT8
         8uCnoLFnIvC/dK5kwMzB36wB3WcBqGWXuQCtQWgX8v9hzNiEOV4C8QV62AUw6x9RBc
         peMRvv/ZZ+ZrNuEWNQ3FBHMZRCcUJI+3lakFvwy0=
Date:   Wed, 31 Mar 2021 19:32:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hassan Shahbazi <h.shahbazi.git@gmail.com>
Cc:     daniel.vetter@ffwll.ch, jirislaby@kernel.org,
        yepeilin.cs@gmail.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix NULL pointer deference crash
Message-ID: <YGSyFgeNd7gfsbR6@kroah.com>
References: <20210331163425.8092-1-h.shahbazi.git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331163425.8092-1-h.shahbazi.git@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:34:29PM +0300, Hassan Shahbazi wrote:
> The patch has fixed a NULL pointer deference crash in hiding the cursor. It 
> is verified by syzbot patch tester.
> 
> Reported by: syzbot
> https://syzkaller.appspot.com/bug?id=defb47bf56e1c14d5687280c7bb91ce7b608b94b
> 
> Signed-off-by: Hassan Shahbazi <h.shahbazi.git@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 44a5cd2f54cc..ee252d1c43c6 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1333,8 +1333,9 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
>  
>  	ops->cursor_flash = (mode == CM_ERASE) ? 0 : 1;
>  
> -	ops->cursor(vc, info, mode, get_color(vc, info, c, 1),
> -		    get_color(vc, info, c, 0));
> +	if (ops && ops->cursor)

As ops obviously is not NULL here (you just used it on the line above),
why are you checking it again?

And what makes curser be NULL here?  How can that happen?

Also your subject line can use some work, please make it reflect the
driver subsystem you are looking at.

thanks,

greg k-h
