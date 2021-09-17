Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675CF40FD1C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbhIQPtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:49:52 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:55785 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343971AbhIQPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:49:49 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id E4D873200914;
        Fri, 17 Sep 2021 11:48:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 17 Sep 2021 11:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=fDrqAiKkTh/di0wnBvNl4ElHMUw
        aF9hP7mXIhAjdorE=; b=MhRTZhbCxUctdBSDpy3/ySDBIhavriObviDI5cc396u
        LzbAWDjCHxY12wkF+bCRRL0PImB/QHWM/5obURepNARozx2MsRhUXUeDYe+xoBxK
        FrxPOLAb9VXeLZ7i8C0bXPUCQ+1gX4NKQeAqLS2pjeSLZvWoXWk3z/RIRF5M7AiM
        DWkc8Uam/Htnd4ODYD9D1qJOmf2VsgSWsuhRix0u24LyP+vK76Fsvcpk0fKPU4kg
        uSX69cUM0/lx5wRF1rPu2ThMCZHsHMC7qfNliIPq/zjmTlFn4Sv+LFqYlMnH1bVB
        ZbmMl0xzxlRErFmCcKzr4EAtzjOPoG9dJTKBkYKMQCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fDrqAi
        KkTh/di0wnBvNl4ElHMUwaF9hP7mXIhAjdorE=; b=rxyve818Zslr7fTyiVUggq
        +MgKdbnkmbS5YM3kQHdZJzO5YmR0lSCsJJRdcb2gS6qSEMHTdW3lmCO9qXLUh/++
        sJbGTsmogOkAam8V7xk695CTDKwiH4MCspUyI2EsTDWOA+ZUBjY/JzddPprcvyQt
        xOu6XewErG8FhDycYhr73pVrrbQuQT+Fm2KxWJ4woM2ucUfzQMq4yz2wc//HCeVx
        n4oPBblslp/ijnvRWbttehcVUFdHdVUuzIMtVO/O0oJAfGaeIFZPsvW9e/vB+EQG
        +3dP3f8uLQlrvMAfckD/d10ECax1h8PLHRyNUYKroH34WI3IrIgaCAYOSjB1PwlA
        ==
X-ME-Sender: <xms:ybhEYXGrVxF61T9s3Hplmdh92hN1ZHf1uMt5qzPQ-Kj4UtQRnHSs4Q>
    <xme:ybhEYUWhfXjZoNCyA7N7PTSMna-2mVJGnD-W9EgNerKd2dnDMPZqHAOxv_L6NjOcM
    BGL6jjp-tg8g-Pfutk>
X-ME-Received: <xmr:ybhEYZIAXqX5ejj6_vJsTX1ivDYAeyl_YVi6mqg9Uu6RfiKZj6rLCmBVjWHtEfe00BrICQ3nOJr8So9oTe4GhS0fWD1M4ItezZgB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehiedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    sehgtderredttdejnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimh
    gvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnheplefgkeffudffleeijeef
    gffgtdegvdeuieetkedvueejfeegudehueehkedtleeknecuffhomhgrihhnpegsohhoth
    hlihhnrdgtohhmpdhigidrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ybhEYVHWBEU4h0MD14EeJQOCavksI1B_RbyNczXgBuVQ5gVO4wTAbg>
    <xmx:ybhEYdXKi8hYHL5am4JJSz1n37gOkmI3eTacCl8aWJwf0ZD2uxeTWQ>
    <xmx:ybhEYQNXAy-ES9xZbABa8KXcayRPiwOOaPoEEW5hcS7S--XSb3KRRw>
    <xmx:ybhEYQR6kHiWmp3kJ6fFPYWEw1ZHP_wdRjThnb1JGpu15VVcZ1KWOQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Sep 2021 11:48:24 -0400 (EDT)
Date:   Fri, 17 Sep 2021 17:48:23 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-sunxi@lists.linux.dev,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Issue with fw_devlink=on on 5.14
Message-ID: <20210917154823.jly4hsbe73bathce@gilmour>
References: <5570111.f9yF5Hohu3@kista>
 <33995494.1UIDBzYVPQ@kista>
 <CAGETcx-_sNJ1Z-8Bmqh+awi-2xnQQLjnJf+Zncj23ByDmJYDJQ@mail.gmail.com>
 <1757257.sNEdEUkno9@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cyyux7n7aa3lplag"
Content-Disposition: inline
In-Reply-To: <1757257.sNEdEUkno9@jernej-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cyyux7n7aa3lplag
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 17, 2021 at 06:32:45AM +0200, Jernej =C5=A0krabec wrote:
> Dne petek, 17. september 2021 ob 04:55:22 CEST je Saravana Kannan napisal=
(a):
> > On Wed, Sep 15, 2021 at 11:59 AM Jernej =C5=A0krabec
> >=20
> > <jernej.skrabec@gmail.com> wrote:
> > > /cc linux-kernel@vger.kernel.org
> > >=20
> > > Dne sreda, 15. september 2021 ob 20:36:11 CEST je Saravana Kannan=20
> napisal(a):
> > > > On Wed, Sep 15, 2021 at 11:23 AM Saravana Kannan <saravanak@google.=
com>
> > >=20
> > > wrote:
> > > > > On Wed, Sep 15, 2021 at 11:07 AM Jernej =C5=A0krabec
> > > > >=20
> > > > > <jernej.skrabec@gmail.com> wrote:
> > > > > > Hi Saravana!
> > > > > >=20
> > > > > > I noticed that in kernel 5.14, at least on Allwinner H3, deinte=
rlace
> > >=20
> > > driver
> > >=20
> > > > > > doesn't load anymore if fw_devlink is set to on. If I set it to=
 off,
> > >=20
> > > driver
> > >=20
> > > > > > loads and works without problems. If I remove interconnects pro=
perty
> > > > > > in
> > >=20
> > > DT
> > >=20
> > > > > > node and use driver hack instead, it also loads and work ok.
> > > > > >=20
> > > > > > For reference, I speak about this node:
> > > > > > https://elixir.bootlin.com/linux/v5.14/source/arch/arm/boot/dts=
/sun8
> > > > > > i-h3.dtsi#L153> >=20
> > > > Oh the dts file please. Not dtsi. I need the full picture of
> > > > dependencies.
> > >=20
> > > I just dumped DTB from the board I use for testing this:
> > > http://ix.io/3yZB
> >=20
> > I was basically asking for this:
> > arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
> >=20
> > > > -Saravana
> > > >=20
> > > > > > Do you have any clue why it doesn't work?
> > > > >=20
> > > > > Kinda busy today and I'll take a close look later, but if you del=
ete
> > > > > "interconnect" but it works, then it seems like you have no drive=
r for
> > > > > your "mbus" interconnect? Is that expected?
> > >=20
> > > Ah, you're completely right. There is no MBUS driver (yet), since cur=
rent
> > > purpose of that node is to determine DMA memory offsets and for that =
you
> > > don't need a driver.
> >=20
> > Can you explain more how you get the DMA memory offsets in the code
> > from this node?
>=20
> Maxime, can you help with this?

Sure, Jernej is right, the interconnects binding with the dma-mem name
is here to describe the path DMA accesses take between devices.

In our case, the registers accesses go through the usual busses, but the
DMA accesses go through a separate one controlled by the mbus controller
Jernej was talking about.

The driver core will then take this into account and apply any DMA
mapping the mbus controller has:
https://elixir.bootlin.com/linux/latest/source/drivers/of/address.c#L582

So it's entirely transparent to the consumer driver.

Maxime

--cyyux7n7aa3lplag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYUS4xwAKCRDj7w1vZxhR
xdh2AP46XGze/rsedwcLNrSmU/Q4Mz2R/XKJSzttmt1e5kR9bwEA/U/Kh4kQYt3d
qKJI6rkrJdzYM8NxQn8D7sGbq2JwdQA=
=IjO6
-----END PGP SIGNATURE-----

--cyyux7n7aa3lplag--
