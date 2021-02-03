Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9295C30DC36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhBCOGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:06:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:51544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231880AbhBCOGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:06:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B8BCACB0;
        Wed,  3 Feb 2021 14:05:52 +0000 (UTC)
Subject: Re: [PATCH v5 3/6] drm/qxl: release shadow on shutdown
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-4-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <1eb3e4ed-59e5-bb06-1250-973a3df575be@suse.de>
Date:   Wed, 3 Feb 2021 15:05:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203131615.1714021-4-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qZBHC3Bd9N00CIww95cpIRd0jvR8GyZSk"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qZBHC3Bd9N00CIww95cpIRd0jvR8GyZSk
Content-Type: multipart/mixed; boundary="PPNomQPjxpLsOXImbAxAa8i4Hg8ZgRQAj";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <1eb3e4ed-59e5-bb06-1250-973a3df575be@suse.de>
Subject: Re: [PATCH v5 3/6] drm/qxl: release shadow on shutdown
References: <20210203131615.1714021-1-kraxel@redhat.com>
 <20210203131615.1714021-4-kraxel@redhat.com>
In-Reply-To: <20210203131615.1714021-4-kraxel@redhat.com>

--PPNomQPjxpLsOXImbAxAa8i4Hg8ZgRQAj
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 03.02.21 um 14:16 schrieb Gerd Hoffmann:
> In case we have a shadow surface on shutdown release
> it so it doesn't leak.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/qxl/qxl_display.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> index 38d6b596094d..60331e31861a 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1229,5 +1229,9 @@ int qxl_modeset_init(struct qxl_device *qdev)
>  =20
>   void qxl_modeset_fini(struct qxl_device *qdev)
>   {
> +	if (qdev->dumb_shadow_bo) {
> +		drm_gem_object_put(&qdev->dumb_shadow_bo->tbo.base);
> +		qdev->dumb_shadow_bo =3D NULL;
> +	}

In qxl_plane_prepare_fb(), qdev->dumb_shadow_bo is being created as=20
pinned object. Wouldn't it have to be unpinned here and during the=20
release in qxl_plane_prepare_fb()?

Best regards
Thomas

>   	qxl_destroy_monitors_object(qdev);
>   }
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--PPNomQPjxpLsOXImbAxAa8i4Hg8ZgRQAj--

--qZBHC3Bd9N00CIww95cpIRd0jvR8GyZSk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAarb8FAwAAAAAACgkQlh/E3EQov+AC
dw//YIjQM9+UQ6YEOTFclxVumzNIR/1B7MQxhCImAAgboACDyhWpcRrQ0XiixXw100IS0IIvE2rH
3sHu/zVvwT5Kr7M6AtR4x90pMR4NKM7wp+Ffm5F2GqUYQteW6fBB2ahHmu+XtvRfkmKyJcs9NzDX
rOP6LgVZSCvGaFaMGYC4veZh12gIitPDmqyLgp3t6ChNUOcQXCx6Sf+cPzM8054+vYkYsSuDVWqS
ZjixZau+Eb8M59eYcP5RFRkImgxpS70gAJg0xOmyH/USnXHtwPKyJovQVR6lnxXHTPOBlnidXU7d
nIPTimKw3lwBvuQTZpggiXTW5V36WYf7bX/ybAMlM/+4JfK1CECKQ5cKu1gT2UGw7asVfYU4xTP3
b44tqJToefnterytaQfpzPOxrwXhYsklcU+jjzNWPuWc1jKsSimPcva3xSqJl3TUA353UAFbFuKV
82MMmyvveePWjIw1Tw1zhJvf13feNEy8igA8ZeqAOGxomvj8RBVj7LjLaMhddkLXPh1VsB5MSDjY
LWL1J+D02fvePgHik2HuRKGFx46FA78weWhrS5szw2BkTu8fZyY7u9Ecfok/R16GQZZj7KEbR/F8
K/7amY5blEpV7QIRiR1Ifv4h0shSWjtVkQTfSe1cbSfnSvReq/5h7+Oe3DNNn+XnB9WVCQql4FtO
QDw=
=k6RT
-----END PGP SIGNATURE-----

--qZBHC3Bd9N00CIww95cpIRd0jvR8GyZSk--
