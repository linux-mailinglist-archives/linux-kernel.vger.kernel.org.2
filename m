Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2BA35F63C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348699AbhDNOca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:32:30 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58121 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231818AbhDNOc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:32:28 -0400
Received: (qmail 1494041 invoked by uid 1000); 14 Apr 2021 10:32:06 -0400
Date:   Wed, 14 Apr 2021 10:32:06 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     gregkh@linuxfoundation.org, m.v.b@runbox.com, hadess@hadess.net,
        linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: Don't set USB_PORT_FEAT_SUSPEND on WD19's Realtek
 Hub
Message-ID: <20210414143206.GA1493067@rowland.harvard.edu>
References: <20210412150006.53909-1-chris.chiu@canonical.com>
 <20210412151205.GB1420451@rowland.harvard.edu>
 <CABTNMG1fvbOMrP+FmH0X5Yh04gf6vvhqhXfRrmpJ=f-fPBx4xw@mail.gmail.com>
 <20210413144416.GB1454681@rowland.harvard.edu>
 <CABTNMG21xp6TA8SGJhamfM9D6JGvQHwg8AMySSCh09-DnAZ5qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTNMG21xp6TA8SGJhamfM9D6JGvQHwg8AMySSCh09-DnAZ5qQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 01:07:43PM +0800, Chris Chiu wrote:
> Thanks for the instructions. I can hit the same timeout problem with
> runtime PM. The
> fail rate seems the same as normal PM. (around 1/4 ~ 1/7)
> root@:/sys/bus/usb/devices/3-4.3# echo auto > power/control
> root@:/sys/bus/usb/devices/3-4.3# echo on > power/control
> root@:/sys/bus/usb/devices/3-4.3# dmesg -c
> [ 2789.679807] usb 3-4: kworker/7:0 timed out on ep0out len=0/0
> [ 2789.679812] usb 3-4-port3: can't suspend, status -110
> [ 2789.680078] usb 3-4.3: Failed to suspend device, error -110

Since these are random failures, occurring at a low rate, maybe it would 
help simply to retry the transfer that timed out.  Have you tested this?

> > > > > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > > > > index 7f71218cc1e5..8478d49bba77 100644
> > > > > --- a/drivers/usb/core/hub.c
> > > > > +++ b/drivers/usb/core/hub.c
> > > > > @@ -3329,8 +3329,11 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
> > > > >        * descendants is enabled for remote wakeup.
> > > > >        */
> > > > >       else if (PMSG_IS_AUTO(msg) || usb_wakeup_enabled_descendants(udev) > 0)
> > > > > -             status = set_port_feature(hub->hdev, port1,
> > > > > -                             USB_PORT_FEAT_SUSPEND);
> > > > > +             if (udev->quirks & USB_QUIRK_NO_SET_FEAT_SUSPEND)
> > > >
> > > > You should test hub->hdev->quirks, here, not udev->quirks.  The quirk
> > > > belongs to the Realtek hub, not to the device that's plugged into the
> > > > hub.
> > > >
> > >
> > > Thanks for pointing that out. I'll verify again and propose a V2 after
> > > it's done.
> >
> > Another thing to consider: You shouldn't return 0 from usb_port_suspend
> > if the port wasn't actually suspended.  We don't want to kernel to have
> > a false idea of the hardware's current state.
> >
> So we still need the "really_suspend=false". What if I replace it with
> the following?
> It's a little verbose but expressive enough. Any suggestions?
> 
> +       else if (!(hub->hdev->quirks & USB_QUIRK_NO_SET_FEAT_SUSPEND) &&
> +               (PMSG_IS_AUTO(msg) || usb_wakeup_enabled_descendants(udev) > 0))
> +               status = set_port_feature(hub->hdev, port1,
> +                               USB_PORT_FEAT_SUSPEND);
>         else {
>                 really_suspend = false;
>                 status = 0;

You should do something more like this:

-	else if (PMSG_IS_AUTO(msg) || usb_wakeup_enabled_descendants(udev) > 0)
-		status = set_port_feature(hub->hdev, port1,
-				USB_PORT_FEAT_SUSPEND);
-	else {
+	else if (PMSG_IS_AUTO(msg) || usb_wakeup_enabled_descendants(udev) > 0) {
+		if (hub->hdev->quirks & USB_QUIRK_NO_SUSPEND)
+			status = -EIO;
+		else
+			status = set_port_feature(hub->hdev, port1,
+					USB_PORT_FEAT_SUSPEND);
+	} else {
		really_suspend = false;
		status = 0;
	}

But I would prefer to find a way to make port suspend actually work, 
instead of giving up on it.

Alan Stern
