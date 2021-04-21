Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FAB366F71
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbhDUPvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:51:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34960 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbhDUPvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:51:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9BBFC1F42362
Received: by earth.universe (Postfix, from userid 1000)
        id 1A6D53C0C96; Wed, 21 Apr 2021 17:51:01 +0200 (CEST)
Date:   Wed, 21 Apr 2021 17:51:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@kernel.org,
        Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 051/190] Revert "power: supply: core: fix memory leak in
 HWMON error path"
Message-ID: <20210421155101.n2mbmhj6x42i3a4l@earth.universe>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-52-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gqpebck3mxmnoa5l"
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-52-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gqpebck3mxmnoa5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 21, 2021 at 02:58:46PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 1d7a7128a2e9e1f137c99b0a44e94d70a77343e3.
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
> Cc: stable@kernel.org
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Change is quite simple, so doing another review now:

It is correct that power_supply_hwmon_bitmap_free() must be called
when devm_add_action() fails. This is not already done in the error
path, so the original patch is correct and the revert reintroduces a
memory leak in error path.

I suggest dropping the revert.

Thanks,

-- Sebastian

>  drivers/power/supply/power_supply_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index bffe6d84c429..62ca29e0d47a 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -356,7 +356,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply =
*psy)
>  		goto error;
>  	}
> =20
> -	ret =3D devm_add_action_or_reset(dev, power_supply_hwmon_bitmap_free,
> +	ret =3D devm_add_action(dev, power_supply_hwmon_bitmap_free,
>  			      psyhw->props);
>  	if (ret)
>  		goto error;
> --=20
> 2.31.1
>=20

--gqpebck3mxmnoa5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCASd4ACgkQ2O7X88g7
+poN+Q//dEiIYl4MXs5BKdHvnm3UkgY+WTHhV6lItI21prSNE45lvhQECS+aKjlU
dp1TO/M6AZtl0P91Rxl3K4KMTJ9287aZdgpkZJZBaOq/DNC0iFKrNEFuKyu8Si52
E7WoKGgDK3zk1Z0ENPXxgPyqYdXMPNfgnxpfCnYWnyobI4L8BCUrtJNklnX0JAyq
4hA9JcpsCpFldZ7EktIzPEH95gpNc5e3frxQFSrvmZkkqHpbAB0aN0WXyls/wnwu
7V9gJRgG4EtT31VCkPTPgc3z41FQV4V8lOojIOqxJR2NRxedhNRHbCoaq/86KTa1
a1FYJUh4SPb7IrzyUJwXwpaElY9wmnQ+0KZpPxoNIGC/QRbda0/VE9wy0214L/K6
srJs3YBYthgOtqovvjuB43PuA99jsmL4axjM7Kuf5EjkLkXrdJeX37E4YK9q3pyT
USl7zRf5BHIkjnIuE3rx83YIczrezJih0XAeC4PX4zgy5tmOoYpb9S5SFA8wboff
T3YnETrpiCt45fEJvIW7PNBECpAxtmUrBsBfgH0+GBS59S4z1BPx5oLccDwFHlrr
ZqBC7ESSnafhQTCNDGSfvGYlRY7JvK4T2hLcbsS2Nink7e5WtL0nTQlXmW/+aAzx
G02JtwWOZiwqaoWUnP/MR+KP9vbf2oX4OiY+Use24F3fXMSCOrk=
=9a4A
-----END PGP SIGNATURE-----

--gqpebck3mxmnoa5l--
