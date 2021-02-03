Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2F930D639
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhBCJYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:24:40 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37417 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233440AbhBCJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:22:12 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CCA085C02D0;
        Wed,  3 Feb 2021 04:21:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 03 Feb 2021 04:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Udngpf/YArB0jXH1yZKIilILRb8
        ZTIexwk+pRsrCm1M=; b=fIWTPfsLFHgStb7knpBcDme81WgPCBqqEh+fOcHj29W
        zVIxhakuLrwcstXG1jdf6vsSJfMpae5WUaFleTFD5MdBq2UY97qMgTfCZ90l25PZ
        t/TGXs3WA8c6enNaxFm53ra4cRpUt1VEe1YYVpB94RUQIkorFwnTo8t4bbm3GPiv
        N9qO45JD06wSx6e8NcIUJwj43DJMS+Yzm8KBzSbUC5VkcXHSL2oI4kScZ6s5LGIW
        eSvYVVp/Zen9XFskTy6JoupXfaYjshWQAp++G6d4VSdsKUKl9K5kb9efbpzyZNKe
        njMzS3zbI+5B9KXpWIb9YkszpfJ3CXwQ2FrFGQDCtiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Udngpf
        /YArB0jXH1yZKIilILRb8ZTIexwk+pRsrCm1M=; b=eFnSutXMeu+IvvojLp9fp1
        GsKe2cXhDjlEdHilH/7GClZw4oZzmLxjzn84fS3CsqTfee6azhl/w56ZldsiDQnZ
        PqyhQ5U/Fbyau+G/5M5FO3Gy90hQIVxdzIgXNYYxvX92S5vC6o8lyT74xPCV0Q/l
        c9KMD9W6uCT9KkgzHZKslipxKWZ7udR0MHpbvvc1ii3x0BLWBNj3RSi4sUa8g0H2
        Je3RnIisWo6HNDhytBeak9PvZ4AfyLCyYdsu/gHio0JBMVmsB3txARIHyfA5ODV6
        ta4g0Wbr/DsW21sTAkHko2usUWBWWpZTiZa5K19IDjkQW/tMEURzeefEHHidHAVw
        ==
X-ME-Sender: <xms:AGsaYNDT5sOCnSN7gNjGUiEJMPNTbcBg9kimHEdDzGyzeQJjYY6VbQ>
    <xme:AGsaYLgrS7dcRd4c3cR8FkJ6SaGe4-5GhBJwnOeXWLOiJjven9asAskqOsUQscuKJ
    x94HkO1qdmuaOj0QHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgedvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehff
    fgieejhffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:AGsaYIlFSWlVqftqt00xcLth2mXED9wwwcXDS2HNvAxTBICOPHV3UQ>
    <xmx:AGsaYHwd29VFOibAxesRNcaOZeCxeutCA8KMcUI8VKwiCHJk6w8B5g>
    <xmx:AGsaYCS6XN1dYIlcjmYdpFtYUSAJL7vP9QwwxSTaxNtsRS1zIkbekQ>
    <xmx:AWsaYAdqje8QemZEoueB0AhKsRJ8rSAcbbNFpFP0ZItJNOP8hO0JXQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 920F124005D;
        Wed,  3 Feb 2021 04:21:04 -0500 (EST)
Date:   Wed, 3 Feb 2021 10:21:03 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     agriveaux <agriveaux@deutnet.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun5i: Add dts for inet86v_rev2
Message-ID: <20210203092103.7nznjzlr2t3llwj5@gilmour>
References: <20210124193903.21401-1-agriveaux@deutnet.info>
 <20210128172329.ncuda3xlgpmefpqk@gilmour>
 <20210201171236.GA7024@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i4oddnffukordr7u"
Content-Disposition: inline
In-Reply-To: <20210201171236.GA7024@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i4oddnffukordr7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2021 at 06:18:18PM +0100, agriveaux wrote:
> On Thu, Jan 28, 2021 at 06:23:29PM +0100, Maxime Ripard wrote:
> > Hi,
> Hi,
> >=20
> > On Sun, Jan 24, 2021 at 08:39:03PM +0100, Alexandre GRIVEAUX wrote:
> > > Add Inet 86V Rev 2 support, based upon Inet 86VS.
> > >=20
> > > The Inet 86V use SL1536 touchpanel controller, the Inet 86VS a GSL168=
0,
> > > which make them both incompatible.
> > >=20
> > > Missing things:
> > > - Accelerometer (MXC6225X)
> > > - Touchpanel (Sitronix SL1536)
> > > - Nand (29F32G08CBACA)
> > > - Camera (HCWY0308)
> > >=20
> > > Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> > > ---
> > >  arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts | 17 +++++++++++++++++
> >=20
> > You have to add it to the Makefile
> >=20
> Ok.
> > >  1 file changed, 17 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
> > >=20
> > > diff --git a/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts b/arch/arm=
/boot/dts/sun5i-a13-inet-86v-rev2.dts
> > > new file mode 100644
> > > index 000000000000..581083e932d8
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
> > > @@ -0,0 +1,17 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2021 Alexandre Griveaux <agriveaux@deutnet.info>
> > > + *
> > > + * Minimal dts file for the iNet 86V
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "sun5i-a13.dtsi"
> > > +#include "sun5i-reference-design-tablet.dtsi"
> > > +
> > > +/ {
> > > +	model =3D "iNET 86V Rev 02";
> > > +	compatible =3D "inet,86v-rev2", "allwinner,sun5i-a13";
> >=20
> > inet should be documented in the vendor prefixes, and that compatible
> > should be documented in Documentation/devicetree/bindings/arm/sunxi.yaml
> >=20
>=20
> I forgot, but should be:
>=20
>       - description: iNet-86V Rev 02
>         items:
>           - const: primux,inet86v-rev2
>           - const: allwinner,sun5i-a13
>=20
> > Having the first rev compatible would be good too
>=20
> Unfortunatly, I didn't find inet86v rev1 on FCC website and on
> linux-sunxi.=20
>=20
> >=20
> > > +
> > > +};
> >=20
> > But I'm wondering. If there's nothing here to add, why would we need
> > that DT in the first place?
> >=20
> I prefer to add often instead of bulk adding, and to show there are some
> board to add missing things like those above.

Yeah, I get that, but the point really is that you're not really adding
anything here except an empty device tree.

Maxime

--i4oddnffukordr7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBpq/gAKCRDj7w1vZxhR
xY5dAP0RVBpUXOsucOwVWFpAeDXraWqu32KorINEixbtc5ylEwEA8Nq7CM+X98xN
d4oEJbzsgET1W3VsKcx+Gw95Plvd0wU=
=Rrst
-----END PGP SIGNATURE-----

--i4oddnffukordr7u--
