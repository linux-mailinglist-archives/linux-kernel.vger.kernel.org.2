Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2141B360FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhDOQOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:14:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59556 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhDOQOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:14:19 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lX4ct-0000wF-KJ
        for linux-kernel@vger.kernel.org; Thu, 15 Apr 2021 16:13:55 +0000
Received: by mail-ot1-f71.google.com with SMTP id f89-20020a9d2c620000b0290280d753a255so3233095otb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoBRnXr8Cr0X0MRit5d9FD8OWQUaxA4q/o9zqh6RF3M=;
        b=J3wNsltPiXSxVVDXtbqruP8f/rGbnQ0HCRns5W6hC5a9I20UaOfSCu4js9GDx7McF2
         F0qUigpMrCxwE6a5Rcp09plq0va9vcrKrDkGGIBSTF0npI/yjtRf1mXRVuG2S62TkyvH
         8ImfO/idw4bk9gjqPvvyLEJKgKqhcjxGR9rFs9V+gVEuTHRX9Wq04Q0vKK7Ebipj3tEU
         EBgSUTWK5Kf7icxA3yUQ9XK+n6rY0vBMUcOaj2Ux0Njo3U7Re2K/qPYDaXifvBKHr1rQ
         I6a+Qex96d2lfomPdRbeURZ7ItIP7XIzcjj+bXCxAJ3cky+Bv2TH6MSGPWfQRXqqZRQM
         fLOw==
X-Gm-Message-State: AOAM530M0d6o4gyxZDQejfo69+Epw5u7LPq6vtSwVmrker2hCaGDXHJb
        kerLFA4pN3RHs7i+X3R0m/FkRacLtEeiLkUka/lPmVVQhEF/Ob8NYBwSzM2EUrMmty7yyE16LvK
        4GT7uqnHyZ1F/VaxAqbsVo+ExAz+9l9Ro4dMDjUiGSlNg2wIJfDuFcZfNCA==
X-Received: by 2002:a05:6830:4121:: with SMTP id w33mr26959ott.153.1618503234543;
        Thu, 15 Apr 2021 09:13:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTkN5yPeNIlgujYmM5xJmJgHMEuCM7Dc7p2j6tks6lvmgL3bOASaVyOIYRFOrqnhmcxQM9VvC5z3iamo9B4ok=
X-Received: by 2002:a05:6830:4121:: with SMTP id w33mr26945ott.153.1618503234322;
 Thu, 15 Apr 2021 09:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210415114856.4555-1-chris.chiu@canonical.com> <YHgyP8tGNM1Wi5dJ@kroah.com>
In-Reply-To: <YHgyP8tGNM1Wi5dJ@kroah.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Fri, 16 Apr 2021 00:13:43 +0800
Message-ID: <CABTNMG0MuaSkWZhiTwtWjPTg5WZ-Vdt9Ju9-RzBke9JjCBJo8Q@mail.gmail.com>
Subject: Re: [PATCH v3] USB: Don't set USB_PORT_FEAT_SUSPEND on WD19's Realtek Hub
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, m.v.b@runbox.com,
        hadess@hadess.net, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 8:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 15, 2021 at 07:48:56PM +0800, chris.chiu@canonical.com wrote:
> > From: Chris Chiu <chris.chiu@canonical.com>
> >
> > Realtek Hub (0bda:5487) in Dell Dock WD19 sometimes fails to work
> > after the system resumes from suspend with remote wakeup enabled
> > device connected:
> > [ 1947.640907] hub 5-2.3:1.0: hub_ext_port_status failed (err = -71)
> > [ 1947.641208] usb 5-2.3-port5: cannot disable (err = -71)
> > [ 1947.641401] hub 5-2.3:1.0: hub_ext_port_status failed (err = -71)
> > [ 1947.641450] usb 5-2.3-port4: cannot reset (err = -71)
>
> How does other operating systems handle this?  The hardware seems like
> it does not follow the USB spec, how did it get "certified"?
>
I agree. All usb hubs that claim to support Selective Scan should handle
SetPortFeature (PORT_SUSPEND) w/o problems. As I know, the Windows
usb device driver should submit an Idle Request before it's really going to
suspend, and the bus driver will "selectively" suspend the port.

One thing worth mentioning here, I never hit the hub_ext_port_status -71
problem if I resume by waking up from the keyboard connected to the hub.
But the usbcore kernel log shows me wPortStatus: 0503 wPortChane: 0004
of that port while resuming. In normal cases, they are 0507:0000.
 I don't know how to SetPortFeature() with setting the status change bit only.
Or maybe it's just some kind of timing issue of the
idle/suspend/resume signaling.

Chris

> > Information of this hub:
> > T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 10 Spd=480  MxCh= 5
> > D:  Ver= 2.10 Cls=09(hub  ) Sub=00 Prot=02 MxPS=64 #Cfgs=  1
> > P:  Vendor=0bda ProdID=5487 Rev= 1.47
> > S:  Manufacturer=Dell Inc.
> > S:  Product=Dell dock
> > C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> > I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=01 Driver=hub
> > E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
> > I:* If#= 0 Alt= 1 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=02 Driver=hub
> > E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
> >
> > The failure results from the ETIMEDOUT by chance when turning on
> > the suspend feature for the target port of the hub. The port
> > will be unresponsive and placed in unknown state. The hub_activate
> > invoked during resume will fail to get the port stautus with -EPROTO.
> > Then all devices connected to the hub will never be found and probed.
> >
> > The USB_PORT_FEAT_SUSPEND is not really necessary due to the
> > "global suspend" in USB 2.0 spec. It's only for many hub devices
> > which don't relay wakeup requests from the devices connected to
> > downstream ports. For this realtek hub, there's no problem waking
> > up the system from connected keyboard.
> >
> > This commit bypasses the USB_PORT_FEAT_SUSPEND for the quirky hub.
>
> Can you make this only be allowed for hubs?  But why doesn't the nomal
> "this can not suspend properly" bit work for this?  We have that for
> other USB devices already.
>
> thanks,
>
> greg k-h
