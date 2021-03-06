Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6487E32FD46
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCFU5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCFU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:57:14 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D3CC06174A;
        Sat,  6 Mar 2021 12:57:14 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id u8so5818245ior.13;
        Sat, 06 Mar 2021 12:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=PxTSOA3UGcBBEnp9AOTNsMAiPJxdF/GQhFts9dY+hQ4=;
        b=L1lxlFWnEtu26w8gz5S3bKYSP4pnTGXvQimU9RkACxfHS4Mcu2rIlf1LMbHFPhRDbe
         8t5TaBi39XU6bREfuzyt+skR/gQzlhe14aF5sMsLIkynUbwkchx4QsQkY9zNDz5t6SgO
         sNBuawrmixQ8WPxO3dEYwpBZx8VRkxF4nTZO3pknYjzIdheFoWUjEvVgfsdceJLJWJzT
         GCFR7kP67TeRBSyTRQ0ujGMzzw2Kfilbjo8tjchkXsMP5gVgNQxTK9nzLzLNC81qRd+7
         sIGtqyLQbO3oO+KhzA39Bya1ajYxRndY/qLXnFNuLNK1+5+jqiP5Bx5cpU668/oyVyRY
         lVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=PxTSOA3UGcBBEnp9AOTNsMAiPJxdF/GQhFts9dY+hQ4=;
        b=dp8zQNs6KnkERICsvkNWI7jkwkN/rEKDDLNOebxmC1uM6fp+8PLuQQFjTr/Yc+bK93
         7qc6TP93Hp1kgvv+fPaI8vqDaSbbQF4d7xTgWrhqwtgKoN/jpQgZHmITF64kgIFkvDlS
         hTA4l7WRzsiML7qfNuFAsYMO3MVsW/jRUwfDIvUmXsUHMF4LCupjw3Bec+fdwXFg9ie0
         5UMnzFRNvZv3qqsU+TFLrCqEWRfBWS4tWTi9EfclLlNMJy/pqrbHpQHfu7yrFO7k6Cu5
         X52yJEMuHpsuKKUpZf/BoXid+/sF9H0il8lf1p51r5LA2SUn/TFX6YtsIDGGhvj6WEN0
         Obtw==
X-Gm-Message-State: AOAM531taMqqkFuGdBCymlaZ1c199jwUmuVTwNx0JIwRfpNvBQsmcXSl
        F8CRlFbKloSxJIIM01cdKyKLkeVjERkV0VCSKcrPvdISKO5NLw==
X-Google-Smtp-Source: ABdhPJwn9hgvK7vuBoeZUR1hCjsewZk/cEaLQnNhKQtAhm93sr3JO5QvqN/32zVpXA9lVTm+YNrZYyEUqJhlPNC68M8=
X-Received: by 2002:a6b:d80d:: with SMTP id y13mr13269839iob.75.1615064233366;
 Sat, 06 Mar 2021 12:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20210301155321.GA1490228@rowland.harvard.edu> <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu> <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
 <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
 <20210305193003.GE48113@rowland.harvard.edu> <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu> <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
 <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com>
 <20210306165808.GD74411@rowland.harvard.edu> <CA+icZUWXBtOo+7TBGHFA=aKBs5o9hy3Po6NM0EPssu6y4SOZsQ@mail.gmail.com>
 <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com> <CA+icZUUyNQN_CEwJcTY887GOeWknz4h29b+XdY0FqUKVJD7cfQ@mail.gmail.com>
In-Reply-To: <CA+icZUUyNQN_CEwJcTY887GOeWknz4h29b+XdY0FqUKVJD7cfQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Mar 2021 21:56:36 +0100
Message-ID: <CA+icZUUY2duV5UdDzKZrFEqOJZ5xhFi_tjdeWK+=r62JogT1YQ@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 9:49 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Mar 6, 2021 at 9:38 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Sat, Mar 6, 2021 at 9:26 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Sat, Mar 6, 2021 at 5:58 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Sat, Mar 06, 2021 at 07:42:30AM +0100, Sedat Dilek wrote:
> > > > > No, with Debian-Kernel 5.10.19-1 there are no xhci-resets:
> > > >
> > > > Is the kernel the only thing that is different?  The rest of the
> > > > operating system and environment is exactly the same?
> > > >
> > > > > But I see there is already a quirk enabled and matches my ASmedia USB
> > > > > 3.0 controller (as I have *no* usb-storage-quirks enabled):
> > > > >
> > > > > root# LC_ALL=C dmesg -T | grep -i quirks | egrep '174c|55aa'
> > > > > [Sat Mar  6 06:52:41 2021] usb-storage 4-1:1.0: Quirks match for vid
> > > > > 174c pid 55aa: 400000
> > > >
> > > > Yes, this is because that type of device already has a quirk entry built
> > > > into the kernel.  You can find it by searching for "174c" in the kernel
> > > > source file drivers/usb/storage/unusual_devs.h.
> > > >
> > > > > Thanks Alan for all the hints and tips in the topic "usb-storage and
> > > > > quirks" and your patience.
> > > >
> > > > You can try building a 5.11 kernel with the patch below.  I don't know
> > > > whether it will show anything in the dmesg log when one of these resets
> > > > occurs, but it might.
> > > >
> > > > If that doesn't work out, another possibility is to use git bisect to
> > > > find the commit between 5.10 and 5.11 which caused the problem to start.
> > > >
> > > > Alan Stern
> > > >
> > > >
> > > > --- usb-devel.orig/block/scsi_ioctl.c
> > > > +++ usb-devel/block/scsi_ioctl.c
> > > > @@ -258,8 +258,11 @@ static int blk_complete_sghdr_rq(struct
> > > >         hdr->host_status = host_byte(req->result);
> > > >         hdr->driver_status = driver_byte(req->result);
> > > >         hdr->info = 0;
> > > > -       if (hdr->masked_status || hdr->host_status || hdr->driver_status)
> > > > +       if (hdr->masked_status || hdr->host_status || hdr->driver_status) {
> > > >                 hdr->info |= SG_INFO_CHECK;
> > > > +               printk(KERN_INFO "SCSI ioctl error, cmd %02X, prog %s\n",
> > > > +                               req->cmd[0], current->comm);
> > > > +       }
> > > >         hdr->resid = req->resid_len;
> > > >         hdr->sb_len_wr = 0;
> > > >
> > > >
> > >
> > > Thanks for the diff, Alan.
> > >
> > > With an adapted version to fit Linux v5.12-rc2 (see attachment) I see:
> > >
> > > root@iniza:~# LC_ALL=C dmesg -T | grep 'SCSI ioctl error'
> > > [Sat Mar  6 21:16:42 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > [Sat Mar  6 21:16:42 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > [Sat Mar  6 21:16:45 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > [Sat Mar  6 21:17:07 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > [Sat Mar  6 21:17:07 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > [Sat Mar  6 21:17:12 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > [Sat Mar  6 21:17:12 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:15 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:16 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:19 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:19 2021] SCSI ioctl error, cmd 85, prog smartd
> > > [Sat Mar  6 21:17:21 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > [Sat Mar  6 21:17:21 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:30 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:30 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:34 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > > [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > > [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > [Sat Mar  6 21:18:55 2021] SCSI ioctl error, cmd 85, prog smartctl
> > > [Sat Mar  6 21:18:56 2021] SCSI ioctl error, cmd 85, prog smartctl
> > > [Sat Mar  6 21:18:56 2021] SCSI ioctl error, cmd 85, prog smartctl
> > >
> > > My linux-config and full dmesg-log are attached.
> > >
> >
> > Checking dmesg again...
> >
> > So, this is pool-udisksd (cmd A1 and 85) and smartctl (cmd 85) causing
> > regular xhci-resets.
> >
> > SCSI ioctl error, cmd 85, prog smartctl
> >
> > SCSI ioctl error, cmd A1, prog pool-udisksd
> > SCSI ioctl error, cmd 85, prog pool-udisksd
> >
>
> For testing purposes, I stopped these systemd services:
>
> 1. systemctl stop smartmontools.service
>
> 2. systemctl stop udisks2.service
>
> Last seen xhci-reset:
>
> [Sat Mar  6 21:37:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
>
> So, that every 10min xhci-reset was caused by pool-udisksd from udisks2.service.
>

These are the user-space programs:

root@iniza:~# LC_ALL=C dmesg -T | grep 'SCSI ioctl error' | awk '{
print $11 " " $12 }' | sort -u
prog ata_id
prog hdparm
prog pool-udisksd
prog smartctl
prog smartd
prog udisksd

These are cmd #:

root@iniza:~# LC_ALL=C dmesg -T | grep 'SCSI ioctl error' | awk '{
print $9 " " $10 }' | sort -u
cmd 85,
cmd A1,

- Sedat -
