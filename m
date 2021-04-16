Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F31036241E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbhDPPkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:40:00 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54511 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236141AbhDPPj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:39:57 -0400
Received: (qmail 44307 invoked by uid 1000); 16 Apr 2021 11:39:32 -0400
Date:   Fri, 16 Apr 2021 11:39:32 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, m.v.b@runbox.com,
        hadess@hadess.net, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] USB: Don't set USB_PORT_FEAT_SUSPEND on WD19's
 Realtek Hub
Message-ID: <20210416153932.GD42403@rowland.harvard.edu>
References: <20210415114856.4555-1-chris.chiu@canonical.com>
 <YHgyP8tGNM1Wi5dJ@kroah.com>
 <CABTNMG0MuaSkWZhiTwtWjPTg5WZ-Vdt9Ju9-RzBke9JjCBJo8Q@mail.gmail.com>
 <20210415184637.GA15445@rowland.harvard.edu>
 <CABTNMG3aweq43eQcONif2_M4JF3ARmBgOKE18v7vzHvaJnjrtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTNMG3aweq43eQcONif2_M4JF3ARmBgOKE18v7vzHvaJnjrtA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 09:24:30AM +0800, Chris Chiu wrote:
> On Fri, Apr 16, 2021 at 2:46 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Apr 16, 2021 at 12:13:43AM +0800, Chris Chiu wrote:
> > > One thing worth mentioning here, I never hit the hub_ext_port_status -71
> > > problem if I resume by waking up from the keyboard connected to the hub.
> >
> > I thought you said earlier that the port got into trouble while it was
> > suspending, not while it was resuming.  You wrote:
> >
> > > [ 2789.679812] usb 3-4-port3: can't suspend, status -110
> >
> > So if the problem occurs during suspend, how can it be possible to avoid
> > the problem by taking some particular action later while resuming?
> >
> 
> The ETIMEDOUT is still there, but the port can resume w/o problems and I
> don't really know what the hub did. I can only reset_resume the hub to bring it
> back if I'm not waking up from the connected keyboard.

What if two devices are plugged into the hub, only one of them is 
runtime suspended, and you need to runtime resume that device?  Then you 
can't do a reset-resume of the hub, because the hub isn't suspended.

> > > But the usbcore kernel log shows me wPortStatus: 0503 wPortChane: 0004
> > > of that port while resuming. In normal cases, they are 0507:0000.
> >
> > The 0004 bit of wPortChange means that the suspend status has changed;
> > the port is no longer suspended because the device attached to that port
> > (your keyboard) issued a wakeup request.
> >
> > >  I don't know how to SetPortFeature() with setting the status change bit only.
> >
> > You can't.  Only the hub itself can set the wPortChange bits.
> >
> > > Or maybe it's just some kind of timing issue of the
> > > idle/suspend/resume signaling.
> >
> > Not timing.  It's because you woke the system up from the attached
> > keyboard.
> >
> > Alan Stern
> 
> Got it. I'm just confused by the USB 2.0 spec 11.24.2.7.2 that
> "Hubs may allow setting of the status change bits with a SetPortFeature()
>  request for diagnostic purposes."

Yeah, I don't think very many hubs actually do that.

> So for this case, I think USB_QUIRK_RESET_RESUME would be a
> better option to at least bring back the port. Any suggestion about what
> kind of test I can do on this hub? Thanks

I'm not sure what you're proposing.

If (as mentioned above) the hub doesn't handle the 
Set-Port-Feature(suspend) request properly, then we should avoid issuing 
that request.  Which means runtime suspend attempts should not be 
allowed, as in your most recent patch.

Alan Stern
