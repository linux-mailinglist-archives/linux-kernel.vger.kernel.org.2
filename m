Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F7E32FD52
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 22:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCFVCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 16:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCFVCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 16:02:38 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FBDC06174A;
        Sat,  6 Mar 2021 13:02:37 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e2so5389408ilu.0;
        Sat, 06 Mar 2021 13:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=DXlTYLsEmDnH/uv1r3MR/WOT/dnfqtcNLCVDIOP38R4=;
        b=LzBxbRyiWvQ/HP1SmHb+PYvfqN5gqqrwa//RYCP1ylNgPH+p3t+zoQPYBTZsgz6/VV
         JboXJzXPDcyYEC2WxPpZRcxsaLh0F/LbpoxmbfyN1cqvJi1ejWsTf91WJWhy9+Rs5Peq
         Rk+AIhZPCi9v/If4+TREJ6uyM3GS9oJhqgTcxKQit0YQmDzGuOWwJpANj2ttOZmZn2sd
         OzR/g5FsT9PwMo3fBg2rs+vgWh50Cg8ryJMexSQ/ZS6f0GijmPnHSGafVCiAtamu2Rot
         jT83rTMrOo2RwrrU9qQb2DxiHyWuDgtwQC4uY1hqz6kv7GWdxJCTLnhbGLTrqe+zdIhe
         0EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DXlTYLsEmDnH/uv1r3MR/WOT/dnfqtcNLCVDIOP38R4=;
        b=Yje/SNH4pFzZ98WaJ7UnSurLthRK8NAnZnYicoRPZNaKjMet2wLuxWWeZJohoaviMx
         FhhDX/qsQjj7zgFdVyEBw+uoYNYZleoLQPAPbmr7zdMfevpjRE2cjI9JqjLUlEn75X6C
         Dwo53VK//vVOq/lxUOKqF2mBb57TY8/aQqtFk84bbjTQ0TmuGRyMLG/8McBE6y7sm+h/
         x/uuImpZYP/d9XSx3D0Ag8QKOMQBnEE7rzAFQqzv/uQRS7k33e8CdXHCg4B899YRt5Aw
         V9F19IwZon0ixQpFUkc9pGDV+FPzykfnXpY0YOHy3G59TbEORnwxEKqObzbTBTClAqsW
         6Tpw==
X-Gm-Message-State: AOAM532MZJG6Cn2TlXrCz6brlsQS+iTAFSHvUMAAibBD8eZ4GDua2Iz6
        yCziASAdoYHiEugUUTYjfFOW/sUzf/03FlF913w=
X-Google-Smtp-Source: ABdhPJzwAfKdYbQwQxAiGTjTebczd9frKY+U8yvsMJf2zN9/b4GKSEbzbnHSkHVNamgmqVTP1uxBkaOLYqHUherL0EM=
X-Received: by 2002:a92:ce84:: with SMTP id r4mr13947003ilo.112.1615064557104;
 Sat, 06 Mar 2021 13:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20210301155321.GA1490228@rowland.harvard.edu> <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu> <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
 <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
 <20210305193003.GE48113@rowland.harvard.edu> <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu> <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
 <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com>
 <20210306165808.GD74411@rowland.harvard.edu> <CA+icZUWXBtOo+7TBGHFA=aKBs5o9hy3Po6NM0EPssu6y4SOZsQ@mail.gmail.com>
 <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com>
 <CA+icZUUyNQN_CEwJcTY887GOeWknz4h29b+XdY0FqUKVJD7cfQ@mail.gmail.com> <CA+icZUUY2duV5UdDzKZrFEqOJZ5xhFi_tjdeWK+=r62JogT1YQ@mail.gmail.com>
In-Reply-To: <CA+icZUUY2duV5UdDzKZrFEqOJZ5xhFi_tjdeWK+=r62JogT1YQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Mar 2021 22:02:00 +0100
Message-ID: <CA+icZUWh_Jx0v2o1t9X7QsEO0-25TZ3UeRue3rSF4y9O2mswvw@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 9:56 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Mar 6, 2021 at 9:49 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Sat, Mar 6, 2021 at 9:38 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Sat, Mar 6, 2021 at 9:26 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Sat, Mar 6, 2021 at 5:58 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > >
> > > > > On Sat, Mar 06, 2021 at 07:42:30AM +0100, Sedat Dilek wrote:
> > > > > > No, with Debian-Kernel 5.10.19-1 there are no xhci-resets:
> > > > >
> > > > > Is the kernel the only thing that is different?  The rest of the
> > > > > operating system and environment is exactly the same?
> > > > >
> > > > > > But I see there is already a quirk enabled and matches my ASmedia USB
> > > > > > 3.0 controller (as I have *no* usb-storage-quirks enabled):
> > > > > >
> > > > > > root# LC_ALL=C dmesg -T | grep -i quirks | egrep '174c|55aa'
> > > > > > [Sat Mar  6 06:52:41 2021] usb-storage 4-1:1.0: Quirks match for vid
> > > > > > 174c pid 55aa: 400000
> > > > >
> > > > > Yes, this is because that type of device already has a quirk entry built
> > > > > into the kernel.  You can find it by searching for "174c" in the kernel
> > > > > source file drivers/usb/storage/unusual_devs.h.
> > > > >
> > > > > > Thanks Alan for all the hints and tips in the topic "usb-storage and
> > > > > > quirks" and your patience.
> > > > >
> > > > > You can try building a 5.11 kernel with the patch below.  I don't know
> > > > > whether it will show anything in the dmesg log when one of these resets
> > > > > occurs, but it might.
> > > > >
> > > > > If that doesn't work out, another possibility is to use git bisect to
> > > > > find the commit between 5.10 and 5.11 which caused the problem to start.
> > > > >
> > > > > Alan Stern
> > > > >
> > > > >
> > > > > --- usb-devel.orig/block/scsi_ioctl.c
> > > > > +++ usb-devel/block/scsi_ioctl.c
> > > > > @@ -258,8 +258,11 @@ static int blk_complete_sghdr_rq(struct
> > > > >         hdr->host_status = host_byte(req->result);
> > > > >         hdr->driver_status = driver_byte(req->result);
> > > > >         hdr->info = 0;
> > > > > -       if (hdr->masked_status || hdr->host_status || hdr->driver_status)
> > > > > +       if (hdr->masked_status || hdr->host_status || hdr->driver_status) {
> > > > >                 hdr->info |= SG_INFO_CHECK;
> > > > > +               printk(KERN_INFO "SCSI ioctl error, cmd %02X, prog %s\n",
> > > > > +                               req->cmd[0], current->comm);
> > > > > +       }
> > > > >         hdr->resid = req->resid_len;
> > > > >         hdr->sb_len_wr = 0;
> > > > >
> > > > >
> > > >
> > > > Thanks for the diff, Alan.
> > > >
> > > > With an adapted version to fit Linux v5.12-rc2 (see attachment) I see:
> > > >
> > > > root@iniza:~# LC_ALL=C dmesg -T | grep 'SCSI ioctl error'
> > > > [Sat Mar  6 21:16:42 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > > [Sat Mar  6 21:16:42 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > > [Sat Mar  6 21:16:45 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > > [Sat Mar  6 21:17:07 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > > [Sat Mar  6 21:17:07 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > > [Sat Mar  6 21:17:12 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > > [Sat Mar  6 21:17:12 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > > [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > > [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > > [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > > [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:15 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:16 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:19 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:19 2021] SCSI ioctl error, cmd 85, prog smartd
> > > > [Sat Mar  6 21:17:21 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > > [Sat Mar  6 21:17:21 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd A1, prog ata_id
> > > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > > [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:30 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:30 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:34 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog udisksd
> > > > [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > > > [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > > > [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> > > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > > > [Sat Mar  6 21:18:55 2021] SCSI ioctl error, cmd 85, prog smartctl
> > > > [Sat Mar  6 21:18:56 2021] SCSI ioctl error, cmd 85, prog smartctl
> > > > [Sat Mar  6 21:18:56 2021] SCSI ioctl error, cmd 85, prog smartctl
> > > >
> > > > My linux-config and full dmesg-log are attached.
> > > >
> > >
> > > Checking dmesg again...
> > >
> > > So, this is pool-udisksd (cmd A1 and 85) and smartctl (cmd 85) causing
> > > regular xhci-resets.
> > >
> > > SCSI ioctl error, cmd 85, prog smartctl
> > >
> > > SCSI ioctl error, cmd A1, prog pool-udisksd
> > > SCSI ioctl error, cmd 85, prog pool-udisksd
> > >
> >
> > For testing purposes, I stopped these systemd services:
> >
> > 1. systemctl stop smartmontools.service
> >
> > 2. systemctl stop udisks2.service
> >
> > Last seen xhci-reset:
> >
> > [Sat Mar  6 21:37:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> >
> > So, that every 10min xhci-reset was caused by pool-udisksd from udisks2.service.
> >
>
> These are the user-space programs:
>
> root@iniza:~# LC_ALL=C dmesg -T | grep 'SCSI ioctl error' | awk '{
> print $11 " " $12 }' | sort -u
> prog ata_id
> prog hdparm
> prog pool-udisksd
> prog smartctl
> prog smartd
> prog udisksd
>
> These are cmd #:
>
> root@iniza:~# LC_ALL=C dmesg -T | grep 'SCSI ioctl error' | awk '{
> print $9 " " $10 }' | sort -u
> cmd 85,
> cmd A1,
>

The combined list of cmd # and prog name might be more helpful:

root@iniza:~# LC_ALL=C dmesg -T | grep 'SCSI ioctl error' | awk '{
print $9 " " $10 " " $11 " " $12 }' | sort -u
cmd 85, prog hdparm
cmd 85, prog pool-udisksd
cmd 85, prog smartctl
cmd 85, prog smartd
cmd 85, prog udisksd
cmd A1, prog ata_id
cmd A1, prog pool-udisksd

- Sedat -
