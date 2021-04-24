Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E1A36A157
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhDXNSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 09:18:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:36623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhDXNSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 09:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619270240;
        bh=zbFt1dgDmLg2fkUHe6+fUzd+kp6JVhh4Jhigqnl7tIc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WgZhFVggT+J3NxVw1vAu/e5Sn9kN2j8xsnJ0Mm/cmCz5j6+TiiT1zodzsj52ULqPX
         kJaCqx7NxaGpNVB+IOSt1RnoQr48yVSwevV35YE5zDIp+ZljVVybc9b7dgpCkBiUWR
         I1LEuh6a12m5qJ2FVhUIHaxke7NYOFXIlGfh3XJ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6qp-1lHSo71Tx5-00pYqh; Sat, 24
 Apr 2021 15:17:20 +0200
Date:   Sat, 24 Apr 2021 15:17:19 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] misc: eeprom_93xx46: set size and addrlen according
 to the dts
Message-ID: <YIQaXx9b2fGLOBmI@latitude>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
 <20210424123034.11755-3-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ly0JB824f729Aq5V"
Content-Disposition: inline
In-Reply-To: <20210424123034.11755-3-linkmauve@linkmauve.fr>
X-Provags-ID: V03:K1:FJFY5yrtnU05NYFDOVjWijV9MZiQ3xYQ3lw2U/CQAG16qAyXONR
 mk/hD/Y9n1j0kYeI932yFtQOCnqUH/POHOGNXWGavHaBX5KE6qaEXkfxAHZhtnLyTL4cUDu
 wuThWS48WTS8lGw4hhemPRskC1OMLFc66GnoPMNTJAH4Gg2+kMKiG+tl+M54RPKSjLrYWKX
 OySrWPoW5GybYvs4o85hA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZUq28VjbIHo=:XIcPkzrzI4RKfacPTu9UEl
 nsXX4+0MWHXUAjw54HhJ9q19JFJV2tQfHV+dDmLvLkOPTkJC1xcDNaQcWhwIqLNh1d1KdNPZE
 2Xh9S1UyFEp7HUhCZ22mXfE/XF3FGxS7TBwnn0swf1Vs9x1JVEEHez5JUWgCvX0hlz9jT9Pxs
 9x3FBitRxgyZni0C3gbqdlxGkpCatg8rxDAzVOIRac8nqq9Y5fezZCKuQ0d33OSxY7FDtMnYx
 ejERBPDvQi5qEJ3aU+0wfF466nOlb3PCg9Qgb03B3b1EpgumVKuMEunbGdqC1aiRjoNX7SDso
 U+cuTXt4ZV4FG4fIQthk2bwXoGhI0Ob5mS2ZfniHwBMIGDkzFgQXe1vrEPFKQIV/LyW1emvNh
 xZCCDdM/TRIdTija4LpET4Jukkd9xq1O1nIXjhgSmGAnb7jjEkr13O972GBVJfmZc+3sg/52u
 NLERB6h68CJz8qhENva68LSDT0Hpv3zASC/NR7jceq+cbnHJjkkYSqiBNhN+6+KGs+K8tJDcv
 ynlh8YE6CzZTUFawo2OUZ40TGzSs1HcS+Hy4T3+AZ3Vt7tLCcIenydxeWdqzGXDZSarPMJ7yu
 1esCCxgn4E/MD2w3DpozbbBo/IiLUOTRZ8VVGespXsIzJAYXKsGvn1JZfRcUx7ozfE0+2qJht
 yFOrIWn7F/QLSr2AMTNu1gV7Cv+OHNYASSp1WSZGkTbyEkfFkIA8ajVqITFmzFISh3tS60bt8
 wbFXmYyO6KAYqsfxwf9Q59TsCflP/4Wu+SiLmvaA/0lIAZXLWLGyuItE4ArhLE0/hZY0f1SQd
 GfurVa50uxdCaBSXUI3mEH4HNHUD1haULUaV9EKZZKTOK3TBE1GhCsjrJzuakFQY44CKwn/sJ
 Bul4vksGe4ylIXjlTdedSvPAAxP3ECniLmydWSbxyj85VfenzRdOAEll/16K6njteb3UlxlhG
 cvy2S9pVieZfc1DEwzrIWjZ41oX2kvdUIbs9LdJrNYI16Ay+FpA9lPJsj8vlD38zVaKlfSFFi
 WTukWJus0BakD78i8imHihQ2Adm7rw29/2U6fEdoQweQnNNk8MAGjHsBF9sDmVCYZ7mWQ1ohi
 sC/b+6cxNLfQRcfodPt91s9kONtJMVsVimWXu7A1ioufRmU1OVNJYibsjwP6t1afwWraPvYhZ
 DkX2YbDGS6himH0CGeuveDgBv8pJEwUeVwgm8ieRw5yaYdjiM1n4B1EEru6ljva1bfXAUu9XX
 H+T5YVSin8XuNkqqI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ly0JB824f729Aq5V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,


> [PATCH 2/4] misc: eeprom_93xx46: set size and addrlen according to the dts

This patch doesn't really deal with the devicetree, so this subject line
seems a bit mismatched.

On Sat, Apr 24, 2021 at 02:30:31PM +0200, Emmanuel Gil Peyrot wrote:
> This can then be used by the rest of the driver to use the correct
> commands on 93c56 and 93c66.
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---

Ah hmmm. Does this mean that with the previous patch, the driver will be
instanciated for 93c56 and 93c66 but send the wrong commands? I think
you should avoid this pitfall by rearranging (or squashing) the patches.

>  drivers/misc/eeprom/eeprom_93xx46.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/ee=
prom_93xx46.c
> index 64dd76f66463..39375255e22a 100644
> --- a/drivers/misc/eeprom/eeprom_93xx46.c
> +++ b/drivers/misc/eeprom/eeprom_93xx46.c
> @@ -18,6 +18,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/nvmem-provider.h>
>  #include <linux/eeprom_93xx46.h>
> +#include <linux/log2.h>
> =20
>  #define OP_START	0x4
>  #define OP_WRITE	(OP_START | 0x1)
> @@ -474,10 +475,22 @@ static int eeprom_93xx46_probe(struct spi_device *s=
pi)
>  	if (!edev)
>  		return -ENOMEM;
> =20
> +	if (pd->flags & EE_SIZE1K)
> +		edev->size =3D 128;
> +	else if (pd->flags & EE_SIZE2K)
> +		edev->size =3D 256;
> +	else if (pd->flags & EE_SIZE4K)
> +		edev->size =3D 512;
> +	else {
> +		dev_err(&spi->dev, "unspecified size\n");
> +		err =3D -EINVAL;
> +		goto fail;
> +	}
> +
>  	if (pd->flags & EE_ADDR8)
> -		edev->addrlen =3D 7;
> +		edev->addrlen =3D ilog2(edev->size);
>  	else if (pd->flags & EE_ADDR16)
> -		edev->addrlen =3D 6;
> +		edev->addrlen =3D ilog2(edev->size) - 1;
>  	else {
>  		dev_err(&spi->dev, "unspecified address type\n");
>  		return -EINVAL;
> @@ -488,7 +501,6 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
>  	edev->spi =3D spi;
>  	edev->pdata =3D pd;
> =20
> -	edev->size =3D 128;
>  	edev->nvmem_config.type =3D NVMEM_TYPE_EEPROM;
>  	edev->nvmem_config.name =3D dev_name(&spi->dev);
>  	edev->nvmem_config.dev =3D &spi->dev;
> @@ -508,8 +520,9 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
>  	if (IS_ERR(edev->nvmem))
>  		return PTR_ERR(edev->nvmem);
> =20
> -	dev_info(&spi->dev, "%d-bit eeprom %s\n",
> +	dev_info(&spi->dev, "%d-bit eeprom containing %d bytes %s\n",
>  		(pd->flags & EE_ADDR8) ? 8 : 16,
> +		edev->size,
>  		(pd->flags & EE_READONLY) ? "(readonly)" : "");


The logic itself looks good though.

Thanks,
Jonathan

--ly0JB824f729Aq5V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmCEGlcACgkQCDBEmo7z
X9tZiA//RQ98peNwYvrBcp2+LWR4f0GsREFO8qgr81278RaviAVdrBl90PhDLDXk
Gfg1kCA09/2KQW/fQyBxTDbM1iy3/c8FC+XvqP2lF9WkX/cRbOT8bz8aDTCAYFsL
S9kuIX3TiEdjObNWb7UxQS1pjMlMwlI/eMBI0WhP4Px5A50f/8L+emvzJ7OKa5Lm
u3DEgtUVekYRw5H3KuCTfwc9AJbNhNGUbVUppm+F9FYqR8s5Q3RdfNKDbnxYY9p4
YC5W055tOXm5AyAjc8wR/9uD63E1UpWlR73CXXTzUH3bm4plKJwgI/lb0GWmJUbc
o8J07GSA9MgpfSMIldpF+Hka2BO2T+l9fVXdu7S7w7EFcj+pPAwfbsILa7NIJbeJ
Xj6AJEn9CHTNdq/7MY9zUyLUbGYBcavgog3DPJxcMuLQk4BYRIpV1ztLOiMQndg7
+vp+FHUCK5aPxd9knQAXz5a4g+9zaKxPkcGwgmYKbBOBEflVbzrWCGU48BkvuIz8
23oBoKvWEj9+tDedPamCL1RpP+3H+YZ8PJQ2Zd/JQXD/S1V9HWiEe3b1Sm1T5ui+
F7ps6pWiMYRd9dZonHYWKpovgQZjtBJa7jwuHUeVKT7eLR9Ac/dEaQD2xOi0if4p
6wjIe6/M57kFdykaLLrGoWH0fbur2iICEvnS4WmSZ6ULAEUnh2w=
=0v/y
-----END PGP SIGNATURE-----

--ly0JB824f729Aq5V--
