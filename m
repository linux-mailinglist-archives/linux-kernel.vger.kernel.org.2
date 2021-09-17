Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85FC40F158
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 06:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243809AbhIQEeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 00:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbhIQEeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 00:34:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8254FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 21:32:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso8911795wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 21:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CuxZghyhVhMfnxIfYloUb+CTfop3eq4J/ICJFqbMMf8=;
        b=SXEqjhF4dGbOnoYgk6/eDdrnHGP0EOWuZ08dsjC3oU+gYKO0eqB5H2jZN7CB+cVVeY
         Z7bPfXrI+zaDLZIgN7chkJS2OBhndXjM7ZGoEzc6pPePazSmSMzwWI8VCCFf76OZw71l
         HB7gpBWyLM823GM1yDbvTphpaYXxb4GagPikhluZAn5GdQxP054glYh692BSw1a84NMN
         FXujPWlJqqULT2XZRHApmvT82J60JZW06gUuWKtV27bKO/QPiTn6Cnfw5QoFOdl06WWq
         OZ0EwzQDgnF7ZPPl1Vc+TT9yLEd7TMb+96COTjMj/PuRJPSnYWRXwLI/NlH2epWWr46a
         c9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CuxZghyhVhMfnxIfYloUb+CTfop3eq4J/ICJFqbMMf8=;
        b=w6Rl1Nyhk8HvX0OG85g5SNDoWXVwtXqzNIJWOTR+5ekK1FWoZ/5nVVyHWSYHhgHxUQ
         aXJpLoqbArCMmOROntYbaCdWOjn0zLBbLCc8Nd1DpkIfQWs6OI2DF0mQGfcpY6JXARs4
         GKfNhy7PBtzFhNfAzXD7ggQg/SShW6vJAylVang1nfr4L3sqhteEC3te1y4VWUI/U5kv
         dXnkyRrfOp6X83QKgdNKXZQPOfExm0ImWK9XTdet/+QqkZgLh8Gsi1CF5m5yxkVJhvlz
         iZc8KvMxWoR6AlKJO/yWA9Rd0h8GEiwGbTbmUsV2kIyNp694NYzi3PFnMkE+qMJMhwU5
         xFyw==
X-Gm-Message-State: AOAM532HO/+/nr8klmw9Ot6d166I/WWrytb6zDiyG8W/uijZyHvGr6Jn
        Wt+6+gO0gXQ2xNdRzWp8uts=
X-Google-Smtp-Source: ABdhPJwX1EqPGztau07ROAQJGqZUGfnzWPLY3DF8DLxiE1yiX1YTIbCFB4a1VCbv76W7od5h2VARvQ==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr8349770wmi.31.1631853167032;
        Thu, 16 Sep 2021 21:32:47 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id b188sm5289640wmd.39.2021.09.16.21.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 21:32:46 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     linux-sunxi@lists.linux.dev,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Subject: Re: Issue with fw_devlink=on on 5.14
Date:   Fri, 17 Sep 2021 06:32:45 +0200
Message-ID: <1757257.sNEdEUkno9@jernej-laptop>
In-Reply-To: <CAGETcx-_sNJ1Z-8Bmqh+awi-2xnQQLjnJf+Zncj23ByDmJYDJQ@mail.gmail.com>
References: <5570111.f9yF5Hohu3@kista> <33995494.1UIDBzYVPQ@kista> <CAGETcx-_sNJ1Z-8Bmqh+awi-2xnQQLjnJf+Zncj23ByDmJYDJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/cc Maxime

Dne petek, 17. september 2021 ob 04:55:22 CEST je Saravana Kannan napisal(a=
):
> On Wed, Sep 15, 2021 at 11:59 AM Jernej =C5=A0krabec
>=20
> <jernej.skrabec@gmail.com> wrote:
> > /cc linux-kernel@vger.kernel.org
> >=20
> > Dne sreda, 15. september 2021 ob 20:36:11 CEST je Saravana Kannan=20
napisal(a):
> > > On Wed, Sep 15, 2021 at 11:23 AM Saravana Kannan <saravanak@google.co=
m>
> >=20
> > wrote:
> > > > On Wed, Sep 15, 2021 at 11:07 AM Jernej =C5=A0krabec
> > > >=20
> > > > <jernej.skrabec@gmail.com> wrote:
> > > > > Hi Saravana!
> > > > >=20
> > > > > I noticed that in kernel 5.14, at least on Allwinner H3, deinterl=
ace
> >=20
> > driver
> >=20
> > > > > doesn't load anymore if fw_devlink is set to on. If I set it to o=
ff,
> >=20
> > driver
> >=20
> > > > > loads and works without problems. If I remove interconnects prope=
rty
> > > > > in
> >=20
> > DT
> >=20
> > > > > node and use driver hack instead, it also loads and work ok.
> > > > >=20
> > > > > For reference, I speak about this node:
> > > > > https://elixir.bootlin.com/linux/v5.14/source/arch/arm/boot/dts/s=
un8
> > > > > i-h3.dtsi#L153> >=20
> > > Oh the dts file please. Not dtsi. I need the full picture of
> > > dependencies.
> >=20
> > I just dumped DTB from the board I use for testing this:
> > http://ix.io/3yZB
>=20
> I was basically asking for this:
> arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
>=20
> > > -Saravana
> > >=20
> > > > > Do you have any clue why it doesn't work?
> > > >=20
> > > > Kinda busy today and I'll take a close look later, but if you delete
> > > > "interconnect" but it works, then it seems like you have no driver =
for
> > > > your "mbus" interconnect? Is that expected?
> >=20
> > Ah, you're completely right. There is no MBUS driver (yet), since curre=
nt
> > purpose of that node is to determine DMA memory offsets and for that you
> > don't need a driver.
>=20
> Can you explain more how you get the DMA memory offsets in the code
> from this node?

Maxime, can you help with this?

>=20
> You might be able to add status=3D"disabled" to the mbus node and this
> would go away as fw_devlink doesn't cause a consumer to wait on a
> disabled supplier. See more below -- you have a bunch of options.
>=20
> > There is already WIP driver for it, though:
> > https://github.com/crust-firmware/linux/commit/
> > db34316a0194dbf0fcb8eba677ef11085a06a340
> >=20
> > > > If you have a driver, then make it use the proper driver model (pro=
be
> > > > a platform device).
> > > >=20
> > > > If you don't have a driver for it, I'm assuming you have
> > > > CONFIG_MODULES enabled. Otherwise, fw_devlink=3Don is smart enough =
to
> > > > know not to block on devices that'll never be probed.
> >=20
> > Correct, modules are enabled.
> >=20
> > > > If you do need CONFIG_MODULES enabled, then use
> > > > deferred_probe_timeout=3Dxxx so that fw_devlink doesn't wait for mo=
re
> > > > modules to be loaded past xxx seconds.
> >=20
> > It's not what I want, but more that we broke default configuration and
> > CONFIG_MODULES=3Dy should really work.
>=20
> Well, fw_devlink=3Don can't tell if you don't have a driver or if you
> are going to load it soon (since you have CONFIG_MODULES enabled). So
> if it's a board you are actively bringing up, one of the other options
> below might be good to use.
>=20
> > Is there any other way to fix this besides
> > providing dummy MBUS driver? I doubt it would be accepted for backporti=
ng.
>=20
> You could use fw_devlink=3Dpermissive in the kernel commandline, but it
> will disable a bunch of benefits of fw_devlink=3Don (no pointless
> deferred probes, no suspend/resume ordering based on dependencies
> listed in DT, etc).

I tried this one, but for some reason network driver didn't show up and the=
re=20
was crash when doing reboot. Even if it would work, I don't consider it as=
=20
proper solution because... (see below)

>=20
> Another option would be to use deferred_probe_timeout=3D1 in the kernel
> commandline, and this will cause this to be unblocked 1 second after
> late_initcall() and you'll get the benefit of fw_devlink=3Don for all
> the devices that have a driver registered by then (and some more
> devices too -- see commit text of
> d46f3e3ed5276e756caf40f760d4902d15c12dcb).

That would probably work (can't test atm), but as I said, I want solution=20
without adding any argument. Users are not familiar with any of this. From=
=20
their perspective, it looks like as the driver (not just this one, but also=
=20
others which use interconnects) was never enabled in kernel config in first=
=20
place.

So, if "status =3D disabled" works, then great. If not, something else must=
 be=20
found.=20

Note: I won't be able to test anything until next week.

Best regards,
Jernej

>=20
> -Saravana
>=20
> > > > Also I like to look up emails on lore, so when emailing me about
> > > > fw_devlink (or any Linux stuff in general I suppose), it'd be nice =
if
> > > > you can cc LKML.
> >=20
> > Noted.
> >=20
> > Best regards,
> > Jernej
> >=20
> > > > Thanks,
> > > > Saravana




