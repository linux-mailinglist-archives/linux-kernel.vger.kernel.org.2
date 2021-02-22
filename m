Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CB7321268
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 09:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhBVIy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 03:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhBVIyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 03:54:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBAA664DD3;
        Mon, 22 Feb 2021 08:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613984024;
        bh=AJ4Jnexz4G+2eNYpf2WgdbDxY9MFPsAtkq+r5c6p0hU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQlEnNOxNgMxynHBmypJDyndLgPKPbA9lQKFICJNLJd11/xukONkbPNLIz4Xkkf2p
         MmhRjsGFuzSgGqB8CkQ2AXnORcK/yGYk2c7Uw1eKkGg+LyrtTDm4Fy5+R6Uw+Lsmxe
         7LZewiqQT+6UG+2caKITPloBdHd914tV4rrHUmwE=
Date:   Mon, 22 Feb 2021 09:53:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: convert sysfs sprintf/snprintf family to sysfs_emit
Message-ID: <YDNxFGx3bHCBoZVd@kroah.com>
References: <1613983729-101495-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613983729-101495-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 04:48:49PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/tty/vt/vt.c:3909:8-16: WARNING: use scnprintf or sprintf.
> ./drivers/tty/vt/vt.c:3917:8-16: WARNING: use scnprintf or sprintf

Why?

You say what you did, but there is no justification for why this is
required in the tree.

> 
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>

You forgot a ' '.

> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/tty/vt/vt.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 284b072..cdf8132 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3906,7 +3906,7 @@ static ssize_t show_bind(struct device *dev, struct device_attribute *attr,
>  	bind = con_is_bound(con->con);
>  	console_unlock();
>  
> -	return snprintf(buf, PAGE_SIZE, "%i\n", bind);
> +	return sysfs_emit(buf, "%i\n", bind);
>  }
>  
>  static ssize_t show_name(struct device *dev, struct device_attribute *attr,
> @@ -3914,9 +3914,8 @@ static ssize_t show_name(struct device *dev, struct device_attribute *attr,
>  {
>  	struct con_driver *con = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%s %s\n",
> -			(con->flag & CON_DRIVER_FLAG_MODULE) ? "(M)" : "(S)",
> -			 con->desc);
> +	return sysfs_emit(buf, "%s %s\n", (con->flag & CON_DRIVER_FLAG_MODULE) ? "(M)" : "(S)",
> +			  con->desc);

Why make the line longer now?  Can't this be a 1 line change here?

And why is this needed?

thanks,

greg k-h
