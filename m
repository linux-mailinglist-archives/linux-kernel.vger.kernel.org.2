Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232D931CAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 14:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBPNSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 08:18:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:54490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhBPNSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 08:18:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CE71ACBF;
        Tue, 16 Feb 2021 13:17:26 +0000 (UTC)
Subject: Re: [PATCH 06/10] drm/qxl: add qxl_bo_kmap/qxl_bo_kunmap
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-7-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <72d297c4-1a93-aa4f-88c4-721818cfc33b@suse.de>
Date:   Tue, 16 Feb 2021 14:17:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210216113716.716996-7-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="juTD9d22fjPa3seaUdQD0WNZ0GwQ7my5e"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--juTD9d22fjPa3seaUdQD0WNZ0GwQ7my5e
Content-Type: multipart/mixed; boundary="1VGG77xM4sURpaHnz9v3NjgHCWihVFql3";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <72d297c4-1a93-aa4f-88c4-721818cfc33b@suse.de>
Subject: Re: [PATCH 06/10] drm/qxl: add qxl_bo_kmap/qxl_bo_kunmap
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-7-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-7-kraxel@redhat.com>

--1VGG77xM4sURpaHnz9v3NjgHCWihVFql3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 16.02.21 um 12:37 schrieb Gerd Hoffmann:
> Add kmap/kunmap variants which reserve (and pin) the bo.
> They can be used in case the caller doesn't hold a reservation
> for the bo.

Again, these functions should rather be called vmap/vunamp.

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/qxl/qxl_object.h |  2 ++
>   drivers/gpu/drm/qxl/qxl_object.c | 36 +++++++++++++++++++++++++++++++=
+
>   2 files changed, 38 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl=
_object.h
> index 5bd33650183f..360972ae4869 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.h
> +++ b/drivers/gpu/drm/qxl/qxl_object.h
> @@ -64,7 +64,9 @@ extern int qxl_bo_create(struct qxl_device *qdev,
>   			 u32 priority,
>   			 struct qxl_surface *surf,
>   			 struct qxl_bo **bo_ptr);
> +extern int qxl_bo_kmap(struct qxl_bo *bo, struct dma_buf_map *map);
>   extern int qxl_bo_kmap_locked(struct qxl_bo *bo, struct dma_buf_map *=
map);
> +extern int qxl_bo_kunmap(struct qxl_bo *bo);
>   extern void qxl_bo_kunmap_locked(struct qxl_bo *bo);
>   void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo =
*bo, int page_offset);
>   void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev, struct qxl_bo=
 *bo, void *map);
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl=
_object.c
> index b56d4dfc28cb..22748b9566af 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -29,6 +29,9 @@
>   #include "qxl_drv.h"
>   #include "qxl_object.h"
>  =20
> +static int __qxl_bo_pin(struct qxl_bo *bo);
> +static void __qxl_bo_unpin(struct qxl_bo *bo);
> +
>   static void qxl_ttm_bo_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct qxl_bo *bo;
> @@ -179,6 +182,25 @@ int qxl_bo_kmap_locked(struct qxl_bo *bo, struct d=
ma_buf_map *map)
>   	return 0;
>   }
>  =20
> +int qxl_bo_kmap(struct qxl_bo *bo, struct dma_buf_map *map)
> +{
> +	int r;
> +
> +	r =3D qxl_bo_reserve(bo);
> +	if (r)
> +		return r;
> +
> +	r =3D __qxl_bo_pin(bo);
> +	if (r) {
> +		qxl_bo_unreserve(bo);
> +		return r;
> +	}
> +
> +	r =3D qxl_bo_kmap_locked(bo, map);
> +	qxl_bo_unreserve(bo);
> +	return r;
> +}
> +
>   void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
>   			      struct qxl_bo *bo, int page_offset)
>   {
> @@ -223,6 +245,20 @@ void qxl_bo_kunmap_locked(struct qxl_bo *bo)
>   	ttm_bo_vunmap(&bo->tbo, &bo->map);
>   }
>  =20
> +int qxl_bo_kunmap(struct qxl_bo *bo)
> +{
> +	int r;
> +
> +	r =3D qxl_bo_reserve(bo);
> +	if (r)
> +		return r;
> +
> +	qxl_bo_kunmap_locked(bo);
> +	__qxl_bo_unpin(bo);
> +	qxl_bo_unreserve(bo);
> +	return 0;
> +}
> +
>   void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev,
>   			       struct qxl_bo *bo, void *pmap)
>   {
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--1VGG77xM4sURpaHnz9v3NjgHCWihVFql3--

--juTD9d22fjPa3seaUdQD0WNZ0GwQ7my5e
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmArxeQFAwAAAAAACgkQlh/E3EQov+AE
fBAAjOrPhoueaJnUnP8T9zehkvOOOnupjQhTJkpSEBKhHyC4SHEm9pEoxvFyZnwFDLoGacK3iKMm
6Qa+91fBMtaKAMkwRqk2DMK6Gbc/p8YK2Yp0Tf2AJB+nHJ7eYeizG+AWbIKx+tsgvwl+6ikndmpo
/nJ8Owu5ip4dvrbZlvEj4xyVoE07WTrk8gwlI7tMe7vC6bZ0jkPEKjpLsww83XaD+nLRaXvCxHjE
qj9uvAnFVP2GF0Q06jQU9YVNxoHuTDEzyMH1kBhFxVgNIlUfWK+OxqUWYpONPNsO3DTq+O5tklHv
R4+xHeIbWrvcAYSPVNGcEQ/i0R50CcgBY62Q7erdxrsrLIOaYrLIlGr5CQmenF6A7EoIAFsOcv8O
S7syBmwKAqiQzcYUGBJgQVal3PWhDsbVDWQAEaOEmjh6+kdGcVq6+8jOPHchGVSzN3tBTD7hZMfP
tsN+0bD3Wwfgn+WDKMXMZ4I7PkEizQs5ZCbzJYQaxaIPTHSd8dvne945DuqVtuLm9cXl/5bG66Hk
/MmxpYg78m7Yz5HCN3M1QXgSPqte7MMY14toPisBY2nPXELwKZzrJKCu5iRSeDU2wCc7idPMBmSk
xmQk1PoWmjiRCSwJX1u6Ly1HFuQnGLhR9LX/F8JWzJl09PyYOY42juINE1XeJIUgvZBDJMHfAQx9
xe0=
=1S3z
-----END PGP SIGNATURE-----

--juTD9d22fjPa3seaUdQD0WNZ0GwQ7my5e--
