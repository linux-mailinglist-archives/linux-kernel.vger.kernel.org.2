Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EB63395D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhCLSF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:05:57 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40355 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231679AbhCLSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:05:25 -0500
Received: (qmail 306756 invoked by uid 1000); 12 Mar 2021 13:05:23 -0500
Date:   Fri, 12 Mar 2021 13:05:23 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using
 xhci_hcd
Message-ID: <20210312180523.GB302347@rowland.harvard.edu>
References: <20210306165808.GD74411@rowland.harvard.edu>
 <CA+icZUWXBtOo+7TBGHFA=aKBs5o9hy3Po6NM0EPssu6y4SOZsQ@mail.gmail.com>
 <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com>
 <CA+icZUUyNQN_CEwJcTY887GOeWknz4h29b+XdY0FqUKVJD7cfQ@mail.gmail.com>
 <20210307154645.GA103559@rowland.harvard.edu>
 <CA+icZUVLC7=-MsXeGQOrAe1emzGW2UwWYxh3EHGPhjR=chygoQ@mail.gmail.com>
 <20210307170702.GB104554@rowland.harvard.edu>
 <CA+icZUWaGt2k4kdV0JHqKUkB8DySqdeUgVNnVT1BUo8aveGZOw@mail.gmail.com>
 <CA+icZUWb40r1MTFYk9S0h2XgGfqCQtxpm9yHKNr3PDnDbUNBKQ@mail.gmail.com>
 <CA+icZUXkheVR-c9cdsJmeS9+FZj4Gswii+xBoAWK882QNdfcTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXkheVR-c9cdsJmeS9+FZj4Gswii+xBoAWK882QNdfcTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 06:41:58PM +0100, Sedat Dilek wrote:
> OK, now for the records:
> 
> [ /etc/modprobe.d/usb-storage.conf  ]
> 
> # Add quirks for USB Mass Storage devices
> #
> # Link: https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
> #
> # Option #1: Use Kernel command line parameter
> # [1] Usage: usb-storage.quirks=<VID:PID:Flags>
> # [2] VendorID (VID) and ProductID (PID):
> #     ASMedia M1042 USB-3.0 controller: VID: 174c PID: 55aa
> # [3] Flags:
> #     t = NO_ATA_1X  (don't allow ATA(12) and ATA(16) commands, uas only);
> #     u = IGNORE_UAS (don't bind to the uas driver);
> # [4] Example: usb-storage.quirks=174c:55aa:t
> #
> # Option #2: Set quirk via sysfs
> # DEBUG: echo '174c:55aa:t' > /sys/module/usb_storage/parameters/quirks
> #
> # Option #3: Pass options via /etc/modprobe.d/usb-storage.conf (this file here)
> # XXX: Do NOT forget to run `update-initramfs` command!
> options usb-storage quirks=174c:55aa:t
> - EOF -
> 
> With generating a new /boot/initrd.img via `update-initramfs` this
> looks good to me:
> 
> root# LC_ALL=C dmesg -T | egrep -i 'quirks|reset|SCSI ioctl error'
> [Fri Mar 12 18:25:56 2021] xhci_hcd 0000:03:00.0: hcc params
> 0x0200f180 hci version 0x96 quirks 0x0000000000080000
> [Fri Mar 12 18:25:57 2021] usb-storage 4-1:1.0: Quirks match for vid
> 174c pid 55aa: 2400000
> [Fri Mar 12 18:25:57 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 18:25:57 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 18:25:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:25:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:25:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:01 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:03 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:03 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:03 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 18:26:24 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 18:26:24 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 18:26:29 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 18:26:39 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 18:26:39 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 18:26:43 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:43 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:28:09 2021] SCSI ioctl error, cmd 85, prog smartctl
> [Fri Mar 12 18:28:09 2021] SCSI ioctl error, cmd 85, prog smartctl
> [Fri Mar 12 18:28:10 2021] SCSI ioctl error, cmd 85, prog smartctl
> [Fri Mar 12 18:28:11 2021] SCSI ioctl error, cmd 85, prog smartctl
> [Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd

Although it's not conclusive, this log seems to indicate that ata_id
is the only program causing resets.  Have you tried preventing the 
ata_id program from running (for example, by renaming it)?

> Your diff now should say; s/SCSI ioctl error/SCSI ioctl info'.

No, it shouldn't.  The log message itself is an info, but the event it
reports is an error.

> Alan, so "t" flags should be added as a quirks to linux-kernel sources...
> 
> t = NO_ATA_1X  (don't allow ATA(12) and ATA(16) commands, uas only);
> 
> ...for my ASMedia USB-3.0 controller?

That's not at all clear.  This is a very common and popular device,
and nobody else has reported these problems.  It could be that
something is odd about your particular drive or computer, not these
drives in general.

Alan Stern
