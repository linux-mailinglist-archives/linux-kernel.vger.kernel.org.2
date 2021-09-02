Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76733FEAFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhIBJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233511AbhIBJQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:16:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC76060FE6;
        Thu,  2 Sep 2021 09:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630574118;
        bh=KuAjmVrOqdZCZCHcGGY4uTWopUeI1LXNwgvNJx+punw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Ei+yj9vtdfT7NQi4xrKIDVy4Bci9D3wx67OaYdLo1TkXA7742ZId7nw6sWy53fTq
         QH2GRbYcmH2ep2XL7ozqKNPyktB/k+L2wK1ZXEN9/cp8IBFKHz8wPSWdDD668GtKv9
         1jQUhGudpI7vgjR0GEOv29Y0kmeGQ04BvkN3lT+4=
Date:   Thu, 2 Sep 2021 11:15:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: greybus: Convert uart.c from IDR to XArray
Message-ID: <YTCWI5wID0pS9PMl@kroah.com>
References: <20210816195000.736-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816195000.736-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 09:50:00PM +0200, Fabio M. De Francesco wrote:
> Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
> is more memory-efficient, parallelisable, and cache friendly. It takes
> advantage of RCU to perform lookups without locking. Furthermore, IDR is
> deprecated because XArray has a better (cleaner and more consistent) API.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v2->v3:
> 	Fix some issues according to a review by Alex Elder <elder@ieee.org>
> 
> v1->v2:
>         Fix an issue found by the kernel test robot. It is due to
>         passing to xa_*lock() the same old mutex that IDR used with
>         the previous version of the code.
> 
>  drivers/staging/greybus/uart.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> index 73f01ed1e5b7..815156c88005 100644
> --- a/drivers/staging/greybus/uart.c
> +++ b/drivers/staging/greybus/uart.c
> @@ -22,7 +22,7 @@
>  #include <linux/serial.h>
>  #include <linux/tty_driver.h>
>  #include <linux/tty_flip.h>
> -#include <linux/idr.h>
> +#include <linux/xarray.h>
>  #include <linux/fs.h>
>  #include <linux/kdev_t.h>
>  #include <linux/kfifo.h>
> @@ -32,8 +32,9 @@
>  
>  #include "gbphy.h"
>  
> -#define GB_NUM_MINORS	16	/* 16 is more than enough */
> -#define GB_NAME		"ttyGB"
> +#define GB_NUM_MINORS		16	/* 16 is more than enough */
> +#define GB_RANGE_MINORS		XA_LIMIT(0, GB_NUM_MINORS)
> +#define GB_NAME			"ttyGB"
>  
>  #define GB_UART_WRITE_FIFO_SIZE		PAGE_SIZE
>  #define GB_UART_WRITE_ROOM_MARGIN	1	/* leave some space in fifo */
> @@ -67,8 +68,7 @@ struct gb_tty {
>  };
>  
>  static struct tty_driver *gb_tty_driver;
> -static DEFINE_IDR(tty_minors);
> -static DEFINE_MUTEX(table_lock);
> +static DEFINE_XARRAY(tty_minors);
>  
>  static int gb_uart_receive_data_handler(struct gb_operation *op)
>  {
> @@ -341,8 +341,8 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
>  {
>  	struct gb_tty *gb_tty;
>  
> -	mutex_lock(&table_lock);
> -	gb_tty = idr_find(&tty_minors, minor);
> +	xa_lock(&tty_minors);
> +	gb_tty = xa_load(&tty_minors, minor);
>  	if (gb_tty) {
>  		mutex_lock(&gb_tty->mutex);
>  		if (gb_tty->disconnected) {
> @@ -353,19 +353,19 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
>  			mutex_unlock(&gb_tty->mutex);
>  		}
>  	}
> -	mutex_unlock(&table_lock);
> +	xa_unlock(&tty_minors);
>  	return gb_tty;
>  }
>  
>  static int alloc_minor(struct gb_tty *gb_tty)
>  {
>  	int minor;
> +	int ret;
>  
> -	mutex_lock(&table_lock);
> -	minor = idr_alloc(&tty_minors, gb_tty, 0, GB_NUM_MINORS, GFP_KERNEL);
> -	mutex_unlock(&table_lock);
> -	if (minor >= 0)
> -		gb_tty->minor = minor;
> +	ret = xa_alloc(&tty_minors, &minor, gb_tty, GB_RANGE_MINORS, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +	gb_tty->minor = minor;
>  	return minor;
>  }
>  
> @@ -374,9 +374,7 @@ static void release_minor(struct gb_tty *gb_tty)
>  	int minor = gb_tty->minor;
>  
>  	gb_tty->minor = 0;	/* Maybe should use an invalid value instead */
> -	mutex_lock(&table_lock);
> -	idr_remove(&tty_minors, minor);
> -	mutex_unlock(&table_lock);
> +	xa_erase(&tty_minors, minor);
>  }
>  
>  static int gb_tty_install(struct tty_driver *driver, struct tty_struct *tty)
> @@ -837,7 +835,7 @@ static int gb_uart_probe(struct gbphy_device *gbphy_dev,
>  
>  	minor = alloc_minor(gb_tty);
>  	if (minor < 0) {
> -		if (minor == -ENOSPC) {
> +		if (minor == -EBUSY) {
>  			dev_err(&gbphy_dev->dev,
>  				"no more free minor numbers\n");
>  			retval = -ENODEV;
> @@ -982,7 +980,7 @@ static void gb_tty_exit(void)
>  {
>  	tty_unregister_driver(gb_tty_driver);
>  	put_tty_driver(gb_tty_driver);
> -	idr_destroy(&tty_minors);
> +	xa_destroy(&tty_minors);
>  }
>  
>  static const struct gbphy_device_id gb_uart_id_table[] = {
> -- 
> 2.32.0
> 
> 

I'm going to drop this from my review queue as I do not see the need to
do this type of conversion at this point in time.  Perhaps if "real"
drivers in the kernel get converted over to this new api we should also
do it here, but for now, there's much more "real" issues with the
greybus drivers that should be done that is keeping them from being
merged into the main part of the kernel tree, that the churn here is not
necessary at this point in time (especially if you have not tested
this.)

thanks,

greg k-h
