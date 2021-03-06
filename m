Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98CF32FCA8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhCFTPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:15:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:48455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231177AbhCFTOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615058087;
        bh=xmOKEwI7ZeP/3hnIXVV4eVvYACS1d36IEoWwwamsar8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HbVy8j0J5xdj2CIIlle8WNtDpams6uVTGCQEGtiN9bMglj/0KriEsEh4zA0VbcBGO
         SJRS5CKDlRooB+dK/azjj3s20Ywj81+ivQxLgdidoid0F7mlVrT/m9dMNVFNuKFuuR
         Wa1sGSaYWlXVWJTJpUBzmZ+uawVf3gzZF5LGVBQw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1liZPz3N2X-0108EM; Sat, 06
 Mar 2021 20:14:46 +0100
Date:   Sat, 6 Mar 2021 20:14:46 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     j.neuschaefer@gmx.net, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <YEPUppNWNiAMnczF@latitude>
References: <20210306181314.12673-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hCtsFvQpjT434NKf"
Content-Disposition: inline
In-Reply-To: <20210306181314.12673-1-andreas@kemnade.info>
X-Provags-ID: V03:K1:XsEnlvIuR7wTpmDHOH9z04Biy4KW4BVturfThauM6aAgvZiN3r6
 +Wyex+kbQYGtcHyMv7C4H5EXW63I/HY4pDdhuj+PY/gO75uEBSFc/7aH5lEu8nFBeRZtpJS
 c6UvjHTu5xH3cwUuwzDzICMsqnQ2sn59cNL71f1CHhBluytx9TjhbOnE+eaGnx4RCQIUE+a
 E4RbrtZgflrBoM1A9Ju+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mtgMcpaqMVk=:yiK8n4Tr9Y5niTvQolX86s
 FYAV85FZTnBHmvD9dLb2TPpW5n/kZRp0fpXANpO3J3ieaZEl8kxaGvGFv1N9H4bT1IH1cysUR
 IjD9YpFpsRtCLnJfP/ZRAikFOMYU/1hUm2ySawckKzbD8D62ADMSa+J74i57M5klr2/NLT3Gp
 C7PHsWbWcsKR3IrYngefweAC3c1Ga5fXYfuawtWWDjdqNAIXMfz2/ZNZON2tR8OvNsca7/aAH
 2lPP0TldF4EgrpkQTJ7yXM9I6YONxZN6hCH6EbFqLjdaG3oTn3urGJEknNEMujr2hppZh85NH
 2vR4sl0gK/sURbl8nQA2ucEkIkRCTXb5M8sJ02AmT3KlIS33Lp13XZzp/PFnd7uE1Dm9OoX18
 88ddhFoofz60VL4tNGn1+KW2wVYky46cAbCtlHcfkNQadECVzepy+NAgusnTRQyJWYJzUKc62
 mLiBkkYQTvrf9zy5DCY0kECcIIXRmTpOPxsImUKUABcTlyFUaKMabMmRrNqhUv07cvdEx44NM
 yJHEnQpxIVcM7OwryhSexTemmBGbtDdh2pSrYAhaj7AHiEBJcVtPBFOdYPxj7D9lQn593hcS6
 23AiSbKw1IjrZUbHKDbaaubgCGoxzsPngmaZeCbxJ4XlUunk70xkvRb91fg+k/zhF44ncHFz+
 q+O58uR+KeQuvx0lSo/ehueKCn9NafNLUcsPLnvVl7QADrVBsLbUgFfweyzXSFFPBcNM9IH13
 WEnh8RlycCljUoVBvoQfkSggaxq85sAzRk47VE9+EmdVCKsB4UUzVyX92B3VLEdijL9Zu3T2K
 0GHw0c12Sz+WxqwfU6F4mxDP9lxLQruUd+NF208Q3dguvqgf/Trz7V1mXXIaFJKqYClXhwL4z
 jmWD0dDqHkdCFjAaaUVg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hCtsFvQpjT434NKf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(Cc'ing Mark Brown because of the regmap related questions)

On Sat, Mar 06, 2021 at 07:13:14PM +0100, Andreas Kemnade wrote:
> Add the version of the EC in the Tolino Shine 2 HD
> to the supported versions. It seems not to have an RTC
> and does not ack data written to it.
> The vendor kernel happily ignores write errors, using
> I2C via userspace i2c-set also shows the error.
> So add a quirk to ignore that error.
>=20
> PWM can be successfully configured despite of that error.

I'm curious, is this one of the variants with two PWM channels
(for configurable color temperature)?

>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/ntxec.c       | 57 ++++++++++++++++++++++++++++++++++++---
>  include/linux/mfd/ntxec.h |  1 +
>  2 files changed, 55 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
> index 957de2b03529..e7fe570127af 100644
> --- a/drivers/mfd/ntxec.c
> +++ b/drivers/mfd/ntxec.c
> @@ -96,6 +96,36 @@ static struct notifier_block ntxec_restart_handler =3D=
 {
>  	.priority =3D 128,
>  };
> =20
> +static int regmap_ignore_write(void *context,
> +			       unsigned int reg, unsigned int val)
> +
> +{
> +	struct regmap *regmap =3D context;
> +
> +	regmap_write(regmap, reg, val);
> +
> +	return 0;
> +}
> +
> +static int regmap_wrap_read(void *context, unsigned int reg,
> +			    unsigned int *val)
> +{
> +	struct regmap *regmap =3D context;
> +
> +	return regmap_read(regmap, reg, val);
> +}
> +
> +/* some firmware versions do not ack written data, add a wrapper */
> +static const struct regmap_config regmap_config_noack =3D {
> +	.name =3D "ntxec_noack",
> +	.reg_bits =3D 8,
> +	.val_bits =3D 16,
> +	.cache_type =3D REGCACHE_NONE,
> +	.val_format_endian =3D REGMAP_ENDIAN_BIG,
> +	.reg_write =3D regmap_ignore_write,
> +	.reg_read =3D regmap_wrap_read

Is the read wrapper necessary? It seems to me from reading regmap.h
that leaving .reg_read set to NULL should do the right thing, but I'm
not sure.

> +};
> +
>  static const struct regmap_config regmap_config =3D {
>  	.name =3D "ntxec",
>  	.reg_bits =3D 8,
> @@ -109,10 +139,15 @@ static const struct mfd_cell ntxec_subdevices[] =3D=
 {
>  	{ .name =3D "ntxec-pwm" },
>  };
> =20
> +static const struct mfd_cell ntxec_subdev_pwm[] =3D {
> +	{ .name =3D "ntxec-pwm" },
> +};

ntxec_subdevices vs. ntxec_subdev_pwm seems slightly inconsistent in
naming. ntxec_subdevices_pwm would be a wrong plural, but IMHO slightly
better because of consistency. Maybe rename ntxec_subdevices to
ntxec_subdev?

> +
>  static int ntxec_probe(struct i2c_client *client)
>  {
>  	struct ntxec *ec;
>  	unsigned int version;
> +	bool has_rtc;
>  	int res;
> =20
>  	ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> @@ -137,6 +172,15 @@ static int ntxec_probe(struct i2c_client *client)
>  	/* Bail out if we encounter an unknown firmware version */
>  	switch (version) {
>  	case NTXEC_VERSION_KOBO_AURA:
> +		has_rtc =3D true;
> +		break;
> +	case NTXEC_VERSION_TOLINO_SHINE2:
> +		has_rtc =3D false;
> +		ec->regmap =3D devm_regmap_init(ec->dev, NULL,
> +					      ec->regmap,
> +					      &regmap_config_noack);

Ah=E2=80=94 A custom regmap stacked on top of the old regmap=E2=80=A6 I thi=
nk this
deserves a comment.

> +		if (IS_ERR(ec->regmap))
> +			return PTR_ERR(ec->regmap);
>  		break;
>  	default:
>  		dev_err(ec->dev,
> @@ -155,7 +199,6 @@ static int ntxec_probe(struct i2c_client *client)
>  		 */
>  		res =3D regmap_write(ec->regmap, NTXEC_REG_POWERKEEP,
>  				   NTXEC_POWERKEEP_VALUE);
> -		if (res < 0)
>  			return res;

This deletion looks like a mistake.

> =20
>  		if (poweroff_restart_client)
> @@ -181,8 +224,16 @@ static int ntxec_probe(struct i2c_client *client)
> =20
>  	i2c_set_clientdata(client, ec);
> =20
> -	res =3D devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE, ntxec_subdev=
ices,
> -				   ARRAY_SIZE(ntxec_subdevices), NULL, 0, NULL);
> +	if (has_rtc)
> +		res =3D devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
> +					   ntxec_subdevices,
> +					   ARRAY_SIZE(ntxec_subdevices),
> +					   NULL, 0, NULL);
> +	else
> +		res =3D devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
> +					   ntxec_subdev_pwm,
> +					   ARRAY_SIZE(ntxec_subdev_pwm),
> +					   NULL, 0, NULL);

At some point, it will probably be simpler to have

	struct mfd_cell *subdev =3D ntxec_subdevices;
	size_t subdev_size =3D ARRAY_SIZE(ntxec_subdevices);

on top of the probe function and override them in the switch statement,
but at this point I think it doesn't matter, and either way is fine.

>  	if (res)
>  		dev_err(ec->dev, "Failed to add subdevices: %d\n", res);
> =20
> diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
> index 361204d125f1..26ab3b8eb612 100644
> --- a/include/linux/mfd/ntxec.h
> +++ b/include/linux/mfd/ntxec.h
> @@ -33,5 +33,6 @@ static inline __be16 ntxec_reg8(u8 value)
> =20
>  /* Known firmware versions */
>  #define NTXEC_VERSION_KOBO_AURA	0xd726	/* found in Kobo Aura */
> +#define NTXEC_VERSION_TOLINO_SHINE2 0xf110 /* found in Tolino Shine 2 HD=
 */
> =20
>  #endif
> --=20
> 2.29.2
>=20


Thanks for your patch,
Jonathan

--hCtsFvQpjT434NKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmBD1JkACgkQCDBEmo7z
X9spmhAAyUafhUf8Qp2yJSoFl5wr/LVs4uklDu6AXnVkdLW9N6UtfhyXG2P7sENr
CciUSPfSOw0JKCfoctTW5/y7A4AWYzGeRy6GUYsl2Cj0qmRouD0Pj5RTzfJeatf4
9KMgoX7e09rpAfPIGKJengnqr1ju8z6qJlDA3DyxrRVYRJIsXCau78KnObsDyfDX
VLpX+icsQ4VlILA4GB2iVVz/Rl1j1HqBT//nUTQa3TuLFhA4cg7sPCoYGR9RzfkE
si0eC9NSIUfq0WXZSbP8YmBMlVL6WTP/6c3JsOCP1+0kDqF+SX1pqw35I4Nfe8Z/
Q8XSMilHc6+hHDYflOKVjkpRUzivVkUlCS/X/zk0UXb4ddCRacqVUdtrwAHKjjbX
UrJbMBZWUG6AnYesOgnGpq14WeZ4dUcZq6SsT+P7BhcHIrmyknzqAxxCQap8PRkW
JW0elXFi+aZyRWiDo4aHymtfXhFyJHMEzHwipl+f7Un68swWpqMtqsOL26anuZ9A
52B+HNRGW6sWHwUcMP+nS2zEvPxXPlD5+WJAXdOO3pyIfO/MDIpp34jhesLJAx4d
mTpLgK+332PCWzCNamgA/LthezaW2m3+d4BlHD0IbCNcLG8J41b6eRgl2dZG1fJi
/VGIupyUZqaZm3iy2ItbtnMEIbZ627m1StIOnUH2hKB2p00IP5I=
=bTIl
-----END PGP SIGNATURE-----

--hCtsFvQpjT434NKf--
