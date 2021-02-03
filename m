Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E663530DC41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhBCOIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:08:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:52720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232306AbhBCOH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:07:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0008FACB0;
        Wed,  3 Feb 2021 14:07:17 +0000 (UTC)
Subject: Re: [PATCH v5 4/6] drm/qxl: handle shadow in primary destroy
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-5-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <a47d7646-d34e-8a5a-eb66-6b7e0f3aa777@suse.de>
Date:   Wed, 3 Feb 2021 15:07:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203131615.1714021-5-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zVkp2LbXeo9xdK24qHbVhhpFZXgl64cyQ"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zVkp2LbXeo9xdK24qHbVhhpFZXgl64cyQ
Content-Type: multipart/mixed; boundary="VtRkb7Y62egMcaLwIsPWaCXoVqjlYGBKM";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <a47d7646-d34e-8a5a-eb66-6b7e0f3aa777@suse.de>
Subject: Re: [PATCH v5 4/6] drm/qxl: handle shadow in primary destroy
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-5-kraxel@redhat.com>
In-Reply-To: <20210203131615.1714021-5-kraxel@redhat.com>

--VtRkb7Y62egMcaLwIsPWaCXoVqjlYGBKM
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 03.02.21 um 14:16 schrieb Gerd Hoffmann:
> qxl_primary_atomic_disable must check whenever the framebuffer bo has a=

> shadow surface and in case it has check the shadow primary status.

I believe you :)

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> index 60331e31861a..f5ee8cd72b5b 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -562,6 +562,8 @@ static void qxl_primary_atomic_disable(struct drm_p=
lane *plane,
>   	if (old_state->fb) {
>   		struct qxl_bo *bo =3D gem_to_qxl_bo(old_state->fb->obj[0]);
>  =20
> +		if (bo->shadow)
> +			bo =3D bo->shadow;
>   		if (bo->is_primary) {
>   			qxl_io_destroy_primary(qdev);
>   			bo->is_primary =3D false;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--VtRkb7Y62egMcaLwIsPWaCXoVqjlYGBKM--

--zVkp2LbXeo9xdK24qHbVhhpFZXgl64cyQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAarhQFAwAAAAAACgkQlh/E3EQov+B5
0Q//QF3+DxUtgM4jYfWiDkOHWVPkTilkocbU+UmeJ4FeVVTtpsBpmVkMnZgJINaapQhY1NUnpI6k
hpvgCT+tekKDBOZutLQXWWPy5T1r7Smrhip8Db1BzElpkl7XK0ONQ5b2EqmfLCfVv53pBKR7nSov
1nFv8gCLQwmAUkeW5Rw1SRlXioQbs5ByeD5anVHUKsDMoovDyflyfgRG1P+z1KA9CB5d3vaH0wTS
AHGednnr0q9GeVeLHN9UCKzIXF0zClSZ7DovbPgmcTYS3TDjU8JNPf8qfjMJyhocTS9n036At65X
kIbK7HxblJtmUmJ2cTRkmxgou0mqtbD2PTYyHTvMEQwQCUP9kRU3/rMlhEVtiOxHpOw9RxcApXta
GOTVQZSgHhZ/ukfZg65fltF7Gm5jCUSaaqSs/00tuUN9ACpoCyTEc2e/ubwxvx4J1vqDka9wpTZv
7BtAdpu+En5NjYYsSGrsr87OObNx334zYQN2knzyI1ah3lvQ5vs9qxkgmHcRzK+e7iop3HWqak3g
MTn7DEK4X4A7ASH0F7c/bgMhtk5fAJAFNLXXid/7f2kiY0LeR0JwTGFUJBX0uzV7O0Bt7kW57Zpi
LyCuF22UrSGlW5FOQN5EDqck5F9I4mNkB+WpbE3RiMx7jjTX3gL6K4/fSvDXbMo4ICW30BwvSKra
7sk=
=dwrl
-----END PGP SIGNATURE-----

--zVkp2LbXeo9xdK24qHbVhhpFZXgl64cyQ--
