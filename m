Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECAA3ED91E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhHPOqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhHPOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:46:42 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1FC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:46:10 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a13so23181990iol.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=quV1XrmV9zPiXd7zZTAaUb0pBNxhnja3alO533JQRy0=;
        b=Iui0sehgKwy98k7iNsk+Qd6b4jCLOtI/+0FHbrcFH2pi+W2//4zmprbsnaCdLVnx+B
         bJ5IySkF69DTIQhUCgCI+13xJ/cfip6daFgJ247DKUE8PjfevXUxjs9n7wHuGF2F3my6
         ZvqjP6X//cGUlHhtwYDYpp2wgYlyg3jeRNGgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=quV1XrmV9zPiXd7zZTAaUb0pBNxhnja3alO533JQRy0=;
        b=PTC1rEoz5+lGwW3efXaBQ5PCgzeUWm9MlFLqyaIt8XjTB8AQSEdLzgMXsWRSgz6vM5
         jcVBlP0FC2za08CgugWC9vzwTRJFyNt7JqgfjX6jpEcQkpRbDMB3v/pcKmxWCOC8Goxf
         JzjIB1zCR5YPOqy8RpJhphlv2dUnBXS56gG5a9/EVAbWROMKPRUR/kOx99iru3gSVZ2V
         BhLeKJKYUMRxPJsCnD5kdKcF2CEP+gHkyxx3wKIlybS09JTSFlOc5zvD7y4zS6847pMm
         C5Tg3dZbyMusXh8c1yg9A8J31Gt+1UQxSGol8M5M/i1T5opEIMgvz0+jveD/8D5axyO0
         piTg==
X-Gm-Message-State: AOAM533r95HmSumoLBFd47+d/DHTQXhJWAqg7aUF4gOjvbr+N9lo78g3
        heAsUZKqudfD91ltDX0dK/WENg==
X-Google-Smtp-Source: ABdhPJw+bRZEpoiv2fnhdu/CRQbEOhznxaa6CuMX94A21PAjBHsJik8o1CeMW2ZWV4a9uXIbPAA05A==
X-Received: by 2002:a5d:9707:: with SMTP id h7mr13713769iol.28.1629125170181;
        Mon, 16 Aug 2021 07:46:10 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id z15sm2276991ioh.28.2021.08.16.07.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 07:46:09 -0700 (PDT)
Subject: Re: [PATCH v2] staging: greybus: Convert uart.c from IDR to XArray
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20210814181130.21383-1-fmdefrancesco@gmail.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <5541b638-db1e-26f2-2682-81f35504c9a3@ieee.org>
Date:   Mon, 16 Aug 2021 09:46:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210814181130.21383-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/21 1:11 PM, Fabio M. De Francesco wrote:
> Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
> is more memory-efficient, parallelisable, and cache friendly. It takes
> advantage of RCU to perform lookups without locking. Furthermore, IDR is
> deprecated because XArray has a better (cleaner and more consistent) API.

I haven't verified the use of the new API (yet) but I have a few
comments on your patch, below.

					-Alex

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

I'm not sure I'm right about this...  But the actual change you're
making has nothing to do with what the Intel test robot reported.
I personally find the "Reported-by" here a little misleading, but
maybe the "Link" line that gets added will provide explanation.

Anyway, unless someone else contradicts/corrects me, I'd rather
not have the "Reported-by" here (despite wanting to provide much
credit to <lkp@intel.com>...).

> ---
> 
> v1->v2:
>          Fixed an issue found by the kernel test robot. It was due to
>          passing to xa_*lock() the same old mutex that IDR used with
>          the previous version of the code.
> 
>   drivers/staging/greybus/uart.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> index 73f01ed1e5b7..5bf993e40f84 100644
> --- a/drivers/staging/greybus/uart.c
> +++ b/drivers/staging/greybus/uart.c
> @@ -22,7 +22,7 @@
>   #include <linux/serial.h>
>   #include <linux/tty_driver.h>
>   #include <linux/tty_flip.h>
> -#include <linux/idr.h>
> +#include <linux/xarray.h>
>   #include <linux/fs.h>
>   #include <linux/kdev_t.h>
>   #include <linux/kfifo.h>
> @@ -33,6 +33,7 @@
>   #include "gbphy.h"
>   
>   #define GB_NUM_MINORS	16	/* 16 is more than enough */
> +#define GB_RANGE_MINORS		XA_LIMIT(0, GB_NUM_MINORS)
>   #define GB_NAME		"ttyGB"

Please align the right-hand side of all three definitions here.

>   #define GB_UART_WRITE_FIFO_SIZE		PAGE_SIZE
> @@ -67,8 +68,7 @@ struct gb_tty {
>   };
>   
>   static struct tty_driver *gb_tty_driver;
> -static DEFINE_IDR(tty_minors);
> -static DEFINE_MUTEX(table_lock);
> +static DEFINE_XARRAY(tty_minors);
>   
>   static int gb_uart_receive_data_handler(struct gb_operation *op)
>   {
> @@ -77,6 +77,7 @@ static int gb_uart_receive_data_handler(struct gb_operation *op)
>   	struct tty_port *port = &gb_tty->port;
>   	struct gb_message *request = op->request;
>   	struct gb_uart_recv_data_request *receive_data;
> +

Please do not add a blank line amid the local variable
definitions.

I'm not sure it checks for this, but you should run
your patch through "checkpatch.pl" before you send
it.  E.g.:
     ./scripts/checkpatch.pl idr_to_xarray.patch

The error reported in the build of your first version
of this patch makes me think you might not have test-
built the code.  I don't know if that's the case, but
(at least) building the code is expected before you
submit a patch for review.

>   	u16 recv_data_size;
>   	int count;
>   	unsigned long tty_flags = TTY_NORMAL;
> @@ -341,8 +342,8 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
>   {
>   	struct gb_tty *gb_tty;
>   
> -	mutex_lock(&table_lock);
> -	gb_tty = idr_find(&tty_minors, minor);
> +	xa_lock(&tty_minors);
> +	gb_tty = xa_load(&tty_minors, minor);
>   	if (gb_tty) {
>   		mutex_lock(&gb_tty->mutex);
>   		if (gb_tty->disconnected) {
> @@ -353,19 +354,19 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
>   			mutex_unlock(&gb_tty->mutex);
>   		}
>   	}
> -	mutex_unlock(&table_lock);
> +	xa_unlock(&tty_minors);
>   	return gb_tty;
>   }
>   
>   static int alloc_minor(struct gb_tty *gb_tty)
>   {
>   	int minor;
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

The caller of alloc_minor() (gb_uart_probe()) checks the return
value, and if it's -ENOSPC it logs a device error indicating
there are no remaining free device minor numbers.  For xa_alloc()
this is indicated by returning -EBUSY.  Please update the caller
to print the error message based on the updated error code.

> +	gb_tty->minor = minor;
>   	return minor;
>   }
>   
> @@ -374,9 +375,7 @@ static void release_minor(struct gb_tty *gb_tty)
>   	int minor = gb_tty->minor;
>   
>   	gb_tty->minor = 0;	/* Maybe should use an invalid value instead */
> -	mutex_lock(&table_lock);
> -	idr_remove(&tty_minors, minor);
> -	mutex_unlock(&table_lock);
> +	xa_erase(&tty_minors, minor);
>   }
>   
>   static int gb_tty_install(struct tty_driver *driver, struct tty_struct *tty)
> @@ -982,7 +981,7 @@ static void gb_tty_exit(void)
>   {
>   	tty_unregister_driver(gb_tty_driver);
>   	put_tty_driver(gb_tty_driver);
> -	idr_destroy(&tty_minors);
> +	xa_destroy(&tty_minors);
>   }
>   
>   static const struct gbphy_device_id gb_uart_id_table[] = {
> 

