Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084113574D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355577AbhDGTOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDGTOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:14:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFDBC06175F;
        Wed,  7 Apr 2021 12:14:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B97081F45811
Received: by earth.universe (Postfix, from userid 1000)
        id 1025B3C0C96; Wed,  7 Apr 2021 21:14:09 +0200 (CEST)
Date:   Wed, 7 Apr 2021 21:14:08 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/19] dt-bindings: power: supply: da9150: update
 da9150-charger.txt reference
Message-ID: <20210407191408.nugrjqrmz5vby44k@earth.universe>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
 <77aa40c58600dfc1f047ce2d86ad1d1cd67d67e4.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eqhquad7psvwpyfu"
Content-Disposition: inline
In-Reply-To: <77aa40c58600dfc1f047ce2d86ad1d1cd67d67e4.1617783062.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eqhquad7psvwpyfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 07, 2021 at 10:20:51AM +0200, Mauro Carvalho Chehab wrote:
> Changeset f3332532463f ("power/supply: unify DT documentation")
> renamed: Documentation/devicetree/bindings/power/da9150-charger.txt
> to: Documentation/devicetree/bindings/power/supply/da9150-charger.txt.
>=20
> Update its cross-reference accordingly.
>=20
> Fixes: f3332532463f ("power/supply: unify DT documentation")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/da9150.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Documenta=
tion/devicetree/bindings/mfd/da9150.txt
> index b7afa39d6260..f4db2b520327 100644
> --- a/Documentation/devicetree/bindings/mfd/da9150.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9150.txt
> @@ -20,7 +20,7 @@ Required properties:
> =20
>  Sub-devices:
>  - da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/dlg,da9150=
-gpadc.yaml
> -- da9150-charger: See Documentation/devicetree/bindings/power/da9150-cha=
rger.txt
> +- da9150-charger: See Documentation/devicetree/bindings/power/supply/da9=
150-charger.txt
>  - da9150-fg: See Documentation/devicetree/bindings/power/da9150-fg.txt

This got "renamed" again in -next. Also I do not see the point to
update the next line in its own patch.

git show --stat 59604ba75633
commit 59604ba756334377deca54bc0526da739bfc0c51
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
Date:   Wed Mar 17 14:48:55 2021 +0100

    dt-bindings: power: supply: da9150: Convert to DT schema format
   =20
    Convert the binding to DT schema format.
   =20
    Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
    Reviewed-by: Rob Herring <robh@kernel.org>

 Documentation/devicetree/bindings/power/supply/da9150-charger.txt         =
| 26 --------------------------
 Documentation/devicetree/bindings/power/supply/da9150-fg.txt              =
| 23 -----------------------
 Documentation/devicetree/bindings/power/supply/dlg,da9150-charger.yaml    =
| 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/dlg,da9150-fuel-gauge.yaml =
| 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 49 deletions(-)

Thanks,

-- Sebastian

--eqhquad7psvwpyfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBuBHgACgkQ2O7X88g7
+prPfQ/8CnvlgjbLH5VDSNzgIbCevKqe31jK7FvR4kW5YjijJHfPAHGqB0n1yNOG
kp+p7K4DSipqTAyAraixrRZE/7oNgUXLDug5bbWmqlNZ5Y/elf6wzf2wq4LEyzZX
X5gR6StvSTKXW/pvkAfcjY8Z1UMs94XkmX9gby/lQhC09KDda38RZlfeFvxNVH4M
OjRCkiQtpmN9H73j03obNZ3oI+Maf/Wu9fpI88Z9KFbT+55t9gPP3loQt9p1fdFg
R3HmydW8/EWiD44YOXJBpxt5t6Em70n1ukjT/LlWikaqN780alhjBQwxdM9G2ju8
NURmF9DE3Wo+2unmuCxlIH/WYtRpsxuHyTKjZxzjvs2Xx/V1ky7fw4Z4yCxEYN/V
ttoc/UcbG6o3gQAB25O3YP1tJR1Dm2tV2s/r7JpG5yppUlOOO6XWL8HKFigvtk0O
dgX1CAOS4yfEN12SHoM0N0Kw91mSHXXilsXe1GLb/tf/szsKY8xK+eBjwjaLfd+p
kc9wB/p3VTqLtWICwRbNokNTQmLuueK0Qx9SysC6CyvqZIl/tVI2b4FMC9j1Pol8
K6tcyM6w4imuuqSaAfgFuFy/aPzgKZCjbkY1cRV1HoSBtlyS7lQtwQM3pJ3q+6wE
zBfuJ6luf+iEc9ISY1omJiDkne8HrUAb/G14tL9GnFnb/erk9yg=
=z4D9
-----END PGP SIGNATURE-----

--eqhquad7psvwpyfu--
