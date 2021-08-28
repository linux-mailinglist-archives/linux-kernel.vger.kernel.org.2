Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF23FA688
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhH1Poo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhH1Pom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:44:42 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D73C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 08:43:52 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x5so10604723ill.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9eIn9xmZE3lDDxF5D7SNUmbx8I+eA8wKnaNy1sQ/lzw=;
        b=o75epPEcTLKnpr8vmg72GB4RV/9INyBQjSXUD/UExbzMjRC0K+am+369CyveyW8rjP
         qe39+wLdWNiJlLNqQWkrt47SCn0nOx5UjQ4heXT5o99FsRqQ68qcC0oGwqxtbPWXbCo1
         9F8HqBp8rhxhKMLT/0eBLaCAHWy/CbIgSC3Fel2OpKd7qPTuoff/QERZsIBCvRfUVwEO
         Ryi5nLUUQDncbMYps/Yaup+Gx3GMOkpwu2tJ8x6bdI0csGsQiJ8Wl3gqj031mlyWfiHD
         ZvQl9kWepMYRZW9E4T848Om4rml9f/zed+1oiMtpo43Kdn4f4DMHNKzf/5AZFi+XcVes
         PrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9eIn9xmZE3lDDxF5D7SNUmbx8I+eA8wKnaNy1sQ/lzw=;
        b=OIXwvU47hSGRQJidhUO6Rp0nSYcXjb9kQO0tpXujTvTnb2yccjq9xdH1t9qfpu6lbe
         GRx3YTqThOk6ud2yVxDFM9xuxe7K6tj/q5jTFVSlXX4toZPA9d1tYMi0TlOLVjNJ48Iz
         UuQ0UNeBSzXPdmNxAevYsAOsP1H4ts8JLo522l32pDCmuEJXm71rShyUuBKbzIyjhFyb
         vudx+B5ZgYrQ94oefCKsPC4G1doq+X2qLa8POZODiPW0HacmwS24ukioKWHE0uWMiPG7
         rHjYGwbSIDDCuoeLmDcUUj6/bYST7iGpSahOHQkGa0UrYRX0cI4dKWkHN6JiSrVfxMIz
         c3ig==
X-Gm-Message-State: AOAM533NYJxQtSqqDhxLkFg0Pe/ni4WsD6hTUXdLBBib+aze0AVRRudb
        Lt+ytky0laEg7uGqbIet4g0YMvXmHMDhhb4w
X-Google-Smtp-Source: ABdhPJzQrf6w26UPOoT1HFywMYAXwxcOdbv56BRWEou16crQY/Tq/dqYrZi2jZ1rvCZNniB8vY9VTQ==
X-Received: by 2002:a92:cb0f:: with SMTP id s15mr10077698ilo.59.1630165431122;
        Sat, 28 Aug 2021 08:43:51 -0700 (PDT)
Received: from [10.10.10.198] (047-035-132-030.res.spectrum.com. [47.35.132.30])
        by smtp.googlemail.com with ESMTPSA id m26sm5120282ioj.54.2021.08.28.08.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 08:43:50 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH v3] staging: greybus: Convert uart.c from
 IDR to XArray
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210816195000.736-1-fmdefrancesco@gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <dc2d0dda-0a04-8b45-d83e-f7c54baa357b@linaro.org>
Date:   Sat, 28 Aug 2021 10:43:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816195000.736-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 2:50 PM, Fabio M. De Francesco wrote:
> Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
> is more memory-efficient, parallelisable, and cache friendly. It takes
> advantage of RCU to perform lookups without locking. Furthermore, IDR is
> deprecated because XArray has a better (cleaner and more consistent) API.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

I have one more comment, below.  Generally, I don't think it is
important to make this change, but I think it's fine to switch
to the newer XArray interface.  The result is a little simpler.

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

I'm basically new to using the XArray interface, but I

don't think you really need the xa_lock()/xa_unlock()

calls here.  You are not relying on reference counting

to control when the allocated minor device numbers are

freed, so I'm pretty sure you can simply call xa_load()

to look up the gb_tty for the given minor device.



But please don't only take my word for it; investigate

it for yourself, and if needed ask others about it so

you're confident it's correct.  There is no harm in
taking the lock, but if it's not needed, it would be
nice to avoid it.

If you conclude the locks are necessary, just say so,
and explain why, and I'll probably just accept it.
Otherwise, please explain why you are sure they are
not needed when you send version 4.  Thank you.

					-Alex


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
> 

