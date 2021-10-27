Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9157443CA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242092AbhJ0NUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242074AbhJ0NUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:20:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0450A60F90;
        Wed, 27 Oct 2021 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635340686;
        bh=gYKkav877VAg4ZzNKbkrv8KDnbZA1+6U9iXG52v/XDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IncU+GrwvZHjSItIr1ur5CtmqCwYbIyoLLyeeRu/gFR0krBk+3tFxBc0Y5/smuCBX
         Trc0/c1Jf1CBLWmTiC/6V4806VFPhguq8vOJ7ORgH7N6kx0DKGx1HBZ8Y0tsZe4ODe
         mC3HYTau2KPsDZZldOJH4skg2/cS767cKXOu7pvgSYfbNIoUfSh0R0QLNqilMB6IQb
         sLBKPyrm805GFWNH0mDciYa2cDyLJ2xxfmWWEubj2m84cnf9+Kwjib/3FTsidxtEbB
         qR07+bCEDXuYoDBzD1bfENyYTBYdjJlPkTfzou77Q+uQbcQ+/B6tQaPTeU/MLMs0kf
         1McAupDhd/Q2Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mfioQ-0004gB-IB; Wed, 27 Oct 2021 15:17:50 +0200
Date:   Wed, 27 Oct 2021 15:17:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] USB: serial: cp210x: use usb_control_msg_recv()
 and usb_control_msg_send()
Message-ID: <YXlRfsv6L53ZaaA7@hovoldconsulting.com>
References: <20211001065720.21330-1-himadrispandya@gmail.com>
 <20211001065720.21330-3-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001065720.21330-3-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 08:57:20AM +0200, Himadri Pandya wrote:
> The new wrapper functions for usb_control_msg() can accept data from
> stack and treat short reads as error. Hence use the wrappers functions.
> Please note that because of this change, cp210x_read_reg_block() will no
> longer log the length of short reads.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
> Changes in v3:
>  - Rephrase the commit message
>  - Explicitly mention that short reads don't log length now
> 
> Changes in v2:
>  - Drop unrelated style fixes

This looks good now, but I did do some minor style changes described
below.

> ---
>  drivers/usb/serial/cp210x.c | 106 ++++++++++--------------------------
>  1 file changed, 30 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index 189279869a8b..3c3ca46b0b82 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -631,29 +631,19 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
>  {
>  	struct usb_serial *serial = port->serial;
>  	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> -	void *dmabuf;
>  	int result;
>  
> -	dmabuf = kmalloc(bufsize, GFP_KERNEL);
> -	if (!dmabuf)
> -		return -ENOMEM;
>  
> -	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
> -			req, REQTYPE_INTERFACE_TO_HOST, 0,
> -			port_priv->bInterfaceNumber, dmabuf, bufsize,
> -			USB_CTRL_GET_TIMEOUT);
> -	if (result == bufsize) {
> -		memcpy(buf, dmabuf, bufsize);
> -		result = 0;
> -	} else {
> +	result = usb_control_msg_recv(serial->dev, 0, req,
> +				      REQTYPE_INTERFACE_TO_HOST, 0,
> +				      port_priv->bInterfaceNumber, buf,
> +				      bufsize, USB_CTRL_SET_TIMEOUT,
> +				      GFP_KERNEL);

The indentation style of this driver is a bit inconsistent but there's
no need to change to the open-parenthesis alignment style when you can
avoid it (it's mostly just "checkpacth.pl --subjective" that insists on
it).

Indenting continuation lines two tabs is just fine and avoids excessive
indentation and having to realign arguments when symbol names change.

> +	if (result) {
>  		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
>  				req, bufsize, result);
> -		if (result >= 0)
> -			result = -EIO;
>  	}
>  
> -	kfree(dmabuf);
> -
>  	return result;

I changed this to explicit zero and return an error above instead.

> @@ -952,27 +915,18 @@ static int cp210x_get_tx_queue_byte_count(struct usb_serial_port *port,
>  {
>  	struct usb_serial *serial = port->serial;
>  	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> -	struct cp210x_comm_status *sts;
> +	struct cp210x_comm_status sts;
>  	int result;
>  
> -	sts = kmalloc(sizeof(*sts), GFP_KERNEL);
> -	if (!sts)
> -		return -ENOMEM;
> -
> -	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
> -			CP210X_GET_COMM_STATUS, REQTYPE_INTERFACE_TO_HOST,
> -			0, port_priv->bInterfaceNumber, sts, sizeof(*sts),
> -			USB_CTRL_GET_TIMEOUT);
> -	if (result == sizeof(*sts)) {
> -		*count = le32_to_cpu(sts->ulAmountInOutQueue);
> -		result = 0;
> -	} else {
> +	result = usb_control_msg_recv(serial->dev, 0, CP210X_GET_COMM_STATUS,
> +				      REQTYPE_INTERFACE_TO_HOST, 0,
> +				      port_priv->bInterfaceNumber, &sts,
> +				      sizeof(sts), USB_CTRL_GET_TIMEOUT,
> +				      GFP_KERNEL);
> +	if (result == 0)
> +		*count = le32_to_cpu(sts.ulAmountInOutQueue);
> +	else
>  		dev_err(&port->dev, "failed to get comm status: %d\n", result);
> -		if (result >= 0)
> -			result = -EIO;
> -	}
> -
> -	kfree(sts);

The above is now also better handled with an explicit error check and
early return and the doing the *count assignment in the success path.

>  
>  	return result;
>  }

Now applied with the above changes. The result is here:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next&id=f5cfbecb0a162319464c9408420282d22ed69721

Johan
