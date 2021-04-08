Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A8357E80
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhDHIx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:53:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:54056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhDHIxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:53:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617872022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zj0nUFHGIlAwQGqC4lttL4D1UrKTgkmzkgf8ADN5sIo=;
        b=L16osLsS4gpWWvY8e5uuy5JRXAwkE50Z/OySzPNGJqvMxljK4q7AFC99NKAHhrfipj+d2O
        t7k8k/jU24MI9wM9xyiuw2KfPGBrnhzOrXPS/Penqa3nrJ+FiQI1BLXRiIAAowb9uoC4NI
        bvKPiHxZ1u3EX99xC1dErbGMiySwPkU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11851B0E6;
        Thu,  8 Apr 2021 08:53:42 +0000 (UTC)
Message-ID: <a1a94db2d373c4c7b8841908d8e6133ab022232e.camel@suse.com>
Subject: Re: [PATCH 3/3] USB: cdc-acm: fix TIOCGSERIAL implementation
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 10:36:46 +0200
In-Reply-To: <20210407102845.32720-4-johan@kernel.org>
References: <20210407102845.32720-1-johan@kernel.org>
         <20210407102845.32720-4-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 07.04.2021, 12:28 +0200 schrieb Johan Hovold:
> TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
> serial devices is only useful for setting the close_delay and
> closing_wait parameters.
> 
> The xmit_fifo_size parameter could be used to set the hardware transmit
> fifo size of a legacy UART when it could not be detected, but the
> interface is limited to eight bits and should be left unset when it is
> not used.

OK.

> Similarly, baud_base could be used to set the uart base clock when it
> could not be detected, but might as well be left unset when it is not
> known.

Well, the devices report it. It is part of the standard.

> Fix the cdc-acm TIOCGSERIAL implementation by dropping its custom
> interpretation of the unused xmit_fifo_size and baud_base fields, which
> overflowed the former with the URB buffer size and set the latter to the
> current line speed. Also return the port line number, which is the only
> other value used besides the close parameters.
> 
> Fixes: 18c75720e667 ("USB: allow users to run setserial with cdc-acm")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/class/cdc-acm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 43e31dad4831..b74713518b3a 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -929,8 +929,7 @@ static int get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
>  {
>  	struct acm *acm = tty->driver_data;
>  
> -	ss->xmit_fifo_size = acm->writesize;
> -	ss->baud_base = le32_to_cpu(acm->line.dwDTERate);

If we do this, we have a value that can be set, but is not reported.
That looks a bit strange to me.

	Regards
		Oliver


