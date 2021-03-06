Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E6932FD31
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhCFUjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCFUiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:38:52 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D464C06174A;
        Sat,  6 Mar 2021 12:38:52 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id d5so5316620iln.6;
        Sat, 06 Mar 2021 12:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=QyhZhhyCKzCTzQTQrak6BPr24chz1Q/z60GqPQNGxv8=;
        b=CFaDEzMvMflwW2NS2IlYegNNGCSw8/FkGYACoMzPNz3JMbAc6VlCYwaTsrLJnhFXWM
         QLuH9cWNun8mJQqf6co8V74Y24GUyleEe/Y1qAIkLE926E2qPEF1PJEg0YoOt4sjWt1x
         PXN7ristt5+8amStc63nfO4MKQRLIhJRonaUpG4dIcXeChkMy7fHjjuzWjqZZlHCVxvb
         OF4Gd8guRfU+q18gOcpIY+0UzRhqfgixdi5HNRiH+ko7uvInb3kpu3NhsHLlehQIFPBA
         B+PX70/VtKY57fuJ/24GyvbtlWTcPxsKxPmQUBkP1bJXVfG6rqzuxkHN8iLpb6qd3P9j
         /Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=QyhZhhyCKzCTzQTQrak6BPr24chz1Q/z60GqPQNGxv8=;
        b=JcjH2yBlPGjFDvswsK0dBbVk2H9Ep5LAs+HnCdPalXfGWNZwYF1lfpWmsmqnAC9XHq
         ES7HZ8ro9gNQZcLmlM8/870QvgL0MRzu7WgJyUt6iBMHaj320xOsF45r513mP8u/JU7s
         avIA6rzznF4bBWieQDWTQlgrEW/jRlLrr+tmRd6RfhRUCLyBFjatz7WKdy/0KJJrYLQB
         5u/SPMMMGWf4TVO8M+Jdvp7Kcx5ZH6znyGNDV5CZ4wbX08aYSIaBAwQ11/XnyAQQbbHT
         /DJxu53uWTHqArHDPYkktmdTWEUl8/hM4EVu/KkECB25U48xkMQI1gzwtFytxM0ZQukC
         EXhg==
X-Gm-Message-State: AOAM533RSoiGuzmpZv2qawCKspTuuNklLlByNICAS8t2x5veDU0AeeU/
        ieEtgaHhnYF5wamT09Sh71oUYLTcMz3ywgtRw0lT1AzuJ2ZxMw==
X-Google-Smtp-Source: ABdhPJxRRuEDbdoZ/3RyY4N83HyWJXqfR6cC3oK3vTOk1VE2RW+ze8B4j2lISnHtXa5f7lonpx2A5vRnL0OTRaOm7qw=
X-Received: by 2002:a92:c145:: with SMTP id b5mr13634241ilh.186.1615063131944;
 Sat, 06 Mar 2021 12:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20210301155321.GA1490228@rowland.harvard.edu> <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu> <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
 <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
 <20210305193003.GE48113@rowland.harvard.edu> <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu> <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
 <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com>
 <20210306165808.GD74411@rowland.harvard.edu> <CA+icZUWXBtOo+7TBGHFA=aKBs5o9hy3Po6NM0EPssu6y4SOZsQ@mail.gmail.com>
In-Reply-To: <CA+icZUWXBtOo+7TBGHFA=aKBs5o9hy3Po6NM0EPssu6y4SOZsQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Mar 2021 21:38:15 +0100
Message-ID: <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 9:26 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Mar 6, 2021 at 5:58 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Sat, Mar 06, 2021 at 07:42:30AM +0100, Sedat Dilek wrote:
> > > No, with Debian-Kernel 5.10.19-1 there are no xhci-resets:
> >
> > Is the kernel the only thing that is different?  The rest of the
> > operating system and environment is exactly the same?
> >
> > > But I see there is already a quirk enabled and matches my ASmedia USB
> > > 3.0 controller (as I have *no* usb-storage-quirks enabled):
> > >
> > > root# LC_ALL=C dmesg -T | grep -i quirks | egrep '174c|55aa'
> > > [Sat Mar  6 06:52:41 2021] usb-storage 4-1:1.0: Quirks match for vid
> > > 174c pid 55aa: 400000
> >
> > Yes, this is because that type of device already has a quirk entry built
> > into the kernel.  You can find it by searching for "174c" in the kernel
> > source file drivers/usb/storage/unusual_devs.h.
> >
> > > Thanks Alan for all the hints and tips in the topic "usb-storage and
> > > quirks" and your patience.
> >
> > You can try building a 5.11 kernel with the patch below.  I don't know
> > whether it will show anything in the dmesg log when one of these resets
> > occurs, but it might.
> >
> > If that doesn't work out, another possibility is to use git bisect to
> > find the commit between 5.10 and 5.11 which caused the problem to start.
> >
> > Alan Stern
> >
> >
> > --- usb-devel.orig/block/scsi_ioctl.c
> > +++ usb-devel/block/scsi_ioctl.c
> > @@ -258,8 +258,11 @@ static int blk_complete_sghdr_rq(struct
> >         hdr->host_status = host_byte(req->result);
> >         hdr->driver_status = driver_byte(req->result);
> >         hdr->info = 0;
> > -       if (hdr->masked_status || hdr->host_status || hdr->driver_status)
> > +       if (hdr->masked_status || hdr->host_status || hdr->driver_status) {
> >                 hdr->info |= SG_INFO_CHECK;
> > +               printk(KERN_INFO "SCSI ioctl error, cmd %02X, prog %s\n",
> > +                               req->cmd[0], current->comm);
> > +       }
> >         hdr->resid = req->resid_len;
> >         hdr->sb_len_wr = 0;
> >
> >
>
> Thanks for the diff, Alan.
>
> With an adapted version to fit Linux v5.12-rc2 (see attachment) I see:
>
> root@iniza:~# LC_ALL=C dmesg -T | grep 'SCSI ioctl error'
> [Sat Mar  6 21:16:42 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Sat Mar  6 21:16:42 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Sat Mar  6 21:16:45 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Sat Mar  6 21:17:07 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Sat Mar  6 21:17:07 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Sat Mar  6 21:17:12 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Sat Mar  6 21:17:12 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Sat Mar  6 21:17:13 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Sat Mar  6 21:17:14 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:15 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:16 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:18 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:19 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:19 2021] SCSI ioctl error, cmd 85, prog smartd
> [Sat Mar  6 21:17:21 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Sat Mar  6 21:17:21 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd A1, prog ata_id
> [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Sat Mar  6 21:17:22 2021] SCSI ioctl error, cmd 85, prog hdparm
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:28 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:30 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:30 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:34 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:35 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:36 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:37 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Sat Mar  6 21:17:38 2021] SCSI ioctl error, cmd 85, prog udisksd
> [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> [Sat Mar  6 21:17:39 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd A1, prog pool-udisksd
> [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Sat Mar  6 21:17:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> [Sat Mar  6 21:18:55 2021] SCSI ioctl error, cmd 85, prog smartctl
> [Sat Mar  6 21:18:56 2021] SCSI ioctl error, cmd 85, prog smartctl
> [Sat Mar  6 21:18:56 2021] SCSI ioctl error, cmd 85, prog smartctl
>
> My linux-config and full dmesg-log are attached.
>

Checking dmesg again...

So, this is pool-udisksd (cmd A1 and 85) and smartctl (cmd 85) causing
regular xhci-resets.

SCSI ioctl error, cmd 85, prog smartctl

SCSI ioctl error, cmd A1, prog pool-udisksd
SCSI ioctl error, cmd 85, prog pool-udisksd

- Sedat -
