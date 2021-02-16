Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34E631CB16
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 14:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhBPN23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 08:28:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:60778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhBPN2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 08:28:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4DDE0ACBF;
        Tue, 16 Feb 2021 13:27:42 +0000 (UTC)
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-10-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 09/10] drm/qxl: map/unmap framebuffers in
 prepare_fb+cleanup_fb callbacks.
Message-ID: <5baf096f-b1ee-46ba-5ee9-1c829b96e088@suse.de>
Date:   Tue, 16 Feb 2021 14:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210216113716.716996-10-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t6ObCfqeNje5PVm1VdE1lp9lo3sqV3OU7"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t6ObCfqeNje5PVm1VdE1lp9lo3sqV3OU7
Content-Type: multipart/mixed; boundary="1gO4pp0ZAZQBFWSJwOpmGsR9livlUNtlm";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <5baf096f-b1ee-46ba-5ee9-1c829b96e088@suse.de>
Subject: Re: [PATCH 09/10] drm/qxl: map/unmap framebuffers in
 prepare_fb+cleanup_fb callbacks.
References: <20210216113716.716996-1-kraxel@redhat.com>
 <20210216113716.716996-10-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-10-kraxel@redhat.com>

--1gO4pp0ZAZQBFWSJwOpmGsR9livlUNtlm
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

this is a shadow-buffered plane. Did you consider using the new helpers=20
for shadow-buffered planes? They will map the user BO for you and=20
provide the mapping in the plane state.

 From there, you should implement your own plane state on top of struct=20
drm_shadow_plane_state, and also move all the other allocations and=20
vmaps into prepare_fb and cleanup_fb. Most of this is not actually=20
allowed in commit tails. All we'd have to do is to export the reset,=20
duplicate and destroy code; similar to what=20
__drm_atomic_helper_plane_reset() does.

Best regards
Thomas


Am 16.02.21 um 12:37 schrieb Gerd Hoffmann:
> We don't have to map in atomic_update callback then,
> making locking a bit less complicated.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> index 7500560db8e4..39b8c5116d34 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -584,7 +584,6 @@ static void qxl_cursor_atomic_update(struct drm_pla=
ne *plane,
>   	struct drm_gem_object *obj;
>   	struct qxl_bo *cursor_bo =3D NULL, *user_bo =3D NULL, *old_cursor_bo=
 =3D NULL;
>   	int ret;
> -	struct dma_buf_map user_map;
>   	struct dma_buf_map cursor_map;
>   	void *user_ptr;
>   	int size =3D 64*64*4;
> @@ -599,11 +598,8 @@ static void qxl_cursor_atomic_update(struct drm_pl=
ane *plane,
>   		obj =3D fb->obj[0];
>   		user_bo =3D gem_to_qxl_bo(obj);
>  =20
> -		/* pinning is done in the prepare/cleanup framevbuffer */
> -		ret =3D qxl_bo_kmap_locked(user_bo, &user_map);
> -		if (ret)
> -			goto out_free_release;
> -		user_ptr =3D user_map.vaddr; /* TODO: Use mapping abstraction proper=
ly */
> +		/* mapping is done in the prepare/cleanup framevbuffer */
> +		user_ptr =3D user_bo->map.vaddr; /* TODO: Use mapping abstraction pr=
operly */
>  =20
>   		ret =3D qxl_alloc_bo_reserved(qdev, release,
>   					    sizeof(struct qxl_cursor) + size,
> @@ -639,7 +635,6 @@ static void qxl_cursor_atomic_update(struct drm_pla=
ne *plane,
>   		cursor->chunk.data_size =3D size;
>   		memcpy(cursor->chunk.data, user_ptr, size);
>   		qxl_bo_kunmap_locked(cursor_bo);
> -		qxl_bo_kunmap_locked(user_bo);
>  =20
>   		cmd =3D (struct qxl_cursor_cmd *) qxl_release_map(qdev, release);
>   		cmd->u.set.visible =3D 1;
> @@ -778,6 +773,7 @@ static int qxl_plane_prepare_fb(struct drm_plane *p=
lane,
>   	struct drm_gem_object *obj;
>   	struct qxl_bo *user_bo;
>   	struct qxl_surface surf;
> +	struct dma_buf_map unused;
>  =20
>   	if (!new_state->fb)
>   		return 0;
> @@ -815,7 +811,7 @@ static int qxl_plane_prepare_fb(struct drm_plane *p=
lane,
>   		}
>   	}
>  =20
> -	return qxl_bo_pin(user_bo);
> +	return qxl_bo_kmap(user_bo, &unused);
>   }
>  =20
>   static void qxl_plane_cleanup_fb(struct drm_plane *plane,
> @@ -834,7 +830,7 @@ static void qxl_plane_cleanup_fb(struct drm_plane *=
plane,
>  =20
>   	obj =3D old_state->fb->obj[0];
>   	user_bo =3D gem_to_qxl_bo(obj);
> -	qxl_bo_unpin(user_bo);
> +	qxl_bo_kunmap(user_bo);
>  =20
>   	if (old_state->fb !=3D plane->state->fb && user_bo->shadow) {
>   		qxl_bo_unpin(user_bo->shadow);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--1gO4pp0ZAZQBFWSJwOpmGsR9livlUNtlm--

--t6ObCfqeNje5PVm1VdE1lp9lo3sqV3OU7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAryEwFAwAAAAAACgkQlh/E3EQov+Dg
TA//dRXUg0MLOw9b81xM6nt0HJ9RLw46bRhb4XCqoLhICz7Pg97Fyx2JaE8yf3hioB9rmTSV675Z
BJStK9iol7BnxcpVcZEnVo7KJUPCANiMiFefVid694ycHsIulct4yieM1UyBv+b1Kyz1reOHw6a8
lhinyf1hBf7DeU7FPxTJkcVc7LQQmLN7s8Vvgr0cnRync+YgDEv+4KXwyseVcIPwvYWk8hEUXNpJ
TqafUD1yWZjFzIyn2h3Ud9iTuOe/dAFvo79yuOZC16XoqXO4go/JToEbrt3QpXt0Jd9tk1GZS7Mq
4Yn+AsHNH+7bh5UWku1s5d2NIx+OFI3V8tkSOdmjT442QOFffxaYJzOsW2pJMvdu3/zbLz73bg3V
QoVhHvIcyfWltLBLUgnQBURZu6P1/G4u61nTMQ1hxl99Zt+ENcv0DWoQ5WtS9M/6TCwi6jolvqqn
s3IGA+wgJdAoUBR4PCCaD4vb32iMehkSUSNh7/Zc88a5ijmtryB6yjN4Gih5/B9OiLyDmUN7YcMD
GMwsE13FnPzUxieh0QVgR4L05Uu06gFSRKamWgHOmwqtm9HIwB2E+/zwJxYvhrkY6YmzavkUy2eP
X+zOz43MKLoDiNYo1RVrhGnHZdD6MaqPTxP8gnzFGjH2+GIApvj5wNmvlnyeCn2Eth6NwCVJ19cH
xT4=
=clOc
-----END PGP SIGNATURE-----

--t6ObCfqeNje5PVm1VdE1lp9lo3sqV3OU7--
