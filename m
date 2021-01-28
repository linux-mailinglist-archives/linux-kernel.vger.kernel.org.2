Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FCC307C59
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhA1R0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:26:42 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:50083 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233019AbhA1RYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:24:31 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7AF4FDEE;
        Thu, 28 Jan 2021 12:23:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 28 Jan 2021 12:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Asut31g+3M2HqZz4XapZMGT0VSq
        4HgEgevdM142+ows=; b=MlCaZZYC2vjIZl2Q1MBRK/n2KWXI3lUJMxQgvbUUHd9
        dr5Evx5Fo0q3oVWfPeVSwLwcyhmUHCVkMr1Zo5x840ktkuTP3fFCVH9li23xk1no
        95awI9e4i18DWNuHMGMfo8nvML7l8GBKa/gvnkWgXwVnOEp0W1QBdYR5Z1aMBK18
        u+nQYA5jEDJUrFE65Gowz3uYfn2FemtFmuYpYpTAumr3G/al++4E8T6bvRGs2sSR
        D14stacGkUWdlqnLuw7Rgluzt0Ys3j1kAwZFGg3ebzv60xcNcbAR7hnzqzDksN4q
        WFZn7jDo9GLyrZrY56G+sxdyILvxMiiPKM7jlhGyxVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Asut31
        g+3M2HqZz4XapZMGT0VSq4HgEgevdM142+ows=; b=L8QNwCjSnlxF2nHIvunQyx
        FCPyVCuXm2drR2jJj00jQHEUi/Dh7YkoQYXmOtkGa8Wpum4PAgItKXYMexvMt75Z
        HD5HUYHGk39JLhhO+Ar/NdpG7vIcDueSdR06uPYwza4k47VBmYZoUxjK1Oftf7km
        IYSFkzcFgAlzyEPeVNYuDTRCYi9mybW7e7ruZbr9Fla2HGpKLiFA7f/O0A27VMWg
        L6HDtH6/Rh5Mrq1OrzgPfC/8M92SwEjwXLoTX19tm23zy/DRQj6G9s5siRbg4J7U
        bvs1yswOAPoHmEoaz3qUXRHXq1ppqLTCeJl01YL490T7YfHfQoU6htZ2zhn+oJRw
        ==
X-ME-Sender: <xms:E_MSYIgAnvp1S_X7qiGo3oJX4c8tzzg-yWE8ax7PHmSN56AYf_FOqg>
    <xme:E_MSYFRfRbjWORLAZFzrHswmYunY0NxHXxCQ1R-ofR8Sa3iwvNQLEFzgpb5I9r_yu
    4XtzH1o0DLnG2id8Ck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:E_MSYLH7SURqazu0mpwK6_c-pY-mptkQXbb0iRle5vkMQ3LO8UtGHg>
    <xmx:E_MSYNk5zB9iVwlHO3-ObmHl2ai1VSkk0c2m5Xx4a6nlKfblA04zmw>
    <xmx:E_MSYO02jWA-TZbIVZFffL5cYfyle-7IPkkQvgGzDHgfwXT9yE8VtA>
    <xmx:FfMSYCKzVYjfXDqYrTh8m1Oog-QlzgMdkYlEi2CRhajP2kts3vZv1Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A55F8240057;
        Thu, 28 Jan 2021 12:23:31 -0500 (EST)
Date:   Thu, 28 Jan 2021 18:23:29 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Alexandre GRIVEAUX <agriveaux@deutnet.info>
Cc:     robh+dt@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun5i: Add dts for inet86v_rev2
Message-ID: <20210128172329.ncuda3xlgpmefpqk@gilmour>
References: <20210124193903.21401-1-agriveaux@deutnet.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k4cm2m27ds2us2uy"
Content-Disposition: inline
In-Reply-To: <20210124193903.21401-1-agriveaux@deutnet.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k4cm2m27ds2us2uy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 24, 2021 at 08:39:03PM +0100, Alexandre GRIVEAUX wrote:
> Add Inet 86V Rev 2 support, based upon Inet 86VS.
>=20
> The Inet 86V use SL1536 touchpanel controller, the Inet 86VS a GSL1680,
> which make them both incompatible.
>=20
> Missing things:
> - Accelerometer (MXC6225X)
> - Touchpanel (Sitronix SL1536)
> - Nand (29F32G08CBACA)
> - Camera (HCWY0308)
>=20
> Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> ---
>  arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts | 17 +++++++++++++++++

You have to add it to the Makefile

>  1 file changed, 17 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
>=20
> diff --git a/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts b/arch/arm/boo=
t/dts/sun5i-a13-inet-86v-rev2.dts
> new file mode 100644
> index 000000000000..581083e932d8
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021 Alexandre Griveaux <agriveaux@deutnet.info>
> + *
> + * Minimal dts file for the iNet 86V
> + */
> +
> +/dts-v1/;
> +
> +#include "sun5i-a13.dtsi"
> +#include "sun5i-reference-design-tablet.dtsi"
> +
> +/ {
> +	model =3D "iNET 86V Rev 02";
> +	compatible =3D "inet,86v-rev2", "allwinner,sun5i-a13";

inet should be documented in the vendor prefixes, and that compatible
should be documented in Documentation/devicetree/bindings/arm/sunxi.yaml

Having the first rev compatible would be good too

> +
> +};

But I'm wondering. If there's nothing here to add, why would we need
that DT in the first place?

Maxime

--k4cm2m27ds2us2uy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBLzEQAKCRDj7w1vZxhR
xYadAP9cGrpBxSbb5zUUY68pocS+xBLJA4997Xpt7GBe3dmjyQD8D96d0GBJraQf
g4OEghijouKAGzvAj1MtjcmPWyhWtQw=
=jgSc
-----END PGP SIGNATURE-----

--k4cm2m27ds2us2uy--
