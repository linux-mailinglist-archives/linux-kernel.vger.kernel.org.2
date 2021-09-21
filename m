Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A299413354
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhIUM2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232656AbhIUM2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:28:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56F3661168;
        Tue, 21 Sep 2021 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632227225;
        bh=eaTif5s6bxhSJHAd9R9W5noZyQpp5SoLOYriCI608QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVf+w0D+u5EvcFf2ADHgfYHOlZ+nhQgUHMm2/C8VTP1SUGW1Mq8APWuZ5fUetCwFq
         8npMoX0/JfmnUVTJ4I2haOAApJfRdJ/pAZUVS81cxqmBI1JTSBG86BVKGrD2FG8r7e
         2xLhdv0g5DcxMB0RtSdAViLf26E4FzqYEd8EAX6iNZyIewFw6q3CSEcmEwVxb7NCOQ
         hXABqWiVAGMrtT8XbiOgvVkqWEBJiERBBDOQy2WWOuKsI9+hcL1LBWNrAC/T3aMILC
         xJ7N3QtxilzVULoXnJXYAIFNJS8zcnG1fti0z5KG+5RgjCm0/rRu15mpWJE5yqaKhO
         y0Z6VFk9DzymA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSerY-0004yx-2z; Tue, 21 Sep 2021 14:27:04 +0200
Date:   Tue, 21 Sep 2021 14:27:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] USB: serial: keyspan_pda: use
 usb_control_msg_recv()
Message-ID: <YUnPmDMzRTNvptA0@hovoldconsulting.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
 <20210801203122.3515-6-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801203122.3515-6-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:01:21AM +0530, Himadri Pandya wrote:
> Use the wrapper function usb_control_msg_recv() that accepts stack
> variables and remove dma buffers from callers of usb_control_msg().
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
> Changes in v2:
>  - Rebase the patch on top of recent changes
>  - Drop unrelated style changes
> ---
>  drivers/usb/serial/keyspan_pda.c | 70 ++++++++++++++------------------
>  1 file changed, 31 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
> index 39b0f5f344c2..831dc5f42dea 100644
> --- a/drivers/usb/serial/keyspan_pda.c
> +++ b/drivers/usb/serial/keyspan_pda.c
> @@ -77,35 +77,28 @@ static int keyspan_pda_get_write_room(struct keyspan_pda_private *priv)
>  {
>  	struct usb_serial_port *port = priv->port;
>  	struct usb_serial *serial = port->serial;
> -	u8 *room;
> +	u8 room;
>  	int rc;
>  
> -	room = kmalloc(1, GFP_KERNEL);
> -	if (!room)
> -		return -ENOMEM;
> -
> -	rc = usb_control_msg(serial->dev,
> -			     usb_rcvctrlpipe(serial->dev, 0),
> -			     6, /* write_room */
> -			     USB_TYPE_VENDOR | USB_RECIP_INTERFACE
> -			     | USB_DIR_IN,
> -			     0, /* value: 0 means "remaining room" */
> -			     0, /* index */
> -			     room,
> -			     1,
> -			     2000);
> -	if (rc != 1) {
> -		if (rc >= 0)
> -			rc = -EIO;
> +	rc = usb_control_msg_recv(serial->dev,
> +				  0,
> +				  6, /* write_room */
> +				  USB_TYPE_VENDOR | USB_RECIP_INTERFACE
> +				  | USB_DIR_IN,
> +				  0, /* value: 0 means "remaining room" */
> +				  0, /* index */
> +				  &room,
> +				  1,
> +				  2000,
> +				  GFP_KERNEL);
> +	if (rc) {
>  		dev_dbg(&port->dev, "roomquery failed: %d\n", rc);
> -		goto out_free;
> +		goto out;
>  	}
>  
> -	dev_dbg(&port->dev, "roomquery says %d\n", *room);
> -	rc = *room;
> -out_free:
> -	kfree(room);
> -
> +	dev_dbg(&port->dev, "roomquery says %d\n", room);
> +	rc = room;
> +out:

I changed this to just return rc in the error path above directly
instead.

>  	return rc;
>  }

Now applied, thanks.

Johan
