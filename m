Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EED31DF96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhBQTYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:24:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:48176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232841AbhBQTYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:24:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01A21ABA2;
        Wed, 17 Feb 2021 19:23:32 +0000 (UTC)
Subject: Re: [PATCH v2 04/11] drm/qxl: fix lockdep issue in
 qxl_alloc_release_reserved
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-5-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <8957d006-c521-292b-0e95-066098ec8b90@suse.de>
Date:   Wed, 17 Feb 2021 20:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217123213.2199186-5-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g5xlLFvOFFjUKawQ8FM3Kjj3Z5Kdu1uhg"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g5xlLFvOFFjUKawQ8FM3Kjj3Z5Kdu1uhg
Content-Type: multipart/mixed; boundary="5K2XiOgMZEpkZsaQmRkNN3tpTWU2ThwaE";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Message-ID: <8957d006-c521-292b-0e95-066098ec8b90@suse.de>
Subject: Re: [PATCH v2 04/11] drm/qxl: fix lockdep issue in
 qxl_alloc_release_reserved
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-5-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-5-kraxel@redhat.com>

--5K2XiOgMZEpkZsaQmRkNN3tpTWU2ThwaE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 17.02.21 um 13:32 schrieb Gerd Hoffmann:
> Call qxl_bo_unpin (which does a reservation) without holding the
> release_mutex lock.  Fixes lockdep (correctly) warning on a possible
> deadlock.
>=20
> Fixes: 65ffea3c6e73 ("drm/qxl: unpin release objects")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/qxl/qxl_release.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qx=
l_release.c
> index 716d706ca7f0..f5845c96d414 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -283,7 +283,7 @@ int qxl_alloc_release_reserved(struct qxl_device *q=
dev, unsigned long size,
>   				       int type, struct qxl_release **release,
>   				       struct qxl_bo **rbo)
>   {
> -	struct qxl_bo *bo;
> +	struct qxl_bo *bo, *free_bo =3D NULL;
>   	int idr_ret;
>   	int ret =3D 0;
>   	union qxl_release_info *info;
> @@ -315,8 +315,7 @@ int qxl_alloc_release_reserved(struct qxl_device *q=
dev, unsigned long size,
>  =20
>   	mutex_lock(&qdev->release_mutex);
>   	if (qdev->current_release_bo_offset[cur_idx] + 1 >=3D releases_per_b=
o[cur_idx]) {
> -		qxl_bo_unpin(qdev->current_release_bo[cur_idx]);
> -		qxl_bo_unref(&qdev->current_release_bo[cur_idx]);
> +		free_bo =3D qdev->current_release_bo[cur_idx];
>   		qdev->current_release_bo_offset[cur_idx] =3D 0;
>   		qdev->current_release_bo[cur_idx] =3D NULL;
>   	}
> @@ -324,6 +323,10 @@ int qxl_alloc_release_reserved(struct qxl_device *=
qdev, unsigned long size,
>   		ret =3D qxl_release_bo_alloc(qdev, &qdev->current_release_bo[cur_id=
x], priority);
>   		if (ret) {
>   			mutex_unlock(&qdev->release_mutex);
> +			if (free_bo) {
> +				qxl_bo_unpin(free_bo);
> +				qxl_bo_unref(&free_bo);
> +			}
>   			qxl_release_free(qdev, *release);
>   			return ret;
>   		}
> @@ -339,6 +342,10 @@ int qxl_alloc_release_reserved(struct qxl_device *=
qdev, unsigned long size,
>   		*rbo =3D bo;
>  =20
>   	mutex_unlock(&qdev->release_mutex);
> +	if (free_bo) {
> +		qxl_bo_unpin(free_bo);
> +		qxl_bo_unref(&free_bo);
> +	}
>  =20
>   	ret =3D qxl_release_list_add(*release, bo);
>   	qxl_bo_unref(&bo);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--5K2XiOgMZEpkZsaQmRkNN3tpTWU2ThwaE--

--g5xlLFvOFFjUKawQ8FM3Kjj3Z5Kdu1uhg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAtbTIFAwAAAAAACgkQlh/E3EQov+Cu
MA//cnHoAHJQ9PF56fAMErvtgYSHBawIIQ11eHErmocSJejf7Ln34v2+NiL+KHasW3q34ptuzNT5
d0KDbQwE2cQfcUNybx+mLZcn2YnB8o+IAkyRM1R3Tn8SC6AevXACinTB1NSISxipjU6iBmtPMWIA
HXlqiFvZxUhPGq/demqWXeTubcpq+2YhsPwo4cyZCtMBuFcsbpR06XA3kJhiOVBxTLP8+IqFQVsp
hTwKNXOo5+zqIdJvNx2rxIUT2egKjs/t+S+L/pOdnmnW60nP93utc7w/7dwLWbZowU9StTZdJpY/
mWRnsaxmEsAy8NUuKMLKyEYuWvBVkb42NB0gdcQfz/FyrFEpZy5BFROL/Aga16HzqV0jXrHxe9eY
amDlCyzJljnUoFKo+Hyth7Ia+sPnwR+dVzVqgwx5VZMjDmYiHmgVuJFdPJH1x0RO4IG9EvkzeIHs
yoT500xtIpCIAL2HBcM0i1je7ADkHWvmh8i3fZ+K8c5zyxRHq5+bk0Av92H+wPsMPILQKnui2L4q
HS+MpbJpoDtz4iPH9dvUGzogqzpWXmw6ia8zTaiKzBvtKekq3U7skJZk1ebwFnUjTtl2syJSGncl
z4ySMYPabg20ZFrrz7H4mXw6Y2Q8FnI5+3Oj5iWLmuWdLZdG0nPV2kUthCefvXqZRXVEwIXNqukm
yEI=
=AEpE
-----END PGP SIGNATURE-----

--g5xlLFvOFFjUKawQ8FM3Kjj3Z5Kdu1uhg--
