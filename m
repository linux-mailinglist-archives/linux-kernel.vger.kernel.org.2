Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9043FF4F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbhIBUdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhIBUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:32:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277F1C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 13:32:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m28so7060049lfj.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tB+7qSOeuYNf39jZnFuQoVu8qlvAHD86dE4WROXUlnk=;
        b=Ld872oG9YKkkrZG0AO/alnPtDM6jS3xYmLXI9PelXPwtk6InhSgj4Eq0nauNTxvWK9
         U3MWzKO73rqftR2glFNQI2b11ER9UF864fIdMHSGzH/vCpZ4xk7PdFjUprYTnzoiM1OT
         aJW1rVwgsCwQR1M5x6Q/O2tQxvJTbyq3czI1gbvF/fBW5uJfwJYqPsdlAbtQi/Dzvekc
         WdS+9g+O0XVnhUsNVKL2B+jKGRLPKkcPR9L7iXe5UNy9yxU0+32MBnM+vXbIwtW/NvuS
         TAD79crbe0cqbgwpQP4l8BJd9V0RNOMg8WRNfTFd4fsCKDXHGZ20D94O8VqN/kMKhBEY
         OXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tB+7qSOeuYNf39jZnFuQoVu8qlvAHD86dE4WROXUlnk=;
        b=Abv7+ucay47VHIXlq9gdAk9etuMHslY6SYg3vGdwMe2vqcPm+y+M4/6nOflPxUeVYU
         Zp7SlR2xb8XubfO1FT9IgUZdiOidb91D7sb1OFwy7+TyBC0LHKKK8ke40zWVAD2vjM9V
         ZxDcmbXhixfmeeFeN+JnW3K2UBeHLZBB2nwmLPEnre+kLx8Dsx0m/m5M3nPolFm/4mCv
         /Oe/gDurC/hyyajiIcv3sDqqaX4utJR5yyX6Uh2nalyT41QzR/dBpGfRQIK5VxuB7duS
         VJKntkytLtxCAOdirIfOd1cHAMldV8CXUB1vud1ZZc4Ha3+FxECFFbn7aPF5ulI02cmf
         1oeg==
X-Gm-Message-State: AOAM531f1B5qU4dPLsk+3tfBYURTIPdml7m1Jedgu4sDiEAhwMrUR9Ts
        T4xlkrnY+AjWn78Anu8a+CfcL/9Qh8Avo0eZVvPTPUE/z7R5DA==
X-Google-Smtp-Source: ABdhPJy0F0TeKbXJLAK3uhfrPGNwSSMdXtavAuSKOXiPwydKicbW4DmjEI0Gfstl/BOWx1TeJfd1EA9Gty246e5vr68=
X-Received: by 2002:a05:6512:68:: with SMTP id i8mr28549lfo.204.1630614718382;
 Thu, 02 Sep 2021 13:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1630581434.git.mchehab+huawei@kernel.org>
 <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
 <YTC4LPDem9uKXyMd@kroah.com> <20210902151053.7ddfbe3a@coco.lan>
 <20210902153820.5624b57f@coco.lan> <YTDYFCH/DbK1SFVv@kroah.com>
 <20210902163529.734b8e0e@coco.lan> <YTEJuK50e5PBBJfO@google.com>
 <CALAqxLUxgRCUweDcE1WWV1gTsstZAvjUT6ZuTij5Mro8MHKi8Q@mail.gmail.com> <YTEuA+Z3f50RVGgX@google.com>
In-Reply-To: <YTEuA+Z3f50RVGgX@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 2 Sep 2021 13:31:45 -0700
Message-ID: <CALAqxLW_wwRFaWASsy6rFHir23MfFU3psq6pjavDeUF5hNS5OA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] misc: hisi_hikey_usb: change the DT schema
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Arnd Bergmann <arnd@arndb.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 1:03 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> On Thu, Sep 02, 2021 at 11:29:49AM -0700, John Stultz wrote:
> > The current iteration (of which there have been many) of hikey hub
> > driver uses the role switch notification as its trigger. It's not
> > really controlling the role switching, just using that signal. That's
> > why the driver works as an intermediary/relay of the roleswitch
> > notification.
>
> Apologies too, my terminology wasn't very clear, I had little exposure to
> OTG so far.
>
> The hisi_hikey_usb driver doesn't control the role of the USB controller,
> however it deals with platform specific role switching stuff, like muxing
> the USB PHY to the hub (host mode) or directly to the type-C port (device
> mode), or controlling the power of the type-C port.

True, though the exact configuration of powering type-c port, the mux
and the hub power that we want to set depends on the role.

> > We had earlier efforts that had hacks to specific drivers as well as
> > attempts to add notifiers on role switches (but those were terribly
> > racy), so the intermediary/relay approach has been a great improvement
> > on reliability with little impact to other drivers.
>
> I can see how raciness can be a problem. I'm not proprosing to use
> notifiers in the driver that deals with the hub, from the hub's
> perspective it is connected to a host port and it shouldn't have to care
> about OTG.
>
> But the 'hub driver' could expose a synchronous interface that allows the
> hisi_hikey_usb driver to power the hub on and off (or keep it in reset).
> That would maintain the relay approach, but without having a driver that
> tries to do too many things at once. For example the onboard_usb_hub driver
> has the option to power the hub down during suspend if no wakeup capable
> devices are connected downstream, I'm not convinced that this and the
> handling of the mux should be done by the same driver.

I'm not sure I'm totally following your proposal, so apologies if I
have it wrong.
It seems you're suggesting to move just the hub power logic out of the
hisi hub driver, and utilize the onboard_usb_hub driver for that?

I guess that could be done, but I also feel like it's really just the
regulator control, which is a pretty small part of the hisi hub driver
logic.
Additionally, if you look at the logic that handles the different
setting configurations needed for the different roles:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/misc/hisi_hikey_usb.c#n97

You'll see the ordering of powering things on/off and switching the
mux is a bit subtle.

So while I guess we could call some onboard_usb_hub hook for the hub
power on/off calls (hub_power_ctrl() in the hisi driver), I'm not sure
that really is saving much logic wise, and splits the details across
an additional driver in an already somewhat complicated config.

Again, apologies if I'm being thick headed. :)

thanks
-john
