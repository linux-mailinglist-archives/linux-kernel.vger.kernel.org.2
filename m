Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208C5365314
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhDTHTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhDTHTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:19:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DD2F60C40;
        Tue, 20 Apr 2021 07:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618903158;
        bh=pktyu9GGKjTObq0rU5/41yUklfwS8kQ21/mqPt8V+QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hP5I0a8Z6H63iP4GVjgKXs6PS4lmyGeoOI68kBxEG36thouvMInr+buISN7xUY51c
         z03bn/K0dn21GscboQv7l7voWkHt6cw6RQeOwQEVmo8FxRzOyYnpOTMbd8DiMd384D
         wbytYch/wqtQ04/LADGgGHxXABWN3eAW3h6c+jDs=
Date:   Tue, 20 Apr 2021 09:19:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: sm501fb:  Fix deallocation of buffers order
Message-ID: <YH6AdPxOE8d51pXy@kroah.com>
References: <20210406233519.2205389-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406233519.2205389-1-pakki001@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:35:17PM -0500, Aditya Pakki wrote:
> The resource release in sm501fb_remove() is not in the inverse order of
> sm501fb_probe(), for the buffers. Release the info object after
> deallocating the buffers.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/video/fbdev/sm501fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
> index 6a52eba64559..4c32c9e88850 100644
> --- a/drivers/video/fbdev/sm501fb.c
> +++ b/drivers/video/fbdev/sm501fb.c
> @@ -2060,11 +2060,11 @@ static int sm501fb_remove(struct platform_device *pdev)
>  		unregister_framebuffer(fbinfo_pnl);
>  
>  	sm501fb_stop(info);
> -	kfree(info);
>  
>  	framebuffer_release(fbinfo_pnl);
>  	framebuffer_release(fbinfo_crt);
>  
> +	kfree(info);
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 

There is no function change here at all, please stop it with pointless
patches.

greg k-h
