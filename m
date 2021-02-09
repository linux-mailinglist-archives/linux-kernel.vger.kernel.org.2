Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB432315833
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 22:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhBIU6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 15:58:22 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58501 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233460AbhBISt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:49:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 90CB05C00C6;
        Tue,  9 Feb 2021 13:48:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 09 Feb 2021 13:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mn/e+tyB+vqs+N9FQI5skZmFa+C
        mDlJEVMgXGsgeRQg=; b=pFap7oB5xlNaYe1XETRZOA6q3yr3X+FF2Sv8V2+5fZY
        LlbaF6g46KKlUVDlJy4mUKtpg7daG9B2Jt3tBjgmr2f1I1yS9yD+YOxyBFKxUkoA
        9kjnxan4+gdt//VQPDXLIhSrCbeIOVEcd6kSl2pLRfpadC497h7HkAJ7ysuDpMBq
        zK0MQpD4nVk3ExkakOYGoHCcyQ66KZ/p1Qjbj1Ahd2nYJT+FnyTgwEVoWXFxBDET
        7VLXXCLLw8yfk9GXRUwzFrilv30z9CPweQ0nw9H871dgUKgQG9zZdbNxWTtnjLh0
        /4U3FpD5o774C11KzEL6ryw9MvFNB5qQPGSUAqwJNgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mn/e+t
        yB+vqs+N9FQI5skZmFa+CmDlJEVMgXGsgeRQg=; b=lf5innqnor77wXO8gLIMMt
        fX0pLyoYb4Ayeq8pc/WJnBWzBF9DkDrxNLeGdLGLDJYuoOf6f1xO/0VBPzEfbwFb
        6HXGDzWcvVl1uf9piofbuMXm0fr3twoSTwvswievxWQ6bkkJJBUN17zh1JnBuLmq
        kVtoBk2UTqFkltgGvQ1Nzps7AspD2b0h9qribxFOp/mk/lTSIv5zABq0/HyFRnSh
        NXoIPCGeSYptQMK5w+0i6fra1qAIcQ/3jz2zwmJwaNNXU3X0jdX8vp9IC0WW5ks7
        fecPcfpDt5xWsx/vf6kB435KivJ8CiWPYP+amTaFtBYtEGP58AMA+El313cmcWlQ
        ==
X-ME-Sender: <xms:DdkiYDXtnz_rWB9WFmGZ4scLB7uyVMGgB8Zr_RBTThkhuSeytbKGQQ>
    <xme:DdkiYLm5B7EQlY2Mb8D9pqqsvYi_ChmiYIGQYLqbpGrsbwsuzlIStVO93cF7kjjEq
    WIWedCL87gqhFcoLTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheehgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteduffeihfehvdfgueefjeevvdevffffieekuddvjeeugfeiffegtddutdef
    kedtnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghdpghhithhhuhgsrdgtoh
    hmnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:DtkiYPahEu3ukZiKAai1X8hHigvXTX7B4yXjmjbqpmwimsdcqiythg>
    <xmx:DtkiYOVlHZaUqoJ_AdgXVq4O2lR7VKSAp2g2hjdBFD_Ky_IYEwBgKA>
    <xmx:DtkiYNnkbxVeiNr522YvBitIxGUFVYQF5cqQjHDV4jd3Z_mKbnkC4g>
    <xmx:D9kiYAsCGvoMikYr_xgF2dcOeGNA4q912dJpXsGRC_IKVzWMen7KgA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BDE791080059;
        Tue,  9 Feb 2021 13:48:45 -0500 (EST)
Date:   Tue, 9 Feb 2021 19:48:43 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <20210209184843.h4nky5wi6ncfrowq@gilmour>
References: <cover.1608721968.git.wilken.gottwalt@posteo.net>
 <ef9657337a9a033bcbac2bc14805398b907835d6.1608721968.git.wilken.gottwalt@posteo.net>
 <CAL_JsqKZ44fDZzvY+Z0J5eMqjxGX3LM=MoJzV9Y7Y7Wisf2bnA@mail.gmail.com>
 <20210207100731.58f1c621@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j5dfin6j47kmkfum"
Content-Disposition: inline
In-Reply-To: <20210207100731.58f1c621@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j5dfin6j47kmkfum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 07, 2021 at 10:07:31AM +0100, Wilken Gottwalt wrote:
> On Wed, 23 Dec 2020 15:49:19 -0700
> Rob Herring <robh+dt@kernel.org> wrote:
>=20
> > On Wed, Dec 23, 2020 at 4:34 AM Wilken Gottwalt
> > <wilken.gottwalt@posteo.net> wrote:
> > >
> > > Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> > > compatible SoCs.
> >=20
> > Please resend to DT list so that automated checks run and it's in my
> > queue (PW). You need to run 'make dt_binding_check' as there are
> > several issues.
>=20
> Mentioning somewhere, that yamllint is required would have helped here a =
lot.
> Without it I always ended up with that, what was quite misleading:
>=20
> ERROR: dtschema minimum version is v2020.8.1
> make[1]: *** [Documentation/devicetree/bindings/Makefile:12: check_dtsche=
ma_version] Error 1
> make: *** [Makefile:1370: dt_binding_check] Error 2
>=20
> > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > > ---
> > > Changes in v5:
> > >   - changed binding to earliest known supported SoC sun6i-a31
> > >   - dropped unnecessary entries
> > >
> > > Changes in v4:
> > >   - changed binding to sun8i-a33-hwpinlock
> > >   - added changes suggested by Maxime Ripard
> > >
> > > Changes in v3:
> > >   - changed symbols from sunxi to sun8i
> > >
> > > Changes in v2:
> > >   - fixed memory ranges
> > > ---
> > >  .../bindings/hwlock/sun6i-a31-hwspinlock.yaml | 44 +++++++++++++++++=
++
> > >  1 file changed, 44 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/hwlock/sun6i-a3=
1-hwspinlock.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspi=
nlock.yaml
> > > b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml =
new file mode 100644
> > > index 000000000000..481c5c995ad7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.y=
aml
> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/hwlock/sun6i-hwspinlock.yaml#
> >=20
> > This will fail checks. Wrong filename.
> >=20
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SUN6I hardware spinlock driver for Allwinner sun6i compatible=
 SoCs
> > > +
> > > +maintainers:
> > > +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > > +
> > > +description:
> > > +  The hardware unit provides semaphores between the ARM cores and th=
e embedded
> > > +  companion core on the SoC.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: allwinner,sun6i-a31-hwspinlock
> > > +
> > > +    reg:
> > > +      maxItems: 1
> > > +
> > > +    clocks:
> > > +      maxItems: 1
> > > +
> > > +    resets:
> > > +      maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - resets
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    hwspinlock@1c18000 {
> >=20
> > hwlock@...
>=20
> sprd, stm32 and omap using hwspinlock. Why is it okay there and not okay =
in
> my version?

The spec mandates hwlock:

https://github.com/devicetree-org/devicetree-specification/blob/master/sour=
ce/chapter2-devicetree-basics.rst#generic-names-recommendation

They probably introduced their nodes before it was standardized (or
didn't care).

> > > +      compatible =3D "allwinner,sun6i-a31-hwspinlock";
> > > +      reg =3D <0x01c18000 0x1000>;
> > > +      clocks =3D <&ccu CLK_BUS_SPINLOCK>;
> > > +      resets =3D <&ccu RST_BUS_SPINLOCK>;
> >=20
> > You need an include for these defines.
>=20
> So I guess it is needed because I the clocks/resets are used, right? But =
why
> is it not the case for the sprd example, which also uses clocks?

If you're talking about sprd,hwspinlock-r3p0, it doesn't use any define
(and thus doesn't need any include), and it's a binding in a text format
that wouldn't compile the example (this is only done for yaml bindings).
Even if it was wrong for them to do so, they wouldn't notice.

Maxime

--j5dfin6j47kmkfum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYCLZCwAKCRDj7w1vZxhR
xaudAQDt6b9Ux+yzMkOmj/0R/JkmEaYT1zT9InRA27NEa47CzwD/djOFhXxETW1C
lElLsobXqtoU+HgYfU/zWr13my0B+Q4=
=+7wD
-----END PGP SIGNATURE-----

--j5dfin6j47kmkfum--
