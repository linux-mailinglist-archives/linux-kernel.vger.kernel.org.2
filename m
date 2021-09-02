Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60B53FF487
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345288AbhIBUEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344200AbhIBUEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:04:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046B4C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 13:03:18 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r2so3143156pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TAAe1Qk4hJTsBo1P0uuQjp0FfLmalTA5KfOdOLqGMEU=;
        b=VLuQZeLiU+Uont5QUkBVe7CHel3fR6ufQoDQMRfZaU8eiAC9AYXY2DL2jMLjVu/aes
         Wf439FrimgzlNZa7hhbZk+rpkwvp3G+d9RPvGKsDGlkUzHe+Oclvo2t3CjPDUN+PPpqo
         ksKyMUECQY+9Cc0KGnnthu0X93CWvMtzsTKM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TAAe1Qk4hJTsBo1P0uuQjp0FfLmalTA5KfOdOLqGMEU=;
        b=oG2gmiImraiCMrw+t04WkN5YoIYaBzXUGFBvpBllq5Zh9GvWeodzQ4HcmF7aL31b7w
         4Z7+4L4YTdL33Aqm92BV7oK4k6Z84zvBBdtyGX/91fFgqNtRwsquVzMzPa9onnax+gm0
         hgs07omBlT2QClFnVXIayVi74wgK5DXSjLZuEO0pID2dTrTR/BQnj73rksCdS93Ox7Jl
         Up4dsCO+fTVat59Kr+YOIiV0mG+03XcQS1Ub06WiP4wH7GeoYkBn6htVavHT9ghCx7jT
         4tXmC11JDqS3vqLembMpCXHESLg8gL0+fxz1QVUiQ3+LFU7lDJTcAHCYccfuIy7FBudk
         NPmg==
X-Gm-Message-State: AOAM532XuVVbejP9jjxf0qU32Ch6SfjSNzSDYdKFi+EFByrRDwDqyRUY
        pDyvgHiYOJlLapdGGhuvxH1ttQ==
X-Google-Smtp-Source: ABdhPJwAbVH81plXjNNTw1ct4J4G+xuEXQ/WfFTZK2D7zZZU7HnEvdrrUDyF4ktfc18SoCjX5DLqdQ==
X-Received: by 2002:a63:af12:: with SMTP id w18mr55891pge.221.1630612997438;
        Thu, 02 Sep 2021 13:03:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:76ac:d178:a633:4fb5])
        by smtp.gmail.com with UTF8SMTPSA id u8sm3626275pgc.69.2021.09.02.13.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 13:03:16 -0700 (PDT)
Date:   Thu, 2 Sep 2021 13:03:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Arnd Bergmann <arnd@arndb.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/4] misc: hisi_hikey_usb: change the DT schema
Message-ID: <YTEuA+Z3f50RVGgX@google.com>
References: <cover.1630581434.git.mchehab+huawei@kernel.org>
 <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
 <YTC4LPDem9uKXyMd@kroah.com>
 <20210902151053.7ddfbe3a@coco.lan>
 <20210902153820.5624b57f@coco.lan>
 <YTDYFCH/DbK1SFVv@kroah.com>
 <20210902163529.734b8e0e@coco.lan>
 <YTEJuK50e5PBBJfO@google.com>
 <CALAqxLUxgRCUweDcE1WWV1gTsstZAvjUT6ZuTij5Mro8MHKi8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALAqxLUxgRCUweDcE1WWV1gTsstZAvjUT6ZuTij5Mro8MHKi8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 11:29:49AM -0700, John Stultz wrote:
> On Thu, Sep 2, 2021 at 10:28 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > On Thu, Sep 02, 2021 at 04:35:29PM +0200, Mauro Carvalho Chehab wrote:
> > > Em Thu, 2 Sep 2021 15:56:36 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > > > On Thu, Sep 02, 2021 at 03:38:20PM +0200, Mauro Carvalho Chehab wrote:
> > > > > While I'm not sure how generic this driver can be, I'm thinking that
> > > > > maybe a future patch could rename it to 'generic-usb-hub' or
> > > > > something similar - finding a good name is always the hardest
> > > > > part :-)
> > > >
> > > > Try looking at:
> > > >     https://lore.kernel.org/r/20210813195228.2003500-1-mka@chromium.org
> > > > for another example of this.
> > >
> > > (C/C Matthias here).
> > >
> > > Interesting to know that someone else is also needing to add support
> > > for USB chips.
> >
> > Yeah, there were several attempts over the years, but so far none of
> > them landed upstream ...
> >
> > > Yet, the approach took there won't work with HiKey 960/970, as
> > > it needs to control not only the regulator, but it should also
> > > work as as usb-role-switch.
> > >
> > > So, besides controlling the regulator, which seems to be basically what
> > > the onboard_usb_hub_driver does, but it should also be able to:
> > >
> > >       - (optionally) reset the HUB;
> > >       - control its OTG switch;
> > >       - control power on/off for an USB type-C connector;
> > >       - set USB role as host or device.
> >
> > > Perhaps it would be possible to merge both approaches by modifying
> > > hisi_hikey_usb in order to add the extra bits required by the boards that
> > > Matthias is currently working, and requiring the GPIOs for OTG and
> > > type-C connectors only if DT contains usb-role-switch.
> >
> > I'm not convinced that a hub driver should be in charge of role switching.
> > I wonder if the hub part could remain separate, and the role switching be
> > done by a dedicated driver that interacts with the hub driver through
> > some interface. From the above list the hub driver could still be in charge
> > of:
> >
> > - (optionally) reset the HUB;
> > - control power on/off for an USB type-C connector;
> >
> > Maybe the hub driver could implement a reset controller to allow the role
> > switching driver to switch it on and off (including type-C power).
> >
> > The role switch driver (a leaner version of hisi_hikey_usb) could model
> > the mux and switch the hub on and off, without being concerned about all
> > the details.
> 
> Apologies, I may be misunderstanding you, but I think the missing
> issue there is: "what triggers the hub driver to switch it on or off?"
> 
> For the hikey960/970 boards, removing/plugging in the usb-c cable is
> what we use to enable/disable the mux/hub.
> 
> The current iteration (of which there have been many) of hikey hub
> driver uses the role switch notification as its trigger. It's not
> really controlling the role switching, just using that signal. That's
> why the driver works as an intermediary/relay of the roleswitch
> notification.

Apologies too, my terminology wasn't very clear, I had little exposure to
OTG so far.

The hisi_hikey_usb driver doesn't control the role of the USB controller,
however it deals with platform specific role switching stuff, like muxing
the USB PHY to the hub (host mode) or directly to the type-C port (device
mode), or controlling the power of the type-C port.

> We had earlier efforts that had hacks to specific drivers as well as
> attempts to add notifiers on role switches (but those were terribly
> racy), so the intermediary/relay approach has been a great improvement
> on reliability with little impact to other drivers.

I can see how raciness can be a problem. I'm not proprosing to use
notifiers in the driver that deals with the hub, from the hub's
perspective it is connected to a host port and it shouldn't have to care
about OTG.

But the 'hub driver' could expose a synchronous interface that allows the
hisi_hikey_usb driver to power the hub on and off (or keep it in reset).
That would maintain the relay approach, but without having a driver that
tries to do too many things at once. For example the onboard_usb_hub driver
has the option to power the hub down during suspend if no wakeup capable
devices are connected downstream, I'm not convinced that this and the
handling of the mux should be done by the same driver.
