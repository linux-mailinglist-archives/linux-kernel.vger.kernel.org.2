Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206A43D0CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbhGUJzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237923AbhGUJnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:43:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40C75610F7;
        Wed, 21 Jul 2021 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626863039;
        bh=Iu2JiDDG0eWSlcpAlkHVXAWB7CncVs3Oinc1pECdzf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PB/4TrgteWCs+wehP3yxy4taysJjkpy9Oo/hsMHiBa2pGxht5vcZJa402TTcMsEOd
         s5tvhazFM3zgRQ8LDP5J9RTXLGM1HZOQOm1Ffc+i/hWfVcsKOwcJwXVsJLES+Qm2VG
         OzUXfWSYC3mPthvWehXlqBOKNNIvbIHdVWGD90vE=
Date:   Wed, 21 Jul 2021 12:23:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: n_gsm: delete SABM command frame as requester
Message-ID: <YPf1vb9fnvDDSSro@kroah.com>
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

Same issue here with this text.  Please work on fixing it up to be
understood by others better.

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

Why is this only an issue for initiators?  And why has no one reported
this problem before now?

Do you not also need to make ths same change somewhere else when
shutting down?

thanks,

greg k-h
