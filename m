Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AA23FF33E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbhIBSbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241834AbhIBSbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:31:01 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F237DC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 11:30:02 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q21so5300408ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mwRgrMFwQz0tqWAKg3InojRGPZBklTXN5vGQDujzdc=;
        b=DujDKssSYKnTJZHygGN7EYjvKLL0kxheyMAa8UY5l9+gLdpTFGQB4q/fbtZ1jA2Wfk
         /UVtiUb0zlzQZ/bL2GVn5G077yhQEA656mYfzZZ/Tss61Qkvg/0zO7WPg6hsIxqPTbQd
         +Z6u32hy4A/9LbdBdeObvduIYvq6qinYKMAHyOiCwceQSB3MtQ+6VWaDDvYYkPmXvbtT
         9gxAs8EqMQfrvdKTshEgnlEFaC78pmDPCwJYH+A/rckS1CjlOFMxUQycZ4l6STXNbZWr
         UzXAKyQdkwBgOnO4tspcQKEMVMMcrrBwF3/2Uv5tlDATTJ9wpNWr6BfyN/jk6NX047tj
         7aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mwRgrMFwQz0tqWAKg3InojRGPZBklTXN5vGQDujzdc=;
        b=d+8Sae/dEpzcgXAbZQ0gs+q3QfzWnLYHwPYtTZs4oOvHugTshCUnJMD+WtmEwGZmyC
         ZlCASfP7nay2nytrPjYNkyE1332QL77U2V+mp2aqfVaePHFoQ95I1MLch3I+lSw7TJ9F
         L57dXMtwVGoibC/hKwal8RalpTpS5bRi2UHHKGZ375XgoaiPYCk3drkRY6qdj3N7Iuv0
         zWWIMR37t92qLf36Y91DFDEAX+QTvw6sjCcEDKWXWs/Tek56mQWWomqZ/kdPm5pA48zp
         GNwXkCFPT5evfwnAvJGnczx6oW7txbAU+D8F8MXsEIHM10a7RT0FJKQ8B0LM+YD4KROv
         ue5w==
X-Gm-Message-State: AOAM531J7vRSdTyI92qcxlwLls2GIKdv3lXGuQyHFITsPlOVcltD8XF9
        p2SDy8hj1FenaTjLZxwlGfM6mktLYX8vCDp22OqibQ==
X-Google-Smtp-Source: ABdhPJyneURMf/qpSbeqMf1DOXD3nZmG9C/yONY7blBwufXpnDrjtxZDMMX7ej+rEyqen6g2DnUfwSsBVVtzaPDGcXI=
X-Received: by 2002:a05:651c:510:: with SMTP id o16mr3731605ljp.257.1630607401314;
 Thu, 02 Sep 2021 11:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1630581434.git.mchehab+huawei@kernel.org>
 <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
 <YTC4LPDem9uKXyMd@kroah.com> <20210902151053.7ddfbe3a@coco.lan>
 <20210902153820.5624b57f@coco.lan> <YTDYFCH/DbK1SFVv@kroah.com>
 <20210902163529.734b8e0e@coco.lan> <YTEJuK50e5PBBJfO@google.com>
In-Reply-To: <YTEJuK50e5PBBJfO@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 2 Sep 2021 11:29:49 -0700
Message-ID: <CALAqxLUxgRCUweDcE1WWV1gTsstZAvjUT6ZuTij5Mro8MHKi8Q@mail.gmail.com>
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

On Thu, Sep 2, 2021 at 10:28 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> On Thu, Sep 02, 2021 at 04:35:29PM +0200, Mauro Carvalho Chehab wrote:
> > Em Thu, 2 Sep 2021 15:56:36 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > > On Thu, Sep 02, 2021 at 03:38:20PM +0200, Mauro Carvalho Chehab wrote:
> > > > While I'm not sure how generic this driver can be, I'm thinking that
> > > > maybe a future patch could rename it to 'generic-usb-hub' or
> > > > something similar - finding a good name is always the hardest
> > > > part :-)
> > >
> > > Try looking at:
> > >     https://lore.kernel.org/r/20210813195228.2003500-1-mka@chromium.org
> > > for another example of this.
> >
> > (C/C Matthias here).
> >
> > Interesting to know that someone else is also needing to add support
> > for USB chips.
>
> Yeah, there were several attempts over the years, but so far none of
> them landed upstream ...
>
> > Yet, the approach took there won't work with HiKey 960/970, as
> > it needs to control not only the regulator, but it should also
> > work as as usb-role-switch.
> >
> > So, besides controlling the regulator, which seems to be basically what
> > the onboard_usb_hub_driver does, but it should also be able to:
> >
> >       - (optionally) reset the HUB;
> >       - control its OTG switch;
> >       - control power on/off for an USB type-C connector;
> >       - set USB role as host or device.
>
> > Perhaps it would be possible to merge both approaches by modifying
> > hisi_hikey_usb in order to add the extra bits required by the boards that
> > Matthias is currently working, and requiring the GPIOs for OTG and
> > type-C connectors only if DT contains usb-role-switch.
>
> I'm not convinced that a hub driver should be in charge of role switching.
> I wonder if the hub part could remain separate, and the role switching be
> done by a dedicated driver that interacts with the hub driver through
> some interface. From the above list the hub driver could still be in charge
> of:
>
> - (optionally) reset the HUB;
> - control power on/off for an USB type-C connector;
>
> Maybe the hub driver could implement a reset controller to allow the role
> switching driver to switch it on and off (including type-C power).
>
> The role switch driver (a leaner version of hisi_hikey_usb) could model
> the mux and switch the hub on and off, without being concerned about all
> the details.

Apologies, I may be misunderstanding you, but I think the missing
issue there is: "what triggers the hub driver to switch it on or off?"

For the hikey960/970 boards, removing/plugging in the usb-c cable is
what we use to enable/disable the mux/hub.

The current iteration (of which there have been many) of hikey hub
driver uses the role switch notification as its trigger. It's not
really controlling the role switching, just using that signal. That's
why the driver works as an intermediary/relay of the roleswitch
notification.

We had earlier efforts that had hacks to specific drivers as well as
attempts to add notifiers on role switches (but those were terribly
racy), so the intermediary/relay approach has been a great improvement
on reliability with little impact to other drivers.

thanks
-john
