Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0844E42B6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 08:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbhJMGVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 02:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237940AbhJMGVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:21:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E23AB60E74;
        Wed, 13 Oct 2021 06:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634105948;
        bh=JSjfMx0FtEzkD9nFNaix3VBaJvvP+0sPjIpxvGSeX30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1LucEv/OC8nASne80gQb2J/oCFfy1K593axLCYRrQVpP9D9fEC9p9k5wmOHp1lc7l
         ZYti/jgr4QvstKC4bzXQctHry7cR7aXA13Zm6uB8Fz2Q1YfY0s754XTe019xIhLvqk
         e7qdCNLkHpQllzfMwt36XebHJyhziqVxWVMs4KUQ=
Date:   Wed, 13 Oct 2021 08:19:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: replace snprintf in show functions with sysfs_emit
Message-ID: <YWZ6Wa/RmeBaGrWK@kroah.com>
References: <1634095668-4319-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634095668-4319-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 08:27:47PM -0700, Qing Wang wrote:
> coccicheck complains about the use of snprintf() in sysfs show functions.
> 
> Fix the following coccicheck warning:
> drivers/usb/core/sysfs.c:730:8-16: WARNING: use scnprintf or sprintf.
> drivers/usb/core/sysfs.c:921:8-16: WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/usb/core/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> index fa2e49d..6387c0d 100644
> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c
> @@ -727,7 +727,7 @@ static ssize_t authorized_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
>  	struct usb_device *usb_dev = to_usb_device(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", usb_dev->authorized);
> +	return sysfs_emit(buf, "%u\n", usb_dev->authorized);
>  }
>  
>  /*
> @@ -918,7 +918,7 @@ static ssize_t authorized_default_show(struct device *dev,
>  	struct usb_hcd *hcd;
>  
>  	hcd = bus_to_hcd(usb_bus);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", hcd->dev_policy);
> +	return sysfs_emit(buf, "%u\n", hcd->dev_policy);
>  }
>  
>  static ssize_t authorized_default_store(struct device *dev,
> -- 
> 2.7.4
> 

If you are going to change this file, you should do this for all of the
sysfs show functions in this file, not just 2 of them, right?  Please
change this patch to do that.

thanks,

greg k-h
