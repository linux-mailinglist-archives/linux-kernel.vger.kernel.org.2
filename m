Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7B32FD40
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCFUtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhCFUth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:49:37 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11AC06174A;
        Sat,  6 Mar 2021 12:49:37 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id f10so5326513ilq.5;
        Sat, 06 Mar 2021 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=gYA+WJ4WVcv8FZuTwrQy2FiwhoIwq3DTgYcrRDglwek=;
        b=hMSP85QYooAEXKPAa3yAd5issJ1J8kAlN77+1NiI3e7fR/FrtTL1AvtqB5CK0m2F2p
         cvmPoU3rskQ6eF8nbbH1DVWjkVtHk/YodqkX1X1S4bm/83FkPb+Dy/03h0Uhd7PXGfV4
         3sfpU5QQrNHhtwqk/h/pRejo+XGszs8ha1PWFYyB+fk77jJqlBXn/g2JPcrkpJFpHCYM
         KK1a/PLxKYkIn0zwraTHkwqKK1vhoTSzGnbyGIhuSL40YMqbRgrqSTGpRumh5fyJQUeH
         NqCAV6lhEunPLDvMxck/sA1aYLHAM8M0TSg44yEHWxXddcuev1Yrsk1jN9GQAcp0qqHX
         ty1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=gYA+WJ4WVcv8FZuTwrQy2FiwhoIwq3DTgYcrRDglwek=;
        b=fI65EIgKYWJ0AoFz8OSC1yzamuZvvTppyE4gwEAFchWozhRYT98M1GdOGuLoYzoBEV
         xYQGwKsMI6omBXssY7cHrGoktT6e7Mq4n/Psid9lU0aCtwM3cNtXNxjE21YqtDcyrFUx
         tMZOwlR3vYC+tMFjF3ug66WmE0QzPIBC0HjXKb5fqt9VmYSS1cwNdT2K0tOeLRgXcCyM
         ocllh/dYuGIGOVcWolodY+9oa9p5IDlFnAlhYXzNVela8czgi1RfvVEpHqJRqm+UrgEi
         uRBqerk1qsmFbrfCCVRX/Roi2fvgYcKPpnPjVJ62SUSatKPAUc3EacFbz392QfyzrdbG
         2xJA==
X-Gm-Message-State: AOAM532sY9grkgkn4kfhjlgWZsQfWd3+yNaY6gcGY95OeIHdJuvk7vwo
        e38gsyD2B/PMq+lRjD23jtnqb0PqifB00DfsNu0=
X-Google-Smtp-Source: ABdhPJwy/RXhRthUVOdLAGWmeWNY+GQvyNjKmUOsamq41V10yUFN0jisip6gIS1JR6btQRXU5Y9Kj3iCmasBInoSYUA=
X-Received: by 2002:a05:6e02:13a6:: with SMTP id h6mr14936154ilo.10.1615063776946;
 Sat, 06 Mar 2021 12:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20210301155321.GA1490228@rowland.harvard.edu> <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu> <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
 <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
 <20210305193003.GE48113@rowland.harvard.edu> <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu> <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
 <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com>
 <20210306165808.GD74411@rowland.harvard.edu> <CA+icZUWXBtOo+7TBGHFA=aKBs5o9hy3Po6NM0EPssu6y4SOZsQ@mail.gmail.com>
 <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com>
In-Reply-To: <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Mar 2021 21:49:00 +0100
Message-ID: <CA+icZUUyNQN_CEwJcTY887GOeWknz4h29b+XdY0FqUKVJD7cfQ@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 9:38 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Mar 6, 2021 at 9:26 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Sat, Mar 6, 2021 at 5:58 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Sat, Mar 06, 2021 at 07:42:30AM +0100, Sedat Dilek wrote:
> > > > No, with Debian-Kernel 5.10.19-1 there are no xhci-resets:
> > >
> > > Is the kernel the only thing that is different?  The rest of the
> > > operating system and environment is exactly the same?
> > >
> > > > But I see there is already a quirk enabled and matches my ASmedia USB
> > > > 3.0 controller (as I have *no* usb-storage-quirks enabled):
> > > >
> > > > root# LC_ALL=C dmesg -T | grep -i quirks | egrep '174c|55aa'
> > > > [Sat Mar  6 06:52:41 2021] usb-storage 4-1:1.0: Quirks match for vid
> > > > 174c pid 55aa: 400000
> > >
> > > Yes, this is because that type of device already has a quirk entry built
> > > into the kernel.  You can find it by searching for "174c" in the kernel
> > > source file drivers/usb/storage/unusual_devs.h.
> > >
> > > > Thanks Alan for all the hints and tips in the topic "usb-storage and
> > > > quirks" and your patience.
> > >
> > > You can try building a 5.11 kernel with the patch below.  I don't know
> > > whether it will show anything in the dmesg log when one of these resets
> > > occurs, but it might.
> > >
> > > If that doesn't work out, another possibility is to use git bisect to
> > > find the commit between 5.10 and 5.11 which caused the problem to start.
> > >
> > > Alan Stern
> > >
> > >
> > > --- usb-devel.orig/block/scsi_ioctl.c
> > > +++ usb-devel/block/scsi_ioctl.c
> > > @@ -258,8 +258,11 @@ static int blk_complete_sghdr_rq(struct
> > >         hdr->host_status = host_byte(req->result);
> > >         hdr->driver_status = driver_byte(req->result);
> > >         hdr->info = 0;
> > > -       if (hdr->masked_status || hdr->host_status || hdr->driver_status)
> > > +       if (hdr->masked_status || hdr->host_status || hdr->driver_status) {
> > >                 hdr->info |= SG_INFO_CHECK;
> > > +               printk(KERN_INFO "SCSI ioctl error, cmd %02X, prog %s\n",
> > > +                               req->cmd[0], current->comm);
> > > +       }
> > >         hdr->resid = req->resid_len;
> > >         hdr->sb_len_wr = 0;
> > >
> > >
> >
> > Thanks for the diff, Alan.
> >
> > With an adapted version to fit Linux v5.12-rc2 (see attachment) I see:
> >
> > root@iniza:~# LC_ALL=C dmesg -T | grep 'SCSI ioctl error'
> > [Sat Mar  6 21:16:42 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Sat Mar  6 21:16:42 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Sat Mar  6 21:16:45 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Sat Mar  6 21:17:07 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Sat Mar  6 21:17:07 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Sat Mar  6 21:17:12 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Sat Mar  6 21:17:12 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:15 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:16 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:19 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:19 2021] SCSI ioctl error, cmd 85, prog smartd
> > [Sat Mar  6 21:17:21 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Sat Mar  6 21:17:21 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd A1, prog ata_id
> > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:30 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:30 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:34 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog udisksd
> > [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > [Sat Mar  6 21:18:55 2021] SCSI ioctl error, cmd 85, prog smartctl
> > [Sat Mar  6 21:18:56 2021] SCSI ioctl error, cmd 85, prog smartctl
> > [Sat Mar  6 21:18:56 2021] SCSI ioctl error, cmd 85, prog smartctl
> >
> > My linux-config and full dmesg-log are attached.
> >
>
> Checking dmesg again...
>
> So, this is pool-udisksd (cmd A1 and 85) and smartctl (cmd 85) causing
> regular xhci-resets.
>
> SCSI ioctl error, cmd 85, prog smartctl
>
> SCSI ioctl error, cmd A1, prog pool-udisksd
> SCSI ioctl error, cmd 85, prog pool-udisksd
>

For testing purposes, I stopped these systemd services:

1. systemctl stop smartmontools.service

2. systemctl stop udisks2.service

Last seen xhci-reset:

[Sat Mar  6 21:37:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd

So, that every 10min xhci-reset was caused by pool-udisksd from udisks2.service.

- Sedat -
