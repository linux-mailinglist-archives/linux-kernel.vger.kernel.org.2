Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E844B32F408
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCETiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhCETiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:38:03 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3510BC06175F;
        Fri,  5 Mar 2021 11:38:03 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id f20so3203381ioo.10;
        Fri, 05 Mar 2021 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=uSeN0qARe+XbbdeZaAL1eJ+yCD+ekoKA0Dc7Yo6zN5w=;
        b=M41o+BmIaooe+W4rMoeQ+HaqRyWpUSThR3xvCrxRlD/OAp4DIPkq4qPN0i3+pYSJ2v
         PpdXFXHL/gd1rfq/BcqH7AD50kypqwN/ENgPGu9AzAn5c3DNmHw8ypkgwNcnt/2WC0LR
         0dGV74V3LV+dzyAkc00mNgpq4MtIEFkZLAbrj4CIlOlH6LKHoZa9WMNnq8CMxA6OkhGt
         oGz6OhDfXP8XtcgdnM79r18sp+torko5CANFfdgX6VkrfthIK9xunGve487tuOfqlvrq
         jORQ7yPLhF7gwrQH06mdZhUrKL4yh0MudV9l/bm8UBI8PI0OiuzNuLwnrLmr7ZxM+wN0
         2TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=uSeN0qARe+XbbdeZaAL1eJ+yCD+ekoKA0Dc7Yo6zN5w=;
        b=CWFp8n4etLSXzyLVJTXdqb4Ja7XqyMQULL2faWlmwD7uDrO5kyUoSQmquKFQy/kPE4
         6jqwrev/vwwcEzQ5VtucFkeg5C7RNl+7cOV+rWf0MN5Lo1NC+FAxGIbXUpKmfk73XFTS
         Rf+Yt0tM564MlDITRBoF6aFkeU7543wfweDBpuLchOGn6KjMKkOar2Tu18JXq1IISzyA
         CD39tUW8CZbS5rOzVWfdiG9aeh26II8TT4NE1J3UdK8Ckl+L29WsW3LEODkc4lpfhSGl
         M5RDTuoXFUNvj8hud9iwhE7EJOUhkRG5+ng5BVhSvZberj+kWHOh9l+1lEkRuAC9PLCv
         L7hg==
X-Gm-Message-State: AOAM530ffBCyaKeIrF/LO0krWvnlBluMR/7ajyyOs+L9P6K+epHq8WBT
        9AUhCWVlFB1fcTfjUSlOEOpa5ZmxKPL/YG3LMxOE79g4ktBXqg==
X-Google-Smtp-Source: ABdhPJw43U41KDxv++eRasVeLJLj+li2ayAGf9kbxqF/JfG9yodVO5ht7BTlXjQF1NVSzWgLY2LBYZjbHtUh3pNOosI=
X-Received: by 2002:a6b:c401:: with SMTP id y1mr9642378ioa.110.1614973082624;
 Fri, 05 Mar 2021 11:38:02 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
 <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
 <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
 <20210301155321.GA1490228@rowland.harvard.edu> <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu> <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
 <20210305192529.GD48113@rowland.harvard.edu>
In-Reply-To: <20210305192529.GD48113@rowland.harvard.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Mar 2021 20:37:26 +0100
Message-ID: <CA+icZUXHnc-Qd9NhwxFx3+LQakNTWmS_RRYsTAY8-gO8wc219Q@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 8:25 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Mar 05, 2021 at 08:05:49PM +0100, Sedat Dilek wrote:
> > On Fri, Mar 5, 2021 at 5:07 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> > > Don't worry about trying to decode the output.  To me it looks like the
> > > drive crashes and needs to be reset at times when the computer sends it
> > > an ATA command.  (Not all ATA commands, but some.)  You can prevent this
> > > by setting the following module parameter for the usb-storage driver:
> > >
> > >         quirks=174c:55aa:t
> > >
> > > where the two numbers are the Vendor and Product IDs for the external
> > > drive, and the 't' is a quirks flag saying not to use any ATA commands.
> > > If this module parameter fixes the problem, we can add a permanent quirk
> > > setting to the kernel.
> > >
> >
> > Thanks Alan.
> >
> > I did:
> >
> > [ /etc/modules-load.d/usb-storage.conf ]
> >
> > # Add quirks for ATA commands for usb-storage devices connected to
> > ASMedia M1042 USB-3.0 controller
> > options usb-storage quirks=174c:55aa:t
> > - EOF -
> >
> > It is:
> >
> > /lib/modules/5.12.0-rc1-11-amd64-clang13-cfi/kernel/drivers/usb/storage/usb-storage.ko
> >
> > But:
> >
> > root# lsmod | grep usb | grep storage
> > usb_storage            90112  2 uas
> > scsi_mod              307200  6 sd_mod,usb_storage,uas,libata,sg,sr_mod
> > usbcore               385024  14
> > usbserial,xhci_hcd,ehci_pci,usbnet,usbhid,usb_storage,usb_wwan,uvcvideo,ehci_hcd,btusb,xhci_pci,cdc_ether,uas,option
>
> I don't understand.  What is the point of this listing?
>

I was confused about lsmod and modinfo output:
usb-storage.ko (kernel-module name) VS. usb_storage (modinfo: name: usb_storage)

> > I have not rebooted yet.
>
> Depending on how your system is set up, the new usb-storage.conf file
> might need to be copied into the initramfs image.
>

That seems not to be needed.

> However, you don't need to reload the driver module or reboot.  To make
> the new quirk take effect, all you have to do is write 174c:55aa:t to
> /sys/module/usb_storage/parameters/quirks.
>

OK, keep this for next USB(mon) testings before doing a reboot.

> > Interferences with PowerTop?
>
> Maybe.  It's entirely possible that PowerTop or some other program is
> issuing the troublesome ATA commands.
>
> > These xhci-resets happen every 10mins in a sequence of 4.
> >
> > I have here a powertop.service (systemd) with passing --auto-tune option.
> > That was not a problem with previous Linux-kernels >= v5.12-rc1, so.
> >
> > Alan, what do you think?
>
> Try turning the service off and see if that makes any difference.
>

NO, it is not powertop.service causing the xhci-resets.

- Sedat -
