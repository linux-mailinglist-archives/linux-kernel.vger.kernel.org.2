Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F93379EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhEKFF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:05:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40084 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhEKFFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:05:55 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lgKZc-0005xQ-Ps
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 05:04:48 +0000
Received: by mail-ot1-f70.google.com with SMTP id 59-20020a9d0dc10000b02902a57e382ca1so12494041ots.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 22:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brZ8seLUgy1mI8u+SqjRB90BaFqTsR5ZweglLqWNyqE=;
        b=O3QTbqmkNTbouvU4eTb0z38EQD1S+4csqiPf2xto+UGmdHZAnlhpJNJtnt8IFGlMdG
         MGavxgK+/uvoYj6pB+Xfo237eLsvielY7CFdeRQNwZVOVhBxPF29D+o8SR1y9h2gTknk
         TX77bP1bpVeM3d2psqRGQAzlUwfYC6XsVsoHHA7XUSeriqjgtVPBsAHs6zBxW/Il0ExY
         a+58/aKIfJtFEUF6gMhtEU2V2B9yYdLFNp9rktl3lFXVHi6rb6AojOTtDmiDLF8LeedL
         Uwl7V1bk6nY4l1k5JgiDJ1ilIRIAO62YH4C4ccKI0EJtYVHYqkxke0KV1pvxT82K2OKS
         cQDQ==
X-Gm-Message-State: AOAM533+34p9oFejO688LoMBF9xTyU2upxTQX01ovqxCYTR2+TOMMxMS
        /7yCPiNN1zCRzaN60IpLeKw57hSb8WCqdB8Wf19KoQLN9+uBiz2M2Ze7G51DvZ7Rp8D5dpkls0T
        xzHyXGKL46yE8GcNwoNXnRZbnJOTLeDyGomd8bKjcOKn9WhXAlmj2tpSv5Q==
X-Received: by 2002:a9d:68d8:: with SMTP id i24mr23614125oto.347.1620709487638;
        Mon, 10 May 2021 22:04:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZhmtkBBjmQYwoJMbfZXYocai8UBKgp/4xnW7NTgH6VcZ9R+5q6XbuFeI9ObLU0Kn8ArbUb7sIcY6Twzswo00=
X-Received: by 2002:a9d:68d8:: with SMTP id i24mr23614109oto.347.1620709487400;
 Mon, 10 May 2021 22:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210510145030.1495-1-chris.chiu@canonical.com>
 <20210510145030.1495-2-chris.chiu@canonical.com> <20210510150203.GD863718@rowland.harvard.edu>
In-Reply-To: <20210510150203.GD863718@rowland.harvard.edu>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Tue, 11 May 2021 13:04:36 +0800
Message-ID: <CABTNMG24BOS_+uGEYFLJrmEW10eTGjrOowwS7Zb_U+AvkZWTyQ@mail.gmail.com>
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

On Mon, May 10, 2021 at 11:02 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, May 10, 2021 at 10:50:29PM +0800, chris.chiu@canonical.com wrote:
> > From: Chris Chiu <chris.chiu@canonical.com>
> >
> > On the Realtek high-speed Hub(0bda:5487), the port which has wakeup
> > enabled_descendants will sometimes timeout when setting PORT_SUSPEND
> > feature. After checking the PORT_SUSPEND bit in wPortStatus, it is
> > already set. However, the hub will fail to activate because the
> > PORT_SUSPEND feature of that port is not cleared during resume. All
> > connected devices are lost after resume.
> >
> > This commit force reset-resume the device connected to the timeout
> > but suspended port so that the hub will have chance to clear the
> > PORT_SUSPEND feature during resume.
>
> Are you certain that the reset-resume is needed?  What happens if you
> leave out the line that sets udev->reset_resume?  The rest of the patch
> will cause the kernel to realize that the port really is suspended, so
> maybe the suspend feature will get cleared properly during resume.
>
> It's worthwhile to try the experiement and see what happens.
>
> Alan Stern
>

If I leave out the udev->reset_resume set, the resume will fail. Please refer
to the following kernel log. The usb 1-1 is the hub which has wakeup enabled
descendants.

[   57.210472] usb 1-1: kworker/u32:7 timed out on ep0out len=0/0
[   57.211022] usb 1-1-port3: suspend timeout, status 0507
[   57.211130] hub 1-1:1.0: hub_suspend
[   57.230500] usb 1-1: usb suspend, wakeup 0

The timeout happens at 57.210472 and you can see the PORT_SUSPEND
bit is actually set in the "status 0507". The following shows the resume log.

[   58.046556] usb 1-1: usb resume
[   58.114515] usb 1-1: Waited 0ms for CONNECT
[   58.114524] usb 1-1: finish resume
[   58.114928] hub 1-1:1.0: hub_resume
[   58.116035] usb 1-1-port3: status 0507 change 0000
[   58.116720] usb 1-1-port5: status 0503 change 0000
[   58.116778] hub 1-1.3:1.0: hub_resume
[   58.116908] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
[   58.116952] usb 1-1.5: Waited 0ms for CONNECT
[   58.116955] usb 1-1.5: finish resume
[   58.117157] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
[   58.117397] usb 1-1.3-port5: can't resume, status -71
[   58.117782] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
[   58.118147] usb 1-1.3-port2: can't resume, status -71
[   58.118149] usb 1-1.3.2: Waited 0ms for CONNECT
[   58.118151] usb 1-1.3-port2: status 07eb.906e after resume, -19
[   58.118153] usb 1-1.3.2: can't resume, status -19
[   58.118154] usb 1-1.3-port2: logical disconnect
[   58.118526] usb 1-1.3-port2: cannot disable (err = -71)

As you see in the 58.116035, the hub_resume and activate is OK for the
usb 1-1. The "usb 1-1.3: finish resume" is not in the log because it's not
considered suspended and no chance to ClearPortFeature. Then it fails
the subsequent hub 1-1.3 resume and active because the usb 1-1.3 happens
to be a downstream hub. So this is why we need at least udev->reset_resume
to give this kind of timeout port/device a chance to clear port feature and
come back from an unknown state.

Chris

> > Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> > ---
> >
> > Changelog:
> >   v2:
> >     - create a new variable to keep the result of hub_port_status
> >       when suspend timeout.
> >
> >  drivers/usb/core/hub.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index b2bc4b7c4289..3c823544e425 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -3385,6 +3385,21 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
> >               status = 0;
> >       }
> >       if (status) {
> > +             if (status == -ETIMEDOUT) {
> > +                     u16 portstatus, portchange;
> > +
> > +                     int ret = hub_port_status(hub, port1, &portstatus,
> > +                                     &portchange);
> > +
> > +                     dev_dbg(&port_dev->dev,
> > +                             "suspend timeout, status %04x\n", portstatus);
> > +
> > +                     if (ret == 0 && port_is_suspended(hub, portstatus)) {
> > +                             udev->reset_resume = 1;
> > +                             goto err_wakeup;
> > +                     }
> > +             }
> > +
> >               dev_dbg(&port_dev->dev, "can't suspend, status %d\n", status);
> >
> >               /* Try to enable USB3 LTM again */
> > --
> > 2.20.1
> >
