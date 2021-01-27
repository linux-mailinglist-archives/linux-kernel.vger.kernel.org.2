Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45E305C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbhA0NEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:04:30 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35917 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbhA0NBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:01:32 -0500
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9A2151C000A;
        Wed, 27 Jan 2021 13:00:40 +0000 (UTC)
Date:   Wed, 27 Jan 2021 14:00:39 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2] of/device: Update dma_range_map only when dev has
 valid dma-ranges
Message-ID: <YBFj9whLvqlV2erm@aptenodytes>
References: <20210119105203.15530-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BIH3KrdpdMNN62Ds"
Content-Disposition: inline
In-Reply-To: <20210119105203.15530-1-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BIH3KrdpdMNN62Ds
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue 19 Jan 21, 18:52, Yong Wu wrote:
> The commit e0d072782c73 ("dma-mapping: introduce DMA range map,
> supplanting dma_pfn_offset") always update dma_range_map even though it w=
as
> already set, like in the sunxi_mbus driver. the issue is reported at [1].
> This patch avoid this(Updating it only when dev has valid dma-ranges).
>=20
> Meanwhile, dma_range_map contains the devices' dma_ranges information,
> This patch moves dma_range_map before of_iommu_configure. The iommu
> driver may need to know the dma_address requirements of its iommu
> consumer devices.

Just a gentle ping on this issue, it would be nice to have this fix merged
ASAP, in the next RC :)

Cheers,

Paul

> [1] https://lore.kernel.org/linux-arm-kernel/5c7946f3-b56e-da00-a750-be09=
7c7ceb32@arm.com/
>=20
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Frank Rowand <frowand.list@gmail.com>
> Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting d=
ma_pfn_offset"),
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/device.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index aedfaaafd3e7..1122daa8e273 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -162,9 +162,11 @@ int of_dma_configure_id(struct device *dev, struct d=
evice_node *np,
>  	mask =3D DMA_BIT_MASK(ilog2(end) + 1);
>  	dev->coherent_dma_mask &=3D mask;
>  	*dev->dma_mask &=3D mask;
> -	/* ...but only set bus limit if we found valid dma-ranges earlier */
> -	if (!ret)
> +	/* ...but only set bus limit and range map if we found valid dma-ranges=
 earlier */
> +	if (!ret) {
>  		dev->bus_dma_limit =3D end;
> +		dev->dma_range_map =3D map;
> +	}
> =20
>  	coherent =3D of_dma_is_coherent(np);
>  	dev_dbg(dev, "device is%sdma coherent\n",
> @@ -172,6 +174,9 @@ int of_dma_configure_id(struct device *dev, struct de=
vice_node *np,
> =20
>  	iommu =3D of_iommu_configure(dev, np, id);
>  	if (PTR_ERR(iommu) =3D=3D -EPROBE_DEFER) {
> +		/* Don't touch range map if it wasn't set from a valid dma-ranges */
> +		if (!ret)
> +			dev->dma_range_map =3D NULL;
>  		kfree(map);
>  		return -EPROBE_DEFER;
>  	}
> @@ -181,7 +186,6 @@ int of_dma_configure_id(struct device *dev, struct de=
vice_node *np,
> =20
>  	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> =20
> -	dev->dma_range_map =3D map;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure_id);
> --=20
> 2.18.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--BIH3KrdpdMNN62Ds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmARY/cACgkQ3cLmz3+f
v9HHbgf/Rk9Hu0kUW5B3MNVJs1JlKh376ihTjnZEjV3Xo7c4YP4KwGcTzAB2AMY2
ja2o4bLiLOBTOVExH1kXCmXuxvlgvumq3H9Zxi0+Ef/5ZPPlmi915WuSw440Seg3
t3W638nzVrqrIcvKa6YiS41UV5CbYGKHhBiInpPDdK3FbSDzRMSFkr3EKFdhNK1F
qgL/9PV6WpamufJW589cWXQFumazQN/kz+zop1kD0jqWbNiSKM4rNz5j4PvH5iwj
uQFWwUF/nuPfiEMCTeICiFrtgMTpl6QqiZqAUenTk+wuPeB7Xk0mXg0kaFmeUYpX
k9INUJJAqUv96+i8ZW2lfOnI7fo90g==
=2oxl
-----END PGP SIGNATURE-----

--BIH3KrdpdMNN62Ds--
