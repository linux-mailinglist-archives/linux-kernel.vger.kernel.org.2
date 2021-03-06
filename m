Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0356632FCCA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhCFTbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhCFTbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:31:04 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D967C06174A;
        Sat,  6 Mar 2021 11:31:04 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e2so5263444ilu.0;
        Sat, 06 Mar 2021 11:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2lh9+dUR8kVgvf+4hcHiRqiDmfQ8HmE46F/fM16hxVQ=;
        b=bav/D0rcQqutO1YZNXtcpUEzITsezhHmyAfADOF+++WKuQxQVBA34z8fcIhihZmlD6
         rXtm2gxPinRBx2kAQed40SzlUic/YDWn31hhStdl6q15wOODx+BwTAgNlfvGsLXDpMPR
         TodaalRuO6R0nQ0RQvCySe/9fDEXEg/GrOuAPW11Zq0eRRHn472n1+1dXiBkt8kC8Qws
         b7X7tNmOhioEXDlS7RBFGISeD7Qz9VANwz/2CNcdbvnPrChkxqAaeoswiDjqmuHldpAm
         FLCLhcsY0YN98AB6FQ3y4MA/IiB7sUkmvDmAwJdS+fU6+kFOJtAsQ2LUP0gIhfREa5RS
         KHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2lh9+dUR8kVgvf+4hcHiRqiDmfQ8HmE46F/fM16hxVQ=;
        b=g1qzbMrnk6pTQi0VBLWsnq1y5YmbqgtkZzMC7flpMVOyrmNqMVmLz/PpV8DCG5t9pu
         iYHLl+FOakgV0y3JVC+c3d/KfDnztCtrG8W9pdhnLXZJFN5+8kGIMrZN4C4UmAjFK123
         DluVVdyfpkiureyPNXXw6XhzqezP8hjaNCaDc1ygr14Izz0ctB87qZqA+rzrK9slY6uw
         UWb29RoUNzdD5ADCmlMzDKOBavDInvQW8qpClUqJB2XAO/G5NMH7TlUvqSRA7Zjnndki
         /GjXaR76SNuWma9cpPdBJdZB2+Z+feCqI2to+SvKF8ZBjdzWNNi0hVzdp9WOGZ3xsf7V
         qr+A==
X-Gm-Message-State: AOAM533gGXHbtSBrlwfJCWo/n+4pR9IuBLGHicaMwVhXT/uQHfuxNNyh
        d38tDeaMDMm/IvfBR0rMK6quZ6VkfnsyWtnz1cAL47ypUHI=
X-Google-Smtp-Source: ABdhPJxMNTytnXFRmnFIxWtt/BY1W0K+wRvlHPyORrPVvzw6j47ot6IMx+h4E2WngpcUCWgNWEl7kFAchkVqv36u+sE=
X-Received: by 2002:a05:6e02:13a6:: with SMTP id h6mr14773241ilo.10.1615059063453;
 Sat, 06 Mar 2021 11:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20210301155321.GA1490228@rowland.harvard.edu> <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu> <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
 <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
 <20210305193003.GE48113@rowland.harvard.edu> <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu> <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
 <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com> <20210306165808.GD74411@rowland.harvard.edu>
In-Reply-To: <20210306165808.GD74411@rowland.harvard.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Mar 2021 20:30:27 +0100
Message-ID: <CA+icZUVfDvAnHucYtGC3J6OXyFAZ-c9DU0z8s6iqK_g4Y=Nckw@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 5:58 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, Mar 06, 2021 at 07:42:30AM +0100, Sedat Dilek wrote:
> > No, with Debian-Kernel 5.10.19-1 there are no xhci-resets:
>
> Is the kernel the only thing that is different?  The rest of the
> operating system and environment is exactly the same?
>

The kernel is the only change.

> > But I see there is already a quirk enabled and matches my ASmedia USB
> > 3.0 controller (as I have *no* usb-storage-quirks enabled):
> >
> > root# LC_ALL=C dmesg -T | grep -i quirks | egrep '174c|55aa'
> > [Sat Mar  6 06:52:41 2021] usb-storage 4-1:1.0: Quirks match for vid
> > 174c pid 55aa: 400000
>
> Yes, this is because that type of device already has a quirk entry built
> into the kernel.  You can find it by searching for "174c" in the kernel
> source file drivers/usb/storage/unusual_devs.h.
>

OK, will look into it.

> > Thanks Alan for all the hints and tips in the topic "usb-storage and
> > quirks" and your patience.
>
> You can try building a 5.11 kernel with the patch below.  I don't know
> whether it will show anything in the dmesg log when one of these resets
> occurs, but it might.
>
> If that doesn't work out, another possibility is to use git bisect to
> find the commit between 5.10 and 5.11 which caused the problem to start.
>

This is with Linux v5.12-rc2 - not v5.11.y.
I look if I can apply the patch.

- Sedat -

>
>
> --- usb-devel.orig/block/scsi_ioctl.c
> +++ usb-devel/block/scsi_ioctl.c
> @@ -258,8 +258,11 @@ static int blk_complete_sghdr_rq(struct
>         hdr->host_status = host_byte(req->result);
>         hdr->driver_status = driver_byte(req->result);
>         hdr->info = 0;
> -       if (hdr->masked_status || hdr->host_status || hdr->driver_status)
> +       if (hdr->masked_status || hdr->host_status || hdr->driver_status) {
>                 hdr->info |= SG_INFO_CHECK;
> +               printk(KERN_INFO "SCSI ioctl error, cmd %02X, prog %s\n",
> +                               req->cmd[0], current->comm);
> +       }
>         hdr->resid = req->resid_len;
>         hdr->sb_len_wr = 0;
>
>
