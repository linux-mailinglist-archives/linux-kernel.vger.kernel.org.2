Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB5C3B9148
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbhGALsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236125AbhGALsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:48:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADA616128A;
        Thu,  1 Jul 2021 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625139975;
        bh=ZnjgJHAmKdje4gioA3EdCNPiIw3mg1Qo2HMHG/7N1TI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vR/XGGb9+9dWz460JVd5F96UyZzoBRYNimwcDPqgnAg8+WwS3z94uztgT28nyjCe1
         X7CiKm7j5iE5XbL4yYk/7lV08af7Q1Hms2VCHD7FIXMyR3CpErZ31QcePMuA8C4cXR
         ECpf2gmBKCv5IVtiVB8m1hTjUPkx7wI/UM67AFzM=
Date:   Thu, 1 Jul 2021 13:46:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: n_gsm: delete DISC command frame as requester
Message-ID: <YN2rBLO4gX0Sei83@kroah.com>
References: <1625139723-23197-1-git-send-email-zhenguo6858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625139723-23197-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 07:42:03PM +0800, Zhenguo Zhao wrote:
> From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> 
> as initiator,it need to send DISC command ,as requester,there is
> no need to send the DISC control frame,it will cause redundant data.
> 
> Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> ---
>  drivers/tty/n_gsm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 5fea02c..1aa87d9 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2050,7 +2050,8 @@ static int gsm_disconnect(struct gsm_mux *gsm)
>  	del_timer_sync(&gsm->t2_timer);
>  	/* Now we are sure T2 has stopped */
>  
> -	gsm_dlci_begin_close(dlci);
> +	if (gsm->initiator)
> +		gsm_dlci_begin_close(dlci);
>  	wait_event_interruptible(gsm->event,
>  				dlci->state == DLCI_CLOSED);
>  
> @@ -3014,6 +3015,7 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
>  static void gsmtty_close(struct tty_struct *tty, struct file *filp)
>  {
>  	struct gsm_dlci *dlci = tty->driver_data;
> +	struct gsm_mux *gsm = dlci->gsm;
>  
>  	if (dlci == NULL)
>  		return;
> @@ -3024,7 +3026,8 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
>  	mutex_unlock(&dlci->mutex);
>  	if (tty_port_close_start(&dlci->port, tty, filp) == 0)
>  		return;
> -	gsm_dlci_begin_close(dlci);
> +	if (gsm->initiator)
> +		gsm_dlci_begin_close(dlci);
>  	if (tty_port_initialized(&dlci->port) && C_HUPCL(tty))
>  		tty_port_lower_dtr_rts(&dlci->port);
>  	tty_port_close_end(&dlci->port, tty);
> @@ -3038,7 +3041,8 @@ static void gsmtty_hangup(struct tty_struct *tty)
>  	if (dlci->state == DLCI_CLOSED)
>  		return;
>  	tty_port_hangup(&dlci->port);
> -	gsm_dlci_begin_close(dlci);
> +	if (gsm->initiator)
> +		gsm_dlci_begin_close(dlci);
>  }
>  
>  static int gsmtty_write(struct tty_struct *tty, const unsigned char *buf,
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
