Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA8339432
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhCLRDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhCLRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:02:34 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98180C061574;
        Fri, 12 Mar 2021 09:02:34 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 81so26426255iou.11;
        Fri, 12 Mar 2021 09:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rggnoA7Zg2ZHJQcaswe9io+pxtT+wuQR4iSmKul57nI=;
        b=UkcxH+B8XsuAgeIIH0Pc1wjmRBiBlfW2223eDZFv6jXSxY4NjvkZLVTwqfik6lua7n
         zPiGBg88UbDNRsjD3SiIeNY6Me5SMF9yLXyjyqT7aDHoYbVKmiQJ0YJ/QMoDmLIPiKc8
         tA5IR2rMj1hKfGVBsfbx9I0dyiRZ+zvwUiOJKTZyOcXjQ55XJQneibIO26ZVZnW7/Qh2
         TiAdFrDrjS1XTXqGsIRwipVbhXQUHxXMteSik2pk2b3IotU9zqTq/5VJJE/+d2dy5D49
         dqFKeFrUyzuTjWgUrQfS+4CLWhZc9cqTm+OTL1Kg1YlsRYbAIlQAWt37xNoNmSqwnWAp
         qyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rggnoA7Zg2ZHJQcaswe9io+pxtT+wuQR4iSmKul57nI=;
        b=ZnCN9YGrCWUabuUnta5OfNNSB1ex9ffFwGbWd3bRZrv4bo2FcoP9sd0+RFpj3UAXoL
         kd1ef2RLvsTqUt9RyWk3WwvREjFKlNfN8g+o2jhtdOzjKMHkwG3PyIqD7aQaWY2+ykB4
         PS4Xnw2tcGJAPYRTywLTgc5SxjhCHJbPpwhNe72fbgKmgkCehzmVBPyuEZ/PlDPDfshX
         MBHEjSnjlXs+3V0MYB6vfGb93VQRKOACkzk2owDk3I8neyovCh6CQ3xJQlLANRlh6J+m
         JKWPWvOvsfqQjU+IwhWgw5hKXWVyqBSiGNtXbiIcz1eVv2NQyHYBveFf2CsIlksWfnIl
         XUxw==
X-Gm-Message-State: AOAM531mu6nsmjGQ5ncZtFHOTxp9yg32e5ZCX66SsroCx5o8/OP5mGLV
        mb5lZrmbFYaCf/sZYTgU+PK90KQDnk9mjrK4XQQ=
X-Google-Smtp-Source: ABdhPJziqVOOgD6Js7T2ETpSuJxPMBT1DNnNJlktIvsoso4JAGK/Cb0yUlwV1LCuXD6HVG6XVbtIUeaUfcCte3Nouv0=
X-Received: by 2002:a05:6602:1689:: with SMTP id s9mr124552iow.171.1615568553829;
 Fri, 12 Mar 2021 09:02:33 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu> <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
 <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com>
 <20210306165808.GD74411@rowland.harvard.edu> <CA+icZUWXBtOo+7TBGHFA=aKBs5o9hy3Po6NM0EPssu6y4SOZsQ@mail.gmail.com>
 <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com>
 <CA+icZUUyNQN_CEwJcTY887GOeWknz4h29b+XdY0FqUKVJD7cfQ@mail.gmail.com>
 <20210307154645.GA103559@rowland.harvard.edu> <CA+icZUVLC7=-MsXeGQOrAe1emzGW2UwWYxh3EHGPhjR=chygoQ@mail.gmail.com>
 <20210307170702.GB104554@rowland.harvard.edu> <CA+icZUWaGt2k4kdV0JHqKUkB8DySqdeUgVNnVT1BUo8aveGZOw@mail.gmail.com>
In-Reply-To: <CA+icZUWaGt2k4kdV0JHqKUkB8DySqdeUgVNnVT1BUo8aveGZOw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 12 Mar 2021 18:01:57 +0100
Message-ID: <CA+icZUWb40r1MTFYk9S0h2XgGfqCQtxpm9yHKNr3PDnDbUNBKQ@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 5:57 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Mar 7, 2021 at 6:07 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Sun, Mar 07, 2021 at 05:57:39PM +0100, Sedat Dilek wrote:
> > > On Sun, Mar 7, 2021 at 4:46 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Sat, Mar 06, 2021 at 09:49:00PM +0100, Sedat Dilek wrote:
> > > >
> > > > > For testing purposes, I stopped these systemd services:
> > > > >
> > > > > 1. systemctl stop smartmontools.service
> > > > >
> > > > > 2. systemctl stop udisks2.service
> > > > >
> > > > > Last seen xhci-reset:
> > > > >
> > > > > [Sat Mar  6 21:37:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > >
> > > > > So, that every 10min xhci-reset was caused by pool-udisksd from udisks2.service.
> > > >
> > > > You have found the cause of your problem!  Great!
> > > >
> > > > And now, obviously order to fix the problem, you'll have to look into
> > > > the udisks2 service.  Maybe you can configure it so that it won't send
> > > > the problem-causing commands.
> > > >
> > >
> > > I tried yesterday to add --debug option to the ExexStart line of
> > > udisks2.service, but did not see anything helpful.
> > >
> > > There exist more user-space than udisks2 causing these xhci-resets.
> > > The cmd#s are also clear: A1 and 85 - whatever they mean.
> >
> > Those are the two prefixes which indicate an ATA command is present.
> > You can find them listed as ATA_12 and ATA_16 in
> > include/scsi/scsi_proto.h.
> >
> > > As said with Linux v5.10.y and Linux v5.11 I have not seen this.
> >
> > Have you tried setting the quirk flag we discussed earlier _and_ turning
> > off udisks2?  Maybe also turning off the other services which generate
> > these commands?  Perhaps you'll find that when the quirk flag is
> > present, some of those programs _don't_ generate any ATA commands.
> >
>
> I passed as a kernel-command-line parameter: usb-storage.quirks=174c:55aa:t
>
> dmesg says:
>
> [Fri Mar 12 17:25:33 2021] usb-storage 4-1:1.0: Quirks match for vid
> 174c pid 55aa: 2400000
>
> Without that parameter (there is an existing Quirks for my ASMedia USB
> 3.0 controller in the kernel-sources):
>
> [Fri Mar 12 11:49:03 2021] usb-storage 4-1:1.0: Quirks match for vid
> 174c pid 55aa: 400000
>
> NOTE: 2400000 (new) VS. 400000 (old)
>
> The parameter is really active:
>
> root# cat /sys/module/usb_storage/parameters/quirks
> 174c:55aa:t
>
> The total number of xhci-resets is reduced:
>
> root# LC_ALL=C dmesg -T | egrep 'usb 4-1: reset SuperSpeed Gen 1 USB
> device number 2 using xhci_hcd' | wc -l
> 24
>
> Together with your diff, I see in dmesg now:
>
> # LC_ALL=C dmesg -T | egrep 'reset|SCSI ioctl error'
> [Fri Mar 12 17:25:32 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 17:25:32 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 17:25:33 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:33 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:33 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:34 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:34 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:34 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:34 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:34 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:35 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:35 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:35 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:35 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:36 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:36 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:36 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 17:25:36 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:36 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:37 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:37 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:37 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:37 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:37 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:38 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:38 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:38 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar 12 17:25:58 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 17:25:58 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 17:26:03 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:03 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:03 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:03 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:03 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:03 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:03 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 17:26:05 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 17:26:06 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 17:26:06 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 17:26:06 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 17:26:06 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 17:26:06 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 17:26:06 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 17:26:06 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 17:26:07 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 17:26:07 2021] SCSI ioctl error, cmd 85, prog smartd
> [Fri Mar 12 17:26:13 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 17:26:13 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 17:26:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:13 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Fri Mar 12 17:26:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:14 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:14 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Fri Mar 12 17:26:18 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:18 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:18 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:18 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:18 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:18 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:18 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:18 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:18 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:18 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:23 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:23 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:23 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:23 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:26:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:26:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:26:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:26:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:26:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:26:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:26:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:26:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:26:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:26:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:27:37 2021] SCSI ioctl error, cmd 85, prog smartctl
> [Fri Mar 12 17:27:37 2021] SCSI ioctl error, cmd 85, prog smartctl
> [Fri Mar 12 17:27:39 2021] SCSI ioctl error, cmd 85, prog smartctl
> [Fri Mar 12 17:27:40 2021] SCSI ioctl error, cmd 85, prog smartctl
> [Fri Mar 12 17:36:23 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:36:23 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:36:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:36:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:36:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:36:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:36:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:36:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:36:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:36:24 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:33 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:38:34 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:40:57 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:40:58 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:40:58 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:40:58 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:40:58 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Fri Mar 12 17:40:58 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
>
> So, the quirk you recommended seems to silence the xhci-resets -
> passed as a kernel-command-line parameter.
>
> Furthermore, I tried via:
>
> #1: /etc/modules-load.d/usb-storage.conf
> options usb-storage quirks=174c:55aa:t
>
> Should this be with a dot than a space?
> options usb-storage.quirks=174c:55aa:t
>

Grrr, space is right - I need to do an update-initramfs.

- Sedat -

> #2: echo '174c:55aa:t' > /sys/module/usb_storage/parameters/quirks
> ...after system was booted into
>
> Both had no effect.
>
> After 31mins of uptime I still see above 24 xhci-resets.
>
> I have attached my linux-config and full dmesg-log.
>
> - Sedat -
