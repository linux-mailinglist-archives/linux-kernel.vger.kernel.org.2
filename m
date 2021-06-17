Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7345C3AB7CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhFQPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:45:01 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:57367 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229584AbhFQPo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:44:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E224C580660;
        Thu, 17 Jun 2021 11:42:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 17 Jun 2021 11:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=SWPnTQRfkaFfu4vFG9vDxCIwimL
        XicsHLsu00NcXCJE=; b=yrq+ST+lglXwSlhjUG2LssImGLAFgbLfENV6a7ng0TO
        Gj98VK0znk1e4z4Q1Tj4lNT4TlXuPNpqxQcNGKpmYt0MLnDzewHo6bGs69LhM/cV
        IdGKmW45YS9FHiLXZdP93iNdCB9qIvHHpyPLrklbfzyXi1sBfbh6886OL7mPce2L
        yLypTFumadCLS4Z6OaXGa7IjT5J3t20gDB1O5fZvGutrDr6+UL77qxbUeVEUcfu0
        LC92kmSJU23zAKgPZYnwcl6XsVq7qGa1peg0BCi9xs1csDYyYP/ClYfEpEbJ/hct
        cjvD62V5w/mDH9bwOGgfGh32g+kaGpsOGJECTw+eZMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SWPnTQ
        RfkaFfu4vFG9vDxCIwimLXicsHLsu00NcXCJE=; b=CcBmOiq53FpEGuzUH6keei
        CE37FFHy5iJWYyMTEzMybAub78ZzE2fEyNooKa6W1it1n/MB9rVomvhPzAg413ha
        TkVH5EkgHicxMV7NUQ84mSe0W8ZjQYtlwsSa5AELpUfbOFUOj3bNqbmVUEDCs6/a
        Xb9EbyvxCESXpTJtMoJKxG9KxqOQVHHBTxFI8grlE35siGuRshBbbzJd74rwKad0
        0VNdLLtwAQUMjGAM8XRYT2hbsrGocFP2FeIYDk5fsz8FcDT+jGALUflsA30hOXvv
        liRms8/bGyW1EmBWjSxMpNzquwyR5Tm0EW4nezm55AgoihjT9G9DzQl59VYHu2eg
        ==
X-ME-Sender: <xms:dW3LYNyOw6Yakw00h6WDsPJ913WPVkPCNsBR2kuz2H5_efirezC0QQ>
    <xme:dW3LYNSXY3bL9g4jeVci2H5XRKOD7tvhFPj8aThN-EBgGQpdFZlOXOCeGgG3u1xkL
    NOCWWMDZ4AYLjABpEE>
X-ME-Received: <xmr:dW3LYHV1oKkWd9vx74QX2nBXPZwci1w3d2GMDmwhpMIez29_HbUNLKJyD3L_mkQx2HS2BJVsaiVUcGuClFTpkHSu3IvDXitpYYqf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefuddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:dW3LYPiMmGX6U5iYGNTDrpekWKb9SjMfv-2o-E8SEUYsOYA14kz_Hw>
    <xmx:dW3LYPCZfpERer1OXdwCdhUISuR3w5G2T0_iZFnjrjvd4D9slu8MOg>
    <xmx:dW3LYILHWzscVG--yAowNHJ7MrI5_CWzIFu4BbVpDpvkSMqP317_Aw>
    <xmx:dm3LYD6Ifz-XBkfYaTPon3mI5H2_uiaqv_Jr5k9kBqfxqkFoqo7Igw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jun 2021 11:42:44 -0400 (EDT)
Date:   Thu, 17 Jun 2021 17:42:42 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 16/19] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
Message-ID: <20210617154242.iovbze64up4u7wba@gilmour>
References: <20210615110636.23403-1-andre.przywara@arm.com>
 <20210615110636.23403-17-andre.przywara@arm.com>
 <20210616092355.ndhjelwcch6umdxg@gilmour>
 <20210616110630.54061205@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t7w22vggbyprtpeo"
Content-Disposition: inline
In-Reply-To: <20210616110630.54061205@slackpad.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t7w22vggbyprtpeo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 11:06:30AM +0100, Andre Przywara wrote:
> > > +	reserved-memory {
> > > +		#address-cells =3D <2>;
> > > +		#size-cells =3D <2>;
> > > +		ranges;
> > > +
> > > +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
> > > +		secmon_reserved: secmon@40000000 {
> > > +			reg =3D <0x0 0x40000000 0x0 0x80000>;
> > > +			no-map;
> > > +		};
> > > +	}; =20
> >=20
> > Can't this be added by ATF directly?
>=20
> It actually is, and if you use U-Boot's DT ($fdtcontroladdr), that
> actually works. But as it stands right now, U-Boot fails to propagate
> this to any DTB that gets *loaded*. Fixing this requires generic code
> fixes, so I can't just hack this in for sunxi quickly.
> So I wanted to keep this around for a while, as missing this is a
> showstopper for booting Linux.

It looks like we didn't need it for the H6, what makes it any different?

> > > +		mmc0: mmc@4020000 {
> > > +			compatible =3D "allwinner,sun50i-h616-mmc",
> > > +				     "allwinner,sun50i-a100-mmc";
> > > +			reg =3D <0x04020000 0x1000>;
> > > +			clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> > > +			clock-names =3D "ahb", "mmc";
> > > +			resets =3D <&ccu RST_BUS_MMC0>;
> > > +			reset-names =3D "ahb";
> > > +			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> > > +			pinctrl-names =3D "default";
> > > +			pinctrl-0 =3D <&mmc0_pins>;
> > > +			status =3D "disabled";
> > > +			max-frequency =3D <150000000>;
> > > +			cap-sd-highspeed;
> > > +			cap-mmc-highspeed;
> > > +			mmc-ddr-3_3v;
> > > +			mmc-ddr-1_8v; =20
> >=20
> > This is not something you know in the DTSI? It entirely depends on how
> > the board has been designed.
>=20
> Are you referring just to the last property?

Initially, yes, but the argument is for both...

> This is copying what the driver unconditionally sets for the other
> SoCs at the moment (minus the H5 screwup):
> 	mmc->caps      |=3D MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
> IIUC 1.8V operation requires a 1.8V regulator for vqmmc to actually
> work, so this property alone won't enable anything.
> But if it's just about the 1.8V property, I can of course move this to
> the board dts files.

=2E.. Since we've seen boards with only 3.3v or 1.8v wired to vqmmc, so we
should really just push this to the boards for new SoCs

Maxime

--t7w22vggbyprtpeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYMttcgAKCRDj7w1vZxhR
xYuxAQC4DK94cK//kqLdN06cPTgsn+qQG/7QfkvwdrEDvnBzbgD/fYWoEpCgghlW
xMt7mnfP2LovSgcCpR1FSHcmleg/Ywg=
=3fMO
-----END PGP SIGNATURE-----

--t7w22vggbyprtpeo--
