Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A291F31CB06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 14:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBPNTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 08:19:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:54846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhBPNTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 08:19:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A96ECACBF;
        Tue, 16 Feb 2021 13:18:29 +0000 (UTC)
Subject: Re: [PATCH 08/10] drm/qxl: fix monitors object kmap
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-9-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <47d20b11-5e9e-df5d-f5d7-eeabad0fba51@suse.de>
Date:   Tue, 16 Feb 2021 14:18:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210216113716.716996-9-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dAy6DIFwPM7P209nF5nzfBpzm4IqotlFM"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dAy6DIFwPM7P209nF5nzfBpzm4IqotlFM
Content-Type: multipart/mixed; boundary="pwM01gIs21csFcuVNF3Jw0rrOyqXUFxfO";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <47d20b11-5e9e-df5d-f5d7-eeabad0fba51@suse.de>
Subject: Re: [PATCH 08/10] drm/qxl: fix monitors object kmap
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-9-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-9-kraxel@redhat.com>

--pwM01gIs21csFcuVNF3Jw0rrOyqXUFxfO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 16.02.21 um 12:37 schrieb Gerd Hoffmann:
> Use the correct kmap variant.  We don't hold a reservation here,
> so we can't use the _locked variant.  We can drop the pin because
> qxl_bo_kmap will do that for us.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> index 8672385a1caf..7500560db8e4 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1159,12 +1159,10 @@ int qxl_create_monitors_object(struct qxl_devic=
e *qdev)
>   	}
>   	qdev->monitors_config_bo =3D gem_to_qxl_bo(gobj);
>  =20
> -	ret =3D qxl_bo_pin(qdev->monitors_config_bo);
> +	ret =3D qxl_bo_kmap(qdev->monitors_config_bo, &map);
>   	if (ret)
>   		return ret;
>  =20
> -	qxl_bo_kmap_locked(qdev->monitors_config_bo, &map);
> -
>   	qdev->monitors_config =3D qdev->monitors_config_bo->kptr;
>   	qdev->ram_header->monitors_config =3D
>   		qxl_bo_physical_address(qdev, qdev->monitors_config_bo, 0);
> @@ -1189,8 +1187,7 @@ int qxl_destroy_monitors_object(struct qxl_device=
 *qdev)
>   	qdev->monitors_config =3D NULL;
>   	qdev->ram_header->monitors_config =3D 0;
>  =20
> -	qxl_bo_kunmap_locked(qdev->monitors_config_bo);
> -	ret =3D qxl_bo_unpin(qdev->monitors_config_bo);
> +	ret =3D qxl_bo_kunmap(qdev->monitors_config_bo);
>   	if (ret)
>   		return ret;
>  =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--pwM01gIs21csFcuVNF3Jw0rrOyqXUFxfO--

--dAy6DIFwPM7P209nF5nzfBpzm4IqotlFM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmArxiQFAwAAAAAACgkQlh/E3EQov+DX
pBAA0W9z+geNfjAswRgfoft+rrjdUHqknO2XhhcUtrtmzjXgj4PKfssqO5BWqbUv8Y6k886730Oo
I98cJ2BMs41j6s7Y/WJ0Z2N7pk/o+lSzPxcG4SDWuCWQVSFS9pa2vESADr5CSlc0FnSPdPQhUvOv
WZdZtIGAbny6Ga+6Xf/CRY3BElARaYaPV9xDgR50upLrkPDUR9kvoIbwXK+hT4CxKFgMFdZz3Vh+
CqLB0aX/0GYZ+GfHhlWYvNY/S1Q6MXmMT8AfchNVyDPMSt0grMnHvRkA8ZVxual3FCUUKK5S+8PD
NuX3sdcbfl6pDrXj4vFAGUzPAapnkvjCfxAsozfVbr/b28NrufKIiilKphOy0raCbpYQ/0GwtyTH
UPXOQdywe7+GJce5tbHTExvGmLJ+r7ce2VROllfqPWk/JeLR1Z72SwtRU9HDk34/s8DASjFy4aSv
XjbeSC9lqsdxVFtLlygqAu+VkhcuNUGy+tX4uBz0Xm6TvSCrSWYg4cXdEu9G2/gujkknCcQEE/qb
N7pB8oLc+nG5pwcWMMLHPxSWMtrREmSWSq53cdo9WfS69EWilpn2blAMrO/Yz9ImtABZ8GAS9KFM
4PjnDQqFM6gEl+AWhEYBDwG5fg53dR6XjZzqVshmAS23pYvUuEzGvQJ4OsNCeQwpaFjXg/yhwjgM
85M=
=SKuG
-----END PGP SIGNATURE-----

--dAy6DIFwPM7P209nF5nzfBpzm4IqotlFM--
