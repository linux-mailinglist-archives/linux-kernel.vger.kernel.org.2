Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8287C3B913C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhGALh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236130AbhGALh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:37:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EDD761467;
        Thu,  1 Jul 2021 11:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625139295;
        bh=rIWdk0OMX+YChQUSvtbtOZCRWi45Wfhx8BOlfwG2jdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0qk+r2t/NaaMr8DwAe0Ck6dIkQuIN7Vr9bQhIwvst3AGOB0mNVSSsTCd3Q/pLvHH
         zRfBlbjhtLbhW8VTfnrMt4grXks7I2XLFMRYKMe8JMsuD/XUsE1I2XhcNW6BhrvjfF
         UN+Gvt94ZZgCMLU9Nhm/D+L3IEJXjFB+y8nhJB0A=
Date:   Thu, 1 Jul 2021 13:34:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: n_gsm: delete SABM command frame as requester
Message-ID: <YN2oXSwKCWzEY+jD@kroah.com>
References: <1625138840-22974-1-git-send-email-zhenguo6858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625138840-22974-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 07:27:20PM +0800, Zhenguo Zhao wrote:
> From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> 
> as initiator,it need to send SABM command ,as requester,there is
> no need to send the SABM control frame,it will cause redundant data.
> 
> Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> ---
>  drivers/tty/n_gsm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 5fea02c..41a6501 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2997,6 +2997,7 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
>  {
>  	struct gsm_dlci *dlci = tty->driver_data;
>  	struct tty_port *port = &dlci->port;
> +	struct gsm_mux *gsm = dlci->gsm;
>  
>  	port->count++;
>  	tty_port_tty_set(port, tty);
> @@ -3005,8 +3006,9 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
>  	/* We could in theory open and close before we wait - eg if we get
>  	   a DM straight back. This is ok as that will have caused a hangup */
>  	tty_port_set_initialized(port, 1);
> -	/* Start sending off SABM messages */
> -	gsm_dlci_begin_open(dlci);
> +	/* Start sending off SABM messages for initiator */
> +	if (gsm->initiator)
> +		gsm_dlci_begin_open(dlci);
>  	/* And wait for virtual carrier */
>  	return tty_port_block_til_ready(port, tty, filp);
>  }
> -- 
> 1.9.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
