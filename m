Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F2309CD8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhAaOYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhAaNov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:44:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1764D64E24;
        Sun, 31 Jan 2021 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612100650;
        bh=AEhfRC2GFsW0jQpuy/pTiPmQNoS8jBKYoe94U2/i/gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcHrIJ+lSMXxQ8dEwZFiaUBnAsUYYiFLJKM8mJHnN06JQzDm0VDoGIHpmO9uGimiC
         YMCx/6IxfeBHf6ilhBtKBcEy/zLVbg6Bwl03Miwp6d4rrfykDw69doq2wkbHO/s36c
         jmTX5YttWsL0vKvVrYuU2atTkSm1tHGPSjpTS4nM=
Date:   Sun, 31 Jan 2021 14:44:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: add option to disable registration of
 legacy ISA ports
Message-ID: <YBa0J82FrD6mdP/v@kroah.com>
References: <20210128172244.22859-1-mans@mansr.com>
 <YBam2m2VMowH5Yth@kroah.com>
 <yw1xwnvtcki0.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xwnvtcki0.fsf@mansr.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 01:18:47PM +0000, Måns Rullgård wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, Jan 28, 2021 at 05:22:44PM +0000, Mans Rullgard wrote:
> >> On systems that do not have the traditional PC ISA serial ports, the
> >> 8250 driver still creates non-functional device nodes.  This change
> >> makes only ports that actually exist (PCI, DT, ...) get device nodes.
> >> 
> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> ---
> >>  drivers/tty/serial/8250/8250_core.c | 26 ++++++++++++++++++++------
> >>  drivers/tty/serial/8250/Kconfig     |  5 +++++
> >>  2 files changed, 25 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> >> index cae61d1ebec5..49695dd3677c 100644
> >> --- a/drivers/tty/serial/8250/8250_core.c
> >> +++ b/drivers/tty/serial/8250/8250_core.c
> >> @@ -555,6 +555,7 @@ static void __init serial8250_isa_init_ports(void)
> >>  	}
> >>  }
> >>  
> >> +#ifdef CONFIG_SERIAL_8250_ISA
> >
> > This is just making a mess of the code. 
> 
> It was already a mess.

True, but don't make it a worse one please.

> 
> > To do this right, pull the isa code out into a separate file and put
> > the #ifdef in a .h file, so we can properly maintain and support this
> > code over time.  This change as-is is not going to make that any
> > easier :(
> 
> I might put in that effort if there's a reasonable chance this change
> will be accepted.  If it's going to be rejected regardless, I'd rather
> not waste my time.
> 
> >> +config SERIAL_8250_ISA
> >> +	bool "8250/16550 ISA device support" if EXPERT
> >
> > So, no one will set this?
> 
> I followed the pattern of the existing SERIAL_8250_PNP option.  Was that
> a mistake?  How would you prefer it?

I don't know, I'm just asking.

> > What userspace visable change will be caused by this? 
> 
> There won't be /dev/ttyS devices for ports that don't exist.
> 
> > Will ports get renumbered?
> 
> Not if they had predictable numbers to begin with.

So that would be "yes"?  If so, obviously we couldn't take this, right?

thanks,

greg k-h
