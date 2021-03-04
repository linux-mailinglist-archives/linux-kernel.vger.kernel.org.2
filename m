Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5532D05F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbhCDKFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:05:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39590 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbhCDKFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:05:03 -0500
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lHkqD-0005dM-U7
        for linux-kernel@vger.kernel.org; Thu, 04 Mar 2021 10:04:22 +0000
Received: by mail-lf1-f70.google.com with SMTP id m16so9752224lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 02:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kc1YX2+moqNEiChJAD0LkzYPFpZ2rIkojhEfMRM4GEY=;
        b=KBAhv1aSvFjjH9Vb3QVvXG1ITdT0s2DyyIkDiaaYrCaBzuwrZTIJacZpCm8semeQeF
         HpTeBXhl0HClKqM62xy1HVrF9hcYsJ+A+/h9nxyPUdqqlinGLvDA+jj/ASTuAwOiuZU6
         0/8XCa1Iush/kozjISP7FHA6u9Bl7GV+C2guTIJGZHszTHNtYpahUtEaSbtlWHUPLSc8
         rKgChN1M/2Yk51kxo2m7XSjJZ/jr+mHuO0rrBF/7Rwyx+03yLkyXyd8/CkhOqfkW3UTX
         qht0mJc49g+AlJwni6NbV2rf/3TJOxtSJKeSbEFR6V9Pv9kPOQTo3IrPzHHh4YeCahOs
         p48A==
X-Gm-Message-State: AOAM533yGS6yfwyIUK2lmPRhZLejD9K4x+V/Z/tzmdcUXIJ2l+UIJRaR
        6tKhi/kRtnCx83vjOl3YK+uBDyJ/hEc5pIzq64MOEnurLuhe8JCXccfGdZw2TYo6/ZhX3oTw6d2
        5ej7rv9cTFM2ZrDZeedwplAV4tBQHRn1tUwH/+LKBquemnDvVhouK/LGCfQ==
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr1836049ljk.402.1614852261297;
        Thu, 04 Mar 2021 02:04:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJgfxRSqWNtEd/UIukeBG9yHv0tOB/7Oe2lBuCbbPpt6R/MMqcocY1/4GzTVByQ103C6iKqJh8upDmQ9IF2vg=
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr1836033ljk.402.1614852261095;
 Thu, 04 Mar 2021 02:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20210304043419.287191-1-kai.heng.feng@canonical.com> <1ece75aa13b1ab161473dd153598256e58289dec.camel@infinera.com>
In-Reply-To: <1ece75aa13b1ab161473dd153598256e58289dec.camel@infinera.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 4 Mar 2021 18:04:09 +0800
Message-ID: <CAAd53p5n1xqzgmAj9A3oag88m3BSeK+NTP-u-VrJnP2uSh0tRA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "tiwai@suse.com" <tiwai@suse.com>,
        "crwulff@gmail.com" <crwulff@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dylan_robinson@motu.com" <dylan_robinson@motu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmitry@d-systems.ee" <dmitry@d-systems.ee>,
        "livvy@base.nu" <livvy@base.nu>,
        "joe@perches.com" <joe@perches.com>,
        "alexander@tsoy.me" <alexander@tsoy.me>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joakim,

On Thu, Mar 4, 2021 at 5:50 PM Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
>
> On Thu, 2021-03-04 at 12:34 +0800, Kai-Heng Feng wrote:
> > Rear audio on Lenovo ThinkStation P620 stops working after commit
> > 1965c4364bdd ("ALSA: usb-audio: Disable autosuspend for Lenovo
> > ThinkStation P620"):
> > [    6.013526] usbcore: registered new interface driver snd-usb-audio
> > [    6.023064] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.023083] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> > [    6.023090] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.023098] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> > [    6.023103] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.023110] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> > [    6.045846] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.045866] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> > [    6.045877] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.045886] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> > [    6.045894] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
> > [    6.045908] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
> >
> > I overlooked the issue because when I was working on the said commit,
> > only the front audio is tested. Apology for that.
> >
> > Changing supports_autosuspend in driver is too late for disabling
> > autosuspend, because it was already used by USB probe routine, so it can
> > break the balance on the following code that depends on
> > supports_autosuspend.
> >
> > Fix it by using usb_disable_autosuspend() helper, and balance the
> > suspend count in disconnect callback.
> >
> > Fixes: 1965c4364bdd ("ALSA: usb-audio: Disable autosuspend for Lenovo ThinkStation P620")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> I got an report from a co-worker who has no USB sound from a Lenovo ThinkPad in a Ultra Dock.
> USB HS is connected to Dock USB jack.
> Could this be the same problem?

It's a different issue. Please file a separate bug report.

Kai-Heng

>
>  Jocke
