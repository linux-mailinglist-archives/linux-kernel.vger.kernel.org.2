Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D2F37F86A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhEMNJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:09:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:43640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230498AbhEMNJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:09:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1976BAE57;
        Thu, 13 May 2021 13:08:19 +0000 (UTC)
Subject: Re: [PATCH -next] drm/aperture: Fix missing unlock on error in
 devm_aperture_acquire()
To:     Zou Wei <zou_wei@huawei.com>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1620895564-52367-1-git-send-email-zou_wei@huawei.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <bc0b8b71-507d-c6c2-9029-359c7f27daf4@suse.de>
Date:   Thu, 13 May 2021 15:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1620895564-52367-1-git-send-email-zou_wei@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2LYd2hGxsv9U9ONrL0OFzeYrSnmGgUNVz"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2LYd2hGxsv9U9ONrL0OFzeYrSnmGgUNVz
Content-Type: multipart/mixed; boundary="Pv7MotVf5ovpQSqaWZ0JWXWfLBQj6bAYF";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Zou Wei <zou_wei@huawei.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <bc0b8b71-507d-c6c2-9029-359c7f27daf4@suse.de>
Subject: Re: [PATCH -next] drm/aperture: Fix missing unlock on error in
 devm_aperture_acquire()
References: <1620895564-52367-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1620895564-52367-1-git-send-email-zou_wei@huawei.com>

--Pv7MotVf5ovpQSqaWZ0JWXWfLBQj6bAYF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 13.05.21 um 10:46 schrieb Zou Wei:
> Add the missing unlock before return from function devm_aperture_acquir=
e()
> in the error handling case.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

I added a Fixes tag and queued up the patch for drm-misc-next. Thanks!

Best regards
Thomas

> ---
>   drivers/gpu/drm/drm_aperture.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_aperture.c b/drivers/gpu/drm/drm_apert=
ure.c
> index 33bf018..9335d9d 100644
> --- a/drivers/gpu/drm/drm_aperture.c
> +++ b/drivers/gpu/drm/drm_aperture.c
> @@ -164,13 +164,17 @@ static int devm_aperture_acquire(struct drm_devic=
e *dev,
>  =20
>   	list_for_each(pos, &drm_apertures) {
>   		ap =3D container_of(pos, struct drm_aperture, lh);
> -		if (overlap(base, end, ap->base, ap->base + ap->size))
> +		if (overlap(base, end, ap->base, ap->base + ap->size)) {
> +			mutex_unlock(&drm_apertures_lock);
>   			return -EBUSY;
> +		}
>   	}
>  =20
>   	ap =3D devm_kzalloc(dev->dev, sizeof(*ap), GFP_KERNEL);
> -	if (!ap)
> +	if (!ap) {
> +		mutex_unlock(&drm_apertures_lock);
>   		return -ENOMEM;
> +	}
>  =20
>   	ap->dev =3D dev;
>   	ap->base =3D base;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--Pv7MotVf5ovpQSqaWZ0JWXWfLBQj6bAYF--

--2LYd2hGxsv9U9ONrL0OFzeYrSnmGgUNVz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmCdJMEFAwAAAAAACgkQlh/E3EQov+Bh
fw//T1Y3PBtm36xSAjECT3jg/7zd4WOP89zbgzF6GBPFGoDf+63SbcAP6AkbA9U8/wU1XwmMC5tn
7SqaE7h1mMp2d0+h/OtU7/WVInyFEVoYG3S1KtmdiqjNMu+YAtIbTbwaYnw+4NdgRD3pZ0VTYc1Z
fhyce77rCvruYxWLgPdUell2SylKe8URuGB8Rgh40v5DkAx/6DZ1m4RKSS8sKWZxydDliVWayXAs
uYzBdydq/XOoq+Nq8rzaJMC+MUCiE0T2iqLgC9PR5UYMIBM84VK/jefiLWrYWatUk5HLScPQmAb1
+7y5y4Aqt0kiom810plXO+DneYcCHm0q9PNPYEOHdsoaCE3+wHoV/VHnnzZ5ShTgJl6ovGrRMRm0
pxJ6p8aqALIQUDXJyBQPZLkTlMKS+92SR49WmKZzHAtvmXOKx6Vzx0Fuk3WKot2UHuNHiS3XAh/l
URyyDmylCGc5wm4YDR8NQRFf9FeYTqvPSxMxHro9s49y2JhXU2MC1qLCmm6TApceoI9Tw2yoEX/W
cejQGquZPKtNThZtVRPOejXwKNJbXhsGlDLKDJghVAkw+szKFartVXYpnS6U5sErAhEvOTGZFGlY
3h/eQ99RnnGLimHc4PFjmSwFKKCATkpslGbd8TEXCT+Al4myMRUnTYOYkkFExQtzYy98/vh8GjvN
JpQ=
=vxrH
-----END PGP SIGNATURE-----

--2LYd2hGxsv9U9ONrL0OFzeYrSnmGgUNVz--
