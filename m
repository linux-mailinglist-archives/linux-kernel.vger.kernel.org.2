Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A103FB2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhH3JNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235272AbhH3JNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 839B76101B;
        Mon, 30 Aug 2021 09:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630314757;
        bh=lRY3z7xzOhyAa+s22iimKUyXMmbwq9wyRJbp7StGBn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHzT/+UcQr4T8GBmyidibU8QhwbNurATRroq6qrxAIiHCcADCu/Jio60QFigfdWsL
         xUmzStA75l4aZofPA+jyPkYhViv0v/sdvRszDrPwj7v7IO3b41EytOj6rjbnqv5Nd4
         /lyZjxty59Kbqm+7xJ/j3UFIA41tMAL8GXP8LZz49H13K1S5THaTMPJRXh3CdI1Fnu
         FzwfK8nhClFTcuo2CLOAczAmcwLJ+HV9eU4hyB2Fo6PvsWMh2VjD4VZuxJX3QZ8mNe
         T+cv49ft+TqfUj6Q7RddW4/LL/TXQ3g/CziVJbBlFxDotXPCiOOK8bE+3cCMF06y+4
         gZFzyTDWJ1Fdw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mKdLA-0005T9-6y; Mon, 30 Aug 2021 11:12:28 +0200
Date:   Mon, 30 Aug 2021 11:12:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: greybus: Convert uart.c from IDR to XArray
Message-ID: <YSyg/Db1So0LDGR+@hovoldconsulting.com>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829092250.25379-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 11:22:50AM +0200, Fabio M. De Francesco wrote:
> Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
> is more memory-efficient, parallelisable, and cache friendly. It takes
> advantage of RCU to perform lookups without locking. Furthermore, IDR is
> deprecated because XArray has a better (cleaner and more consistent) API.

Where does it say that IDR is deprecated? Almost all drivers use IDR/IDA
and its interfaces are straight-forward. In most cases we don't care
about a possible slight increase in efficiency either, and so also in
this case. Correctness is what matters and doing these conversions risks
introducing regressions.

And I believe IDR use XArray internally these days anyway.

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v3->v4: 
> 	Remove mutex_lock/unlock around xa_load(). These locks seem to
> 	be unnecessary because there is a 1:1 correspondence between
> 	a specific minor and its gb_tty and there is no reference
> 	counting. I think that the RCU locks used inside xa_load()
> 	are sufficient to protect this API from returning an invalid
> 	gb_tty in case of concurrent access. Some more considerations 
> 	on this topic are in the following message to linux-kernel list:
> 	https://lore.kernel.org/lkml/3554184.2JXonMZcNW@localhost.localdomain/

This just doesn't make sense (and a valid motivation would need to go in
the commit message if there was one).

> v2->v3:
>         Fix some issues according to a review by Alex Elder <elder@ieee.org>
> v1->v2:
>         Fix an issue found by the kernel test robot. It is due to
>         passing to xa_*lock() the same old mutex that IDR used with
>         the previous version of the code.
> 
>  drivers/staging/greybus/uart.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> index 73f01ed1e5b7..f66983adb51b 100644
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
> @@ -341,8 +341,7 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
>  {
>  	struct gb_tty *gb_tty;
>  
> -	mutex_lock(&table_lock);
> -	gb_tty = idr_find(&tty_minors, minor);
> +	gb_tty = xa_load(&tty_minors, minor);
>  	if (gb_tty) {
>  		mutex_lock(&gb_tty->mutex);
>  		if (gb_tty->disconnected) {
> @@ -353,19 +352,18 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
>  			mutex_unlock(&gb_tty->mutex);
>  		}
>  	}
> -	mutex_unlock(&table_lock);

You can't just drop the locking here since you'd introduce a potential
use-after-free in case gb_tty is freed after the lookup but before the
port reference is taken.

That said, this driver is already broken since it can currently free the
gb_tty while there are references to the port. I'll try to fix it up...

>  	return gb_tty;
>  }

But as you may have gathered, I don't think doing these conversions is a
good idea.

Johan
