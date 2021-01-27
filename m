Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759A230613B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhA0QrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231258AbhA0Qqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:46:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED81F60187;
        Wed, 27 Jan 2021 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611765965;
        bh=tQQ1aMFx+Z32YsIj9q7WBQHGMTx/Enh3DKZ90xb1QQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoNSHMDbU1bYSlMjVMjYCPjjNv7MFetOLU4OxDzbswODAMqfq2W6uwqbknRQuDp86
         mtOUsFJq0ldbfJxxoRI3AgzDNNcZ8Hi1p4HDJvyN3uZgteOOwnYmTDEvEAU77ZPa1N
         QhUNAhtgEesnZ+yGY5TkRPrMne4OdlRIwvowJnMiRdqb1ffqoy8oErgcOs509O58UB
         8g7wvSsAMegRm5xnksHuH4wRx7PhL4jYHs1t8w+GoxanFoIxBYk3C+KVy+pXiBZegb
         tv9N1LNEeW4xaDW03oHYZnWhldcwwGy4CiYjjsfMAedXn7Q4xQgJHqtL71ISqJnVqd
         mvbmm59FEZJFw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4nxQ-0002EP-5w; Wed, 27 Jan 2021 17:46:16 +0100
Date:   Wed, 27 Jan 2021 17:46:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/12] usb: misc: usbsevseg: update to use
 usb_control_msg_send()
Message-ID: <YBGY2HqALY81bzif@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126184030.915039-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126184030.915039-1-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:10:30AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, instances of usb_control_msg() have been replaced with
> usb_control_msg_send() appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/usbsevseg.c | 60 ++++++++++--------------------------
>  1 file changed, 17 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/usb/misc/usbsevseg.c b/drivers/usb/misc/usbsevseg.c
 
> @@ -99,15 +94,10 @@ static void update_display_mode(struct usb_sevsegdev *mydev)
>  	if(mydev->shadow_power != 1)
>  		return;
>  
> -	rc = usb_control_msg(mydev->udev,
> -			usb_sndctrlpipe(mydev->udev, 0),
> -			0x12,
> -			0x48,
> -			(82 * 0x100) + 10, /* (set mode) */
> -			(mydev->mode_msb * 0x100) + mydev->mode_lsb,
> -			NULL,
> -			0,
> -			2000);
> +	rc = usb_control_msg_send(mydev->udev, 0, 0x12, 0x48,
> +				  (82 * 0x100) + 10, /* (set mode) */
> +				  (mydev->mode_msb * 0x100) + mydev->mode_lsb,
> +				  NULL, 0, 2000, GFP_KERNEL);
>  
>  	if (rc < 0)
>  		dev_dbg(&mydev->udev->dev, "mode retval = %d\n", rc);

This function is called from resume() and reset_resume() where GFP_NOIO
should be used (and is used for update_display_visual()) so I think you
need to add a GFP flag argument here too.

Looks good otherwise.

Johan
