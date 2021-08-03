Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD33DE3B0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 02:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhHCA4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 20:56:43 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44559 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232798AbhHCA4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 20:56:39 -0400
Received: (qmail 350279 invoked by uid 1000); 2 Aug 2021 20:56:28 -0400
Date:   Mon, 2 Aug 2021 20:56:28 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: realtek_cr: get lock before calling
 usb_enable_autosuspend()
Message-ID: <20210803005628.GA349864@rowland.harvard.edu>
References: <20210802230313.GA1480457@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802230313.GA1480457@pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 12:03:13AM +0100, Salah Triki wrote:
> Based on the documentation of usb_enable_autosuspend(), the
> caller must hold udev's device lock.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/usb/storage/realtek_cr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index 3789698d9d3c..6948d6fdad39 100644
> --- a/drivers/usb/storage/realtek_cr.c
> +++ b/drivers/usb/storage/realtek_cr.c
> @@ -918,9 +918,13 @@ static int realtek_cr_autosuspend_setup(struct us_data *us)
>  	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
>  	fw5895_init(us);
>  
> +	usb_lock_device(us->pusb_dev);
> +
>  	/* enable autosuspend function of the usb device */
>  	usb_enable_autosuspend(us->pusb_dev);
>  
> +	usb_unlock_device(us->pusb_dev);
> +
>  	return 0;
>  }
>  #endif

I assume you didn't test this patch, because RTS51xx card readers aren't 
very common.  If you had tested it, you would have found that it causes 
the system to hang.

This is because when realtek_cr_autosuspend_setup runs, the driver 
already holds the device lock.  The route is a little circuitous:

	realtek_cr_probe is called with the lock held, like all
	probe routines.

	It calls usb_store_probe2, which calls 
	usb_stor_acquire_resources.  That routine calls 
	us->unusual_dev->initFunction.  For the realtek_cr driver, the 
	initFunction is set to init_realtek_cr (see unusual_realtek.h).

	init_realtek_cr calls realtek_cr_autosuspend_setup.

There is no other pathway to the usb_enable_autosuspend call.  So your 
patch is not needed.

Alan Stern
