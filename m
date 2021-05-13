Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A5737F85C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhEMNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:05:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:41544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232864AbhEMNEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:04:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2ABF9B1AB;
        Thu, 13 May 2021 13:03:41 +0000 (UTC)
Subject: Re: [PATCH -next] drm: simpledrm: print resource info using '%pr'
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org
References: <20210512233459.19534-1-rdunlap@infradead.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <7bc970ed-007f-6374-b7f8-71707606a6b9@suse.de>
Date:   Thu, 13 May 2021 15:03:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210512233459.19534-1-rdunlap@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dak79HA3qMhgihHuHU08I4mi89otf7oWG"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dak79HA3qMhgihHuHU08I4mi89otf7oWG
Content-Type: multipart/mixed; boundary="KhcWyEjhF4h3QqCazWrFGqRbaZorvBSf5";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Message-ID: <7bc970ed-007f-6374-b7f8-71707606a6b9@suse.de>
Subject: Re: [PATCH -next] drm: simpledrm: print resource info using '%pr'
References: <20210512233459.19534-1-rdunlap@infradead.org>
In-Reply-To: <20210512233459.19534-1-rdunlap@infradead.org>

--KhcWyEjhF4h3QqCazWrFGqRbaZorvBSf5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 13.05.21 um 01:34 schrieb Randy Dunlap:
> struct resource start and end fields are not always long long,
> so using %llx to print them can cause build warnings (below).
> Fix these by using the special "%pr" for printing struct resource info.=

>=20
> ../drivers/gpu/drm/tiny/simpledrm.c: In function =E2=80=98simpledrm_dev=
ice_init_mm=E2=80=99:
> ../include/drm/drm_print.h:412:32: warning: format =E2=80=98%llx=E2=80=99=20
expects argument of type =E2=80=98long long unsigned int=E2=80=99, but ar=
gument 3 has type =E2=80=98resource_size_t {aka unsigned int}=E2=80=99 [-=
Wformat=3D]
> ../drivers/gpu/drm/tiny/simpledrm.c:533:54: note: format string is defi=
ned here
>     drm_err(dev, "could not acquire memory range [0x%llx:0x%llx]: error=20
%d\n",
>                                                     ~~~^
>                                                     %x
> ../include/drm/drm_print.h:412:32: warning: format =E2=80=98%llx=E2=80=99=20
expects argument of type =E2=80=98long long unsigned int=E2=80=99, but ar=
gument 4 has type =E2=80=98resource_size_t {aka unsigned int}=E2=80=99 [-=
Wformat=3D]
> ../drivers/gpu/drm/tiny/simpledrm.c:533:61: note: format string is defi=
ned here
>     drm_err(dev, "could not acquire memory range [0x%llx:0x%llx]: error=20
%d\n",
>                                                            ~~~^
>                                                            %x
>=20
> Fixes: 4aae79f77e3a ("drm/simpledrm: Acquire memory aperture for frameb=
uffer")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: dri-devel@lists.freedesktop.org

Queued up for drm-misc-next. Thanks a lot.

Best regards
Thomas

> ---
>   drivers/gpu/drm/tiny/simpledrm.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- linux-next-20210512.orig/drivers/gpu/drm/tiny/simpledrm.c
> +++ linux-next-20210512/drivers/gpu/drm/tiny/simpledrm.c
> @@ -530,8 +530,8 @@ static int simpledrm_device_init_mm(stru
>  =20
>   	ret =3D devm_aperture_acquire_from_firmware(dev, mem->start, resourc=
e_size(mem));
>   	if (ret) {
> -		drm_err(dev, "could not acquire memory range [0x%llx:0x%llx]: error =
%d\n",
> -			mem->start, mem->end, ret);
> +		drm_err(dev, "could not acquire memory range %pr: error %d\n",
> +			mem, ret);
>   		return ret;
>   	}
>  =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--KhcWyEjhF4h3QqCazWrFGqRbaZorvBSf5--

--dak79HA3qMhgihHuHU08I4mi89otf7oWG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmCdI6wFAwAAAAAACgkQlh/E3EQov+D2
oRAAlm3YwzQg7SISFqmaJ+lXLJUv0eRBctw3inqSWTrwYCw+VoLwAkyOhXp8iVHDX9vkjGYO/5pO
WXyAmOZUFQVlRkTAl+woOZsvulqRdRnDc+xf/1Zir7gMnrvhefUXJCdQpQiG+DYaYy6Fw9NzlFfU
jYTDohglR/ha4CBS6eOQGj/+/sjrdWdgmTEvZhftTuxwYUZ1hIL/26Qt0RceNH4PBOAhgi6JwqrO
ICa1k+gfi2Of3H+aaROR2BhK7xGplD7rO+EgRgZOxRTytIjkcl4vUqtxQFeUHOQuyfqy3dJhalVH
Drqy0fYoqC2EvDy/wysOPoPL0M25bqQYZvxWzfZNGv5fZYAWnvBFmB1cdinnxpHR9k53QGSn1i6j
hjG1+F7KZ6cau6n3NzlEKcq9i0U5rgncMA3aYMnobddaGCQ3p53O/ZQWDnLDfptFZZoRFIWlyqfz
3Ls9DU/vTU65mtwQBXwv32e9Z8+EIzSpPz+PNVzbKQzd88WQEI+43G5872y6HBSaehKoz39cDS4d
D+SU+QWBCIDwH7XDe93JrN3jlTt3P3wQ3CHRCeFKDSFiUayQeD0yXTeVAbh3f90C1CSIPQDh6HmZ
j0zmqJyE6DJ+i6BLLwJYZxujMJMFvwTp5g8x7JtSZ2GmD3nvuuxaT5Lz0zl8C2IYouJyt8F9cN2x
eY0=
=ygU8
-----END PGP SIGNATURE-----

--dak79HA3qMhgihHuHU08I4mi89otf7oWG--
