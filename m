Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB273A91CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFPGWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231361AbhFPGWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:22:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FA496109D;
        Wed, 16 Jun 2021 06:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623824403;
        bh=fsk3tIBKiIoVIW1bA1eVzoU4ws0RV2PZ5tHn6Axph38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMLKrrCbUMWbT29JO3HxvCLHhICklO1VKalK5aV+ViFpbtxp17QSO4jy8iyF1I07j
         OPB/gV4WuLfYb7wscFSW0oqLPpKMOJmZZvPmd+4fzSTpgvQkFdMPFlbDmzBMEZ3wyp
         idWYB0v0tiKVEMI+4yWegPbLAFWaAAXuyC8OQ0k8=
Date:   Wed, 16 Jun 2021 08:19:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]    tty: n_gsm: Fix CR bit value when initiator=0
Message-ID: <YMmYD3rkS8o+1dXr@kroah.com>
References: <1623812199-31866-1-git-send-email-zhenguo6858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623812199-31866-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:56:39AM +0800, Zhenguo Zhao wrote:
> From: Zhenguo Zhao <zhenguo.zhao1@unisoc.com>
> 
> 	When set initiator=0,switch to Responder,gsmld received dlci SABM/DISC
> 	frame,CR bit should be 0 by calculation.
> 
> 	receive DLC0 SABM CMD:
> 	[69.740263] c1 gsmld_receive: 00000000: f9 03 3f 01 1c f9
> 	[69.893247] c1 gsm_queue cr:1
> 	[69.897629] c1 <-- 0) C: SABM(P)
> 	[69.907516] c1 gsm_queue cr:0

Why is this changelog text indented by tabs?

And I do not understand the changelog text here, what is this showing?
What is wrong here and what is being fixed?

> Signed-off-by: Zhenguo Zhao <zhenguo.zhao1@unisoc.com>

Does this fix a long-standing issue?  Should a "Fixes:" tag go here?  If
so, please provide it.

Should it also be sent to stable kernels?

> ---
>  drivers/tty/n_gsm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 5fea02c..becca2c 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1779,7 +1779,7 @@ static void gsm_queue(struct gsm_mux *gsm)
>  
>  	switch (gsm->control) {
>  	case SABM|PF:
> -		if (cr == 0)
> +		if (cr == 1)

How did the original code ever work properly?

>  			goto invalid;
>  		if (dlci == NULL)
>  			dlci = gsm_dlci_alloc(gsm, address);
> @@ -1793,7 +1793,7 @@ static void gsm_queue(struct gsm_mux *gsm)
>  		}
>  		break;
>  	case DISC|PF:
> -		if (cr == 0)
> +		if (cr == 1)

Same here, how did this ever work?  Are you sure this change is correct?

thanks,

greg k-h
