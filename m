Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACA031ED3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhBRRXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:23:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:52456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhBROnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:43:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90E5CAE42;
        Thu, 18 Feb 2021 14:42:39 +0000 (UTC)
Subject: Re: [PATCH v2 08/11] drm/qxl: fix monitors object vmap
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-9-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <1743626e-d34d-8a7d-1b66-ae38f77c5ea5@suse.de>
Date:   Thu, 18 Feb 2021 15:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217123213.2199186-9-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0GppSwbcLniTLaXzGE2etbBTPbbK4n4z2"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0GppSwbcLniTLaXzGE2etbBTPbbK4n4z2
Content-Type: multipart/mixed; boundary="n6b1Z8I5X2eTfl1kktnTO3v7jFlZGXmyO";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <1743626e-d34d-8a7d-1b66-ae38f77c5ea5@suse.de>
Subject: Re: [PATCH v2 08/11] drm/qxl: fix monitors object vmap
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-9-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-9-kraxel@redhat.com>

--n6b1Z8I5X2eTfl1kktnTO3v7jFlZGXmyO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 17.02.21 um 13:32 schrieb Gerd Hoffmann:
> Use the correct vmap variant.  We don't hold a reservation here,
> so we can't use the _locked variant.  We can drop the pin because
> qxl_bo_vmap will do that for us.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

I simply forgot to ack this patch.

> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> index bfcc93089a94..f106da917863 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1159,12 +1159,10 @@ int qxl_create_monitors_object(struct qxl_devic=
e *qdev)
>   	}
>   	qdev->monitors_config_bo =3D gem_to_qxl_bo(gobj);
>  =20
> -	ret =3D qxl_bo_pin(qdev->monitors_config_bo);
> +	ret =3D qxl_bo_vmap(qdev->monitors_config_bo, &map);
>   	if (ret)
>   		return ret;
>  =20
> -	qxl_bo_vmap_locked(qdev->monitors_config_bo, &map);
> -
>   	qdev->monitors_config =3D qdev->monitors_config_bo->kptr;
>   	qdev->ram_header->monitors_config =3D
>   		qxl_bo_physical_address(qdev, qdev->monitors_config_bo, 0);
> @@ -1189,8 +1187,7 @@ int qxl_destroy_monitors_object(struct qxl_device=
 *qdev)
>   	qdev->monitors_config =3D NULL;
>   	qdev->ram_header->monitors_config =3D 0;
>  =20
> -	qxl_bo_vunmap_locked(qdev->monitors_config_bo);
> -	ret =3D qxl_bo_unpin(qdev->monitors_config_bo);
> +	ret =3D qxl_bo_vunmap(qdev->monitors_config_bo);
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


--n6b1Z8I5X2eTfl1kktnTO3v7jFlZGXmyO--

--0GppSwbcLniTLaXzGE2etbBTPbbK4n4z2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAufN4FAwAAAAAACgkQlh/E3EQov+C5
Tg//TrufcEVK61EAu1+3Er/neTjfN+QwzueogPCYKACr6iPKEZ2vmb31JaXyjAnaXOUw+PxLzH/V
rgOunhMQ7uqjE7Hjvn2Skrf/PjpT2LzN6zTMXZ1BcX4ABYpyg/dCYOrnGrV2rAzQFGxg296HOmur
r6WTQ0a1fdMKZHtl4utDXmEPTWvH2ky8eje1iAMm+xez8h98XknnK2daMQAmSJMFBWuM+0gPnW1z
dGEIP58ZeonvoBkBn0gU340s8aK3VQVWxb8T1U7Qv98MWC+UlXyrl6iCrx+ObsnnUI2OKlJ+1EYw
0l+MudQWVpELBAQVRlNSH5dc9WXXkaLcVP3c7TqyfLHLcuczxVLQqMontuUCw8hVmM3QIWHSDWda
0RlNMBR4pAyxet+Da4Cv8ln7Ka6ftqs+b2HQRdDDn7W5daaCWp5AXhliX3BZqIq3dN35X0tgeH0t
e+zMIzU8Xtu4DN61pxZhJUszK1QdVGpj+uMYo7t1Dchc3NWRcZerbS4iWvG03szzpOcS3rIGpHlA
FOKUL0nslKpQOht8i7kPx1cEngTGtWiVvESkhTgx5FFVjH4F4DjFAA/23ogwbsdO0Icf98KYSXUU
J2bq4Mm7UM81q94GVmKyqaYtwOzVsSnw5iXad+bqWYqYCtdNnx9usNcZz4Q2jKHaIk0Qq+sCLtZ1
iPU=
=eckE
-----END PGP SIGNATURE-----

--0GppSwbcLniTLaXzGE2etbBTPbbK4n4z2--
