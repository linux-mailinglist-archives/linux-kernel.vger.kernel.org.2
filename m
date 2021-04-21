Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C4366FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbhDUQOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbhDUQOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:14:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7295C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:14:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BE1191F42123
Received: by earth.universe (Postfix, from userid 1000)
        id A2CCB3C0C96; Wed, 21 Apr 2021 18:14:07 +0200 (CEST)
Date:   Wed, 21 Apr 2021 18:14:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 143/190] Revert "power: twl4030: fix a missing check of
 return value"
Message-ID: <20210421161407.jhcy5gp24z3cko4e@earth.universe>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-144-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iivphz7ibvztyqoa"
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-144-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iivphz7ibvztyqoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 21, 2021 at 03:00:18PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 6f12e46eebf1a7d4fdd66df5e815df96b8f8b1b5.
>=20
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>=20
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>=20
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Doing another review:

twl4030 is an I2C connected PMIC, so any read operation can
result in -EIO. If this happens 's' will not be initialized,
so without handling the error is_charging will be set to an
arbitrary state in the following lines. Exiting early from
twl4030_bci_get_property is ok and other HW read operation
failures in the same function are exiting early with proper
error code (as the patch introduced for the only read missing
this).

TL;DR: original patch is ok, I suggest to drop the revert.

-- Sebastian

>  drivers/power/supply/twl4030_charger.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 1bc49b2e12e8..dcbd9f03f31a 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -805,9 +805,7 @@ static int twl4030_bci_get_property(struct power_supp=
ly *psy,
>  		is_charging =3D state & TWL4030_MSTATEC_AC;
>  	if (!is_charging) {
>  		u8 s;
> -		ret =3D twl4030_bci_read(TWL4030_BCIMDEN, &s);
> -		if (ret < 0)
> -			return ret;
> +		twl4030_bci_read(TWL4030_BCIMDEN, &s);
>  		if (psy->desc->type =3D=3D POWER_SUPPLY_TYPE_USB)
>  			is_charging =3D s & 1;
>  		else
> --=20
> 2.31.1
>=20

--iivphz7ibvztyqoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCAT0sACgkQ2O7X88g7
+poeng/+M6yBbDUluiVNPJ+L6a6vmYG/Kg41MrFM4D70m6DHgcNQzTgZS/Tba9xj
fRnmlluOftB3VapYAu74JlDyPiWoPbmD/VHlFomKIf84CpUhc5q0bM5k05bNiuSa
828g9iWWO0HG0vy0k34sjyxU0H/Wkv7cibrDahZN1AFmrsOiRtHVOf22gKHgE5SB
UXVeisbVSb2vy0QOUd5WbJMAvBawFmioMCNlcgtglSVoX/yppQRr2TR0p0i9RsOA
jLujdokqXw3gzmTVk7HwB1rJA0khJiJJSyHsqU1yMq+RhqlL65Rd7NZygfffF5UY
JGGd2H7grTFCs6m1H1UJmuILbAIQ/s+iUYBjk59zPjNn4etCrf9UAHYuSv5maktD
64mgKc8k7RmwM5D0s/MiSDmsA5n6iCEwPsn8YkbuuogOFxAQSxyG2XYtejDyJFcr
thNgy6XVZHBiRALVaW41Acbgc2LUHljWMDmw9RufVQ8MCBtr/xXzY8k98ICEcH1o
DfHP1IrOAebGtM3PSSPhONWJzpGu+xnE8ZeTx5CnzH/fUqQsuApzRE5ZDDmXgFez
6Im0t7dPaa+JSkBqxRu80QIlxGVK6zHQhvPSty3tFxIVrsa8C6Os4X+7L9htojMU
KrjrZRqS9XVT0ty6+N0Xv5K86XhxarT3rdgximCeVx5/qyyft9k=
=g1Pe
-----END PGP SIGNATURE-----

--iivphz7ibvztyqoa--
