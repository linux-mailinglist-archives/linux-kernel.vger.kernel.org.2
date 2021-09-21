Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD68413278
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhIUL21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhIUL2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:28:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2079560F9D;
        Tue, 21 Sep 2021 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632223617;
        bh=thTsSyjy0WHn4NbXtqXy6nh03zyFo2cWhYxlI9OW1Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fOtq3hkgP3b8AGRo4t4evjqkQhJFrUHnsr2bu+euVmaYneBbAJh26KXFIgN7NyNUk
         mE92Ww2BEICSpxQ+Gyq548DHeEk76spLvCzOxkuLW9CKPjobL/NyDjEXfN8k+1Fdpn
         jRfyvUncOT66SPB/K4USxXuLbGVj7VKx8Bug5FsiAlrf+ez2cWB/KNOVLMhRZHjBSR
         z2KgYF3jBuROPH0GQqexjewca4HxDCmemGbQXU+PLrvwdWSyeiiW5O5bdPdkUcenlR
         xhWgUczaL9L5rPUnBaH2cvwXlIEQnAsrt9LTLRMLT5zhv4j2jCHGPH8bBOXVf9JvqY
         QuVKH3Sx1965Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSdvL-0002R4-VV; Tue, 21 Sep 2021 13:26:56 +0200
Date:   Tue, 21 Sep 2021 13:26:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] USB: serial: ch314: use usb_control_msg_recv()
 and usb_control_msg_send()
Message-ID: <YUnBf3Z9WJaP/2fo@hovoldconsulting.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
 <20210801203122.3515-2-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801203122.3515-2-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:01:17AM +0530, Himadri Pandya wrote:
> usb_control_msg_send/recv are new wrapper functions for usb_control_msg()
> that have proper error checks for short read/writes.

There no need for any special handling of short writes. Testing against
against negative errno is all that's needed.

> These functions
> can also accept data buffer on stack. Hence use these functions to have
> more robust error checks, and to reduce kernel memory usage for usb
> messages.

I'd rephrase this along the lines of "to simplify error handling for
short reads".

Also, you're not reducing kernel memory usage, you're just moving the
allocation to be handled by the wrapper instead.

> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
> Changes in v2:
>  - Fix callers of ch341_control_out() and ch341_control_in()
>  - Remove label "out"
>  - Remove an unnecessary assignment statement
> ---
>  drivers/usb/serial/ch341.c | 97 ++++++++++++--------------------------
>  1 file changed, 29 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
> index 2db917eab799..c6f7ff9ca8ae 100644
> --- a/drivers/usb/serial/ch341.c
> +++ b/drivers/usb/serial/ch341.c
> @@ -113,10 +113,10 @@ static int ch341_control_out(struct usb_device *dev, u8 request,
>  	dev_dbg(&dev->dev, "%s - (%02x,%04x,%04x)\n", __func__,
>  		request, value, index);
>  
> -	r = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request,
> -			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
> -			    value, index, NULL, 0, DEFAULT_TIMEOUT);
> -	if (r < 0)
> +	r = usb_control_msg_send(dev, 0, request,
> +				 USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
> +				 value, index, NULL, 0, DEFAULT_TIMEOUT, GFP_KERNEL);
> +	if (r)
>  		dev_err(&dev->dev, "failed to send control message: %d\n", r);
>  
>  	return r;

Since ch341_control_out() does not take a data buffer argument, there's
no need to use the new helper which only adds an extra function call.

Note that this function already return 0 on success or a negative errno
on errors.

> @@ -131,23 +131,13 @@ static int ch341_control_in(struct usb_device *dev,
>  	dev_dbg(&dev->dev, "%s - (%02x,%04x,%04x,%u)\n", __func__,
>  		request, value, index, bufsize);
>  
> -	r = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), request,
> -			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> -			    value, index, buf, bufsize, DEFAULT_TIMEOUT);
> -	if (r < (int)bufsize) {
> -		if (r >= 0) {
> -			dev_err(&dev->dev,
> -				"short control message received (%d < %u)\n",
> -				r, bufsize);

You're also removing this error message. It should at least be
mentioned somewhere that short reads will now simply be reported as
-EREMOTEIO with no indication of how short the transfer was.

That's usually just fine, but I'm currently dealing with another driver
where a short read can be used to differentiate between device types as
an example.

> -			r = -EIO;
> -		}
> -
> -		dev_err(&dev->dev, "failed to receive control message: %d\n",
> -			r);
> -		return r;
> -	}
> +	r = usb_control_msg_recv(dev, 0, request,
> +				 USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> +				 value, index, buf, bufsize, DEFAULT_TIMEOUT, GFP_KERNEL);
> +	if (r)
> +		dev_err(&dev->dev, "failed to receive control message: %d\n", r);
>  
> -	return 0;
> +	return r;
>  }
>  
>  #define CH341_CLKRATE		48000000
> @@ -287,23 +277,19 @@ static int ch341_set_handshake(struct usb_device *dev, u8 control)
>  static int ch341_get_status(struct usb_device *dev, struct ch341_private *priv)
>  {
>  	const unsigned int size = 2;
> -	char *buffer;
> +	u8 buffer[2];
>  	int r;
>  	unsigned long flags;
>  
> -	buffer = kmalloc(size, GFP_KERNEL);
> -	if (!buffer)
> -		return -ENOMEM;
> -
>  	r = ch341_control_in(dev, CH341_REQ_READ_REG, 0x0706, 0, buffer, size);
> -	if (r < 0)
> +	if (r)
>  		goto out;
>  
>  	spin_lock_irqsave(&priv->lock, flags);
>  	priv->msr = (~(*buffer)) & CH341_BITS_MODEM_STAT;
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
> -out:	kfree(buffer);
> +out:
>  	return r;

Just return r in the error path above and drop the label.

>  }
>  
> @@ -312,21 +298,17 @@ out:	kfree(buffer);
>  static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
>  {
>  	const unsigned int size = 2;
> -	char *buffer;
> +	u8 buffer[2];
>  	int r;
>  
> -	buffer = kmalloc(size, GFP_KERNEL);
> -	if (!buffer)
> -		return -ENOMEM;
> -
>  	/* expect two bytes 0x27 0x00 */
>  	r = ch341_control_in(dev, CH341_REQ_READ_VERSION, 0, 0, buffer, size);
> -	if (r < 0)
> +	if (r)
>  		goto out;
>  	dev_dbg(&dev->dev, "Chip version: 0x%02x\n", buffer[0]);
>  
>  	r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT, 0, 0);
> -	if (r < 0)
> +	if (r)
>  		goto out;
>  
>  	r = ch341_set_baudrate_lcr(dev, priv, priv->baud_rate, priv->lcr);
> @@ -335,7 +317,7 @@ static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
>  
>  	r = ch341_set_handshake(dev, priv->mcr);
>  
> -out:	kfree(buffer);
> +out:
>  	return r;
>  }

Same here (even if you need to touch the other error paths).

> @@ -647,23 +613,19 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
>  	struct ch341_private *priv = usb_get_serial_port_data(port);
>  	int r;
>  	uint16_t reg_contents;
> -	uint8_t *break_reg;
> +	uint8_t break_reg[2];
>  
>  	if (priv->quirks & CH341_QUIRK_SIMULATE_BREAK) {
>  		ch341_simulate_break(tty, break_state);
>  		return;
>  	}
>  
> -	break_reg = kmalloc(2, GFP_KERNEL);
> -	if (!break_reg)
> -		return;
> -
> -	r = ch341_control_in(port->serial->dev, CH341_REQ_READ_REG,
> -			ch341_break_reg, 0, break_reg, 2);
> -	if (r < 0) {
> +	r = ch341_control_in(port->serial->dev, CH341_REQ_READ_REG, ch341_break_reg, 0,
> +			     break_reg, 2);

Drop this unrelated style change (which creates a line > 80 chars too).

> +	if (r) {
>  		dev_err(&port->dev, "%s - USB control read error (%d)\n",
>  				__func__, r);
> -		goto out;
> +		return;
>  	}
>  	dev_dbg(&port->dev, "%s - initial ch341 break register contents - reg1: %x, reg2: %x\n",
>  		__func__, break_reg[0], break_reg[1]);
> @@ -681,11 +643,10 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
>  	reg_contents = get_unaligned_le16(break_reg);
>  	r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
>  			ch341_break_reg, reg_contents);
> -	if (r < 0)
> +	if (r)
>  		dev_err(&port->dev, "%s - USB control write error (%d)\n",
>  				__func__, r);
> -out:
> -	kfree(break_reg);
> +	return;

No need for return at the end of a void function.

>  }
>  
>  static int ch341_tiocmset(struct tty_struct *tty,

Johan
