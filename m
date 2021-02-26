Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF921326017
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBZJdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:33:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhBZJcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:32:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E99864ED5;
        Fri, 26 Feb 2021 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614331900;
        bh=CyXWD5LrZck3yEqxzTXhr0oQtIwdrRJ8pEYe2Zj1HiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uj4UsTGRQ20WVGooVvPPNxZ5VOkM+Qn4Fv1jW/NMeUO+uFgXKsMny5UO6oQG+tlQ8
         Mqyf8y9gwUDJBD/H+QhvKhI3HY7JN85UYGYBs059YEu2Ao/KT+jWSnCq0LUBwfLQYB
         8XnD3Uwd75t0oCFyNb0vyVwxRiopM9j6n8kShlxQ=
Date:   Fri, 26 Feb 2021 10:31:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ricky Niu <rickyniu@google.com>
Cc:     stern@rowland.harvard.edu, erosca@de.adit-jv.com,
        gustavoars@kernel.org, a.darwish@linutronix.de, oneukum@suse.com,
        kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ANDROID: usb: core: Send uevent when USB TOPO layer over
 6
Message-ID: <YDi/+TN6AYXropf7@kroah.com>
References: <20210226091612.508639-1-rickyniu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226091612.508639-1-rickyniu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 05:16:12PM +0800, Ricky Niu wrote:
> When the topology of the nested hubs are over 6 layers
> Send uevent to user space when USB TOPO layer over 6.
> Let end user more understand what happened.
> 
> Signed-off-by: Ricky Niu <rickyniu@google.com>
> ---
>  drivers/usb/core/hub.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 7f71218cc1e5..e5e924526822 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -55,6 +55,10 @@ static DEFINE_SPINLOCK(device_state_lock);
>  static struct workqueue_struct *hub_wq;
>  static void hub_event(struct work_struct *work);
>  
> +/* struct to notify userspace of hub events */
> +static struct class *hub_class;
> +static struct device *hub_device;

Wait, how did you even test this code?  This will not work if you have
more than one hub in the system at a single time, right?

That's going to be really rough, given here's the output of just my
desktop system, count the number of hubs in it:rdevmgmt.msc

$ lsusb -t
/:  Bus 10.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 10000M
/:  Bus 09.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 480M
    |__ Port 5: Dev 2, If 0, Class=Wireless, Driver=btusb, 12M
    |__ Port 5: Dev 2, If 1, Class=Wireless, Driver=btusb, 12M
    |__ Port 6: Dev 3, If 0, Class=Hub, Driver=hub/4p, 480M
/:  Bus 08.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 10000M
    |__ Port 2: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
    |__ Port 3: Dev 3, If 0, Class=Mass Storage, Driver=uas, 10000M
/:  Bus 07.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 480M
    |__ Port 2: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 2: Dev 4, If 0, Class=Hub, Driver=hub/2p, 12M
            |__ Port 2: Dev 5, If 0, Class=Human Interface Device, Driver=usbhid, 12M
            |__ Port 2: Dev 5, If 1, Class=Human Interface Device, Driver=usbhid, 12M
            |__ Port 2: Dev 5, If 2, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 5: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
    |__ Port 5: Dev 3, If 1, Class=Audio, Driver=snd-usb-audio, 480M
    |__ Port 5: Dev 3, If 6, Class=Audio, Driver=snd-usb-audio, 480M
    |__ Port 5: Dev 3, If 4, Class=Audio, Driver=snd-usb-audio, 480M
    |__ Port 5: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
    |__ Port 5: Dev 3, If 0, Class=Audio, Driver=snd-usb-audio, 480M
    |__ Port 5: Dev 3, If 7, Class=Human Interface Device, Driver=usbhid, 480M
    |__ Port 5: Dev 3, If 5, Class=Audio, Driver=snd-usb-audio, 480M
    |__ Port 6: Dev 6, If 0, Class=Human Interface Device, Driver=usbhid, 12M
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/1p, 10000M/x2
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/1p, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
    |__ Port 1: Dev 11, If 0, Class=Hub, Driver=hub/3p, 5000M
        |__ Port 3: Dev 12, If 0, Class=Hub, Driver=hub/3p, 5000M
            |__ Port 1: Dev 13, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
    |__ Port 1: Dev 14, If 0, Class=Hub, Driver=hub/3p, 480M
        |__ Port 3: Dev 15, If 0, Class=Hub, Driver=hub/3p, 480M
            |__ Port 2: Dev 17, If 0, Class=Human Interface Device, Driver=usbhid, 12M
            |__ Port 3: Dev 18, If 3, Class=Human Interface Device, Driver=usbhid, 12M
            |__ Port 3: Dev 18, If 1, Class=Audio, Driver=snd-usb-audio, 12M
            |__ Port 3: Dev 18, If 2, Class=Audio, Driver=snd-usb-audio, 12M
            |__ Port 3: Dev 18, If 0, Class=Audio, Driver=snd-usb-audio, 12M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M


So, proof that this works?  How did you test this?

Also, you have a memory leak in this submission :(

greg k-h
