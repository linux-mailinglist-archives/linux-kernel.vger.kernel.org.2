Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ACC3DF248
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhHCQPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232739AbhHCQP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:15:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63D6A60F94;
        Tue,  3 Aug 2021 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628007301;
        bh=bMtEE0op4VpnwAaaWde78RzZyPAaxccP4CS1l+2PHjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYtJL2eJJcsgaxku226YHMTshEwEcwA8YKfBEK0wKTHCrx2rOrCpiff00TVcZcDBB
         /yGbAxLAGAjKIA9M5bcJkk7GtgPIgJlByBfyfCzojAqItG1/mmaYjZFNt+j/Kz81gm
         aqYsmBIPNj8Lz4OUpc01Cb/NdY2Ud6vBAE7YxFiftBdwDIM305CV5GloYCbfWo1f7x
         n5ATd0xY1TOL7HtfG8rkRhYMoksURf4AuTWqAdR5wPFzPpqflsnGa2xPMKCn3XLgne
         KLN7wzElfffK2DTnvTW+6xFcukSi6bJdnvcvWcRQIEDlUrOGHTQY7Cq1id7k0z0oS6
         CnWQBI/2yweoQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 1F7583C0C9B; Tue,  3 Aug 2021 18:14:59 +0200 (CEST)
Date:   Tue, 3 Aug 2021 18:14:59 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>
Subject: Re: [PATCH 3/3] power: reset: Enable tristate on restart power-off
 driver
Message-ID: <20210803161459.5752zkc6jhj3mduf@earth.universe>
References: <20210803155452.435812-1-lee.jones@linaro.org>
 <20210803155452.435812-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e2m5yujkkw3dgt3d"
Content-Disposition: inline
In-Reply-To: <20210803155452.435812-4-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e2m5yujkkw3dgt3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 03, 2021 at 04:54:52PM +0100, Lee Jones wrote:
> From: Elliot Berman <eberman@codeaurora.org>
>=20
> Since reboot_mode is an exported symbol, restart power-off driver can be
> compiled as module.
>=20
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/power/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 4d1192062508d..e155b2e2a75c4 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -192,7 +192,7 @@ config POWER_RESET_REGULATOR
>  	  power regulator defined in the devicetree.
> =20
>  config POWER_RESET_RESTART
> -	bool "Restart power-off driver"
> +	tristate "Restart power-off driver"
>  	help
>  	  Some boards don't actually have the ability to power off.
>  	  Instead they restart, and u-boot holds the SoC until the
> --=20
> 2.32.0.554.ge1b32706d8-goog
>=20

--e2m5yujkkw3dgt3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEJa3oACgkQ2O7X88g7
+pq93w/+PlZeAuqctCncZwRgceV2EBkH+i018Pp4f0mfC9R95P60LETyavwm0Ftw
Jrif0Lv51hSPlsY6QXSqPoIQ9hSIHLsi6uh/ipfrXvUo2WnINvsGEcx8Vbu5tht6
NAl/RMC+pbkMYOSWAhqHLbkMLtki9cwEG7XoI02Das87kQFxsiBDKB/yOp9OFpdo
KXyMV7tgeZdmUO7+h70q/8JBYRgrWdtNuN52wd1IR1m5eUrvZ1otFHR1EhNdXL7U
09r4/YNVezVRC9AOID68TB9wUa48+d47oueWXhjWOlgyoNsP5VK8NjV2AoXLHYre
5jR5hLFqNyvR0qpfrE2AEuEbYm+ZYqYun+vUy9VELl5nc+h4NsB28mcmHHKdN5YB
xseIuViBUsisTMeTobIZ99H4/d1i1V4cyVr+wpmwNepg2DJMGj88tAHk1+drzGOH
limgDkxPqCIgrYx2bqXO/+wjgrOn0uKQ3cGsLoV/NRtlhF7Hd7/30g3zI2EQHBIt
MCpujRKejq6RgGaeKQU/ZWTdremGvHsDoJYcXGD5vjT3mn06VbzQ3b6sDgPXMBDa
E0FArIrbIJNincHlkip0mrak9XY3liqjwcxresD1VAgnThYSZ98MBKLvl4GdPdV6
UoZJyUnVBAa1Y6xkGZFnsckVZohsSn+/9JEpFQivM9ArkjYv81U=
=h0Ad
-----END PGP SIGNATURE-----

--e2m5yujkkw3dgt3d--
