Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949C631DF97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhBQTYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:24:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:48364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232841AbhBQTYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:24:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A862AC97;
        Wed, 17 Feb 2021 19:24:02 +0000 (UTC)
Subject: Re: [PATCH v2 05/11] drm/qxl: rename qxl_bo_kmap ->
 qxl_bo_vmap_locked
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-6-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <d7d85f33-d18b-a945-e2fc-ca6738bbcc00@suse.de>
Date:   Wed, 17 Feb 2021 20:24:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217123213.2199186-6-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jWPzIJa4s65bBy4kM4qW7d5yzgZXHBRh8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jWPzIJa4s65bBy4kM4qW7d5yzgZXHBRh8
Content-Type: multipart/mixed; boundary="MFESjvRLB1ed2EA8MgpBs8YTSB6Zs4G7k";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <d7d85f33-d18b-a945-e2fc-ca6738bbcc00@suse.de>
Subject: Re: [PATCH v2 05/11] drm/qxl: rename qxl_bo_kmap ->
 qxl_bo_vmap_locked
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-6-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-6-kraxel@redhat.com>

--MFESjvRLB1ed2EA8MgpBs8YTSB6Zs4G7k
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 17.02.21 um 13:32 schrieb Gerd Hoffmann:
> Append _locked to Make clear that these functions should be called with=

> reserved bo's only.  While being at it also rename kmap -> vmap.
>=20
> No functional change.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/qxl/qxl_object.h  |  4 ++--
>   drivers/gpu/drm/qxl/qxl_display.c | 14 +++++++-------
>   drivers/gpu/drm/qxl/qxl_draw.c    |  8 ++++----
>   drivers/gpu/drm/qxl/qxl_image.c   |  2 +-
>   drivers/gpu/drm/qxl/qxl_object.c  |  8 ++++----
>   drivers/gpu/drm/qxl/qxl_prime.c   |  4 ++--
>   6 files changed, 20 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl=
_object.h
> index dc1659e717f1..2495e5cdf353 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.h
> +++ b/drivers/gpu/drm/qxl/qxl_object.h
> @@ -64,8 +64,8 @@ extern int qxl_bo_create(struct qxl_device *qdev,
>   			 u32 priority,
>   			 struct qxl_surface *surf,
>   			 struct qxl_bo **bo_ptr);
> -extern int qxl_bo_kmap(struct qxl_bo *bo, struct dma_buf_map *map);
> -extern void qxl_bo_kunmap(struct qxl_bo *bo);
> +int qxl_bo_vmap_locked(struct qxl_bo *bo, struct dma_buf_map *map);
> +void qxl_bo_vunmap_locked(struct qxl_bo *bo);
>   void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo =
*bo, int page_offset);
>   void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev, struct qxl_bo=
 *bo, void *map);
>   extern struct qxl_bo *qxl_bo_ref(struct qxl_bo *bo);
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> index a1b5cc5918bc..bfcc93089a94 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -600,7 +600,7 @@ static void qxl_cursor_atomic_update(struct drm_pla=
ne *plane,
>   		user_bo =3D gem_to_qxl_bo(obj);
>  =20
>   		/* pinning is done in the prepare/cleanup framevbuffer */
> -		ret =3D qxl_bo_kmap(user_bo, &user_map);
> +		ret =3D qxl_bo_vmap_locked(user_bo, &user_map);
>   		if (ret)
>   			goto out_free_release;
>   		user_ptr =3D user_map.vaddr; /* TODO: Use mapping abstraction prope=
rly */
> @@ -619,7 +619,7 @@ static void qxl_cursor_atomic_update(struct drm_pla=
ne *plane,
>   		if (ret)
>   			goto out_unpin;
>  =20
> -		ret =3D qxl_bo_kmap(cursor_bo, &cursor_map);
> +		ret =3D qxl_bo_vmap_locked(cursor_bo, &cursor_map);
>   		if (ret)
>   			goto out_backoff;
>   		if (cursor_map.is_iomem) /* TODO: Use mapping abstraction properly =
*/
> @@ -638,8 +638,8 @@ static void qxl_cursor_atomic_update(struct drm_pla=
ne *plane,
>   		cursor->chunk.prev_chunk =3D 0;
>   		cursor->chunk.data_size =3D size;
>   		memcpy(cursor->chunk.data, user_ptr, size);
> -		qxl_bo_kunmap(cursor_bo);
> -		qxl_bo_kunmap(user_bo);
> +		qxl_bo_vunmap_locked(cursor_bo);
> +		qxl_bo_vunmap_locked(user_bo);
>  =20
>   		cmd =3D (struct qxl_cursor_cmd *) qxl_release_map(qdev, release);
>   		cmd->u.set.visible =3D 1;
> @@ -681,7 +681,7 @@ static void qxl_cursor_atomic_update(struct drm_pla=
ne *plane,
>   out_free_bo:
>   	qxl_bo_unref(&cursor_bo);
>   out_kunmap:
> -	qxl_bo_kunmap(user_bo);
> +	qxl_bo_vunmap_locked(user_bo);
>   out_free_release:
>   	qxl_release_free(qdev, release);
>   	return;
> @@ -1163,7 +1163,7 @@ int qxl_create_monitors_object(struct qxl_device =
*qdev)
>   	if (ret)
>   		return ret;
>  =20
> -	qxl_bo_kmap(qdev->monitors_config_bo, &map);
> +	qxl_bo_vmap_locked(qdev->monitors_config_bo, &map);
>  =20
>   	qdev->monitors_config =3D qdev->monitors_config_bo->kptr;
>   	qdev->ram_header->monitors_config =3D
> @@ -1189,7 +1189,7 @@ int qxl_destroy_monitors_object(struct qxl_device=
 *qdev)
>   	qdev->monitors_config =3D NULL;
>   	qdev->ram_header->monitors_config =3D 0;
>  =20
> -	qxl_bo_kunmap(qdev->monitors_config_bo);
> +	qxl_bo_vunmap_locked(qdev->monitors_config_bo);
>   	ret =3D qxl_bo_unpin(qdev->monitors_config_bo);
>   	if (ret)
>   		return ret;
> diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_d=
raw.c
> index 7b7acb910780..7d27891e87fa 100644
> --- a/drivers/gpu/drm/qxl/qxl_draw.c
> +++ b/drivers/gpu/drm/qxl/qxl_draw.c
> @@ -48,7 +48,7 @@ static struct qxl_rect *drawable_set_clipping(struct =
qxl_device *qdev,
>   	struct qxl_clip_rects *dev_clips;
>   	int ret;
>  =20
> -	ret =3D qxl_bo_kmap(clips_bo, &map);
> +	ret =3D qxl_bo_vmap_locked(clips_bo, &map);
>   	if (ret)
>   		return NULL;
>   	dev_clips =3D map.vaddr; /* TODO: Use mapping abstraction properly *=
/
> @@ -202,7 +202,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
>   	if (ret)
>   		goto out_release_backoff;
>  =20
> -	ret =3D qxl_bo_kmap(bo, &surface_map);
> +	ret =3D qxl_bo_vmap_locked(bo, &surface_map);
>   	if (ret)
>   		goto out_release_backoff;
>   	surface_base =3D surface_map.vaddr; /* TODO: Use mapping abstraction=
 properly */
> @@ -210,7 +210,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
>   	ret =3D qxl_image_init(qdev, release, dimage, surface_base,
>   			     left - dumb_shadow_offset,
>   			     top, width, height, depth, stride);
> -	qxl_bo_kunmap(bo);
> +	qxl_bo_vunmap_locked(bo);
>   	if (ret)
>   		goto out_release_backoff;
>  =20
> @@ -247,7 +247,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
>   		rects[i].top    =3D clips_ptr->y1;
>   		rects[i].bottom =3D clips_ptr->y2;
>   	}
> -	qxl_bo_kunmap(clips_bo);
> +	qxl_bo_vunmap_locked(clips_bo);
>  =20
>   	qxl_release_fence_buffer_objects(release);
>   	qxl_push_command_ring_release(qdev, release, QXL_CMD_DRAW, false);
> diff --git a/drivers/gpu/drm/qxl/qxl_image.c b/drivers/gpu/drm/qxl/qxl_=
image.c
> index 60ab7151b84d..ffff54e5fb31 100644
> --- a/drivers/gpu/drm/qxl/qxl_image.c
> +++ b/drivers/gpu/drm/qxl/qxl_image.c
> @@ -186,7 +186,7 @@ qxl_image_init_helper(struct qxl_device *qdev,
>   			}
>   		}
>   	}
> -	qxl_bo_kunmap(chunk_bo);
> +	qxl_bo_vunmap_locked(chunk_bo);
>  =20
>   	image_bo =3D dimage->bo;
>   	ptr =3D qxl_bo_kmap_atomic_page(qdev, image_bo, 0);
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl=
_object.c
> index 7eada4ad217b..f4a015381a7f 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -155,7 +155,7 @@ int qxl_bo_create(struct qxl_device *qdev, unsigned=
 long size,
>   	return 0;
>   }
>  =20
> -int qxl_bo_kmap(struct qxl_bo *bo, struct dma_buf_map *map)
> +int qxl_bo_vmap_locked(struct qxl_bo *bo, struct dma_buf_map *map)
>   {
>   	int r;
>  =20
> @@ -203,7 +203,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qd=
ev,
>   		return rptr;
>   	}
>  =20
> -	ret =3D qxl_bo_kmap(bo, &bo_map);
> +	ret =3D qxl_bo_vmap_locked(bo, &bo_map);
>   	if (ret)
>   		return NULL;
>   	rptr =3D bo_map.vaddr; /* TODO: Use mapping abstraction properly */
> @@ -212,7 +212,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qd=
ev,
>   	return rptr;
>   }
>  =20
> -void qxl_bo_kunmap(struct qxl_bo *bo)
> +void qxl_bo_vunmap_locked(struct qxl_bo *bo)
>   {
>   	if (bo->kptr =3D=3D NULL)
>   		return;
> @@ -233,7 +233,7 @@ void qxl_bo_kunmap_atomic_page(struct qxl_device *q=
dev,
>   	io_mapping_unmap_atomic(pmap);
>   	return;
>    fallback:
> -	qxl_bo_kunmap(bo);
> +	qxl_bo_vunmap_locked(bo);
>   }
>  =20
>   void qxl_bo_unref(struct qxl_bo **bo)
> diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_=
prime.c
> index 4aa949799446..2bebe662516f 100644
> --- a/drivers/gpu/drm/qxl/qxl_prime.c
> +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> @@ -59,7 +59,7 @@ int qxl_gem_prime_vmap(struct drm_gem_object *obj, st=
ruct dma_buf_map *map)
>   	struct qxl_bo *bo =3D gem_to_qxl_bo(obj);
>   	int ret;
>  =20
> -	ret =3D qxl_bo_kmap(bo, map);
> +	ret =3D qxl_bo_vmap_locked(bo, map);
>   	if (ret < 0)
>   		return ret;
>  =20
> @@ -71,7 +71,7 @@ void qxl_gem_prime_vunmap(struct drm_gem_object *obj,=

>   {
>   	struct qxl_bo *bo =3D gem_to_qxl_bo(obj);
>  =20
> -	qxl_bo_kunmap(bo);
> +	qxl_bo_vunmap_locked(bo);
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


--MFESjvRLB1ed2EA8MgpBs8YTSB6Zs4G7k--

--jWPzIJa4s65bBy4kM4qW7d5yzgZXHBRh8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAtbVEFAwAAAAAACgkQlh/E3EQov+AW
mRAAnoa2Ssx47k+A6Z5RDvPZJs6F3pupDzF/GTtyA7N94PpeT7XhScZQdyBvYPDzf76l2Ms8lLvV
hYXpGTrw3hrbWZFH0PydEWLNYvs7kTJ88TYUVKxQ1YdNST2glsm8VP6uJnJlWPcIgU7F3FQ8H3FT
D31ZJt2U9x5i1bJnkNPeV/WeXGAIYRvpZD3hXR8mIZDCclxplz01ynVDBr94MdelVnPvVCIoJyuc
8fjUUYiP6CYSFcjJfAXhKnZOwT6u+CT+jQQaatejwEYeb8DNjT3c9lHMXjC2m7//oVWHdOgi3Hqq
ndIwhMldAdNrYfkw5llcOaKVVFmVRNvKwy0+HLwqJvsWT1RvlzDCRG2vghW7QuyE2w7S4V0MxSbR
zjGwXM+5pKKHjaNAPNvo2SbfQmKw97PrYExn8GyiGeUBaZimMsDUDsfuuhg/6/OmGLRdt8GInaWq
fOjARz+DAped7OFNWe9voGRv1AxXZYZY1V35N24TTBWWP7GEw+V1/1Sql2XPO5uWZlEsPmY7xDYj
BZWwmvd8sq+UBK28jwUP/BOirjATbIz4pbpiRIL5ciW/lek/pmhiZ+V8mnaQbynn3ZxxMUs3PpE8
OmGiNbxvWFRUc1uLQzhQdtTH/F5L1ic7qn/m2MpryG8OaFtPy2Zg3tQYuJ5oPG8cQ4Qf31Fho2Cy
NOY=
=462G
-----END PGP SIGNATURE-----

--jWPzIJa4s65bBy4kM4qW7d5yzgZXHBRh8--
