Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0417F42A4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhJLMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232900AbhJLMns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:43:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D517060E97;
        Tue, 12 Oct 2021 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634042507;
        bh=sGn6oX7A/cABQ/SZVLhoSRBwTYLT5p/BpAYt7PeiP3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQ9HfOz7uy2lfWuiJiFxP6Pa5lGDOIqx3P9OAeW6hIh7NySdnIte7vFU7m8COMvRa
         Vy1ZlE/Zu2ipSuyfqcfWa6CVChucrz7z4o/MSDLogUWHP+rV+nNtPa6DGA0EvuFpIr
         CFaw1BtOzugdUiSitKs7+EFJcKQDchr2CtwVXjO8=
Date:   Tue, 12 Oct 2021 14:41:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: allow -EPIPE errors for some v2 messages
Message-ID: <YWWCiLE6id43uJjp@kroah.com>
References: <YWLbEdHUE3k/i0fe@kroah.com>
 <s5hily46316.wl-tiwai@suse.de>
 <YWRYD7fphcaWKEOG@kroah.com>
 <s5h7dej4kbe.wl-tiwai@suse.de>
 <YWRy+UoG1YHcQ7UM@kroah.com>
 <s5ho87u3dcb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ho87u3dcb.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 09:35:16AM +0200, Takashi Iwai wrote:
> On Mon, 11 Oct 2021 19:23:05 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > On Mon, Oct 11, 2021 at 06:07:01PM +0200, Takashi Iwai wrote:
> > > Could you also post the contents of /proc/asound/card*/usbmixer (only
> > > for the corresponding device), too?
> > 
> > Sure, here it is:
> > 
> > USB Mixer: usb_id=0x30be0101, ctrlif=0, ctlerr=0
> > Card: Schiit Audio Schiit Hel at usb-0000:47:00.1-2.2, high speed
> >   Unit: 5
> >     Control: name="Mic - Input Jack", index=0
> >     Info: id=5, control=2, cmask=0x0, channels=1, type="BOOLEAN"
> >     Volume: min=0, max=1, dBmin=0, dBmax=0
> >   Unit: 7
> >     Control: name="Speaker - Output Jack", index=0
> >     Info: id=7, control=2, cmask=0x0, channels=1, type="BOOLEAN"
> >     Volume: min=0, max=1, dBmin=0, dBmax=0
> >   Unit: 13
> >     Control: name="PCM Playback Switch", index=0
> >     Info: id=13, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
> >     Volume: min=0, max=1, dBmin=0, dBmax=0
> >   Unit: 17
> >     Control: name="Mic Capture Switch", index=0
> >     Info: id=17, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
> >     Volume: min=0, max=1, dBmin=0, dBmax=0
> >   Unit: 18
> >     Control: name="Clock Source 18 Validity", index=0
> >     Info: id=18, control=2, cmask=0x0, channels=1, type="BOOLEAN"
> >     Volume: min=0, max=1, dBmin=0, dBmax=0
> >   Unit: 22
> >     Control: name="Clock Source 22 Validity", index=0
> >     Info: id=22, control=2, cmask=0x0, channels=1, type="BOOLEAN"
> >     Volume: min=0, max=1, dBmin=0, dBmax=0
> 
> Hm, I expected more exotic control that failed, but it was Mic Capture
> Switch, which should be treated normally.
> 
> Could you try the patch below?  This will still show other warning
> messages, but it'll forcibly initialize the mixer elements at probe
> time, and the rest should work.
> 
> Once after it's confirmed to work, we may shut up the device warnings
> with a quirk.

Only one warning message shows up, here's the dmesg with this patch
applied:


[Oct12 14:39] usb 7-2.2: new high-speed USB device number 10 using xhci_hcd
[  +0.123157] usb 7-2.2: New USB device found, idVendor=30be, idProduct=0101, bcdDevice= 1.02
[  +0.000009] usb 7-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  +0.000003] usb 7-2.2: Product: Schiit Hel
[  +0.000002] usb 7-2.2: Manufacturer: Schiit Audio
[  +0.339785] usb 7-2.2: 17:0: failed to get current value for ch 0 (-32)
[  +0.020373] input: Schiit Audio Schiit Hel as /devices/pci0000:40/0000:40:01.1/0000:41:00.0/0000:42:08.0/0000:47:00.1/usb7/7-2/7-2.2/7-2.2:1.3/0003:30BE:0101.000B/input/input24
[  +0.056868] hid-generic 0003:30BE:0101.000B: input,hidraw6: USB HID v1.00 Device [Schiit Audio Schiit Hel] on usb-0000:47:00.1-2.2/input3


I don't see a "mic capture switch" on this device, but maybe it triggers
when I plug a mic into the microphone port, which is currently empty?

thanks,

greg k-h
