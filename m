Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C0B33966B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhCLS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhCLS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:27:08 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9780FC061574;
        Fri, 12 Mar 2021 10:27:08 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id k2so26768120ioh.5;
        Fri, 12 Mar 2021 10:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=vHEf0wZ0jz5+lCXJ7lMvh0dC6aHiwnMz1z2L6kOepkQ=;
        b=BQmtGDIdoNLOcCSF5FHxHKUSEclAV8bg79BaU7SknyTVqbUwUjVYxHh0HzRtZ0t1Cw
         /2SYLjcaIDrBCCqLD/yFx6vI5S2ib95l6z6lSSORG2oJCmQRfSYJ0vU5C8LcNnr+nSen
         xgYYkVNFuGpWmdMSc3VQmhTrmxUlrYkrnAqS7C2o+01pYSYvRiEZ4vMSOKRoKzx/ZECw
         6eaWRATpOclsCRMIjgsv3oxmS8gzbN1sTNNqwjhUrGCWPT929L0KRuUlVlT+b4uiTOqW
         kuYnI0MZLCjmoGeXVQ++WA7YGQDT98uzjEqts5YsuaNKNqIBRDOCQ9U2/1qj3P6IFe4m
         LNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=vHEf0wZ0jz5+lCXJ7lMvh0dC6aHiwnMz1z2L6kOepkQ=;
        b=Nivb+HimAdjcnLyVXttk3JHjIOmJdJwSI5ViYm+I41PcXjxYRsbGpuSzZzYIpQ8eoX
         atEYANamIpR+GdG65JIZ9XbKsKY4awOrcECDB9FbXj0f7DXxW8SjjuN6NmhNqx2WEd2r
         yxrJcCxNQEfMnQ4ArCblDqcH22doNgJ9NNIQFdNhzx3krZpeclh53X6XzjHHb4l22d+n
         77EXaZKoQXwoV5mWnzRJk3Nso7Sf0panLFOZE0VYuTWgaz66SHJlCIASewZoBTC4QTzz
         5IvhgtIKe72rs1PobTqs0bs5cNCn5KoOtNtoaJhvKIUWqOigK3vsmX/tIGFpEA3x4o7G
         HIoA==
X-Gm-Message-State: AOAM530GzRCUy9hr6Aln5OI8FTMrDasmjdAci61xXZEw1iKfclko0q6T
        pw1/7P9XV+r6YBgdLQrgRXHrv3q8n9gnRvc06YE=
X-Google-Smtp-Source: ABdhPJzkBZ2csNpTFtWY2Dsun4bUlsJllw9veIVysuvlW36bA0tbYjilQMN+zqpYJJjaUwWv0qvUNR3r0htCzA+DxSU=
X-Received: by 2002:a02:9a0a:: with SMTP id b10mr553035jal.132.1615573627927;
 Fri, 12 Mar 2021 10:27:07 -0800 (PST)
MIME-Version: 1.0
References: <20210306165808.GD74411@rowland.harvard.edu> <CA+icZUWXBtOo+7TBGHFA=aKBs5o9hy3Po6NM0EPssu6y4SOZsQ@mail.gmail.com>
 <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com>
 <CA+icZUUyNQN_CEwJcTY887GOeWknz4h29b+XdY0FqUKVJD7cfQ@mail.gmail.com>
 <20210307154645.GA103559@rowland.harvard.edu> <CA+icZUVLC7=-MsXeGQOrAe1emzGW2UwWYxh3EHGPhjR=chygoQ@mail.gmail.com>
 <20210307170702.GB104554@rowland.harvard.edu> <CA+icZUWaGt2k4kdV0JHqKUkB8DySqdeUgVNnVT1BUo8aveGZOw@mail.gmail.com>
 <CA+icZUWb40r1MTFYk9S0h2XgGfqCQtxpm9yHKNr3PDnDbUNBKQ@mail.gmail.com>
 <CA+icZUXkheVR-c9cdsJmeS9+FZj4Gswii+xBoAWK882QNdfcTg@mail.gmail.com> <20210312180523.GB302347@rowland.harvard.edu>
In-Reply-To: <20210312180523.GB302347@rowland.harvard.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 12 Mar 2021 19:26:31 +0100
Message-ID: <CA+icZUUysAE0fwDL2iDKsCgY=AfckOtAEi+86kkVEs0Lqc-Jkg@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 7:05 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Mar 12, 2021 at 06:41:58PM +0100, Sedat Dilek wrote:
> > OK, now for the records:
> >
> > [ /etc/modprobe.d/usb-storage.conf  ]
> >
> > # Add quirks for USB Mass Storage devices
> > #
> > # Link: https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
> > #
> > # Option #1: Use Kernel command line parameter
> > # [1] Usage: usb-storage.quirks=<VID:PID:Flags>
> > # [2] VendorID (VID) and ProductID (PID):
> > #     ASMedia M1042 USB-3.0 controller: VID: 174c PID: 55aa
> > # [3] Flags:
> > #     t = NO_ATA_1X  (don't allow ATA(12) and ATA(16) commands, uas only);
> > #     u = IGNORE_UAS (don't bind to the uas driver);
> > # [4] Example: usb-storage.quirks=174c:55aa:t
> > #
> > # Option #2: Set quirk via sysfs
> > # DEBUG: echo '174c:55aa:t' > /sys/module/usb_storage/parameters/quirks
> > #
> > # Option #3: Pass options via /etc/modprobe.d/usb-storage.conf (this file here)
> > # XXX: Do NOT forget to run `update-initramfs` command!
> > options usb-storage quirks=174c:55aa:t
> > - EOF -
> >
> > With generating a new /boot/initrd.img via `update-initramfs` this
> > looks good to me:
> >
> > root# LC_ALL=C dmesg -T | egrep -i 'quirks|reset|SCSI ioctl error'
> > [Fri Mar 12 18:25:56 2021] xhci_hcd 0000:03:00.0: hcc params
> > 0x0200f180 hci version 0x96 quirks 0x0000000000080000
> > [Fri Mar 12 18:25:57 2021] usb-storage 4-1:1.0: Quirks match for vid
> > 174c pid 55aa: 2400000
> > [Fri Mar 12 18:25:57 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Fri Mar 12 18:25:57 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Fri Mar 12 18:25:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:25:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:25:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:01 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:03 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:03 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:03 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar 12 18:26:24 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Fri Mar 12 18:26:24 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Fri Mar 12 18:26:29 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Fri Mar 12 18:26:39 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Fri Mar 12 18:26:39 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Fri Mar 12 18:26:43 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:43 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:28:09 2021] SCSI ioctl error, cmd 85, prog smartctl
> > [Fri Mar 12 18:28:09 2021] SCSI ioctl error, cmd 85, prog smartctl
> > [Fri Mar 12 18:28:10 2021] SCSI ioctl error, cmd 85, prog smartctl
> > [Fri Mar 12 18:28:11 2021] SCSI ioctl error, cmd 85, prog smartctl
> > [Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
>
> Although it's not conclusive, this log seems to indicate that ata_id
> is the only program causing resets.  Have you tried preventing the
> ata_id program from running (for example, by renaming it)?
>

This is /lib/udev/ata_id from Debian's udev package.

> > Your diff now should say; s/SCSI ioctl error/SCSI ioctl info'.
>
> No, it shouldn't.  The log message itself is an info, but the event it
> reports is an error.
>

OK.
Some of these SCSI ioctl errors are not causing a xhci-reset.

> > Alan, so "t" flags should be added as a quirks to linux-kernel sources...
> >
> > t = NO_ATA_1X  (don't allow ATA(12) and ATA(16) commands, uas only);
> >
> > ...for my ASMedia USB-3.0 controller?
>
> That's not at all clear.  This is a very common and popular device,
> and nobody else has reported these problems.  It could be that
> something is odd about your particular drive or computer, not these
> drives in general.
>

So, the external USB-3.0 HDD is now in "UAS only" mode/status.

Cannot judge if things got better or not.

- Sedat -
