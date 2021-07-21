Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795043D0CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhGUJzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239097AbhGUJmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:42:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94BFB60C40;
        Wed, 21 Jul 2021 10:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626862962;
        bh=7AYO5SIE/HKmS1+34D4fFJzQyEx5w7zpC7Ro3UR0+Qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+fBFhw0g2UBiPJsU7oJSmOiHVjcmVE3hKVF3QMcnbKp+GlrZ6Q8tgMG4prNCVUph
         lPcI8RC2qXQTD3sbGJpPJWvZ2kA5DzWaanTfoOYHmfhAGD+fhKX1PqOe8fLjriSZfN
         zReJjMNMQGO+3geFYw/2ZIK5yc1XuzMI078t0XCQ=
Date:   Wed, 21 Jul 2021 12:22:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tty: n_gsm: delete DISC command frame as requester
Message-ID: <YPf1b1/7dWLAnEoI@kroah.com>
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

I am really sorry, but I can not understand what the problem is here,
nor what you are saying is being changed.

Can you try to resend this with a more expanded changelog text?  Perhaps
get someone else to help out with the wording?


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

You have a coding style issue here now, so I can't take this anyway :(

thanks,

greg k-h
