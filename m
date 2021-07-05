Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2243BBCE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 14:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhGEMjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 08:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhGEMjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 08:39:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE48613B6;
        Mon,  5 Jul 2021 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625488598;
        bh=qqOQqU3TjmhXAdd0JbActK+oNV6kgURc6/5/1Av+SMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhW3ES7HMaz0J3KcgyvPyFa5ZCw0rSVhl8QNR6iYT9oBeqQfHAQopS14KrIwkRoSl
         J0N7z751COu5yA+f8q2LzbeiR/Gh9hj3IWnDgVaLYMwPPFGFVSb6HEjye12WbSV+yZ
         PUPf+xxoIRI0GM7j2SsES72lZ2u0d71H+o6HZhP8=
Date:   Mon, 5 Jul 2021 14:36:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tty: n_gsm: delete DISC command frame as requester
Message-ID: <YOL80ipQSv6egZWh@kroah.com>
References: <1625486382-19051-1-git-send-email-zhenguo6858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625486382-19051-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 07:59:42PM +0800, Zhenguo Zhao wrote:
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
> index 5fea02c..ea9c750 100644
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
> @@ -3024,7 +3025,8 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
>  	mutex_unlock(&dlci->mutex);
>  	if (tty_port_close_start(&dlci->port, tty, filp) == 0)
>  		return;
> -	gsm_dlci_begin_close(dlci);
> +	if (dlci->gsm->initiator)
> +		gsm_dlci_begin_close(dlci);
>  	if (tty_port_initialized(&dlci->port) && C_HUPCL(tty))
>  		tty_port_lower_dtr_rts(&dlci->port);
>  	tty_port_close_end(&dlci->port, tty);
> @@ -3035,10 +3037,12 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
>  static void gsmtty_hangup(struct tty_struct *tty)
>  {
>  	struct gsm_dlci *dlci = tty->driver_data;
> +	struct gsm_mux *gsm = dlci->gsm;
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
