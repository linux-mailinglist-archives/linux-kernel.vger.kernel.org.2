Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BD932F3C2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCETX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCETW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:22:59 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93762C061574;
        Fri,  5 Mar 2021 11:22:59 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id o9so3170668iow.6;
        Fri, 05 Mar 2021 11:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=yF8EgpFfFBjawtii+lk6KkLM9nijvdEea1xbqL6g9/g=;
        b=JIFAU9065pdD7Usa/GKyrrPKSsOw4kYG5IFYXWVyMz3VAfNEq1qbKgZfIMx/YJm+CE
         5JesmlrhcT8perj7SLJloWi+3VMHQIhXjd9tbvyv2yNNr7fsW3+5qMPzuIWMNqOH5fPY
         Ecr1slyEY8QEq4Dp0M9JXJgj8dWACBlci/gtm9DnxhU2jMASW1agi9lGp5mfINIXeCzb
         GaZhPt01I6DilwQltRjlCRwqx3qIOC/+BEs+EMX6u3RtOJMRxw0Bn3V0KGhOFB+CEweL
         M/Jm4fRK5C0gGlPm+cFvYIazjJtNmihBHrd2O2RU9esedx8CX0ZvkyhTX1xIpu/9W2p7
         fzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=yF8EgpFfFBjawtii+lk6KkLM9nijvdEea1xbqL6g9/g=;
        b=QSc48hXctW5zUTdWoaNAXODhzODPlcgn/H7gWTx1NRPbSTcXnA5J16ZUoyt1lEvpBA
         nZ+cq3AzHrPJrCv8TDSKVPPZMlsm7muIfnlPQ/4cTh7adpO2NSAncZWmT3h99hj2XbHM
         wRsjDKnr7zzIT/x/HUMOyKpw11jc+cHb8mf6aYC7aLrruESZ2JeKSnjhodgfzm1Ke/d6
         FrmLQVXepu0MDXnCanyHaGJMGqdR0l3jBenp7Q2TY4nEbf7SvGOGjNvKSummV/o06PIP
         9pvsW9V4wrD7ewVAQj14pUFkMJSYf1GFXrm5FVpyE3uAH7lYpHYt4tq/OOXTtDIHhill
         /PsA==
X-Gm-Message-State: AOAM5302eipbLE1abZPBCjfX2OqHCobH1S17QvfFFmzcDv+Y/C9xKAVw
        oHIDzBXFVslT07Qb72Y1RzO/VduVWnce/BQ5Ci8=
X-Google-Smtp-Source: ABdhPJy7QconJtlnVT5IV6PNTNYgzhds96/3IvjMCfVIVS/uTVhUiW+FB+GrAvZLIN3HX71zcm5X12GGe75CEBtOdLA=
X-Received: by 2002:a05:6602:1689:: with SMTP id s9mr9079201iow.171.1614972178707;
 Fri, 05 Mar 2021 11:22:58 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
 <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
 <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
 <20210301155321.GA1490228@rowland.harvard.edu> <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu> <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
In-Reply-To: <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Mar 2021 20:22:22 +0100
Message-ID: <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 8:05 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Mar 5, 2021 at 5:07 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Mar 05, 2021 at 01:09:16PM +0100, Sedat Dilek wrote:
> > > On Mon, Mar 1, 2021 at 4:53 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > [ ... ]
> > > > You can use usbmon on bus 4 to record the USB traffic.  It may indicate
> > > > why the resets occur.
> > > >
> > >
> > > Hi Alan,
> > >
> > > I followed the instructions in [1].
> > >
> > > root# modprobe -v usbmon
> > >
> > > root# ls /sys/kernel/debug/usb/usbmon
> > > 0s  0u  1s  1t  1u  2s  2t  2u  3s  3t  3u  4s  4t  4u
> > >
> > > root# cat /sys/kernel/debug/usb/usbmon/4u > /tmp/usbmon-log_4u.txt
> > > [ Ctrl+C ]
> > >
> > > I recorded 13:03 - 13:04 (one minute).
> > >
> > > So these xhci-resets should be included:
> > >
> > > [Fri Mar  5 13:03:07 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > > number 2 using xhci_hcd
> > > [Fri Mar  5 13:03:07 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > > number 2 using xhci_hcd
> > > [Fri Mar  5 13:03:27 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > > number 2 using xhci_hcd
> > > [Fri Mar  5 13:03:27 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > > number 2 using xhci_hcd
> > > [Fri Mar  5 13:03:27 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > > number 2 using xhci_hcd
> > > [Fri Mar  5 13:03:28 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > > number 2 using xhci_hcd
> > > [Fri Mar  5 13:03:28 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > > number 2 using xhci_hcd
> > >
> > > The usbmon-log is attached.
> > >
> > > Unsure how to interpret the log - the kernel-doc says `raw data`.
> > > How can I bring this into a human-readable format?
> > > Can you give me a hand?
> >
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
>
> I have not rebooted yet.
>
> Interferences with PowerTop?
>
> These xhci-resets happen every 10mins in a sequence of 4.
>
> I have here a powertop.service (systemd) with passing --auto-tune option.
> That was not a problem with previous Linux-kernels >= v5.12-rc1, so.
>
> Alan, what do you think?
>

The quirks match:

[Fri Mar  5 20:06:56 2021] usb-storage 4-1:1.0: USB Mass Storage device detected
[Fri Mar  5 20:06:56 2021] usb-storage 4-1:1.0: Quirks match for vid
174c pid 55aa: 400000

That seems not to be the trick:

root# LC_ALL=C dmesg -T | grep 'usb 4-1:'
[Fri Mar  5 20:06:55 2021] usb 4-1: new SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:55 2021] usb 4-1: New USB device found,
idVendor=174c, idProduct=55aa, bcdDevice= 1.00
[Fri Mar  5 20:06:55 2021] usb 4-1: New USB device strings: Mfr=2,
Product=3, SerialNumber=1
[Fri Mar  5 20:06:55 2021] usb 4-1: Product: MEDION HDDrive-n-GO
[Fri Mar  5 20:06:55 2021] usb 4-1: Manufacturer: MEDION
[Fri Mar  5 20:06:55 2021] usb 4-1: SerialNumber: 3180000000000000092C
[Fri Mar  5 20:06:57 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:57 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:57 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:06:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:28 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:30 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:37 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:37 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:38 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:39 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:39 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:39 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:46 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:47 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:48 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:49 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:52 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:52 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:52 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:52 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:53 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:53 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:54 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:54 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:55 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:55 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:55 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:55 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:56 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:56 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:07:56 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:09:09 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:17:56 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:17:56 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:17:56 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:17:57 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar  5 20:17:57 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd

- Sedat -
