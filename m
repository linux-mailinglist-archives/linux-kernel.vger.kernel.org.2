Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2CA37B4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 06:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhELESe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 00:18:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43291 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhELESd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 00:18:33 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lggJJ-0004xT-2C
        for linux-kernel@vger.kernel.org; Wed, 12 May 2021 04:17:25 +0000
Received: by mail-ot1-f71.google.com with SMTP id 106-20020a9d08730000b02902d29fa5c2c3so14302621oty.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 21:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXfu/0x1x4lUEonZNC+J5qrR2427Up6CMBHzq1M51M4=;
        b=ugfiu8ONbsRQvAQ2z4mQeSw3J2AmZzBrZWSczFA89c0Oopx3AzkR/QlH3GJk6HnNem
         juljWM5kmRkF3dsuZuzFiFWywli0ChwEQp3e1Zv8+B7CJaNLWEpVCmwWTxZpqXhUexF3
         HnatzbPvLYurzbiEx3LgM191x85ZQXSAHM+NkxRlzobzV7ZjbQU5lnDOlb5Yv6Isaz1s
         zZGMhc1+BIRnap9xvcuOmc5J3KDVAr0XYBuN2A7m7SkZZQ9ilvbi6gO9QQuMs1GdjX8N
         P+jVmiQs6M3Zu3UUd/BpX3EAZMyjkwNVVsVxSop0MakqIusETgDhDH8fkR83nHAHn35f
         9iqQ==
X-Gm-Message-State: AOAM531zVSSWIEB2BgMf9VQVcZnKPyaSyejH6NAumg826/QHutZP02HL
        nmThjdIndMcmHDoBvGQIeXTc52nB1Nz9PfZ1BdP5qN/Zlfv05BPqjXWyCMjhKsb7snrp7vlvnqc
        SmV0SPoqAQm2Xfp/cWJCxxM/rettVculFOGMWpJDhupLAGc4xQUGmZNgRnA==
X-Received: by 2002:a9d:68d8:: with SMTP id i24mr28053274oto.347.1620793043842;
        Tue, 11 May 2021 21:17:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzlJA2VnGbYi/ug0mBJj3W7KOWF0uB/EGDVVZKzYprkD8Ui/PyvFtfazSGgXchQrjZUcApbCkEgr2rQqlE1lM=
X-Received: by 2002:a9d:68d8:: with SMTP id i24mr28053258oto.347.1620793043603;
 Tue, 11 May 2021 21:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210510145030.1495-1-chris.chiu@canonical.com>
 <20210510145030.1495-2-chris.chiu@canonical.com> <20210510150203.GD863718@rowland.harvard.edu>
 <CABTNMG24BOS_+uGEYFLJrmEW10eTGjrOowwS7Zb_U+AvkZWTyQ@mail.gmail.com> <20210511163026.GA901897@rowland.harvard.edu>
In-Reply-To: <20210511163026.GA901897@rowland.harvard.edu>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Wed, 12 May 2021 12:17:12 +0800
Message-ID: <CABTNMG2OiEFzMwMaUaVL9B6Om87e9qQMFBXRKej7G6zuvBXW=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] USB: reset-resume the device when PORT_SUSPEND is
 set but timeout
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, m.v.b@runbox.com,
        hadess@hadess.net, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 12:30 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, May 11, 2021 at 01:04:36PM +0800, Chris Chiu wrote:
> > On Mon, May 10, 2021 at 11:02 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Mon, May 10, 2021 at 10:50:29PM +0800, chris.chiu@canonical.com wrote:
> > > > From: Chris Chiu <chris.chiu@canonical.com>
> > > >
> > > > On the Realtek high-speed Hub(0bda:5487), the port which has wakeup
> > > > enabled_descendants will sometimes timeout when setting PORT_SUSPEND
> > > > feature. After checking the PORT_SUSPEND bit in wPortStatus, it is
> > > > already set. However, the hub will fail to activate because the
> > > > PORT_SUSPEND feature of that port is not cleared during resume. All
> > > > connected devices are lost after resume.
> > > >
> > > > This commit force reset-resume the device connected to the timeout
> > > > but suspended port so that the hub will have chance to clear the
> > > > PORT_SUSPEND feature during resume.
> > >
> > > Are you certain that the reset-resume is needed?  What happens if you
> > > leave out the line that sets udev->reset_resume?  The rest of the patch
> > > will cause the kernel to realize that the port really is suspended, so
> > > maybe the suspend feature will get cleared properly during resume.
> > >
> > > It's worthwhile to try the experiement and see what happens.
> > >
> > > Alan Stern
> > >
> >
> > If I leave out the udev->reset_resume set, the resume will fail. Please refer
> > to the following kernel log. The usb 1-1 is the hub which has wakeup enabled
> > descendants.
> >
> > [   57.210472] usb 1-1: kworker/u32:7 timed out on ep0out len=0/0
> > [   57.211022] usb 1-1-port3: suspend timeout, status 0507
> > [   57.211130] hub 1-1:1.0: hub_suspend
> > [   57.230500] usb 1-1: usb suspend, wakeup 0
> >
> > The timeout happens at 57.210472 and you can see the PORT_SUSPEND
> > bit is actually set in the "status 0507". The following shows the resume log.
> >
> > [   58.046556] usb 1-1: usb resume
> > [   58.114515] usb 1-1: Waited 0ms for CONNECT
> > [   58.114524] usb 1-1: finish resume
> > [   58.114928] hub 1-1:1.0: hub_resume
> > [   58.116035] usb 1-1-port3: status 0507 change 0000
> > [   58.116720] usb 1-1-port5: status 0503 change 0000
> > [   58.116778] hub 1-1.3:1.0: hub_resume
> > [   58.116908] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
> > [   58.116952] usb 1-1.5: Waited 0ms for CONNECT
> > [   58.116955] usb 1-1.5: finish resume
> > [   58.117157] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
> > [   58.117397] usb 1-1.3-port5: can't resume, status -71
> > [   58.117782] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
> > [   58.118147] usb 1-1.3-port2: can't resume, status -71
> > [   58.118149] usb 1-1.3.2: Waited 0ms for CONNECT
> > [   58.118151] usb 1-1.3-port2: status 07eb.906e after resume, -19
> > [   58.118153] usb 1-1.3.2: can't resume, status -19
> > [   58.118154] usb 1-1.3-port2: logical disconnect
> > [   58.118526] usb 1-1.3-port2: cannot disable (err = -71)
> >
> > As you see in the 58.116035, the hub_resume and activate is OK for the
> > usb 1-1. The "usb 1-1.3: finish resume" is not in the log because it's not
> > considered suspended and no chance to ClearPortFeature.
>
> Wait -- why isn't it considered suspended?  We saw at 57.211022 that
> 1-1-port3's Suspend feature really was set, and thanks to your patch,
> the kernel should now believe that the port is suspended.
>
But it's still in the `if (status)` branch so it will not get
usb_set_device_state
to USB_STATE_SUSPENDED, then usb_resume_both will not do the resume
process for it.

My original thought is, we still take this as an abnormal status
because we don't
really know the reason for the timeout. Set reset_resume for the udev
will make the
kernel to reset_resume it. Or  I have to create a new `goto` name in
the `else` branch
to force it back to the successful suspended process. And should I
clean the status to
zero for pm_runtime_put_sync()? What's your suggestion?

Chris

> >  Then it fails
> > the subsequent hub 1-1.3 resume and active because the usb 1-1.3 happens
> > to be a downstream hub. So this is why we need at least udev->reset_resume
> > to give this kind of timeout port/device a chance to clear port feature and
> > come back from an unknown state.
>
> Don't worry about this part.  Naturally anything associated with the
> 1-1.3 hub will fail after the resume of 1-1-port3 is messed up.  Fix the
> first problem (failure to resume the port) and the second problem is
> likely to go away.
>
> Alan Stern
