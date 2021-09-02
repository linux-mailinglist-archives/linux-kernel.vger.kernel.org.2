Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2053FF5A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347170AbhIBVf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhIBVf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:35:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED9C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 14:34:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fs6so2287429pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i7HY1LYPv1dhPpnIu1wCK4txAEaMyR8o4SYid4oPsvA=;
        b=DmrubWizS0AhSm2kUYbIl+th5II9zZMfk/AN6u7Jcqh/xrbtpMrCgXE9ooG9Zwc2Ag
         RxFhGLiIiBk7MN8FGwudIISRGQAgoQ5MWnWjJz6ggL4UF3kbRotlFvdQ5baYioYystRR
         b8/m3aowIkxjyNdOBhRIU/+slLUtZJWiEkK3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7HY1LYPv1dhPpnIu1wCK4txAEaMyR8o4SYid4oPsvA=;
        b=Ccp4FNdsl/k+zoPB6eSo8jItzSWhDVpoEUwxSKkgJ4lZ+G6+UNlATw48k/Odul6n3I
         73qEOFqxAJwCY6rjQ2PPvPnhSgRsmGIcRgDKulBT6A4BEyQjnln52rSTuxGpf7fwzjcM
         pY5DikhBl1Es+lO2TcLs65PL6S+RoQ9o85e6IeTfYTTc/P3Ey7XSDycn6VEtOjP9sgr4
         imz+SXgUbpx/F8VuzwUiecn6ElXvrdjAoww0UkBMkq/inq1DvYkt6GSm84qlYl1VZnwu
         +HZXKzGFJkyGx5ekuKmB78zl+BpDQKo7SWd3INTgr/akSmXraSuPUPohPSDKRbyUzAj2
         Wyqw==
X-Gm-Message-State: AOAM531+Pag8HyvldmlzK/Bg1KVMAC/dYYF+xEhCaQ8oMRC10ETgdV2/
        W6APb0WHXOm7EuaVhsYbypHpdg==
X-Google-Smtp-Source: ABdhPJzvlAGSbVfg2xPnOLT097EV7UuzgmSDDDhGVVJrT/ZAMQpXX7yyqiewCEBGFrpAMt7QRYijpw==
X-Received: by 2002:a17:90a:7881:: with SMTP id x1mr210595pjk.102.1630618467061;
        Thu, 02 Sep 2021 14:34:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:76ac:d178:a633:4fb5])
        by smtp.gmail.com with UTF8SMTPSA id d22sm3077903pjw.38.2021.09.02.14.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 14:34:26 -0700 (PDT)
Date:   Thu, 2 Sep 2021 14:34:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Arnd Bergmann <arnd@arndb.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/4] misc: hisi_hikey_usb: change the DT schema
Message-ID: <YTFDYWsTSYlbbIje@google.com>
References: <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
 <YTC4LPDem9uKXyMd@kroah.com>
 <20210902151053.7ddfbe3a@coco.lan>
 <20210902153820.5624b57f@coco.lan>
 <YTDYFCH/DbK1SFVv@kroah.com>
 <20210902163529.734b8e0e@coco.lan>
 <YTEJuK50e5PBBJfO@google.com>
 <CALAqxLUxgRCUweDcE1WWV1gTsstZAvjUT6ZuTij5Mro8MHKi8Q@mail.gmail.com>
 <YTEuA+Z3f50RVGgX@google.com>
 <CALAqxLW_wwRFaWASsy6rFHir23MfFU3psq6pjavDeUF5hNS5OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALAqxLW_wwRFaWASsy6rFHir23MfFU3psq6pjavDeUF5hNS5OA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 01:31:45PM -0700, John Stultz wrote:
> On Thu, Sep 2, 2021 at 1:03 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > On Thu, Sep 02, 2021 at 11:29:49AM -0700, John Stultz wrote:
> > > The current iteration (of which there have been many) of hikey hub
> > > driver uses the role switch notification as its trigger. It's not
> > > really controlling the role switching, just using that signal. That's
> > > why the driver works as an intermediary/relay of the roleswitch
> > > notification.
> >
> > Apologies too, my terminology wasn't very clear, I had little exposure to
> > OTG so far.
> >
> > The hisi_hikey_usb driver doesn't control the role of the USB controller,
> > however it deals with platform specific role switching stuff, like muxing
> > the USB PHY to the hub (host mode) or directly to the type-C port (device
> > mode), or controlling the power of the type-C port.
> 
> True, though the exact configuration of powering type-c port, the mux
> and the hub power that we want to set depends on the role.
> 
> > > We had earlier efforts that had hacks to specific drivers as well as
> > > attempts to add notifiers on role switches (but those were terribly
> > > racy), so the intermediary/relay approach has been a great improvement
> > > on reliability with little impact to other drivers.
> >
> > I can see how raciness can be a problem. I'm not proprosing to use
> > notifiers in the driver that deals with the hub, from the hub's
> > perspective it is connected to a host port and it shouldn't have to care
> > about OTG.
> >
> > But the 'hub driver' could expose a synchronous interface that allows the
> > hisi_hikey_usb driver to power the hub on and off (or keep it in reset).
> > That would maintain the relay approach, but without having a driver that
> > tries to do too many things at once. For example the onboard_usb_hub driver
> > has the option to power the hub down during suspend if no wakeup capable
> > devices are connected downstream, I'm not convinced that this and the
> > handling of the mux should be done by the same driver.
> 
> I'm not sure I'm totally following your proposal, so apologies if I
> have it wrong.
> It seems you're suggesting to move just the hub power logic out of the
> hisi hub driver, and utilize the onboard_usb_hub driver for that?

Yes

> I guess that could be done, but I also feel like it's really just the
> regulator control, which is a pretty small part of the hisi hub driver
> logic.
> Additionally, if you look at the logic that handles the different
> setting configurations needed for the different roles:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/misc/hisi_hikey_usb.c#n97
> 
> You'll see the ordering of powering things on/off and switching the
> mux is a bit subtle.

Indeed, that would make things a bit more involved.

> So while I guess we could call some onboard_usb_hub hook for the hub
> power on/off calls (hub_power_ctrl() in the hisi driver), I'm not sure
> that really is saving much logic wise, and splits the details across
> an additional driver in an already somewhat complicated config.

+ probing, tearing down and potentially reset.

It might not be worth as long as only a single hub model (or compatible
ones) is supported, things might look different if other power on/off/reset
sequences need to be added.

> Again, apologies if I'm being thick headed. :)

no worries, same here :)

I have no objections to leaving the driver structure as is, especially
since it already has been in upstream for a while, I was mainly looking
for possible synergies.
