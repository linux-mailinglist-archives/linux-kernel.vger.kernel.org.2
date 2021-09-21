Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3904132A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhIULgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232428AbhIULg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEC37611BD;
        Tue, 21 Sep 2021 11:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632224098;
        bh=sehRHxD9BDUzvJQZIvimsT0DW3NtntLvpVz/b1t5Rx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBnkq1UHynKf3iAJ4s6MrTsipEQb2lb0Q9ruHLh8F+a9/gGZluY/NROkFuuNSklPD
         IrjtoBLWArqd7tTQYPUGOyWGHF1mEnew5xd/AK/vbzLDYb5DYqPgDg4ZNz1BrkzG/O
         RGDKi7cXGbHSXxw4I59n89DHGtLfIF5o+aQbcYn1wWMRleWIK+i/BXcKat9MUBy9fx
         7XKbOiRkm0GXME3AqukKed3REJq3limSrb89mfpLzSiMqWda3Rovtf87j6j8A+MfC+
         PdSjjZCigVKG+DDluo3tPoI1igaZG2sh4y4D+LYf/OLBkRYFl02n/N/fav7A+Op0Nl
         Sm6kv+e1Mcqzg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSe37-0002Tm-AN; Tue, 21 Sep 2021 13:34:58 +0200
Date:   Tue, 21 Sep 2021 13:34:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] USB: serial: cp210x: use usb_control_msg_recv()
 and usb_control_msg_send()
Message-ID: <YUnDYWWhEUpnMq7R@hovoldconsulting.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
 <20210801203122.3515-3-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801203122.3515-3-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:01:18AM +0530, Himadri Pandya wrote:
> The new wrapper functions for usb_control_msg() can accept data from
> stack with robust error checks.

Please rephrase the "robust error checks" along the lines of "treats
short reads as an error".

> Hence use the wrappers with stack
> variables for usb transfer buffers to save kernel memory.

Again, you're not saving memory here, just moving the allocation.

> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
> Changes in v2:
>  - Drop unrelated style fixes
> ---
>  drivers/usb/serial/cp210x.c | 107 ++++++++++--------------------------
>  1 file changed, 30 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index 3c80bfbf3bec..b73581fc1768 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -628,29 +628,18 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
>  {
>  	struct usb_serial *serial = port->serial;
>  	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> -	void *dmabuf;
>  	int result;
>  
> -	dmabuf = kmalloc(bufsize, GFP_KERNEL);
> -	if (!dmabuf)
> -		return -ENOMEM;
> -
> -	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
> -			req, REQTYPE_INTERFACE_TO_HOST, 0,
> -			port_priv->bInterfaceNumber, dmabuf, bufsize,
> -			USB_CTRL_SET_TIMEOUT);
> -	if (result == bufsize) {
> -		memcpy(buf, dmabuf, bufsize);
> -		result = 0;
> -	} else {
> +	result = usb_control_msg_recv(serial->dev, 0, req,
> +				      REQTYPE_INTERFACE_TO_HOST, 0,
> +				      port_priv->bInterfaceNumber, buf,
> +				      bufsize, USB_CTRL_SET_TIMEOUT,
> +				      GFP_KERNEL);
> +	if (result) {
>  		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
>  				req, bufsize, result);

This will also no longer log the length of short reads. Please at least
mention it in the commit message.

> -		if (result >= 0)
> -			result = -EIO;
>  	}
>  
> -	kfree(dmabuf);
> -
>  	return result;
>  }

Johan
