Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BE84111AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhITJK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:10:57 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:45072 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhITJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:07:19 -0400
X-Greylist: delayed 2033 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2021 05:07:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=s9XB5r3b82eKLamMQyimO3gFwevTCVoV+jr6i6T/3Zc=;
        b=nOmcYtvWU1m9HjRA5/CS0MpnUHRaS2JSEMSxRaPy9+xdZxa+DlIgAetyixGCDV8u2vLjn5NpnnnE18AqGa4d6/9zT+dMpHD3JuHBG/1C5M8vOPbk1bunx7+ImFfy5NVNEuCem37FbSfx9vR3sTgKOKnKFuScq9ophPIZ2sviPVp8yAXsbnZuSfspOdKG+DZhTj/JWv6JHEwjurIP97R9L2v8uwykg3upA8ITZzQjqW2QBx8oRLL3Ty36PjeaIMxw0Rt2FeNu6qwfl5aH+45+X0HbmO6lS2XUjmW1UbGD/sfH2PqnrtmAK4eEjQfYqM8AQshy1XRuHJo27sqr+WI9+Q==;
Received: from a95-92-181-29.cpe.netcabo.pt ([95.92.181.29] helo=mail.igalia.com)
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1mSEiK-0002Ei-EK; Mon, 20 Sep 2021 10:31:48 +0200
Date:   Mon, 20 Sep 2021 09:31:34 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Make use of the helper function
 devm_platform_ioremap_resource_byname()
Message-ID: <20210920083134.hajvw6kpvfg3qitn@mail.igalia.com>
References: <20210901112941.31320-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fg5trcv37os37ajy"
Content-Disposition: inline
In-Reply-To: <20210901112941.31320-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fg5trcv37os37ajy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09/01, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/gpu/drm/v3d/v3d_drv.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index 9403c3b36aca..c1deab2cf38d 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -206,10 +206,7 @@ MODULE_DEVICE_TABLE(of, v3d_of_match);
>  static int
>  map_regs(struct v3d_dev *v3d, void __iomem **regs, const char *name)
>  {
> -	struct resource *res =3D
> -		platform_get_resource_byname(v3d_to_pdev(v3d), IORESOURCE_MEM, name);
> -
> -	*regs =3D devm_ioremap_resource(v3d->drm.dev, res);
> +	*regs =3D devm_platform_ioremap_resource_byname(v3d_to_pdev(v3d), name);
>  	return PTR_ERR_OR_ZERO(*regs);
>  }
lgtm.

Reviewed-by: Melissa Wen <mwen@igalia.com>
> =20
> --=20
> 2.25.1
>=20

--fg5trcv37os37ajy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmFIRuEACgkQwqF3j0dL
ehwFSQ//Q93Ccx+Thy4bGmUslKbPr5ioKli9qBRNNMjK/9lPxrU3kewaKlH9SDEv
9YbLXcl4ejUBZi8TW0q/vOSp+PpeLIvG8xPdR7QSSXSBorMJ24x2WvjZcrXOu24M
B6ZRo0+IsZqyJqRhfTG1PXBiIygG/kf+LZd1QDEMfqQK9ErvBGpuvym0qaQKwq8I
kltEy/LInB2BXIXhAL/Bedh38dXspsHmAigbbd855YuLDAeYvWraQwlVV6x2jjbl
KJcD5OxF8r/OiA21+vGQiGHToIts5gAwIza4UlhK8XzdJNAQQLDJ5K0uATiDXqto
f0okb/2rUFoClL/UrzDLzPoGMSHNHBFgJKNsBKkGl80M5+h0EFLhzkG2fZadoEHp
z5lpJz5JwxxF1e+JuyAVkaSr2Sp+YiT0me4zphNX7L7kjTWEh1M9WZN5OY334hzB
TemrkzB1oQ7IyO2N3Z085klfsM+cy+hDj8V1v8oIlC8y/zaLH/hEyu43oGq64Yai
ZR7SU0ODAdbKm1+m8yHcHHvQBMBL2CifdRtYpyQS5b4QUYGRW+KMfelyLtASqJO/
lYejUsKetJi1uxddbJNtyQQVY+6CME0SEQISaAxBjj9zLCQu4mY1949t/nDeFNZb
7EfIiGDpQaX90sHTjf81JpsuFnk2VIKChMQ8rLm+VUrQ8CeEEJI=
=g7qr
-----END PGP SIGNATURE-----

--fg5trcv37os37ajy--
