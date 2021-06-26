Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F473B5076
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 01:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFZX0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 19:26:42 -0400
Received: from mout02.posteo.de ([185.67.36.66]:48333 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbhFZX0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 19:26:41 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E4AA12400E5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 01:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1624749855; bh=R9ujgHqs1BjJczriy1SBTuBrhRB6tHWhzFhcHRZqkgM=;
        h=Date:From:To:Cc:Subject:From;
        b=STXoIKXQfof9AZAXQHJ6B3Y+h1T7Bs+ajOS5oETT3N+TG+DOLo0Ux7+Bgir9EaidA
         DDbCl7vDR+ee5ibLAHhOAkfSSB7uS1vvEWLxmIDEpbG7ujkgnj8diciQpeQG8jJHYj
         jERwxWvt/MPuqO0svzlK7KPfFretmpAIR9n6cfGfAehYQyaB1103DGkN9XRzbCd8Et
         Lq8C/HWTNSnT5MNM6hH40RHs38sB4mzZXOBBboKt5Zsi8Q4Ut+MVdiIVaOT7yXbGKb
         agLozYAzq07v2zWr/P4vhbkyn9iHz4FCJrlpgpbz3fWcCGOPB4+uEHBnZVlLprtzXe
         63w5znOL/4JXA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4GC91T3CVXz6tm6;
        Sun, 27 Jun 2021 01:24:13 +0200 (CEST)
Date:   Sat, 26 Jun 2021 23:24:07 +0000
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Ash Logan <ash@heyquark.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] nvmem: nintendo-otp: Add new driver for the Wii
 and Wii U OTP
Message-ID: <YNe3F7DPOOKuaFIm@latitude>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210519095044.4109-2-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8Davdyx64OL/jq/h"
Content-Disposition: inline
In-Reply-To: <20210519095044.4109-2-linkmauve@linkmauve.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8Davdyx64OL/jq/h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,


On Wed, May 19, 2021 at 11:50:41AM +0200, Emmanuel Gil Peyrot wrote:
> This OTP is read-only and contains various keys used by the console to
> decrypt, encrypt or verify various pieces of storage.
>=20
> Its size depends on the console, it is 128=C2=A0bytes on the Wii and
> 1024=C2=A0bytes on the Wii=C2=A0U (split into eight 128=C2=A0bytes banks).
>=20
> It can be used directly by writing into one register and reading from
> the other one, without any additional synchronisation.
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---

A link to the (third-party) documentation would be nice, either in the
commit message or in the code itself.

(https://wiiubrew.org/wiki/Hardware/OTP i guess)

[...]
> +static int nintendo_otp_reg_read(void *context,
> +				 unsigned int reg, void *_val, size_t bytes)
> +{
> +	struct nintendo_otp_priv *priv =3D context;
> +	u32 *val =3D _val;
> +	int words =3D bytes >> 2;
> +	u32 bank, addr;
> +
> +	while (words--) {
> +		bank =3D (reg << 1) & ~0xff;

This is a bit non-obvious, IMHO. As far as I understand it, the expanded
formula is:

	bank =3D (reg / 128) << 8;

I.e. first divide by bank size, then shift the parameter into the right
place.

> +		addr =3D (reg >> 2) & 0x1f;

Here, I think it's about the word size (4 bytes); I think / 4 would be
clearer.

I *think* (but haven't checked) that gcc should generate efficent shifts
for the divisions above, so using the division operator shouldn't be
problem.

> +		iowrite32be(OTP_READ | bank | addr, priv->regs + HW_OTPCMD);
> +		*val++ =3D ioread32be(priv->regs + HW_OTPDATA);
> +		reg +=3D 4;
> +	}
> +
> +	return 0;
> +}
> +
[...]
> +	if (of_id->data) {
> +		const struct nintendo_otp_devtype_data *data =3D of_id->data;
> +		config.name =3D data->name;
> +		config.size =3D data->num_banks * 128;

Given that 128 appears a few times, perhaps a #define would be good.

> +	}
> +
> +	config.dev =3D dev;
> +	config.priv =3D priv;
> +
> +	nvmem =3D devm_nvmem_register(dev, &config);
> +
> +	return PTR_ERR_OR_ZERO(nvmem);
> +}
> +
> +static struct platform_driver nintendo_otp_driver =3D {
> +	.probe =3D nintendo_otp_probe,
> +	.driver =3D {
> +		.name =3D "nintendo-otp",
> +		.of_match_table =3D nintendo_otp_of_table,
> +	},
> +};
> +module_platform_driver(nintendo_otp_driver);
> +MODULE_AUTHOR("Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>");
> +MODULE_DESCRIPTION("Nintendo Wii and Wii U OTP driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.31.1
>=20

Tested-by: Jonathan Neusch=C3=A4fer <j.ne@posteo.net>  # on Wii



Thanks,
Jonathan Neusch=C3=A4fer

--8Davdyx64OL/jq/h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmDXttcACgkQCDBEmo7z
X9sKyg//ZTxyWmJLiKXuS5IMWgXtRrk1KE9KhjcJMkkaB8vJdKI7PD0RLx2MemWH
wJyZhd2tc0K3GYDvTG//Jc5tAZ/GkwYAsqil4TdH3qdEZwhNAXiWJkn1FoRtj+BN
7UUhthGVIKY8F3EEeHa5OPpZOo+DiI9/KalB3Nqtar4e/b3UDWnLCu90RF60sbnR
3cw0z5QsBgN5p5IixJffHeHLLgyIYCL/CDMGIJm/sHg1xvD4ywvZHiXKWr5k2RbS
v4bItXWuPXRtEGxDSeq05qvgokqH2AUoXumUPTwvrG5/6t9dxe4H2DkDiWlsSYxp
Tq51R4f2Jrm4wdgBWMHPt8iqPpJALOIIgc1k4CrUdFd8ZetdqFPxc0KTcxgqmm6F
ZgTZsXVb6dyedG1Zc77E4GbuG9zdJLVUIBtXtN9/P1nn1YFDbtPqaoipqfbn5RGS
lmAFVXMXt+4W/7DHWeInMN110HtmsL0GEBpQkdtQjjIrGPeAvGElL7tm5Rq5lAUz
ldTMqaQN3BmaaddNiGO4bJ2f0jgxPVN436vBUo9YYE/kPNv5I+uS4baqtmSSY/+L
QBmRhB4mVIh0tsmpL4DzezQtUBhHHpCz11ONZJwpmJYy5rV7lcNl4JvkISVn0WLv
ukumLTyu76erTnMdbmZpVu3TGDYfS0MyOY0qG0VjHKXR+d01zyI=
=X6iX
-----END PGP SIGNATURE-----

--8Davdyx64OL/jq/h--
