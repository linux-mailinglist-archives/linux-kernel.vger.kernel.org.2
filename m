Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9552D32F374
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhCETG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCETGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:06:25 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440AC061574;
        Fri,  5 Mar 2021 11:06:25 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z13so3121092iox.8;
        Fri, 05 Mar 2021 11:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ephVPlQPJmmPgwhZ2BDumy4J7FYaDt1vhPn9UDOeoJo=;
        b=kojJFOK8wEx+Qt0aJW+eosn5VciYXvhfgX7yNDY76O61WB28CtLFCegC5mXJnPupea
         4tC1hE5pd+2gzZ2O1oqu8C8KxO+BI8qRjqFtbhUvvk8/46XDZOW7BkcLw9VaKPzjYfju
         jgJUbcYqFdZRQ8C5J/QrB6qT2/L+FPVkq9qR4vjcEt//m2dQW/ezz4jf18LOsOtgyb2P
         yn4mLiUTdgWY7yCy/2LETIg1Cnt/xpRjp/t6ShJ+JahHSeWjCBfeHLjdj1+lZBQdLR6P
         mAHBTpgbQzJN9rr2Aw2rEP851YTtQLXqOMHJXXB7fhiFF9+JvSKaXwWY7R0NSiy6fw1q
         Qwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ephVPlQPJmmPgwhZ2BDumy4J7FYaDt1vhPn9UDOeoJo=;
        b=V1rLD8DS1h4j+kb0RzLnzJEWGfu0tAOVis4hNLovW3XnOQoTd4EHW7qt9U9m3kPCTi
         IkXnTVweMth7MH/vfHImXXmAOaqRRVGH/3lzecKb3XOIt1VBwDE5ywZ24jwas19lES1H
         PW74M8Uw1LVHo7Gvt29TA8Bm2w8C787D9wmK3CZ5ND4Z82haCIZ8sjom9MQQW/GjY1M5
         0GgZ2WHMbngWWXXeR84qqVgTle9pq5Zf0jIomea6S9VdyFIay86DHOKRQZTCOu1g/VK8
         5S+iE/+ZjWCqWU/KDWzO8rXqc/axIxqtAuGK6PoVXfuvrbz6flzDZukPgEwQXWlQVZtS
         DcKQ==
X-Gm-Message-State: AOAM532GnkGMhkaxmBCzC8ni+ZYOhDv3zJsNzorOJA546shVhtNd5UgT
        xGTyRn92hmvoU5G2hyIoa/kRp7AI1I5DFWhY1+L16+COB7nI7w==
X-Google-Smtp-Source: ABdhPJzKdMf1mIFrNmr97CtuPmXnIqCEzovVEwqThK1uBKchst6MkQlpqyIFkZrOUZzZP5fVGWprg8vJpiXN5fFL/YU=
X-Received: by 2002:a02:7822:: with SMTP id p34mr11371391jac.65.1614971185085;
 Fri, 05 Mar 2021 11:06:25 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
 <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
 <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
 <20210301155321.GA1490228@rowland.harvard.edu> <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu>
In-Reply-To: <20210305160728.GE38200@rowland.harvard.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Mar 2021 20:05:49 +0100
Message-ID: <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 5:07 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Mar 05, 2021 at 01:09:16PM +0100, Sedat Dilek wrote:
> > On Mon, Mar 1, 2021 at 4:53 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > [ ... ]
> > > You can use usbmon on bus 4 to record the USB traffic.  It may indicate
> > > why the resets occur.
> > >
> >
> > Hi Alan,
> >
> > I followed the instructions in [1].
> >
> > root# modprobe -v usbmon
> >
> > root# ls /sys/kernel/debug/usb/usbmon
> > 0s  0u  1s  1t  1u  2s  2t  2u  3s  3t  3u  4s  4t  4u
> >
> > root# cat /sys/kernel/debug/usb/usbmon/4u > /tmp/usbmon-log_4u.txt
> > [ Ctrl+C ]
> >
> > I recorded 13:03 - 13:04 (one minute).
> >
> > So these xhci-resets should be included:
> >
> > [Fri Mar  5 13:03:07 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar  5 13:03:07 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar  5 13:03:27 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar  5 13:03:27 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar  5 13:03:27 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar  5 13:03:28 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar  5 13:03:28 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> >
> > The usbmon-log is attached.
> >
> > Unsure how to interpret the log - the kernel-doc says `raw data`.
> > How can I bring this into a human-readable format?
> > Can you give me a hand?
>
> Don't worry about trying to decode the output.  To me it looks like the
> drive crashes and needs to be reset at times when the computer sends it
> an ATA command.  (Not all ATA commands, but some.)  You can prevent this
> by setting the following module parameter for the usb-storage driver:
>
>         quirks=174c:55aa:t
>
> where the two numbers are the Vendor and Product IDs for the external
> drive, and the 't' is a quirks flag saying not to use any ATA commands.
> If this module parameter fixes the problem, we can add a permanent quirk
> setting to the kernel.
>

Thanks Alan.

I did:

[ /etc/modules-load.d/usb-storage.conf ]

# Add quirks for ATA commands for usb-storage devices connected to
ASMedia M1042 USB-3.0 controller
options usb-storage quirks=174c:55aa:t
- EOF -

It is:

/lib/modules/5.12.0-rc1-11-amd64-clang13-cfi/kernel/drivers/usb/storage/usb-storage.ko

But:

root# lsmod | grep usb | grep storage
usb_storage            90112  2 uas
scsi_mod              307200  6 sd_mod,usb_storage,uas,libata,sg,sr_mod
usbcore               385024  14
usbserial,xhci_hcd,ehci_pci,usbnet,usbhid,usb_storage,usb_wwan,uvcvideo,ehci_hcd,btusb,xhci_pci,cdc_ether,uas,option

I have not rebooted yet.

Interferences with PowerTop?

These xhci-resets happen every 10mins in a sequence of 4.

I have here a powertop.service (systemd) with passing --auto-tune option.
That was not a problem with previous Linux-kernels >= v5.12-rc1, so.

Alan, what do you think?

- Sedat -
