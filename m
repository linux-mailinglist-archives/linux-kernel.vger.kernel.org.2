Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD23F77EC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241906AbhHYPBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:01:38 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37715 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241879AbhHYPBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:01:37 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5818A5810BD;
        Wed, 25 Aug 2021 11:00:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 25 Aug 2021 11:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=WID1l5X7U8YxqjXZqsmvhcrAsPo
        oKsOJYvzqLrJdSPA=; b=dGGywyYmJerrUumTc+XYh1IDqk7X305XDPOgV88/Cqo
        RHh7qvj4lHFMO7IR8FFGn7yow5UHM0oGvITQb2aA40D6j6bekRZScyfwuFhb6+EA
        qKTQOju/Lj0MV8p0Ch7z0QoM2iuNDNCab4agNizW2iCEjTw08JQyUuum+r4sVDDE
        W1RJAjOMb2kfgNJWeSNSty7nvNknxYEgvkGI7eI6cDyG1pT0cluLF39jGUvqpFwV
        5Ky8eicmOGtxpqgaiAGP5KVntFRLTP8awqpRaV5DLIMy+Zy3EE1Kei35Q2kA0HHk
        YPkoQvQtnQN3lYCG0qkTIkaDWNNGJ3efGUP5EWyeSng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WID1l5
        X7U8YxqjXZqsmvhcrAsPooKsOJYvzqLrJdSPA=; b=mGJ3ThWY5sMMhf8+rEnpNK
        46Q/Ic0ZLdwU3APnmNnFEMfXR14mStZXPkeQ1/f1kFPbFgeXTn2Yv0gHHp8bRySS
        AOwdFDkUYYzLqq4RG/tRzFOkdCsYoPCQpoK3vCqYVM0yx7bwC7Lg/J5joc10bD3U
        DKmt6EuH/Cs5fPBEnTss6V0zIezTLOgUWYBgoHW74Wd0W2X9wi/nFsZF+d/h4ceU
        msqHyAaESe/pZbTnuKQ0Wd1FMafGnnhlKDGC7U61QTbNY7Q9ndC8+nMCALY2vRfJ
        7UFOPOGNc5DDAlgTYeqR8hTZPJP/oab/pa1o7IBQ7MjjuSDXkSnp2bDDinvnFDFA
        ==
X-ME-Sender: <xms:IFsmYXcGf2UAMSy7q9ORwsqXv7rVvv0lHTt6e1qM0fC0dMtNMCy8MQ>
    <xme:IFsmYdPGjsY823OrKansCHiPQFJCjcPUW1xOSKMwkpPPrbY9gVzW2x62u1fDg-WJT
    vB9WMP9-ms6jzswz0Q>
X-ME-Received: <xmr:IFsmYQiSUA0eBeYPXyZ42IWiHL5wkjcSXJJakjVCSKW0AO0tkRBMGJhwzmXCqvdg1Ie9R7gYXUtobuEgds_i1mMS1Zg69WOyMwyJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedvtdffteetleegffefjedujefgieegveeivdekfefggeejffejlefhudeg
    fedunecuffhomhgrihhnpehlihhnuhigqdhsuhhngihirdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhho
    rdhtvggthh
X-ME-Proxy: <xmx:IFsmYY_JxOIRHgMQIZfrIvDXW4DcXxWFY4P1RTPsqCgK7oWFmXS-iQ>
    <xmx:IFsmYTsQ-GiwyBwppQMem4qGjH4g_CDK1bbj9DpaQ6hvwmaftIpiXQ>
    <xmx:IFsmYXGHfjExtDvzXEEKvz-oT-4xA-rrv9Pp748HJyXZF4fvIikFfg>
    <xmx:I1smYXFY-YtYdFy8YD7q3OL9rHwQccGslc0mqMuEbm9a0PVVqNPYXg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Aug 2021 11:00:47 -0400 (EDT)
Date:   Wed, 25 Aug 2021 17:00:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <icenowy@sipeed.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/17] arm64: allwinner: dts: add DTSI file for R329 SoC
Message-ID: <20210825150046.dpua45aeqrndxzbu@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-16-icenowy@sipeed.com>
 <20210818090139.rllz4fvvq3pzdkls@gilmour>
 <74F51516-2470-4A49-972B-E19D8EDD9A3D@sipeed.com>
 <75ae9ef8-496b-68ca-214e-e8b270648a50@sholland.org>
 <8e4a49b8-8f17-d659-0952-0c96b0098139@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qbmzml4ir2p77uxu"
Content-Disposition: inline
In-Reply-To: <8e4a49b8-8f17-d659-0952-0c96b0098139@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qbmzml4ir2p77uxu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 19, 2021 at 10:06:43PM -0500, Samuel Holland wrote:
> On 8/18/21 9:32 PM, Samuel Holland wrote:
> > On 8/18/21 4:15 AM, Icenowy Zheng wrote:
> >> =E4=BA=8E 2021=E5=B9=B48=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=885:01:39, Maxime Ripard <maxime@cerno.tech> =E5=86=99=E5=88=B0:
> >>> On Mon, Aug 02, 2021 at 02:22:10PM +0800, Icenowy Zheng wrote:
> >>>> +		ccu: clock@2001000 {
> >>>> +			compatible =3D "allwinner,sun50i-r329-ccu";
> >>>> +			reg =3D <0x02001000 0x1000>;
> >>>> +			clocks =3D <&osc24M>, <&rtc 0>, <&rtc 2>;
> >>>> +			clock-names =3D "hosc", "losc", "iosc";
> >>>
> >>> Do we have a clock tree for the RTC? Is it the same than the H616?
> >>
> >> Nope, it's the same with H6 because of external LOSC crystal is
> >> possible. (Although production M2A SoMs has it NC for cost control.)
> >=20
> > It is not the same as the H6, either. The clock tree _is_ identical to =
the D1,
> > which has three diagrams on pages 363-364 of its user manual here:
> >=20
> > https://dl.linux-sunxi.org/D1/D1_User_Manual_V0.1_Draft_Version.pdf
> >=20
> > Compared to the H6, the R329/D1:
> >  - Loses the LOSC calibration circuit
> >  - Gains a third mux input for LOSC (not external 32k) to fanout
> >  - Gains a mux to choose between LOSC and HOSC/750 for the RTC clock
> >  - Gains an SPI bus clock input divided from the PRCM AHB
> >=20
> > Compared to the H616, the R329/D1:
> >  - Has an external 32k crystal input
> >    - Gains the IOSC vs. external 32k crystal mux for LOSC
> >    - Switches fanout mux input #1 from pll_periph0/N to external 32k
> >  - Gains a mux to choose between LOSC and HOSC/750 for the RTC clock
> >  - Gains an SPI bus clock input divided from the PRCM AHB
> >=20
> > So the R329/D1 RTC has three^Wfour inputs:
> >  - SPI clock from PRCM
> >  - 24 MHz DCXO crystal
> >  - 32 kHz external crystal (optional)
>=20
> Whoops, I missed one here:
>  - Bus clock from PRCM
>=20
> The SPI clock is new for R329, but the bus clock has been around since H6.
>=20
> > and four outputs:
> >  - 16 MHz "IOSC" RC oscillator
> >  - 32 kHz "LOSC"
> >  - ~1 kHz for RTC timekeeping
>=20
> Even though this is internal to the RTC, it is still useful to model, as =
it can
> be used to correct for known RTC drift. (For example, HOSC/750 is 32000 Hz
> instead of 32768 Hz, so 2.34375% slow. But that is better than IOSC, whic=
h has
> unknown error.)

If it's not useful to any other device, there's no real reason to model
it in the clock framework. We should still force the source of the RTC
to the most accurate option we have, but we can do that without the CCF.

Maxime

--qbmzml4ir2p77uxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYSZbHgAKCRDj7w1vZxhR
xatPAP9SpY3ZG2Q2edvu8/rFpZAHUNCGGnz4rAG/qaugjp1l2AD8CnjkVWrr8xFL
TtZt3w3Zrp8/E1OFyaW5O76k4StSzgo=
=l0B8
-----END PGP SIGNATURE-----

--qbmzml4ir2p77uxu--
