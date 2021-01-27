Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D378305C70
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbhA0NFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:05:23 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:50267 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbhA0NCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:02:46 -0500
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E0F3910000F;
        Wed, 27 Jan 2021 13:01:56 +0000 (UTC)
Date:   Wed, 27 Jan 2021 14:01:56 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] of: device: Allow DMA range map to be set before
 of_dma_configure_id
Message-ID: <YBFkRGMlcyPGKKNT@aptenodytes>
References: <20210115175831.1184260-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y50gX4HMZh5UW8il"
Content-Disposition: inline
In-Reply-To: <20210115175831.1184260-1-paul.kocialkowski@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y50gX4HMZh5UW8il
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 15 Jan 21, 18:58, Paul Kocialkowski wrote:
> A mechanism was recently introduced for the sunxi architecture where
> the DMA offset for specific devices (under the MBUS) is set by a common
> driver (sunxi_mbus). This driver calls dma_direct_set_offset to set
> the device's dma_range_map manually.
>=20
> However this information was overwritten by of_dma_configure_id, which
> obtains the map from of_dma_get_range (or keeps it NULL when it fails
> and the force_dma argument is true, which is the case for platform
> devices).
>=20
> As a result, the dma_range_map was always overwritten and the mechanism
> could not correctly take effect.
>=20
> This adds a check to ensure that no previous DMA range map is
> overwritten and prints a warning when the map was already set while
> also being available from dt. In this case, the map that was already
> set is kept.

FYI this patch has been superseded by the following:
https://patchwork.kernel.org/project/linux-mediatek/patch/20210119105203.15=
530-1-yong.wu@mediatek.com/

Paul

> Fixes: b4bdc4fbf8d0 ("soc: sunxi: Deal with the MBUS DMA offsets in a cen=
tral place")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/of/device.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index aedfaaafd3e7..db1b8634c2c7 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -181,7 +181,14 @@ int of_dma_configure_id(struct device *dev, struct d=
evice_node *np,
> =20
>  	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> =20
> -	dev->dma_range_map =3D map;
> +	if (!dev->dma_range_map) {
> +		dev->dma_range_map =3D map;
> +	} else if (map) {
> +		dev_warn(dev,
> +			 "DMA range map was already set, ignoring range map from dt\n");
> +		kfree(map);
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure_id);
> --=20
> 2.30.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Y50gX4HMZh5UW8il
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmARZEQACgkQ3cLmz3+f
v9GJ4Af/addS8U7AjGXOW//0Aerp8AOTyKd8dlzqnoFR9K3CmoS6UDRBy6Ha5gG5
AQa+JC44HwACPrON49EBdI6spbf2VeuODIL7eM9LWYPEgjM6BWwMA+tIwF2deWMM
KU7LYJP91VG3vSeb9n4YfbHDmWMbtbV8GS/Pka7qQbx/L0DZ20HvGqh+YVEhk2tm
3NRVlwWEvrMYRSeaxmdjMM5FSysuJYT3TdymPqgwwkDo8wsXOrXpflU+lkZl/6r2
XxstkhAm9ff79Le01DqYz43n+oDlIhIWaaxzpz12j+TJvyRwu6igIOC8PbsA3aeW
Ze0sW5qbbX6jU3K/SM4qfXgYQxR1aA==
=HeCq
-----END PGP SIGNATURE-----

--Y50gX4HMZh5UW8il--
