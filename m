Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87432F8A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 07:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhCFGnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 01:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhCFGnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 01:43:08 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7ACC06175F;
        Fri,  5 Mar 2021 22:43:08 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id g27so4453780iox.2;
        Fri, 05 Mar 2021 22:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=cR4EbAaWsK1GhD4zwAYNBpo68gZvVfEMYU6ng3H7RUI=;
        b=qAY+V1E8haZkuzHKPYVNf4y6Nzkt2u01XC6fPWqY44vcuxUYY9iYLQR36ekmHG+nNt
         T7UOab6Qud0ilumiHfi9T2sRvL5QwbTNj9SW87bv0eQuxoqv68qjTZy4c5ngiFfVTca8
         +va6W6G2AsRxG9UkKZTnd19w7sKzQxSLI2II6Xqt+NIF23zxcC2+LZndwJZIJGWzd1L1
         BqfCFuGJWMHG9EHLnWIihcDlOkvrG6fM4HcZWvWIqhLbwAvv7pn06QrqYNWAuwIQh7kY
         PRDKfxgG92mcP0ScUB7mX4hEXHNXdPV5s5mFRz+YafSA7BDuGLHqw5mi0za58E3PAfi5
         kS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=cR4EbAaWsK1GhD4zwAYNBpo68gZvVfEMYU6ng3H7RUI=;
        b=Pu1NKMDitnfesGr7wRBr5yrhOZsBR03r82EUITb/w25UjhwmkJOQQwNfnUnXR7+JS8
         sLb0Pjdtc9dAwBGyHYFhEeHpun9fZj/jvvGMRgS5T2bTG8sF4r7mCvp/DSz8sx59moLp
         zjMtTQq7tCm2xtBzlgmuUsv/fFv5LYWTTVgO1+bVbJbSfwhPSaT4lMJgpeB8Lt/mJ436
         bYZk9FAk1bDm4UA/Ah9sEco+T7aG1yQBsDCUq64kSsOQ1k/0DjCvLacAcnESZvXNGfMy
         qSqRHZz6sJuBwzClWyzxkN0eNmVtcwmQIJWeFXd7NAMj+SmDDkXH5uAtarN/gJZfBZpD
         muIQ==
X-Gm-Message-State: AOAM530twjlGfDRFR6IYNOxLQNp7qYZJWtB6h7ngMF8P4ZSxfYK1v4/y
        EDgfLrqnDtrZvCpVi/waLIF7FmyC0khI2OmEw84z20SOiXiqQw==
X-Google-Smtp-Source: ABdhPJxcH/ZCHstIyWtf4aYTvkpce8iVUFFHV0p0cD/2BhMVcmkQKUMTnXjaobQ2Buw3cw40D5Rl8io5gUZcv6OFgLs=
X-Received: by 2002:a05:6638:635:: with SMTP id h21mr13265011jar.97.1615012987132;
 Fri, 05 Mar 2021 22:43:07 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
 <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
 <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
 <20210301155321.GA1490228@rowland.harvard.edu> <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu> <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
 <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
 <20210305193003.GE48113@rowland.harvard.edu> <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu> <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
In-Reply-To: <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Mar 2021 07:42:30 +0100
Message-ID: <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 8:54 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Mar 5, 2021 at 8:47 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Mar 05, 2021 at 08:41:40PM +0100, Sedat Dilek wrote:
> > > On Fri, Mar 5, 2021 at 8:30 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > > > Okay, that indicates the ATA commands are being sent not by the kernel
> > > > but by some program.  I'm not sure how you can easily find out which
> > > > program; probably the best thing to do is turn them off one by one until
> > > > you find the one responsible.
> > > >
> > >
> > > I can hardly imagine which user-space tools other than powertop can
> > > interfere here.
> > > Any ideas?
> >
> > No.  Especially since I have no idea what programs are running on your
> > computer.
> >
>
> Are we talking about things like gvfs - udisks - fuse etc.?
> All running via systemd here.
>
> Here I am using KDE/Plasma as DE.
> Unsure if this runs apps in the background.
>
> AFAICS I have not seen xhci-resets with Debian-Kernel 5.10.19-1.
>

No, with Debian-Kernel 5.10.19-1 there are no xhci-resets:

root# cat /proc/version
Linux version 5.10.0-4-amd64 (debian-kernel@lists.debian.org) (gcc-10
(Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian)
2.35.2) #1 SMP Debian 5.10.19-1 (2021-03-02)

root# LC_ALL=C dmesg -T | grep xhci | grep reset
[ empty ]

But I see there is already a quirk enabled and matches my ASmedia USB
3.0 controller (as I have *no* usb-storage-quirks enabled):

root# LC_ALL=C dmesg -T | grep -i quirks | egrep '174c|55aa'
[Sat Mar  6 06:52:41 2021] usb-storage 4-1:1.0: Quirks match for vid
174c pid 55aa: 400000

For the sake of completeness my latest /etc/modules-load.d/usb-storage.conf:

# Add quirks for USB Mass Storage devices
#
# Link: https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
#
# usb-storage quirks kernel-parameters and options explained:
# [1] Usage: usb-storage.quirks=<VID:PID:Flags>
# [2] VendorID (VID) and ProductID (PID):
#     ASMedia M1042 USB-3.0 controller: VID: 174c PID: 55aa
# [3] Flags:
#     t = NO_ATA_1X  (don't allow ATA(12) and ATA(16) commands, uas only);
#     u = IGNORE_UAS (don't bind to the uas driver);
# [4] Example: usb-storage.quirks=174c:55aa:t
#
# DEBUG: echo '174c:55aa:t' > /sys/module/usb_storage/parameters/quirks
#
# XXX: Commented - xhci-resets NOT caused by the Linux-kernel (check user-space)
#options usb-storage quirks=174c:55aa:t
- EOF -

Thanks Alan for all the hints and tips in the topic "usb-storage and
quirks" and your patience.

- Sedat -
