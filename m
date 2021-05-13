Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC437F1EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 06:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhEMEXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 00:23:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49299 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhEMEXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 00:23:14 -0400
Received: from mail-ot1-f69.google.com ([209.85.210.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lh2rM-0000io-OK
        for linux-kernel@vger.kernel.org; Thu, 13 May 2021 04:22:04 +0000
Received: by mail-ot1-f69.google.com with SMTP id h10-20020a9d554a0000b02901d8bed80c43so16267519oti.22
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 21:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eS2vX8ZqQoyxo7V8frOg88yNKeaoSqG3TtY0ehSLXg=;
        b=Y1FJD6i5UOA+oSI7fARLT94+5RWy0NmJ0+HnJ5GQ9fCfryxihBvTBUUsACfXYzgHvr
         DV6uCEccrvAhcybHC7rF5P9kHuVqH19RMvbaNZ3uf6xuj5Q6kxD5szvUHdnwM6QwuG0w
         4H2u12wWs43Rvb6xZMuCAMVeW/ahIiBCOhr5u9qRttZzdYylsdtQKI3aZ1UZRka5+S2S
         xqhT1e1GIE8kdYXg6xInFnaPWhshQG2+QEb25ggkBsb7gKw+dEDbk/Gv/XX5OceD7tWb
         J4D+QjSMSOsFX/uF8y6mtW0JpDkCjIwYROoxRJ1REmwQOah6xI3FUJvaw+9NEryKL8K6
         f0rg==
X-Gm-Message-State: AOAM530ZSIrj1ALYfrXywMV8EKA5amKn9XT8+J7kl2kQMndZKBqucSRc
        vH6iRl8yTN49JjEzjAco+ED1LF00k3Xy/whf2GYJnPzuPcq/x3dseKDeN6tcd/k25f2MeJ5GXnL
        vkPzrZJDgozfc/CqhT1oEiaQXEbloWY3W25HoAR9aXz0+JOV/JeNWFgmvLQ==
X-Received: by 2002:a4a:8dd6:: with SMTP id a22mr30834274ool.74.1620879723656;
        Wed, 12 May 2021 21:22:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwegQhHplX61u4jTu8V6xwY2Szd4elytM+vvJGalFfbru1X+X7LWsB6CKWtn4hQcRVala9gKmUqq1LcxX2cL5Q=
X-Received: by 2002:a4a:8dd6:: with SMTP id a22mr30834260ool.74.1620879723402;
 Wed, 12 May 2021 21:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210510145030.1495-1-chris.chiu@canonical.com>
 <20210510145030.1495-2-chris.chiu@canonical.com> <20210510150203.GD863718@rowland.harvard.edu>
 <CABTNMG24BOS_+uGEYFLJrmEW10eTGjrOowwS7Zb_U+AvkZWTyQ@mail.gmail.com>
 <20210511163026.GA901897@rowland.harvard.edu> <CABTNMG2OiEFzMwMaUaVL9B6Om87e9qQMFBXRKej7G6zuvBXW=w@mail.gmail.com>
 <20210512150424.GA934575@rowland.harvard.edu>
In-Reply-To: <20210512150424.GA934575@rowland.harvard.edu>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Thu, 13 May 2021 12:21:52 +0800
Message-ID: <CABTNMG0Skqim9UOMqNuaO94iL+Ff6Eu47itmv0RFTwY4xYWhGQ@mail.gmail.com>
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

On Wed, May 12, 2021 at 11:04 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, May 12, 2021 at 12:17:12PM +0800, Chris Chiu wrote:
> > On Wed, May 12, 2021 at 12:30 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Tue, May 11, 2021 at 01:04:36PM +0800, Chris Chiu wrote:
> > > > On Mon, May 10, 2021 at 11:02 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > >
> > > > > On Mon, May 10, 2021 at 10:50:29PM +0800, chris.chiu@canonical.com wrote:
> > > > > > From: Chris Chiu <chris.chiu@canonical.com>
> > > > > >
> > > > > > On the Realtek high-speed Hub(0bda:5487), the port which has wakeup
> > > > > > enabled_descendants will sometimes timeout when setting PORT_SUSPEND
> > > > > > feature. After checking the PORT_SUSPEND bit in wPortStatus, it is
> > > > > > already set. However, the hub will fail to activate because the
> > > > > > PORT_SUSPEND feature of that port is not cleared during resume. All
> > > > > > connected devices are lost after resume.
> > > > > >
> > > > > > This commit force reset-resume the device connected to the timeout
> > > > > > but suspended port so that the hub will have chance to clear the
> > > > > > PORT_SUSPEND feature during resume.
> > > > >
> > > > > Are you certain that the reset-resume is needed?  What happens if you
> > > > > leave out the line that sets udev->reset_resume?  The rest of the patch
> > > > > will cause the kernel to realize that the port really is suspended, so
> > > > > maybe the suspend feature will get cleared properly during resume.
> > > > >
> > > > > It's worthwhile to try the experiement and see what happens.
> > > > >
> > > > > Alan Stern
> > > > >
> > > >
> > > > If I leave out the udev->reset_resume set, the resume will fail. Please refer
> > > > to the following kernel log. The usb 1-1 is the hub which has wakeup enabled
> > > > descendants.
> > > >
> > > > [   57.210472] usb 1-1: kworker/u32:7 timed out on ep0out len=0/0
> > > > [   57.211022] usb 1-1-port3: suspend timeout, status 0507
> > > > [   57.211130] hub 1-1:1.0: hub_suspend
> > > > [   57.230500] usb 1-1: usb suspend, wakeup 0
> > > >
> > > > The timeout happens at 57.210472 and you can see the PORT_SUSPEND
> > > > bit is actually set in the "status 0507". The following shows the resume log.
> > > >
> > > > [   58.046556] usb 1-1: usb resume
> > > > [   58.114515] usb 1-1: Waited 0ms for CONNECT
> > > > [   58.114524] usb 1-1: finish resume
> > > > [   58.114928] hub 1-1:1.0: hub_resume
> > > > [   58.116035] usb 1-1-port3: status 0507 change 0000
> > > > [   58.116720] usb 1-1-port5: status 0503 change 0000
> > > > [   58.116778] hub 1-1.3:1.0: hub_resume
> > > > [   58.116908] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
> > > > [   58.116952] usb 1-1.5: Waited 0ms for CONNECT
> > > > [   58.116955] usb 1-1.5: finish resume
> > > > [   58.117157] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
> > > > [   58.117397] usb 1-1.3-port5: can't resume, status -71
> > > > [   58.117782] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
> > > > [   58.118147] usb 1-1.3-port2: can't resume, status -71
> > > > [   58.118149] usb 1-1.3.2: Waited 0ms for CONNECT
> > > > [   58.118151] usb 1-1.3-port2: status 07eb.906e after resume, -19
> > > > [   58.118153] usb 1-1.3.2: can't resume, status -19
> > > > [   58.118154] usb 1-1.3-port2: logical disconnect
> > > > [   58.118526] usb 1-1.3-port2: cannot disable (err = -71)
> > > >
> > > > As you see in the 58.116035, the hub_resume and activate is OK for the
> > > > usb 1-1. The "usb 1-1.3: finish resume" is not in the log because it's not
> > > > considered suspended and no chance to ClearPortFeature.
> > >
> > > Wait -- why isn't it considered suspended?  We saw at 57.211022 that
> > > 1-1-port3's Suspend feature really was set, and thanks to your patch,
> > > the kernel should now believe that the port is suspended.
> > >
> > But it's still in the `if (status)` branch so it will not get
> > usb_set_device_state
> > to USB_STATE_SUSPENDED, then usb_resume_both will not do the resume
> > process for it.
>
> Ah, yes.  I was mis-reading the patch.
>
> > My original thought is, we still take this as an abnormal status
> > because we don't
> > really know the reason for the timeout. Set reset_resume for the udev
> > will make the
> > kernel to reset_resume it. Or  I have to create a new `goto` name in
> > the `else` branch
> > to force it back to the successful suspended process. And should I
> > clean the status to
> > zero for pm_runtime_put_sync()? What's your suggestion?
>
> For testing purposes, set status to 0 and jump to a new goto label in
> the "else" branch.  In other words, treat it as if the suspend really
> had worked and go back to the successful pathway.  Try this out and see
> if it fixes the problem.
>
> If it does then the reset-resume isn't needed.  If it doesn't, post your
> patch again, and mention in the patch description that testing shows the
> reset-resume really is necessary.
>
> Alan Stern

Thanks for the suggestion. I revised the patch to create a new goto
label in the "else" branch and clear the status to zero if the port is
really suspended. It fixed the problem in my 100 time suspend/resume
test. I will send v3 patch w/ the modification.

Chris
