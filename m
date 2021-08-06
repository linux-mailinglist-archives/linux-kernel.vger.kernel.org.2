Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF823E2935
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245370AbhHFLMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:12:12 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:43851 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245327AbhHFLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:12:09 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 2DC09C87F1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 11:11:53 +0000 (UTC)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 08710C0002;
        Fri,  6 Aug 2021 11:11:30 +0000 (UTC)
Date:   Fri, 6 Aug 2021 13:11:30 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 1/7] phy: Distinguish between Rx and Tx for MIPI D-PHY
 with submodes
Message-ID: <YQ0Y4ueALPNEAoMI@aptenodytes>
References: <20210624184108.21312-1-p.yadav@ti.com>
 <20210624184108.21312-2-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jvfpZGZYLc0FT7gn"
Content-Disposition: inline
In-Reply-To: <20210624184108.21312-2-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jvfpZGZYLc0FT7gn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 25 Jun 21, 00:11, Pratyush Yadav wrote:
> From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> As some D-PHY controllers support both Rx and Tx mode, we need a way for
> users to explicitly request one or the other. For instance, Rx mode can
> be used along with MIPI CSI-2 while Tx mode can be used with MIPI DSI.
>=20
> Introduce new MIPI D-PHY PHY submodes to use with PHY_MODE_MIPI_DPHY.
> The default (zero value) is kept to Tx so only the rkisp1 driver, which
> uses D-PHY in Rx mode, needs to be adapted.

After some thinking and discussions, it appears that using the submode is
probably not the best way to distinguish between rx and tx. This is because
rx/tx is more of a specification of the hardware component than a run-time
descision. Indeed the D-PHY blocks are usually dedicated to an associated
controller (DSI or CSI-2) and thus each instance is either meant for tx or
rx use.

As a result I will be using the allwinner,direction string property in
device-tree instead of the submode, with values of either "rx" or "tx".
I suppose you can do something similar if you agree it makes more sense.

Cheers,

Paul
=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>=20
> (no changes since v1)
>=20
>  include/linux/phy/phy-mipi-dphy.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/include/linux/phy/phy-mipi-dphy.h b/include/linux/phy/phy-mi=
pi-dphy.h
> index a877ffee845d..0f57ef46a8b5 100644
> --- a/include/linux/phy/phy-mipi-dphy.h
> +++ b/include/linux/phy/phy-mipi-dphy.h
> @@ -6,6 +6,19 @@
>  #ifndef __PHY_MIPI_DPHY_H_
>  #define __PHY_MIPI_DPHY_H_
> =20
> +/**
> + * enum phy_mipi_dphy_submode - MIPI D-PHY sub-mode
> + *
> + * A MIPI D-PHY can be used to transmit or receive data.
> + * Since some controllers can support both, the direction to enable is s=
pecified
> + * with the PHY sub-mode. Transmit is assumed by default with phy_set_mo=
de.
> + */
> +
> +enum phy_mipi_dphy_submode {
> +	PHY_MIPI_DPHY_SUBMODE_TX =3D 0,
> +	PHY_MIPI_DPHY_SUBMODE_RX,
> +};
> +
>  /**
>   * struct phy_configure_opts_mipi_dphy - MIPI D-PHY configuration set
>   *
> --=20
> 2.30.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--jvfpZGZYLc0FT7gn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmENGOIACgkQ3cLmz3+f
v9GG6QgAoetRE6Gm2GsDx9ecF7fYQC0wWavDBMKWXpgAgxTqle+aakC2enQ1ZFKU
0xW8h7LqDAK1YoXJnoObZO792kuMhnmisrsESuP3tPciX/AtygTkU0MXviDmkp9D
FylPgrrzevRPJPfnM6bAOTMziMdtGlFkBOD3VZrLLjpr3+YlexU8/D/OzCPYIZD7
F9Dst/Kh0X8a6+Fh70wt/MofkP5MvxgjrdRc5xuMvSic5qMMxagvnoADp1ox/Rm8
m0twCWqoapjJJXVdVbY3Aois5dJTUhU5FljhunGADroDPs/YbYO85hm1xxStPkeD
kMENkZbq3fCKXEAbC/Df+ny6rsOSow==
=Fhr6
-----END PGP SIGNATURE-----

--jvfpZGZYLc0FT7gn--
