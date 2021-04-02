Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F596352865
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhDBJRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBJRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:17:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 577A861008;
        Fri,  2 Apr 2021 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617355057;
        bh=nNXmKyTHRFu5FEX84hqP3eIGOZ1pmAYpxndQn7fgYQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1bVRMjgYnmVMwuln9bkOhNMTJOytmbdU1QgJ5Dtjpb2LfVD+hbNtkvBbBZw8IA7w3
         M/xh4gd+1KECR2HoShaNrE8pvZHCJ1wIkkdioSG/TrpGKy2E6tLztD7laPSepvqlaq
         XqclZkejDnGUS8hOPj7hLv9X/OQIboeIhOwxWN18=
Date:   Fri, 2 Apr 2021 11:17:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     zhangxuezhi1@yulong.com, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] staging: fbtft: change snprintf() to scnprintf()
Message-ID: <YGbhLxwZO9k/330J@kroah.com>
References: <20210402090501.152561-1-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402090501.152561-1-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 09:05:01AM +0000, Carlis wrote:
> From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> 
> show() must not use snprintf() when formatting the value to
> be returned to user space.

Why not?  The code is just fine as-is.

> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> ---
>  drivers/staging/fbtft/fbtft-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
> index 26e52cc2de64..7df92db648d6 100644
> --- a/drivers/staging/fbtft/fbtft-sysfs.c
> +++ b/drivers/staging/fbtft/fbtft-sysfs.c
> @@ -199,7 +199,7 @@ static ssize_t show_debug(struct device *device,
>  	struct fb_info *fb_info = dev_get_drvdata(device);
>  	struct fbtft_par *par = fb_info->par;
>  
> -	return snprintf(buf, PAGE_SIZE, "%lu\n", par->debug);
> +	return scnprintf(buf, PAGE_SIZE, "%lu\n", par->debug);

If you really want to "fix" this, please just use sysfs_emit().  This
change as-is, does nothing.

thanks,

greg k-h
