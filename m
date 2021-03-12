Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0938339541
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhCLRms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhCLRmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:42:37 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185DBC061574;
        Fri, 12 Mar 2021 09:42:37 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id g27so26607688iox.2;
        Fri, 12 Mar 2021 09:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2BpBKC6amLfVKktHpaa9KFseSm9F+CF9ejShdCoo9Lk=;
        b=RNVUMyfRaM22EyZhJqGc2FjFtG24jh/dlA99EZpkj2QIeuA5wmzDD7Uw3tQHvweJ0h
         diyu8oUY5Kxnug0/6dSK/dBW9aAqoxs5T/Ri5mqc7dpcNZP07p3HVWWzVDh++7pwG2gz
         NAnFoOmKAwCpZaplKrfWdlHenxNMulCdehrhf11wymFTYW0aRAennY2Jtyq8SZVAu8iR
         Lj98au0NlnvFvS9i2pU2QMvpcOctjcLAzLRJD1+nzr6m/8sZTOyKcHgXvHx7n4wLS4oe
         00ELcuZeYxwp5QIstQLMzE42/C+wL1+F2jJU8krQkEsysRceflowC+0Pbf90/f1WCL0k
         xkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2BpBKC6amLfVKktHpaa9KFseSm9F+CF9ejShdCoo9Lk=;
        b=aqFKw54p4bfXzskJ8RnLXj4Yv7V8VsFAUFakQs60+nlB5Gjnu+T2nwAPUF6CHljraN
         8GoI5kLZrssrA5cKXTd5HKr6o+HOJQtgtYi36c+xm2xTUacEhV6wh4fawpQqPyNHrYIn
         lI6YPL+RzeZa+0U+SP2MmYfWnnOUYpVoHWaP8XQIsbwXvW1jDB1HO+eYZH0pLsG1gED1
         cQf20icQOsJGSPQwxGhZ/EJAmQnUROdrotPTsBLmQx0x2SK9aThkvAxWIZ2pJBmfOSnj
         U9fvTIbuV4DfWu/xFC6QPzLcHOi5QswjSsqs09FduSxXwILbuO4+j1Gzrd8C7cEWoXQD
         WJtQ==
X-Gm-Message-State: AOAM533YsEleVCWPundQeMBQuGHXd3ORvO6GiIyI8i6HNB6YMZgemKQc
        nLcWGcAOMB1fnXIurViAqBdZsO5p3qSEAW3q4hP9uTrAK8eC+g==
X-Google-Smtp-Source: ABdhPJyZs5tkHkT6iAbmuJzaJs8b6g/jN6Hv8IE0YuC3erSgi9DEOUXbGhc7CLCi5/lXeSqaV1gM6NDU9VwmsH1le7Y=
X-Received: by 2002:a5d:9d13:: with SMTP id j19mr302189ioj.110.1615570956506;
 Fri, 12 Mar 2021 09:42:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu> <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
 <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com>
 <20210306165808.GD74411@rowland.harvard.edu> <CA+icZUWXBtOo+7TBGHFA=aKBs5o9hy3Po6NM0EPssu6y4SOZsQ@mail.gmail.com>
 <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com>
 <CA+icZUUyNQN_CEwJcTY887GOeWknz4h29b+XdY0FqUKVJD7cfQ@mail.gmail.com>
 <20210307154645.GA103559@rowland.harvard.edu> <CA+icZUVLC7=-MsXeGQOrAe1emzGW2UwWYxh3EHGPhjR=chygoQ@mail.gmail.com>
 <20210307170702.GB104554@rowland.harvard.edu> <CA+icZUWaGt2k4kdV0JHqKUkB8DySqdeUgVNnVT1BUo8aveGZOw@mail.gmail.com>
 <CA+icZUWb40r1MTFYk9S0h2XgGfqCQtxpm9yHKNr3PDnDbUNBKQ@mail.gmail.com>
In-Reply-To: <CA+icZUWb40r1MTFYk9S0h2XgGfqCQtxpm9yHKNr3PDnDbUNBKQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 12 Mar 2021 18:41:58 +0100
Message-ID: <CA+icZUXkheVR-c9cdsJmeS9+FZj4Gswii+xBoAWK882QNdfcTg@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, now for the records:

[ /etc/modprobe.d/usb-storage.conf  ]

# Add quirks for USB Mass Storage devices
#
# Link: https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
#
# Option #1: Use Kernel command line parameter
# [1] Usage: usb-storage.quirks=<VID:PID:Flags>
# [2] VendorID (VID) and ProductID (PID):
#     ASMedia M1042 USB-3.0 controller: VID: 174c PID: 55aa
# [3] Flags:
#     t = NO_ATA_1X  (don't allow ATA(12) and ATA(16) commands, uas only);
#     u = IGNORE_UAS (don't bind to the uas driver);
# [4] Example: usb-storage.quirks=174c:55aa:t
#
# Option #2: Set quirk via sysfs
# DEBUG: echo '174c:55aa:t' > /sys/module/usb_storage/parameters/quirks
#
# Option #3: Pass options via /etc/modprobe.d/usb-storage.conf (this file here)
# XXX: Do NOT forget to run `update-initramfs` command!
options usb-storage quirks=174c:55aa:t
- EOF -

With generating a new /boot/initrd.img via `update-initramfs` this
looks good to me:

root# LC_ALL=C dmesg -T | egrep -i 'quirks|reset|SCSI ioctl error'
[Fri Mar 12 18:25:56 2021] xhci_hcd 0000:03:00.0: hcc params
0x0200f180 hci version 0x96 quirks 0x0000000000080000
[Fri Mar 12 18:25:57 2021] usb-storage 4-1:1.0: Quirks match for vid
174c pid 55aa: 2400000
[Fri Mar 12 18:25:57 2021] SCSI ioctl error, cmd A1, prog ata_id
[Fri Mar 12 18:25:57 2021] SCSI ioctl error, cmd A1, prog ata_id
[Fri Mar 12 18:25:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:25:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:25:58 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:25:59 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:00 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:01 2021] SCSI ioctl error, cmd A1, prog ata_id
[Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:01 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:02 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:03 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:03 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:03 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
number 2 using xhci_hcd
[Fri Mar 12 18:26:24 2021] SCSI ioctl error, cmd A1, prog ata_id
[Fri Mar 12 18:26:24 2021] SCSI ioctl error, cmd A1, prog ata_id
[Fri Mar 12 18:26:29 2021] SCSI ioctl error, cmd 85, prog smartd
[Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd A1, prog ata_id
[Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog smartd
[Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog smartd
[Fri Mar 12 18:26:30 2021] SCSI ioctl error, cmd 85, prog smartd
[Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
[Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
[Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
[Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
[Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
[Fri Mar 12 18:26:31 2021] SCSI ioctl error, cmd 85, prog smartd
[Fri Mar 12 18:26:39 2021] SCSI ioctl error, cmd A1, prog ata_id
[Fri Mar 12 18:26:39 2021] SCSI ioctl error, cmd A1, prog ata_id
[Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd A1, prog ata_id
[Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:40 2021] SCSI ioctl error, cmd 85, prog hdparm
[Fri Mar 12 18:26:43 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:43 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:44 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:49 2021] SCSI ioctl error, cmd 85, prog udisksd
[Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:26:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:28:09 2021] SCSI ioctl error, cmd 85, prog smartctl
[Fri Mar 12 18:28:09 2021] SCSI ioctl error, cmd 85, prog smartctl
[Fri Mar 12 18:28:10 2021] SCSI ioctl error, cmd 85, prog smartctl
[Fri Mar 12 18:28:11 2021] SCSI ioctl error, cmd 85, prog smartctl
[Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:36:49 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
[Fri Mar 12 18:36:50 2021] SCSI ioctl error, cmd 85, prog pool-udisksd

Your diff now should say; s/SCSI ioctl error/SCSI ioctl info'.

Alan, so "t" flags should be added as a quirks to linux-kernel sources...

t = NO_ATA_1X  (don't allow ATA(12) and ATA(16) commands, uas only);

...for my ASMedia USB-3.0 controller?

- Sedat -
