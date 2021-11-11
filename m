Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A34944DBC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 19:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhKKSt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 13:49:56 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:50631 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233575AbhKKStw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 13:49:52 -0500
X-Greylist: delayed 2208 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Nov 2021 13:49:51 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=LJIW4lxDvBNuPZdFbOnJp2QLvNQr8PhdLSeOjMlDVjo=;
        b=YoWJ3UULnfH3LiCnVUgPfEDIbU/2naxM2IjDgqUGgH7R/jaljjaxBVpTpJsqS71Gi5vxUx3iltiiFU6+3o18YGIQU05St1K8j9A6LzpFSMKEqEHlQ1vPm+dx6EVj1S2FAiVe6VFxgp/pVvXo1c+bJE62RfDZ6ComM43BE+yHzUgoHeYJ9GCxWCPwqZdlFRUSe94F7ETN7b7ugnRfEZ0xvmrCR0eiVgVvXeVbCQ2GXGSaZ568oa93a74IYAnSP4mI+AlKZsUypwaHTxoq7XFC+vrEQk8amEym/ggI72GSBZwXK9WTasVt6tMXNXivN0XxFn4UedUY8moWr460Dg2VwA==;
Received: from [169.239.12.53] (helo=mail.igalia.com)
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1mlEWo-00034E-6p; Thu, 11 Nov 2021 19:10:26 +0100
Date:   Thu, 11 Nov 2021 17:09:20 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Iago Toral Quiroga <itoral@igalia.com>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: pass null pointers using NULL
Message-ID: <20211111180920.sbngpa4vqc2ptijs@mail.igalia.com>
References: <20211110193635.312328-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="325a2qr3pmdrhiay"
Content-Disposition: inline
In-Reply-To: <20211110193635.312328-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--325a2qr3pmdrhiay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11/10, Colin Ian King wrote:
> There are a couple of calls that are passing null pointers as
> integer zeros rather than NULL. Fix this by using NULL instead.
>=20
> Fixes: 07c2a41658c4 ("drm/v3d: alloc and init job in one shot")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index e47ae40a865a..c7ed2e1cbab6 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -774,7 +774,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *dat=
a,
> =20
>  	if (args->flags & DRM_V3D_SUBMIT_CL_FLUSH_CACHE) {
>  		ret =3D v3d_job_init(v3d, file_priv, (void *)&clean_job, sizeof(*clean=
_job),
> -				   v3d_job_free, 0, 0, V3D_CACHE_CLEAN);
> +				   v3d_job_free, 0, NULL, V3D_CACHE_CLEAN);
>  		if (ret)
>  			goto fail;
> =20
> @@ -1007,7 +1007,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *=
data,
>  		goto fail;
> =20
>  	ret =3D v3d_job_init(v3d, file_priv, (void *)&clean_job, sizeof(*clean_=
job),
> -			   v3d_job_free, 0, 0, V3D_CACHE_CLEAN);
> +			   v3d_job_free, 0, NULL, V3D_CACHE_CLEAN);
>  	if (ret)
>  		goto fail;

Hi Colin,

This fix has been already done:
https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D75ad021f21927311b8d4=
54939eb248a50df92525

Thanks, anyway.

Melissa
> =20
> --=20
> 2.32.0
>=20

--325a2qr3pmdrhiay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmGNXEsACgkQwqF3j0dL
ehwXUBAAo/tDFp8Fc7C1cDgMAUeGAJzpS1GJtU1NW1hPHWXVDhfN6hiTEwtePgkQ
edppAzJib36jKl92E9sbpNlFVJdBxUEd123iSfeXWjSptxxqjwYgnHHbkh/X06JO
yz/ps/qfumxJGtD36c139fFobd75AvDBcJF1OO+atV9myBOTaz0DClpukUyAh7k5
dE3C7xCgDZg6W4KFWrm+z6F8IG0cHnJlHg/8cAJ5Y3RdsPLBVLdG3Q/5SUKQCqyu
uhpLNh1TLE3FIz81jTmafAsGGJx3cnoVcLlR+gOYOkLcMWoAJcWL5wAXhIJauQkm
2ga4vJaMAVBY+1Q7Ffb4XHEdZdt+6KGANfw3ubu26dpXmyhyWwSGwCasFU7aITi8
v7MoiLWUY6T0CyepvaklWS0+qBCc1xPU7QMycb/nNePYQg5e6igo4MlCfo2V+R87
5Gkmg4TFi3Ea3EIH+7tC4PbPH3UJW0J9L1XCY3KwjroNHla5rkRhULaDUGo2jrRC
cLh8kcuVoyogKp3g5rmpMyrmyBLTJ5ApbvsT4PjfIy/Sxg6GFT6lcWSbl2Wbz5Pu
QUfA080DZPDYZVAWo+vSNHr+AgtfLEnLbcJHexC12kuwpNzpAB5qk6Atynf4xbwU
uZv0BLaGGUt6BzElqRyhst6ttRFNmUZ8M58kN2VTbbvAx0BnKcE=
=9wCf
-----END PGP SIGNATURE-----

--325a2qr3pmdrhiay--
