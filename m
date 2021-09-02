Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC533FF5C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347511AbhIBVnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346353AbhIBVnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:43:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98136610A0;
        Thu,  2 Sep 2021 21:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630618943;
        bh=axhzknejbuamNYdNDZVUtZx1+IlNBh4oBushSCcCYB8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=il7glIKInsLOAhWpIWprslPcoCRLlhYewRFVAEqdZYCT+LMu4HrNv47xgNt142BM6
         EC2CldWBlFXvrGLrzsA0g9FAlbsoCf9yHQYZD8sS2PBIpdEcaSQao5ThIVcrEpKE4r
         ZJTu2ecEtNRghf1zZ8A7jh5i/eTQAw2+PxjQdekuJO6RoNIQPnX3XzkyyqkqTIKmag
         u6pXi3/8Zck3OWgYrM2i9EE0Vul1q8I1W75LvJITF5rM7UaUSoPsTlf3+PFcgdPGd4
         KA/r+skp4ERM1XZj+qVOmkyJXD8xZWfteqxUDTNoT7hVNA3DcedMR5VLfsBz026WmR
         7RVqb0prwCqGg==
Date:   Thu, 2 Sep 2021 23:42:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Arnd Bergmann <arnd@arndb.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/4] misc: hisi_hikey_usb: change the DT schema
Message-ID: <20210902234218.5d04d1fa@coco.lan>
In-Reply-To: <CALAqxLW_wwRFaWASsy6rFHir23MfFU3psq6pjavDeUF5hNS5OA@mail.gmail.com>
References: <cover.1630581434.git.mchehab+huawei@kernel.org>
        <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
        <YTC4LPDem9uKXyMd@kroah.com>
        <20210902151053.7ddfbe3a@coco.lan>
        <20210902153820.5624b57f@coco.lan>
        <YTDYFCH/DbK1SFVv@kroah.com>
        <20210902163529.734b8e0e@coco.lan>
        <YTEJuK50e5PBBJfO@google.com>
        <CALAqxLUxgRCUweDcE1WWV1gTsstZAvjUT6ZuTij5Mro8MHKi8Q@mail.gmail.com>
        <YTEuA+Z3f50RVGgX@google.com>
        <CALAqxLW_wwRFaWASsy6rFHir23MfFU3psq6pjavDeUF5hNS5OA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 2 Sep 2021 13:31:45 -0700
John Stultz <john.stultz@linaro.org> escreveu:

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
> 
> I guess that could be done, but I also feel like it's really just the
> regulator control, which is a pretty small part of the hisi hub driver
> logic.
> Additionally, if you look at the logic that handles the different
> setting configurations needed for the different roles:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/misc/hisi_hikey_usb.c#n97
> 
> You'll see the ordering of powering things on/off and switching the
> mux is a bit subtle.
> 
> So while I guess we could call some onboard_usb_hub hook for the hub
> power on/off calls (hub_power_ctrl() in the hisi driver), I'm not sure
> that really is saving much logic wise, and splits the details across
> an additional driver in an already somewhat complicated config.
> 
> Again, apologies if I'm being thick headed. :)

I agree with John here: this driver itself is really simple. It has less 
than 300 lines of code, as it just turns the regulator on/off, has one GPIO 
for the reset pin of the HUB, and two other GPIOs to turn on/off Type-C
power and to switch OTG phy. The actual OTG implementation is done at
the DWC3 driver and the Type-C support is provided by the RT1711H driver.

Splitting its code on two separate drivers, being one just to replace
the 20-30 lines of code that control the regulator sounds overkill
and will require a glue between those drivers that will likely be 
bigger than that. 

So, I guess the best is to keep this as a separate platform-specific
driver.

Thanks,
Mauro
