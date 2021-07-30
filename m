Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C753DC1B8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 01:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhG3Xw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 19:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhG3Xw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:52:27 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0700AC06175F;
        Fri, 30 Jul 2021 16:52:21 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r6so5094065ioj.8;
        Fri, 30 Jul 2021 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9SlRBNRJeLZxcQWjB/3maprZ3/Rp9f4KaApEdj+0kE=;
        b=kMpXt0PIFP9xCew/VJkaZEcurCt94O8fEog3OfrPYN3wD0spMykaHaBTlgtHGlxwMI
         ecIgmoTTH2jLQdxedj9CQlz5Rh9IE4dcKpLWLPbWWtb0JxN8uFgbw9qsHgXCsA5lY4pI
         tAe+e0JTvcDbDGQ7KczvTiECxsidcEirRNjtcXBY6xgCboPdulpSXQv/0mvDYihzQrcF
         w/40PlY/1AfDizLmBPsPL6pTX/bFGWQBtzlJxM8oKfwgsDyJZRqjNtq09O35hsO+20SL
         sBCwmii0/wRJJbRpFCV8RGLowK/DEBPtm0RCx2UFy5yNf5Hg0GPRtrQlwrJLuYnjlv4p
         8/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9SlRBNRJeLZxcQWjB/3maprZ3/Rp9f4KaApEdj+0kE=;
        b=DmEU0SCiu9bDSgLHf1FqKezuEk3+CpWemKFdklEH448OJT5svQzmD6mOv7RQed0Wnw
         fKDxVMympZ5B7IdUNC/GVzom0RBI8adbrsIbvE7baZGjpKkuApQy2KqdvUonpHUXIje1
         0tYpwEVXU/DY/Bfg8eCuHbvL5XSuFQjBDid3pyuhX31x5Gtzi9D8MLfFMNgNx6SeyyXR
         C35e1+d1OSZCbSYOtIKuXmctRSmlRvbJkcsrU117J+qCLo6paZ8X/X8yUDZSkZQ6YnWR
         I4Dp5lkHCMi4Ibwi18Rzq4kS8g2W0YYpz0NbAo1nVI/61/N1+xOV4NRixqv3bsqG7x3s
         NPzQ==
X-Gm-Message-State: AOAM531q89TIfw23e7RPDysj/RGVgsaN6kLUqcMWHRK4It41KsASPmVb
        nphSvhcPeXTlbRR20mBRXScrhgzjg6xgvBEmjRI=
X-Google-Smtp-Source: ABdhPJyOSr7dDiFFIRBBoOOq7nfryzH4E18nAj+pScGxyHkbGOvaI6d6Kf+UmLZVcLx2R7YWkLQqOYLykCNwQ5EXVR0=
X-Received: by 2002:a5d:9d19:: with SMTP id j25mr2011478ioj.84.1627689140477;
 Fri, 30 Jul 2021 16:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210721235526.10588-1-msbroadf@gmail.com> <7b02cb66-d672-ae95-01ea-c6015725e1ac@linuxfoundation.org>
 <CALdjXpA4_eXen6RjhsEBYt8CQs-2gzwYs9h9q0Z2LKZ=rXVp+Q@mail.gmail.com>
 <ad07410b-05d6-6a12-13df-14e31cbf50ff@linuxfoundation.org>
 <CALdjXpBPRraC8xxORgE3SXw4xFnTW-Y6rLbcS+Cx0xYq3+aBeQ@mail.gmail.com> <976d34c0-d603-1f16-edbd-ad6c8881ad4e@linuxfoundation.org>
In-Reply-To: <976d34c0-d603-1f16-edbd-ad6c8881ad4e@linuxfoundation.org>
From:   Michael <msbroadf@gmail.com>
Date:   Sat, 31 Jul 2021 09:52:09 +1000
Message-ID: <CALdjXpAzE3o7Bwdvj1TvsBRpDWDe1FZ8LsmL5q0suxYnRJCOaA@mail.gmail.com>
Subject: Re: [PATCH v2] vhci_hcd: USB port can get stuck in the disabled state
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes i think just adding the VDEV_ST_USED check in addition to the
VDEV_ST_NOT_ASSIGNED state is fine and would fix the issue.

After many years of writing virtualhere (a similar system to usb/ip
but cross-platform and different non-kernel way of doing it server
side) I've seen many drivers that issue reset at any time. Loading
firmware is usually the reason.  Also sometimes switching
configurations requires a reset also, for example some gaming wheels
do this. I don't think you should make this VDEV_ST_USED check
specific to Wifi devices, as a lot of devices don't follow too closely
to the USB protocol to begin with from my experience. They primarily
base their USB interactions assuming the windows platform and its
quirks.

On Sat, 31 Jul 2021 at 08:52, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/23/21 5:58 PM, Michael wrote:
> > Here is the lsusb on the client when the device fails to attach
> > ---------------------------------------
> > michael@ubuntu:~$ lsusb
> > Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> >
> >
> > Here is the lsusb on the host before use
> > -----------------------------------------------------
> > pi@raspberrypi:~ $ lsusb
> > Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > Bus 001 Device 003: ID 045e:02e6 Microsoft Corp. Wireless XBox Controller Dongle
> > Bus 001 Device 002: ID 2109:3431 VIA Labs, Inc. Hub
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >
>
> Sorry for the delay on this. I had to make time to do some research on
> usb_reset_device() calls from probe routines.
>
>  From what you said in another email:
>
> "The device is in the  VDEV_ST_USED state when a reset occurs and so its
> never re-enabled"
>
> Right if device is in VDEV_ST_USED state, vhci treats reset as invalid.
>
> Your commit log says:
>
> "When a remote usb device is attached to the local Virtual USB
> Host Controller Root Hub port, the bound device driver may send a
> port reset command. For example to initialize firmware (eg. btusb does this).
> This port reset command can be sent at any time, however the VHCI hcd
> root hub is only expecting reset to occur before the device receives
> SET_ADDRESS. The USB port should always be enabled after a reset
> (because the port is virtual and there is no possibility of hardware errors)"
>
> It appears btusb driver issues reset as a workaround: btusb_setup_intel()
>
>         /* The controller has a bug with the first HCI command sent to it
>           * returning number of completed commands as zero. This would stall the
>           * command processing in the Bluetooth core.
>           *
>           * As a workaround, send HCI Reset command first which will reset the
>           * number of completed commands and allow normal command processing
>           * from now on.
>           */
>
> Another "Toggle the hard reset line" workaround for Realtek devices:
> See btusb_rtl_cmd_timeout()
>
> Both of these cases are workarounds. Is this what you are referring to about
> btusb doing reset?
>
> Specific to this bug report and mt76, other network/wireless usb drivers
> call usb_reset_device() from their probe routines unconditionally. These
> are the calls from normal paths and not fw load/error paths.
>
> rtl8152_probe(), carl9170_usb_probe(), mt7663u_probe() and so on. Looking
> at these probe routines, it appears some of them do that to avoid problems
> in disconnect path.
>
> I have two questions:
> - Is it necessary to do usb_reset_device() in net/wireless usb driver
>    probe routines?
> - Are these legit calls according to protocol?
>
> If yes, we can look into changing vhci to handle this case for net/wireless
> usb drivers. I would not delete the check though. I would add VDEV_ST_USED
> check in addition to VDEV_ST_NOTASSIGNED with some comments on why this is
> necessary.
>
> Furthermore there is a bug in the line pr_err("vhci_device speed not set\n");
> (L479) because resetting a full-speed device is not an error.
>
> This is a separate issue is separate. vhci is missing USB_SPEED_FULL checks
> at various places. This has to be done as a separate work.
>
> thanks,
> -- Shuah
>
>
