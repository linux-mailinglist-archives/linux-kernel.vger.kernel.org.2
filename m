Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC245422597
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhJELrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234405AbhJELr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:47:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A0CE6159A;
        Tue,  5 Oct 2021 11:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633434338;
        bh=NIra20hcsUHRkedpcLvDTNl826PaAkXsb/ZidiMq6Tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rmjl8B3U1XQSrhvF4OQDxaWuRe+VZy265wUVs+8+NEyXDsRMqXUstocsmlDiBH98O
         EoeeBkELLrt0hO5d4GRs3Ccm3ZLgdqo7XmyYp9c5N9Px1maoN5nl8zVmKecrTTN5cY
         O8bPFVNBW9rAp4LL/O7k87wlzpqDZemiQR3Yg5oY=
Date:   Tue, 5 Oct 2021 13:45:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] Partially revert "usb: Kconfig: using select for
 USB_COMMON dependency"
Message-ID: <YVw64IFwkvOk2Eu1@kroah.com>
References: <20210921143442.340087-1-carnil@debian.org>
 <YVTMUp7UUKUbsKwn@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVTMUp7UUKUbsKwn@eldamar.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:28:02PM +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
> 
> On Tue, Sep 21, 2021 at 04:34:42PM +0200, Salvatore Bonaccorso wrote:
> > From: Ben Hutchings <ben@decadent.org.uk>
> > 
> > This reverts commit cb9c1cfc86926d0e86d19c8e34f6c23458cd3478 for
> > USB_LED_TRIG.  This config symbol has bool type and enables extra code
> > in usb_common itself, not a separate driver.  Enabling it should not
> > force usb_common to be built-in!
> > 
> > Fixes: cb9c1cfc8692 ("usb: Kconfig: using select for USB_COMMON dependency")
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> > ---
> >  drivers/usb/common/Kconfig | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
> > index 5e8a04e3dd3c..b856622431a7 100644
> > --- a/drivers/usb/common/Kconfig
> > +++ b/drivers/usb/common/Kconfig
> > @@ -6,8 +6,7 @@ config USB_COMMON
> >  
> >  config USB_LED_TRIG
> >  	bool "USB LED Triggers"
> > -	depends on LEDS_CLASS && LEDS_TRIGGERS
> > -	select USB_COMMON
> > +	depends on LEDS_CLASS && USB_COMMON && LEDS_TRIGGERS
> >  	help
> >  	  This option adds LED triggers for USB host and/or gadget activity.
> 
> Sorry for bothering you again. Is this patch now ok, or do you need me
> to change something else? Or do I miss something?

Nope, sorry for the delay, now applied.

greg k-h
