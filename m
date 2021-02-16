Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED11231CAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 14:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBPNRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 08:17:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:53802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhBPNRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 08:17:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1523AF2C;
        Tue, 16 Feb 2021 13:16:27 +0000 (UTC)
Subject: Re: [PATCH 07/10] drm/qxl: fix prime kmap
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-8-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <a5c31dc0-3b89-fbb2-b933-b28a89cf14e7@suse.de>
Date:   Tue, 16 Feb 2021 14:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210216113716.716996-8-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uKKinKeYKRMHvQbXcRlKSL8e4OX4eXTBp"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uKKinKeYKRMHvQbXcRlKSL8e4OX4eXTBp
Content-Type: multipart/mixed; boundary="vAkSA4xPbEBg28YfmM4zHXhoJSRUwKles";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <a5c31dc0-3b89-fbb2-b933-b28a89cf14e7@suse.de>
Subject: Re: [PATCH 07/10] drm/qxl: fix prime kmap
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-8-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-8-kraxel@redhat.com>

--vAkSA4xPbEBg28YfmM4zHXhoJSRUwKles
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 16.02.21 um 12:37 schrieb Gerd Hoffmann:
> Use the correct kmap variant.  We don't have a reservation here,
> so we can't use the _locked version.

I'd merge this change into patch 6. So the new functions come with a call=
er.

Best regards
Thomas

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/qxl/qxl_prime.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_=
prime.c
> index dc295b2e2b52..4aa949799446 100644
> --- a/drivers/gpu/drm/qxl/qxl_prime.c
> +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> @@ -59,7 +59,7 @@ int qxl_gem_prime_vmap(struct drm_gem_object *obj, st=
ruct dma_buf_map *map)
>   	struct qxl_bo *bo =3D gem_to_qxl_bo(obj);
>   	int ret;
>  =20
> -	ret =3D qxl_bo_kmap_locked(bo, map);
> +	ret =3D qxl_bo_kmap(bo, map);
>   	if (ret < 0)
>   		return ret;
>  =20
> @@ -71,7 +71,7 @@ void qxl_gem_prime_vunmap(struct drm_gem_object *obj,=

>   {
>   	struct qxl_bo *bo =3D gem_to_qxl_bo(obj);
>  =20
> -	qxl_bo_kunmap_locked(bo);
> +	qxl_bo_kunmap(bo);
>   }
>  =20
>   int qxl_gem_prime_mmap(struct drm_gem_object *obj,
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--vAkSA4xPbEBg28YfmM4zHXhoJSRUwKles--

--uKKinKeYKRMHvQbXcRlKSL8e4OX4eXTBp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmArxaoFAwAAAAAACgkQlh/E3EQov+DX
qQ/7BvZtEpUlBoumZ69okz6fXrMEsbuaMjN1bickEAHHohlVO0SfwwEszsaj8b7myX+eqyyKppkZ
oP8ya7DtMITYmrOGmQQMwiGWKC44PD6RxXY7DdPMc30m0PZbNI4imf2+r6x9nr6SUztWLN6NrViu
v22jdzrG8uaulYNiUVLIBHb+Sr96apoATLzNS0iAMiEWu4otLs6v5+o8X2t0k+RXk2ACq3ikBJFG
zbSbqAWpM0hXtE+k6OFWa7ke/r/f250qVHXlMomkjKs2B/dcMixIRTOIqzwBPmzbsKe22JUoG1wN
swZLPwUg82WVjw15qamh6n3d1+r01dTIEQp5+lmqbfvsAgZzCrbb7UPFevmDxQVoEsCLza8VfzNU
TTH/mDGvgTUYRylxDCsa9NAEF9k3MEAuuSzA/WmeB+3yNO+Fc7ocFa2vUglNBLsFKgJ+2Kx+WUli
gtVjjoB9CfLeh82NRKVCyFVnXWd/KcsqwEHl8LvLwj0ncFLPv09Uv7CmBBnxurVE529/+M52cc2w
bes0j6XY1k1GhmTfM4m8kElYBYx9t+oXfBgu7vApf8Bp8UJT7rJqlE2k0wdG+Ji2neEva6gVQgUb
0TEFmYCL+/ctcxZsDWvhaKTcyNTn3I2t/yHcD7l4ovETIGlbPNQec+ptT3fCBGb2my/U+tDqkTqR
kng=
=fDtR
-----END PGP SIGNATURE-----

--uKKinKeYKRMHvQbXcRlKSL8e4OX4eXTBp--
