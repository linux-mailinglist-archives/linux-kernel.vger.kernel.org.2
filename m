Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A822351085
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 10:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhDAIBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 04:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhDAIBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 04:01:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80CBB601FA;
        Thu,  1 Apr 2021 08:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617264093;
        bh=Mq39K3+LAF97oI/GCfA+BJgXkBEWc8OJfLC8NFrrFmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U38w/jppE4U80LMU0eTPKdD0Q1xwYUuzr5tVlGCmRWhJHF2AqILRO/deV1RMPPllL
         QxNrQDGBqJcDo15xr9h+eZ9ClYqQjbB9JJME76TbZhdJTSfGbRAheGYFXN7fUa6JQj
         4/sivFnPspRku+jX2rhRL62DbbcFlRwXmPK75p+NJ8jP1uf7arOpiwN3JgH9JzKHp6
         nk/DA+AU3QUJDKmUKR6amIit8TwdI1TGUFHPqzTLulat3OIh+WOY57z11Z9Xlnpxo/
         U+pSLsOWV9NDjGRt0BZhq7aPEHMywTlGW03EyHp+7bzYZdGg57b5LGAe182IQexycN
         eFyo1gN6etMeQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRsGh-0004FK-5C; Thu, 01 Apr 2021 10:01:31 +0200
Date:   Thu, 1 Apr 2021 10:01:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: iuu_phoenix: remove redundant variable
 'error'
Message-ID: <YGV923BQBelY1vnu@hovoldconsulting.com>
References: <20210327232744.26237-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327232744.26237-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 11:27:44PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable error is initialized to 0 and is set to 1 this
> value is never read as it is on an immediate return path. The
> only read of error is to check it is 0 and this check is always
> true at that point of the code. The variable is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/serial/iuu_phoenix.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
> index 093afd67a664..19753611e7b0 100644
> --- a/drivers/usb/serial/iuu_phoenix.c
> +++ b/drivers/usb/serial/iuu_phoenix.c
> @@ -643,7 +643,6 @@ static void iuu_uart_read_callback(struct urb *urb)
>  	struct iuu_private *priv = usb_get_serial_port_data(port);
>  	unsigned long flags;
>  	int status = urb->status;
> -	int error = 0;
>  	int len = 0;
>  	unsigned char *data = urb->transfer_buffer;
>  	priv->poll++;
> @@ -660,12 +659,11 @@ static void iuu_uart_read_callback(struct urb *urb)
>  	if (urb->actual_length > 1) {
>  		dev_dbg(&port->dev, "%s - urb->actual_length = %i\n", __func__,
>  		    urb->actual_length);
> -		error = 1;
>  		return;

Heh, I guess the author at some point intended not return here, but who
knows. The rest of this function is about as esoteric.

>  	}
>  	/* if len > 0 call readbuf */
>  
> -	if (len > 0 && error == 0) {
> +	if (len > 0) {
>  		dev_dbg(&port->dev, "%s - call read buf - len to read is %i\n",
>  			__func__, len);
>  		status = iuu_read_buf(port, len);

Now applied, thanks.

Johan
