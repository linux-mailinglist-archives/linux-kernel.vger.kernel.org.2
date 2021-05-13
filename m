Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E635937F952
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhEMODZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:03:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:44752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234317AbhEMODE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:03:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8CB7B1C3;
        Thu, 13 May 2021 14:01:52 +0000 (UTC)
Subject: Re: [PATCH][next] drm: simpledrm: Fix use after free issues
To:     Colin King <colin.king@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210512203051.299026-1-colin.king@canonical.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <2b709552-cd8c-0885-c99c-7cb9e2af905b@suse.de>
Date:   Thu, 13 May 2021 16:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210512203051.299026-1-colin.king@canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XaWzkNuflmcnRw9sH5tvQKoTUukS4gsCn"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XaWzkNuflmcnRw9sH5tvQKoTUukS4gsCn
Content-Type: multipart/mixed; boundary="la8J2z3cSCMFxMNgESLXqTvLIpk2BDxpm";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Colin King <colin.king@canonical.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <maxime@cerno.tech>,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <2b709552-cd8c-0885-c99c-7cb9e2af905b@suse.de>
Subject: Re: [PATCH][next] drm: simpledrm: Fix use after free issues
References: <20210512203051.299026-1-colin.king@canonical.com>
In-Reply-To: <20210512203051.299026-1-colin.king@canonical.com>

--la8J2z3cSCMFxMNgESLXqTvLIpk2BDxpm
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 12.05.21 um 22:30 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There are two occurrances where objects are being free'd via
> a put call and yet they are being referenced after this. Fix these
> by adding in the missing continue statement so that the put on the
> end of the loop is skipped over.
>=20
> Addresses-Coverity: ("Use after free")
> Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Queued up for drm-misc-next. Thanks!

Best regards
Thomas

> ---
>   drivers/gpu/drm/tiny/simpledrm.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/si=
mpledrm.c
> index 2bdb477d9326..eae748394b00 100644
> --- a/drivers/gpu/drm/tiny/simpledrm.c
> +++ b/drivers/gpu/drm/tiny/simpledrm.c
> @@ -298,6 +298,7 @@ static int simpledrm_device_init_clocks(struct simp=
ledrm_device *sdev)
>   			drm_err(dev, "failed to enable clock %u: %d\n",
>   				i, ret);
>   			clk_put(clock);
> +			continue;
>   		}
>   		sdev->clks[i] =3D clock;
>   	}
> @@ -415,6 +416,7 @@ static int simpledrm_device_init_regulators(struct =
simpledrm_device *sdev)
>   			drm_err(dev, "failed to enable regulator %u: %d\n",
>   				i, ret);
>   			regulator_put(regulator);
> +			continue;
>   		}
>  =20
>   		sdev->regulators[i++] =3D regulator;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--la8J2z3cSCMFxMNgESLXqTvLIpk2BDxpm--

--XaWzkNuflmcnRw9sH5tvQKoTUukS4gsCn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmCdMU8FAwAAAAAACgkQlh/E3EQov+Aw
bw/+P/W5921z5b3YngrfUBXAGxwGZ0ElScedm7rPMu4X7lxySR9LAtZtZj/a+Jy6opYN7PF2QOMu
8lTHe4RRlRlYllWG1agX8pSAiH577d1EURj4XDmFGN8oNJKrpRaBTdV1qJstc3det3qyioHdG401
Ms6cSsZ5pj2TmhOn6LSAGhr1SGKjvNDORGY0bO787YrJTt6gP66uBKv1S6lUH+uLIvptnnzpIzhr
/FCSm57ouQJQdHAo7EtxjCZ8tYXZzyM/xbWtBbsURLc9nBg5cproYS5SlBMYPvOf24pa7gD6CRRa
UpcWfZ3HmEhoE0zrkM0Fo+8fvSNT/d8fyq+9yIRlVn8tACq+yQZqk93nFqzFWEdjl6Q+yue2uo2R
xdfrdr0ZX8z4ycClKaJWyeBN3Pqq96i1vprGuIhUAgBUR0OB+6N195Nr2bPO3HpMm/yKPon3U9IL
FP8XORzMnrxln3pBpHCoxs26WOCt/1pw1i684Im/gkqP+NQ3J3H3x+OTau5NW9FZWXiQu4ogFN/5
5q9/ITkDvbSHcqi5Qb/aDRoiylpzUfIfCHE1kMB1Flt2NH0+69z+K2Ml7cEXQTPmCM5/NDpCY6mV
ntjKyAUu9rFG/EFIR3TX7PhnaKOQWxA0IY6cjc7SMDzD93eS//BZHm5UD1Q+ncP6EBPp6jy3KRM5
f3w=
=/ZoR
-----END PGP SIGNATURE-----

--XaWzkNuflmcnRw9sH5tvQKoTUukS4gsCn--
