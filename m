Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D940C382CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhEQM6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:58:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:43584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235092AbhEQM6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:58:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72E53B1C8;
        Mon, 17 May 2021 12:57:33 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: repair reference in DRM DRIVER FOR SIMPLE
 FRAMEBUFFERS
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210517101648.29906-1-lukas.bulwahn@gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <d86962b1-da7e-232e-6501-9fa2e406781f@suse.de>
Date:   Mon, 17 May 2021 14:57:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210517101648.29906-1-lukas.bulwahn@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8T38aIg0zaK56NSCyYPDE0KMDZccUjuyX"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8T38aIg0zaK56NSCyYPDE0KMDZccUjuyX
Content-Type: multipart/mixed; boundary="nzNGNBF0QtYWhtU9g06smdT7uiap7YwMT";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <d86962b1-da7e-232e-6501-9fa2e406781f@suse.de>
Subject: Re: [PATCH] MAINTAINERS: repair reference in DRM DRIVER FOR SIMPLE
 FRAMEBUFFERS
References: <20210517101648.29906-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210517101648.29906-1-lukas.bulwahn@gmail.com>

--nzNGNBF0QtYWhtU9g06smdT7uiap7YwMT
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 17.05.21 um 12:16 schrieb Lukas Bulwahn:
> Commit 11e8f5fd223b ("drm: Add simpledrm driver") adds the file
> ./drivers/gpu/drm/tiny/simpledrm.c, but refers to the file
> ./drivers/gpu/drm/tiny/simplekms.c with the new MAINTAINERS section
> DRM DRIVER FOR SIMPLE FRAMEBUFFERS.
>=20
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains:
>=20
>    warning: no file matches    F:    drivers/gpu/drm/tiny/simplekms.c
>=20
> Repair the file entry by referring to the right location.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210514
>=20
> Thomas, Daniel, please pick this minor clean-up patch for your -next tr=
ee.

Thank you so much. Added to drm-misc-next

Best regards
Thomas

>=20
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6582d19cdf7a..88277ff25d43 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5885,7 +5885,7 @@ M:	Thomas Zimmermann <tzimmermann@suse.de>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git git://anongit.freedesktop.org/drm/drm-misc
> -F:	drivers/gpu/drm/tiny/simplekms.c
> +F:	drivers/gpu/drm/tiny/simpledrm.c
>  =20
>   DRM DRIVER FOR SIS VIDEO CARDS
>   S:	Orphan / Obsolete
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--nzNGNBF0QtYWhtU9g06smdT7uiap7YwMT--

--8T38aIg0zaK56NSCyYPDE0KMDZccUjuyX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmCiaDwFAwAAAAAACgkQlh/E3EQov+DD
tBAAotWv6n0Bi9OwXQHdZ+36Mh8S4VR1BH5wElL3t3VPjFChCmY0xMSNx44AaW9rD9akvfdE8EWI
M+Q1wPPCoNplbgeQFuwlJZIXTh41NaDQcSJequwUEHEzU4YmPXBP3uq7GvnvjHi0hWfamar87bJ7
kYMp9yax3WjdRzlA03H6fblysVjTZrZnnwCPBShYp81pSTiWgIVPQbhlLotPi/94w6LbYGqN5Kh8
RrTQvEJrpKtqk7GzQ7FxKzAic8jwxv4B4bGhuPVzNEd0ya7fCf9dH1Tn34/DYAjMM2DU9eZyraqB
wYeWJhLOmUoN3xNbOyn6VI3dEJDznnJNZKbfKcXHzSbagu1Ay39KZyYfnONiaW7DXzz7PMpGfyv4
kcMpH+3OTacIwdw111J24LyyGqg0j+AtxebSWEdgbxOs9vtlaIIsuto1/+M72G8GSqaYbwEAQLJ6
QqqlZy3o4CL+/8hsZiPE8+H4EXh2mIB1e5szv0Bxja5cbdwOla5f9PZXVdZbyJACVQOub6W36Otg
/GOrrAjwbJEq21xeX2ouCYOb4HL7mVNj+WnTf8vtUedldlm0aqNYJ66KAH9CkIn27bAYryWcgw8i
NqXijb1CBY7K1iI7gNl9aPl9waFuaL+/e+R2IcbfFGGScAurG1j5gX5RTdizYhLtgQWIiTNfm+1M
ZHk=
=JYFL
-----END PGP SIGNATURE-----

--8T38aIg0zaK56NSCyYPDE0KMDZccUjuyX--
