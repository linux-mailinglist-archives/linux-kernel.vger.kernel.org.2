Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EA5427F54
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 08:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhJJG3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 02:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbhJJG3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 02:29:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 715B160EBD;
        Sun, 10 Oct 2021 06:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633847236;
        bh=vCnFyg7canN42mdsHkanNiVAESAJuv9PTNd0CNc46Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hacgzfcl3I/VAx5sHgppfAvIYKfho33lLH9/83aZCBQ61aa3YnQjY5qkV4x8vH3qP
         N5eoBu/gTk10Kxw35Q7hp9BFfhcapj8S/4KHQm8nfUHn69R8jAJTEIIe0VxQaZjhZf
         gZrAq1mby0BpU9uxitlOBJBgCFnD9Ys/kLEROxow=
Date:   Sun, 10 Oct 2021 08:27:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Christian Gromm <christian.gromm@microchip.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: most: dim2: do not double-register the same
 device
Message-ID: <YWKHvvLtb0MSJy2X@kroah.com>
References: <YVwofSvwGTv3kHjh@kroah.com>
 <20211005143448.8660-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005143448.8660-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 05:34:48PM +0300, Nikita Yushchenko wrote:
> Commit 723de0f9171e ("staging: most: remove device from interface
> structure") moved registration of driver-provided struct device to
> the most subsystem.
> 
> Dim2 used to register the same struct device to provide a custom device
> attribute. This causes double-registration of the same struct device.
> 
> Fix that by moving the custom attribute to driver's dev_groups.
> This moves attribute to the platform_device object, which is a better
> location for platform-specific attributes anyway.
> 
> Fixes: 723de0f9171e ("staging: most: remove device from interface structure")
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  drivers/staging/most/dim2/Makefile |  2 +-
>  drivers/staging/most/dim2/dim2.c   | 31 ++++++++++++-------
>  drivers/staging/most/dim2/sysfs.c  | 49 ------------------------------
>  drivers/staging/most/dim2/sysfs.h  | 11 -------
>  4 files changed, 21 insertions(+), 72 deletions(-)
>  delete mode 100644 drivers/staging/most/dim2/sysfs.c
> 
> diff --git a/drivers/staging/most/dim2/Makefile b/drivers/staging/most/dim2/Makefile
> index 861adacf6c72..5f9612af3fa3 100644
> --- a/drivers/staging/most/dim2/Makefile
> +++ b/drivers/staging/most/dim2/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_MOST_DIM2) += most_dim2.o
>  
> -most_dim2-objs := dim2.o hal.o sysfs.o
> +most_dim2-objs := dim2.o hal.o
> diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> index e8b03fa90e80..bb6dd508e531 100644
> --- a/drivers/staging/most/dim2/dim2.c
> +++ b/drivers/staging/most/dim2/dim2.c
> @@ -118,7 +118,8 @@ struct dim2_platform_data {
>  	(((p)[1] == 0x18) && ((p)[2] == 0x05) && ((p)[3] == 0x0C) && \
>  	 ((p)[13] == 0x3C) && ((p)[14] == 0x00) && ((p)[15] == 0x0A))
>  
> -bool dim2_sysfs_get_state_cb(void)
> +static ssize_t state_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
>  {
>  	bool state;
>  	unsigned long flags;
> @@ -127,9 +128,25 @@ bool dim2_sysfs_get_state_cb(void)
>  	state = dim_get_lock_state();
>  	spin_unlock_irqrestore(&dim_lock, flags);
>  
> -	return state;
> +	return sprintf(buf, "%s\n", state ? "locked" : "");

sysfs_emit()?

>  }
>  
> +static DEVICE_ATTR_RO(state);
> +
> +static struct attribute *dim2_dev_attrs[] = {
> +	&dev_attr_state.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group dim2_attr_group = {
> +	.attrs = dim2_dev_attrs,
> +};
> +
> +static const struct attribute_group *dim2_attr_groups[] = {
> +	&dim2_attr_group,
> +	NULL,
> +};

ATTRIBUTE_GROUPS()?

Other than these minor things, looks good, thanks for doing this!

greg k-h
