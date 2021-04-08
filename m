Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D68357FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhDHJtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230424AbhDHJtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:49:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B97A361154;
        Thu,  8 Apr 2021 09:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617875341;
        bh=75PIUiG/5SWSv418e48iO3sSOjLXnI3KSH2VixtNNN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOcWN5CcJwRrhcrPo35iZTRFodkPiz95adnn36GxcCf7iTeY4FEttFXvtdFP6Bu+4
         hwT/EZZUOy4202beJ2MoQfOPDYGWMOZvsSyYRymvvQbc297CF+VNwQnp4q3kwgiYRI
         dUP5SK4ylCPmpFQfUVuwd9k1RHb5hvoYDk8SO9efON4sy5zbPLGPhOH18NHyxb3Van
         kHz+odK3R3YzyFZkTi12DiWA0vnd+3/WhgzI/AJJ0AajGoX0x7tSilQJ4T99ZAwl63
         Ogg5IGs89AmLO/lHdeFp2GVeAjlJCPhsejQ7kk4JxheGdgdrJVcWdrtj3U7H+Hm3wm
         ysoZ+mopHAAJQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lURHU-00031q-6N; Thu, 08 Apr 2021 11:48:56 +0200
Date:   Thu, 8 Apr 2021 11:48:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] USB: cdc-acm: fix TIOCGSERIAL implementation
Message-ID: <YG7RiLoscS6VXG7n@hovoldconsulting.com>
References: <20210407102845.32720-1-johan@kernel.org>
 <20210407102845.32720-4-johan@kernel.org>
 <a1a94db2d373c4c7b8841908d8e6133ab022232e.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a94db2d373c4c7b8841908d8e6133ab022232e.camel@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:36:46AM +0200, Oliver Neukum wrote:
> Am Mittwoch, den 07.04.2021, 12:28 +0200 schrieb Johan Hovold:
> > TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
> > serial devices is only useful for setting the close_delay and
> > closing_wait parameters.
> > 
> > The xmit_fifo_size parameter could be used to set the hardware transmit
> > fifo size of a legacy UART when it could not be detected, but the
> > interface is limited to eight bits and should be left unset when it is
> > not used.
> 
> OK.
> 
> > Similarly, baud_base could be used to set the uart base clock when it
> > could not be detected, but might as well be left unset when it is not
> > known.
> 
> Well, the devices report it. It is part of the standard.

No, the standard doesn't include anything about a baud-base clock
AFAICT.

> > Fix the cdc-acm TIOCGSERIAL implementation by dropping its custom
> > interpretation of the unused xmit_fifo_size and baud_base fields, which
> > overflowed the former with the URB buffer size and set the latter to the
> > current line speed. Also return the port line number, which is the only
> > other value used besides the close parameters.
> > 
> > Fixes: 18c75720e667 ("USB: allow users to run setserial with cdc-acm")
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/usb/class/cdc-acm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> > index 43e31dad4831..b74713518b3a 100644
> > --- a/drivers/usb/class/cdc-acm.c
> > +++ b/drivers/usb/class/cdc-acm.c
> > @@ -929,8 +929,7 @@ static int get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
> >  {
> >  	struct acm *acm = tty->driver_data;
> >  
> > -	ss->xmit_fifo_size = acm->writesize;
> > -	ss->baud_base = le32_to_cpu(acm->line.dwDTERate);
> 
> If we do this, we have a value that can be set, but is not reported.
> That looks a bit strange to me.

Again, no, the baud_base cannot be set and it is unknown and unused.

The only reason to report back baud_base is to support the deprecated
ASYNC_SPD_CUST interface used to set a custom divisor. cdc-acm has never
supported that for obvious reasons.

Johan
