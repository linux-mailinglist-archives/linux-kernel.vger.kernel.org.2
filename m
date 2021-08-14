Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A83EC0EB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 08:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbhHNGf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 02:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhHNGf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 02:35:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C4C260F42;
        Sat, 14 Aug 2021 06:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628922899;
        bh=oGtCt58JZdQiy65LwaHzaDn8T8xIXJtqmI5aaXJcyuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=thhtb19F8xctA5Icf80p/PaOqEb1XnQMEjYzQqQTuKWptreYYlXDrnkNMh/6VpXrI
         fvKu54R4raNNkrVXamAGhCm2Rzet7GJUYcpfyrmvUVEuwe9er5YOOM/cYn6UBDkhUJ
         texw5uJ1h19DmphJl5aSOqGC8xpYzGeYcJCza4kQ=
Date:   Sat, 14 Aug 2021 08:34:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Keith Packard <keithp@keithp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: misc: chaoskey: remove useless else
Message-ID: <YRdkDvF+BhGsKakD@kroah.com>
References: <20210813164049.GA2310720@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813164049.GA2310720@pc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 05:40:49PM +0100, Salah Triki wrote:
> Remove useless else in order to make the code cleaner.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/usb/misc/chaoskey.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
> index 87067c3d6109..9814ac2201d5 100644
> --- a/drivers/usb/misc/chaoskey.c
> +++ b/drivers/usb/misc/chaoskey.c
> @@ -299,14 +299,11 @@ static int chaoskey_release(struct inode *inode, struct file *file)
>  
>  	--dev->open;
>  
> -	if (!dev->present) {
> -		if (dev->open == 0) {
> -			mutex_unlock(&dev->lock);
> +	mutex_unlock(&dev->lock);
> +
> +	if (!dev->present)
> +		if (dev->open == 0)
>  			chaoskey_free(dev);
> -		} else
> -			mutex_unlock(&dev->lock);
> -	} else
> -		mutex_unlock(&dev->lock);
>  
>  	usb_dbg(interface, "release success");
>  	return 0;
> -- 
> 2.25.1
> 

Please fix whatever tool "found" this code to be changed so that it does
not introduce bugs again, that's a broken tool.

thanks,

greg k-h
