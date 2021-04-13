Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEFB35E1C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244378AbhDMOom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:44:42 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47843 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1345247AbhDMOoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:44:37 -0400
Received: (qmail 1456110 invoked by uid 1000); 13 Apr 2021 10:44:16 -0400
Date:   Tue, 13 Apr 2021 10:44:16 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     gregkh@linuxfoundation.org, m.v.b@runbox.com, hadess@hadess.net,
        linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: Don't set USB_PORT_FEAT_SUSPEND on WD19's Realtek
 Hub
Message-ID: <20210413144416.GB1454681@rowland.harvard.edu>
References: <20210412150006.53909-1-chris.chiu@canonical.com>
 <20210412151205.GB1420451@rowland.harvard.edu>
 <CABTNMG1fvbOMrP+FmH0X5Yh04gf6vvhqhXfRrmpJ=f-fPBx4xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTNMG1fvbOMrP+FmH0X5Yh04gf6vvhqhXfRrmpJ=f-fPBx4xw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 03:52:14PM +0800, Chris Chiu wrote:
> On Mon, Apr 12, 2021 at 11:12 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Mon, Apr 12, 2021 at 11:00:06PM +0800, chris.chiu@canonical.com wrote:
> > > The USB_PORT_FEAT_SUSPEND is not really necessary due to the
> > > "global suspend" in USB 2.0 spec. It's only for many hub devices
> > > which don't relay wakeup requests from the devices connected to
> > > downstream ports. For this realtek hub, there's no problem waking
> > > up the system from connected keyboard.
> >
> > What about runtime suspend?  That _does_ require USB_PORT_FEAT_SUSPEND.
> 
> It's hard to reproduce the same thing with runtime PM. I also don't
> know the aggressive
> way to trigger runtime suspend. So I'm assuming the same thing will happen in
> runtime PM case because they both go the same usb_port_resume path. Could
> you please suggest a better way to verify this for runtime PM?

To put a USB device into runtime suspend, do this:

	echo 0 >/sys/bus/usb/devices/.../bConfigurationValue
	echo auto >/sys/bus/usb/devices/.../power/control

where ... is the pathname for the device you want to suspend.  (Note 
that this will unbind the device from its driver, so make sure there's 
no possibility of data loss before you do it.)

To resume the device, write "on" to the power/control file.  You can 
verify the runtime-PM status by reading the files in the power/ 
subdirectory.

> > > This commit bypasses the USB_PORT_FEAT_SUSPEND for the quirky hub.
> > >
> > > Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> > > ---
> >
> >
> > > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > > index 7f71218cc1e5..8478d49bba77 100644
> > > --- a/drivers/usb/core/hub.c
> > > +++ b/drivers/usb/core/hub.c
> > > @@ -3329,8 +3329,11 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
> > >        * descendants is enabled for remote wakeup.
> > >        */
> > >       else if (PMSG_IS_AUTO(msg) || usb_wakeup_enabled_descendants(udev) > 0)
> > > -             status = set_port_feature(hub->hdev, port1,
> > > -                             USB_PORT_FEAT_SUSPEND);
> > > +             if (udev->quirks & USB_QUIRK_NO_SET_FEAT_SUSPEND)
> >
> > You should test hub->hdev->quirks, here, not udev->quirks.  The quirk
> > belongs to the Realtek hub, not to the device that's plugged into the
> > hub.
> >
> 
> Thanks for pointing that out. I'll verify again and propose a V2 after
> it's done.

Another thing to consider: You shouldn't return 0 from usb_port_suspend 
if the port wasn't actually suspended.  We don't want to kernel to have 
a false idea of the hardware's current state.

Alan Stern
