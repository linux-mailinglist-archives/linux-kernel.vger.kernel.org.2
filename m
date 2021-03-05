Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B5432F3CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCETZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:25:45 -0500
Received: from netrider.rowland.org ([192.131.102.5]:43341 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229597AbhCETZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:25:30 -0500
Received: (qmail 49699 invoked by uid 1000); 5 Mar 2021 14:25:29 -0500
Date:   Fri, 5 Mar 2021 14:25:29 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using
 xhci_hcd
Message-ID: <20210305192529.GD48113@rowland.harvard.edu>
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
 <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
 <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
 <20210301155321.GA1490228@rowland.harvard.edu>
 <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu>
 <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 08:05:49PM +0100, Sedat Dilek wrote:
> On Fri, Mar 5, 2021 at 5:07 PM Alan Stern <stern@rowland.harvard.edu> wrote:

> > Don't worry about trying to decode the output.  To me it looks like the
> > drive crashes and needs to be reset at times when the computer sends it
> > an ATA command.  (Not all ATA commands, but some.)  You can prevent this
> > by setting the following module parameter for the usb-storage driver:
> >
> >         quirks=174c:55aa:t
> >
> > where the two numbers are the Vendor and Product IDs for the external
> > drive, and the 't' is a quirks flag saying not to use any ATA commands.
> > If this module parameter fixes the problem, we can add a permanent quirk
> > setting to the kernel.
> >
> 
> Thanks Alan.
> 
> I did:
> 
> [ /etc/modules-load.d/usb-storage.conf ]
> 
> # Add quirks for ATA commands for usb-storage devices connected to
> ASMedia M1042 USB-3.0 controller
> options usb-storage quirks=174c:55aa:t
> - EOF -
> 
> It is:
> 
> /lib/modules/5.12.0-rc1-11-amd64-clang13-cfi/kernel/drivers/usb/storage/usb-storage.ko
> 
> But:
> 
> root# lsmod | grep usb | grep storage
> usb_storage            90112  2 uas
> scsi_mod              307200  6 sd_mod,usb_storage,uas,libata,sg,sr_mod
> usbcore               385024  14
> usbserial,xhci_hcd,ehci_pci,usbnet,usbhid,usb_storage,usb_wwan,uvcvideo,ehci_hcd,btusb,xhci_pci,cdc_ether,uas,option

I don't understand.  What is the point of this listing?

> I have not rebooted yet.

Depending on how your system is set up, the new usb-storage.conf file 
might need to be copied into the initramfs image.

However, you don't need to reload the driver module or reboot.  To make 
the new quirk take effect, all you have to do is write 174c:55aa:t to
/sys/module/usb_storage/parameters/quirks.

> Interferences with PowerTop?

Maybe.  It's entirely possible that PowerTop or some other program is 
issuing the troublesome ATA commands.

> These xhci-resets happen every 10mins in a sequence of 4.
> 
> I have here a powertop.service (systemd) with passing --auto-tune option.
> That was not a problem with previous Linux-kernels >= v5.12-rc1, so.
> 
> Alan, what do you think?

Try turning the service off and see if that makes any difference.

Alan Stern
