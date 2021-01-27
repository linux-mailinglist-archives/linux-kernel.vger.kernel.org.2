Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783FF305DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhA0OKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:10:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232573AbhA0OJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:09:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEDF3207BC;
        Wed, 27 Jan 2021 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611756540;
        bh=3ScpTD6tKv1mZ+fpsUgDvc8VLpCDZEGkSyxHTIRPj6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9rBnYODziWG/D75MO8s7eHAM/djcmsWQ3pIjliTUsxpGTkW8XRMkJ50LdEALzm2H
         xHjXY8UbuTuqfFm1LNNZXpchNpX3s6uhOFBDcgXmx1/QbDDCeZg+3oiVz/75bwhRWk
         g+/HpRD85vmmZMIBQy81MRrP5PUyyHxyV485OL+Bsgg8qAm/9yfYg8YPCzBaw55JST
         ZPFd0RI61n7UXSn2ncopbpGXmwg3fGoAv//tZC+5mr18KU9Br9wZIG+LnNrzOiY9Uc
         hUIv07BRG1pYtmDuA33mTzqAuauqbo72nclb94G82MpmIOu44Y56OvNxrZIIF4BPHN
         +A8kN50JKSgXw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4lVP-0001nZ-SL; Wed, 27 Jan 2021 15:09:11 +0100
Date:   Wed, 27 Jan 2021 15:09:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/12] usb: misc: cypress_cy7c63: update to use
 usb_control_msg_recv()
Message-ID: <YBF0B50Q9gi/Ezpz@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183403.911653-3-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126183403.911653-3-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:03:53AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated

Short write has always been an error (I won't repeat for the remaining
patches).

> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, the instance of usb_control_msg() has been replaced with
> usb_control_msg_recv().
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/cypress_cy7c63.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/misc/cypress_cy7c63.c b/drivers/usb/misc/cypress_cy7c63.c
> index 14faec51d7a5..76a320ef17a7 100644
> --- a/drivers/usb/misc/cypress_cy7c63.c
> +++ b/drivers/usb/misc/cypress_cy7c63.c
> @@ -70,24 +70,15 @@ static int vendor_command(struct cypress *dev, unsigned char request,
>  			  unsigned char address, unsigned char data)
>  {
>  	int retval = 0;
> -	unsigned int pipe;
> -	unsigned char *iobuf;
> -
> -	/* allocate some memory for the i/o buffer*/
> -	iobuf = kzalloc(CYPRESS_MAX_REQSIZE, GFP_KERNEL);
> -	if (!iobuf) {
> -		retval = -ENOMEM;
> -		goto error;
> -	}
> +	u8 iobuf[CYPRESS_MAX_REQSIZE] = {0};
>  
>  	dev_dbg(&dev->udev->dev, "Sending usb_control_msg (data: %d)\n", data);
>  
>  	/* prepare usb control message and send it upstream */
> -	pipe = usb_rcvctrlpipe(dev->udev, 0);
> -	retval = usb_control_msg(dev->udev, pipe, request,
> -				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
> -				 address, data, iobuf, CYPRESS_MAX_REQSIZE,
> -				 USB_CTRL_GET_TIMEOUT);
> +	retval = usb_control_msg_recv(dev->udev, 0, request,
> +				      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
> +				      address, data, &iobuf, CYPRESS_MAX_REQSIZE,
> +				      USB_CTRL_GET_TIMEOUT, GFP_KERNEL);

Are you sure that the device always returns CYPRESS_MAX_REQSIZE here?
Otherwise, this change may break the driver as it currently only uses
the first two bytes of the received message, and only for some requests.

Note that the driver appears uses the same helper function for
CYPRESS_WRITE_PORT commands, which probably doesn't return 8 bytes in a
reply.

You could possibly add the missing short read check for the
CYPRESS_READ_PORT case, but I'm afraid that the new helper are not a
good fit here either.

>  	/* store returned data (more READs to be added) */
>  	switch (request) {
> @@ -107,8 +98,6 @@ static int vendor_command(struct cypress *dev, unsigned char request,
>  			break;
>  	}
>  
> -	kfree(iobuf);
> -error:
>  	return retval;
>  }

Johan
