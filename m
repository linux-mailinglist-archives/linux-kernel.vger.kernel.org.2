Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE953EDBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhHPQ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhHPQ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:56:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E26C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:55:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b10so24487697eju.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mLAtBuoUt/F9+qFKLYVo0SQofIRNeiR4JVsFSFSXPrY=;
        b=SyYDp2BFIGtjZz+SYCNRmIEKiNevpnuGibsUep/e+IZActHRG4+1dUSkT9fp0+X2Lh
         V1SKbNtXlYSfRkCT102L/ZmfgGdqtHx+w4oyovrmgYAEFOrAjDd2LiV+6wrV6BzzcvCL
         gj04ciMfrx1WnS4a+D6lck4ahVxffH0vWSgY41YdTBwIftIlA3LXFV2H6338vemH/dxG
         UZ+CeiIRZ820UUXr5NLCtkNrdysg5kKyfFCJE9S0BmKzVLn2x0C9ltAUc56sc9fjyQQ7
         DmONcY5/FEuaslx7EvYChE/YoLDK3h6+aFKCmvubqkEke783bRIYokwA6OseVPAgqfDy
         Foew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mLAtBuoUt/F9+qFKLYVo0SQofIRNeiR4JVsFSFSXPrY=;
        b=bsKInAsa6nFNah7RrVx8SEG0Y8/5pMF78ei9T51Hryo4J7Czicg4L3PATZQPvvz3nY
         EdtPTh11tiUws2xrnfuuIpjd/nOmdQydItg/0MpL3mGMEmV7D0jueK2ftzYKmo2F/4/V
         Mphn8DrdYeITx5kAR76CXiVJrK6nwSn/UtKFamVcA3VikkZ2AAWctwmJ7dayI4AwUB7K
         ONxgVbYzKrWtl5Sc9VGebbuKhn8qu3tQu6gt0lCSDDc2zCTtGCEF0U8Ek/P/XEFLmPof
         9uXMKk50Q/k+ugq8pZKfMCIUnP0CTJ89cVIldByVoet8fI98rp6DCLZQKSmlV0OJ8Vtp
         XrIw==
X-Gm-Message-State: AOAM530GxOhHprKySEqKtoQ7HMpT3GE/xOB3fi8unOZUK9q6/Kt6AQGi
        Yd51zISp2OBKcGcLHeNcnlA=
X-Google-Smtp-Source: ABdhPJyjq4fnITCXcJFto7pTY8fSSfek4A22zpkgepLhgCi5YKbQGPyO+JIUq0dVXCx2GWiemwHwXw==
X-Received: by 2002:a17:906:4943:: with SMTP id f3mr17041125ejt.102.1629132931951;
        Mon, 16 Aug 2021 09:55:31 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id n16sm5157455edv.73.2021.08.16.09.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 09:55:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] staging: greybus: Convert uart.c from IDR to XArray
Date:   Mon, 16 Aug 2021 18:55:29 +0200
Message-ID: <16972786.W5nbKQDRf9@localhost.localdomain>
In-Reply-To: <5541b638-db1e-26f2-2682-81f35504c9a3@ieee.org>
References: <20210814181130.21383-1-fmdefrancesco@gmail.com> <5541b638-db1e-26f2-2682-81f35504c9a3@ieee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Monday, August 16, 2021 4:46:08 PM CEST Alex Elder wrote:
> On 8/14/21 1:11 PM, Fabio M. De Francesco wrote:
> > Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
> > is more memory-efficient, parallelisable, and cache friendly. It takes
> > advantage of RCU to perform lookups without locking. Furthermore, IDR is
> > deprecated because XArray has a better (cleaner and more consistent) API.
> 
> I haven't verified the use of the new API (yet) but I have a few
> comments on your patch, below.
> 
> 					-Alex
> 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> I'm not sure I'm right about this...  But the actual change you're
> making has nothing to do with what the Intel test robot reported.
> I personally find the "Reported-by" here a little misleading, but
> maybe the "Link" line that gets added will provide explanation.
> Anyway, unless someone else contradicts/corrects me, I'd rather
> not have the "Reported-by" here (despite wanting to provide much
> credit to <lkp@intel.com>...).

I'm going to remove that tag and send a v3. I too had doubts about using it in 
this case and I was about to omit it (please consider I have just a few months 
of experience with kernel hacking and, as far as I can remember, I haven't had 
more than one other occasion to deal with the kernel test robot). 

Now I think I understand when I should use the Reported-by tag and I'll use it 
accordingly to what you and the others explained in this thread.
 
> > ---
> > 
> > v1->v2:
> >          Fixed an issue found by the kernel test robot. It was due to
> >          passing to xa_*lock() the same old mutex that IDR used with
> >          the previous version of the code.
> >   
> >   drivers/staging/greybus/uart.c | 29 ++++++++++++++---------------
> >   1 file changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/
uart.c
> > index 73f01ed1e5b7..5bf993e40f84 100644
> > --- a/drivers/staging/greybus/uart.c
> > +++ b/drivers/staging/greybus/uart.c
> > @@ -22,7 +22,7 @@
> > 
> >   #include <linux/serial.h>
> >   #include <linux/tty_driver.h>
> >   #include <linux/tty_flip.h>
> > 
> > -#include <linux/idr.h>
> > +#include <linux/xarray.h>
> > 
> >   #include <linux/fs.h>
> >   #include <linux/kdev_t.h>
> >   #include <linux/kfifo.h>
> > 
> > @@ -33,6 +33,7 @@
> > 
> >   #include "gbphy.h"
> >   
> >   #define GB_NUM_MINORS	16	/* 16 is more than enough */
> > 
> > +#define GB_RANGE_MINORS		XA_LIMIT(0, GB_NUM_MINORS)
> > 
> >   #define GB_NAME		"ttyGB"
> 
> Please align the right-hand side of all three definitions here.

Yes, sure.

> 
> >   #define GB_UART_WRITE_FIFO_SIZE		PAGE_SIZE
> > 
> > @@ -67,8 +68,7 @@ struct gb_tty {
> > 
> >   };
> >   
> >   static struct tty_driver *gb_tty_driver;
> > 
> > -static DEFINE_IDR(tty_minors);
> > -static DEFINE_MUTEX(table_lock);
> > +static DEFINE_XARRAY(tty_minors);
> > 
> >   static int gb_uart_receive_data_handler(struct gb_operation *op)
> >   {
> > 
> > @@ -77,6 +77,7 @@ static int gb_uart_receive_data_handler(struct 
gb_operation *op)
> > 
> >   	struct tty_port *port = &gb_tty->port;
> >   	struct gb_message *request = op->request;
> >   	struct gb_uart_recv_data_request *receive_data;
> > 
> > +
> 
> Please do not add a blank line amid the local variable
> definitions.

I didn't notice that addition (it was not intentional). I'll delete 
the line in v3.

> I'm not sure it checks for this, but you should run
> your patch through "checkpatch.pl" before you send
> it.  E.g.:
>      ./scripts/checkpatch.pl idr_to_xarray.patch

I've configured an automatic run of checkpatch.pl a long time ago. It runs 
(automatically) every time I save a "git commit -s -v". Unfortunately, 
sometimes happens that I'm distracted by something else and I don't see its 
output (at least I don't read it in its entirety). My fault, obviously. I'll 
be more focused on what I'm doing when I'm working on the next patches.

> The error reported in the build of your first version
> of this patch makes me think you might not have test-
> built the code.  I don't know if that's the case, but
> (at least) building the code is expected before you
> submit a patch for review.

As said above, I have little experience. So, believe me, I don't minimally 
trust my own code and I wouldn't dare to submit patches without building with 
"make C=2 -j8 drivers/staging/greybus/ W=1".

I'm not entirely sure of what happened, because I ran make at least a couple 
of times, maybe more. I suppose it has to do with some greybus related options 
in .config that only this evening I noticed I had to enable. When today I ran 
"make menuconfig" I saw that a couple of them were not set but I can't 
remember which.

Now that they are set, GCC fails with the v1 of my patch (downloaded and 
installed on a new test branch based on Greg's staging-testing). Yesterday it 
didn't fail. 

> >   	u16 recv_data_size;
> >   	int count;
> >   	unsigned long tty_flags = TTY_NORMAL;
> > 
> > @@ -341,8 +342,8 @@ static struct gb_tty *get_gb_by_minor(unsigned int 
minor)
> > 
> >   {
> >   
> >   	struct gb_tty *gb_tty;
> > 
> > -	mutex_lock(&table_lock);
> > -	gb_tty = idr_find(&tty_minors, minor);
> > +	xa_lock(&tty_minors);
> > +	gb_tty = xa_load(&tty_minors, minor);
> > 
> >   	if (gb_tty) {
> >   	
> >   		mutex_lock(&gb_tty->mutex);
> >   		if (gb_tty->disconnected) {
> > 
> > @@ -353,19 +354,19 @@ static struct gb_tty *get_gb_by_minor(unsigned int 
minor)
> > 
> >   			mutex_unlock(&gb_tty->mutex);
> >   		
> >   		}
> >   	
> >   	}
> > 
> > -	mutex_unlock(&table_lock);
> > +	xa_unlock(&tty_minors);
> > 
> >   	return gb_tty;
> >   
> >   }
> >   
> >   static int alloc_minor(struct gb_tty *gb_tty)
> >   {
> >   
> >   	int minor;
> > 
> > +	int ret;
> > 
> > -	mutex_lock(&table_lock);
> > -	minor = idr_alloc(&tty_minors, gb_tty, 0, GB_NUM_MINORS, 
GFP_KERNEL);
> > -	mutex_unlock(&table_lock);
> > -	if (minor >= 0)
> > -		gb_tty->minor = minor;
> > +	ret = xa_alloc(&tty_minors, &minor, gb_tty, GB_RANGE_MINORS, 
GFP_KERNEL);
> > +	if (ret)
> > +		return ret;
> 
> The caller of alloc_minor() (gb_uart_probe()) checks the return
> value, and if it's -ENOSPC it logs a device error indicating
> there are no remaining free device minor numbers.  For xa_alloc()
> this is indicated by returning -EBUSY.  Please update the caller
> to print the error message based on the updated error code.

Correct, I should have made it since v1. This will also go in v3.

> > +	gb_tty->minor = minor;
> > 
> >   	return minor;
> >   
> >   }
> > 
> > @@ -374,9 +375,7 @@ static void release_minor(struct gb_tty *gb_tty)
> > 
> >   	int minor = gb_tty->minor;
> >   	
> >   	gb_tty->minor = 0;	/* Maybe should use an invalid value 
instead */
> > 
> > -	mutex_lock(&table_lock);
> > -	idr_remove(&tty_minors, minor);
> > -	mutex_unlock(&table_lock);
> > +	xa_erase(&tty_minors, minor);
> > 
> >   }
> >   
> >   static int gb_tty_install(struct tty_driver *driver, struct tty_struct 
*tty)
> > 
> > @@ -982,7 +981,7 @@ static void gb_tty_exit(void)
> > 
> >   {
> >   
> >   	tty_unregister_driver(gb_tty_driver);
> >   	put_tty_driver(gb_tty_driver);
> > 
> > -	idr_destroy(&tty_minors);
> > +	xa_destroy(&tty_minors);
> > 
> >   }
> >   
> >   static const struct gbphy_device_id gb_uart_id_table[] = {

Thanks for your kind review and the time you spent on it.

Regards,

Fabio
 


