Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3384436AF52
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhDZH51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:57:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:38135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232447AbhDZHrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619423183;
        bh=DIZJcHQwQM+JDa0eh886iyXlJ6kDOdkNopfq5uBSyVE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WBxsyuW3PrrUDhjuYPC6gp+pom972QOJdX6wH2hPCQZlDd+YWee371lKWe+Quezfh
         q17BxFfAxmcG4vOsYrffFWg4YFwDnmCGlz68Sz9QRzsbM11OJcLZJiOvvGIv8SCooS
         TjHuU8iTSpsP8VLGvlLMPrpQOO7TeUlFjsoO3VE8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel3t-1l12hH452L-00alSt; Mon, 26
 Apr 2021 09:46:23 +0200
Date:   Mon, 26 Apr 2021 09:46:21 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>,
        linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] misc: eeprom_93xx46: Remove hardcoded bit lengths
Message-ID: <YIZvzVDGaVS2M/ow@latitude>
References: <20210424212543.13929-1-linkmauve@linkmauve.fr>
 <20210424212543.13929-2-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oKEwqg3MVUhuPv5O"
Content-Disposition: inline
In-Reply-To: <20210424212543.13929-2-linkmauve@linkmauve.fr>
X-Provags-ID: V03:K1:AvbWc1SXkrT7D5OLvsRTDp1If/WyllYvOf65OvajP3Um866FPi9
 +1o/xabSiYENijK+SyAZhdZhceq9XnZeRJrVF7UQ4hy9ySMMH9WwQWD00wYY2jHCKpkGVlG
 8aCM5xbg75NlnUlvte9ieksY5T9kLWPqiccDES8mOCxUFq0wLHwEYiYPPYzi35Df5aZQEZH
 Wq9LSg7afko7IlFcD6Onw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WGELtDXMzA0=:TPtl4yNMeOc7hHD6EvPIK1
 egA8eSkitQaZ86sviwxMMati7+LahgTvZeSZPG8756RiR1PFA/pGo9Qwd/zE7+TBZtfxkLzWT
 GOOwhF2hGrkW+3jQWxavBrd1qdpzcwAWgY5t9l79N6LWkwt7Kk7+Nfjpt3aA1t2ijeIARC8ow
 cRS+kMS1YfUYSitkgGAzSHsp63D+Oz2PIa9zekLeYbB7SFwr/sDoagMu2Q934oHXvcWNGxWc8
 ej1i+3v7fSO+eyvlfj0rsnML/bZoTtn3nzpEAC/BqJB2XsYz1iOCrz2dubot7XrkWJnHVmL4T
 wXgeNy58ij/N7EndNkTWNCIdIlNywr2JLbiijZJxAMTth5xWkEOitnp7Co0fsLAB00+SXrEZh
 qaOWc2AdbiR3XD0jSdQyD1gTIwDXEWbxOwAgd4RRPBHhTmnSMvJrPi2mmLdOOKERt+DH8spUs
 hRqYXF6p3BeZcvq6k8mqBmr8RrWpcVaVetwBI7dWE2B2LUdCbL9IEFtlgXJR/MHJ6/8EqBQx2
 wztAdZy8j2F8fuJ1GqREp2PaSDMCo5fcD2z9HT7nr6hwNIpGerMZUyJRz6JtvyNSTAHUqLn3l
 v9xSeQfuD2QeP3sFFZ3XRBlnCguRwUbZlHQdiL4ORS87HrFr4aDc+gyuHlCTI0e0Zfs/7ghdQ
 jFaCWLS6GPM/1VAfu7mJPhYdXJRDxE889UtoLLHcgG+UN9Ug8nZopfzfXNIDdTJip+YhSKUVm
 PYaBzd/P3i6Upp9UBsJVWersREdh21Oc7NDP4UBSgujhUUTtitAyr8UpGGbrB6f0L7bXr+RXN
 dFNQHkQNRi/STXWfKNJLYZciBKeXSdyji5wJ9tsDMFWpNMn5xsGPj8r83/oVHaEuYpStO3UTs
 TE3Y2+DtZuDPjMhGfXwl+CKx0+s1yAWEFFjeJf12dDoLjN0+NRZkcuesldxQhsd8Z+BSycC9M
 h1z3f85mYOyn5wm45iLEwUzzBOs+PIqWCT2WWQ3B1fxXnm9Csp2H/NR6yyRl+XK7UpubAydGZ
 g4InZR+w5x7BKjn+8bu27Farw46/aGPM9S7eHN8B6WRGnngA9+8xJViVryJ8iC7wyrUJmOmiV
 zYjb+cPlynzTI978JvJOweuYMnVnCd2nWP38z3JEuWtek2Cx3DanVmIPnm3n/bPxxy3LItzhQ
 cly/uodyMFkLFdxPAAbjL3HGbIoqqWaKMBuD8Q9L3d1w0++C3IspzEbE6hSJGyfvudEfnc5OB
 VHWIb+cPwEjZsPpoR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oKEwqg3MVUhuPv5O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 24, 2021 at 11:25:41PM +0200, Emmanuel Gil Peyrot wrote:
> This avoids using magic numbers based on the length of an address or a
> command, while we only want to differentiate between 8-bit and 16-bit.
>=20
> The driver was previously wrapping around the offset in the write
> operation, this now returns -EINVAL instead (but should never happen in
> the first place).
>=20
> If two pointer indirections are too many, we could move the flags to the
> main struct instead, but I doubt it=E2=80=99s going to make any sensible
> difference on any hardware.
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---

I'm not an EEPROM driver expert, but FWIW:

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


>  drivers/misc/eeprom/eeprom_93xx46.c | 57 ++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/ee=
prom_93xx46.c
> index 80114f4c80ad..ffdb8e5a26e0 100644
> --- a/drivers/misc/eeprom/eeprom_93xx46.c
> +++ b/drivers/misc/eeprom/eeprom_93xx46.c
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
> +#include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> @@ -70,6 +71,7 @@ static int eeprom_93xx46_read(void *priv, unsigned int =
off,
>  	struct eeprom_93xx46_dev *edev =3D priv;
>  	char *buf =3D val;
>  	int err =3D 0;
> +	int bits;
> =20
>  	if (unlikely(off >=3D edev->size))
>  		return 0;
> @@ -83,21 +85,21 @@ static int eeprom_93xx46_read(void *priv, unsigned in=
t off,
>  	if (edev->pdata->prepare)
>  		edev->pdata->prepare(edev);
> =20
> +	/* The opcode in front of the address is three bits. */
> +	bits =3D edev->addrlen + 3;
> +
>  	while (count) {
>  		struct spi_message m;
>  		struct spi_transfer t[2] =3D { { 0 } };
>  		u16 cmd_addr =3D OP_READ << edev->addrlen;
>  		size_t nbytes =3D count;
> -		int bits;
> =20
> -		if (edev->addrlen =3D=3D 7) {
> -			cmd_addr |=3D off & 0x7f;
> -			bits =3D 10;
> +		if (edev->pdata->flags & EE_ADDR8) {
> +			cmd_addr |=3D off;
>  			if (has_quirk_single_word_read(edev))
>  				nbytes =3D 1;
>  		} else {
> -			cmd_addr |=3D (off >> 1) & 0x3f;
> -			bits =3D 9;
> +			cmd_addr |=3D (off >> 1);
>  			if (has_quirk_single_word_read(edev))
>  				nbytes =3D 2;
>  		}
> @@ -152,14 +154,14 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_de=
v *edev, int is_on)
>  	int bits, ret;
>  	u16 cmd_addr;
> =20
> +	/* The opcode in front of the address is three bits. */
> +	bits =3D edev->addrlen + 3;
> +
>  	cmd_addr =3D OP_START << edev->addrlen;
> -	if (edev->addrlen =3D=3D 7) {
> +	if (edev->pdata->flags & EE_ADDR8)
>  		cmd_addr |=3D (is_on ? ADDR_EWEN : ADDR_EWDS) << 1;
> -		bits =3D 10;
> -	} else {
> +	else
>  		cmd_addr |=3D (is_on ? ADDR_EWEN : ADDR_EWDS);
> -		bits =3D 9;
> -	}
> =20
>  	if (has_quirk_instruction_length(edev)) {
>  		cmd_addr <<=3D 2;
> @@ -205,15 +207,19 @@ eeprom_93xx46_write_word(struct eeprom_93xx46_dev *=
edev,
>  	int bits, data_len, ret;
>  	u16 cmd_addr;
> =20
> +	if (unlikely(off >=3D edev->size))
> +		return -EINVAL;
> +
> +	/* The opcode in front of the address is three bits. */
> +	bits =3D edev->addrlen + 3;
> +
>  	cmd_addr =3D OP_WRITE << edev->addrlen;
> =20
> -	if (edev->addrlen =3D=3D 7) {
> -		cmd_addr |=3D off & 0x7f;
> -		bits =3D 10;
> +	if (edev->pdata->flags & EE_ADDR8) {
> +		cmd_addr |=3D off;
>  		data_len =3D 1;
>  	} else {
> -		cmd_addr |=3D (off >> 1) & 0x3f;
> -		bits =3D 9;
> +		cmd_addr |=3D (off >> 1);
>  		data_len =3D 2;
>  	}
> =20
> @@ -253,7 +259,7 @@ static int eeprom_93xx46_write(void *priv, unsigned i=
nt off,
>  		return count;
> =20
>  	/* only write even number of bytes on 16-bit devices */
> -	if (edev->addrlen =3D=3D 6) {
> +	if (edev->pdata->flags & EE_ADDR16) {
>  		step =3D 2;
>  		count &=3D ~1;
>  	}
> @@ -295,14 +301,14 @@ static int eeprom_93xx46_eral(struct eeprom_93xx46_=
dev *edev)
>  	int bits, ret;
>  	u16 cmd_addr;
> =20
> +	/* The opcode in front of the address is three bits. */
> +	bits =3D edev->addrlen + 3;
> +
>  	cmd_addr =3D OP_START << edev->addrlen;
> -	if (edev->addrlen =3D=3D 7) {
> +	if (edev->pdata->flags & EE_ADDR8)
>  		cmd_addr |=3D ADDR_ERAL << 1;
> -		bits =3D 10;
> -	} else {
> +	else
>  		cmd_addr |=3D ADDR_ERAL;
> -		bits =3D 9;
> -	}
> =20
>  	if (has_quirk_instruction_length(edev)) {
>  		cmd_addr <<=3D 2;
> @@ -455,10 +461,12 @@ static int eeprom_93xx46_probe(struct spi_device *s=
pi)
>  	if (!edev)
>  		return -ENOMEM;
> =20
> +	edev->size =3D 128;
> +
>  	if (pd->flags & EE_ADDR8)
> -		edev->addrlen =3D 7;
> +		edev->addrlen =3D ilog2(edev->size);
>  	else if (pd->flags & EE_ADDR16)
> -		edev->addrlen =3D 6;
> +		edev->addrlen =3D ilog2(edev->size) - 1;
>  	else {
>  		dev_err(&spi->dev, "unspecified address type\n");
>  		return -EINVAL;
> @@ -469,7 +477,6 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
>  	edev->spi =3D spi;
>  	edev->pdata =3D pd;
> =20
> -	edev->size =3D 128;
>  	edev->nvmem_config.type =3D NVMEM_TYPE_EEPROM;
>  	edev->nvmem_config.name =3D dev_name(&spi->dev);
>  	edev->nvmem_config.dev =3D &spi->dev;
> --=20
> 2.31.1
>=20

--oKEwqg3MVUhuPv5O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmCGb8UACgkQCDBEmo7z
X9tjZBAAyxa25kPUJbax5Dzsz5lhOgS4PpOVUY2tf+YlwG+OauEnXzpVx+WECCvi
AiQlzf8QqVx4xna55KXwzyBEsjjeiMAjAyJV+IKWqhMnWJzjB69jkT+tbMHDzmS0
D6o2/CpiiZJ+uJEmfeh69q9yyOM5Z2Dg6JT33x7XlXU/0oEFyBbjMGKeu51WEhVc
UkP2E1LGySDdDn/qpVGmxn58n+zQckFKKeGBx6A6XIBNsEovK6wSwPgqGFcEaYtx
tpSzxTMlAHyoKKPCEpOsBbWR8WrBkTVKR73RbthImAfBUSQHH1s6+Hyx8Dg4V+iY
8O6O1oQ97VKAc9SBnS2nFBs+iJrS9E0CpLQxzS3Xa+gpAU+jiUVTP9GjB6AkqQIo
kf3Hd2Vxu1o7UXgo/WP3A4YY1gmX1cvOAyBeKCryfZfoIv72yUj+tH1jXvEAVoS3
kfdMqifPqOZl6oYYG0RQkp7fOcXblqaKbMJ+6baA7/cdi39rEgWpdv2N6ozsatbP
dLpAlpbfpBEUa8k4doIvD6+eFmW9nORcwS66d1FwVG4hXqF8zfLkjd24SYx2MV/e
plqP6CVY0XB+75JIfnoagR1viXdPbV9jBcSwkB94mVcp4yHRK6awr0emeutND9aq
TsPGNgQ2eqR3B5ifldiexzKICjKU1GFegkM5yhWZxmoTuju30XI=
=H6un
-----END PGP SIGNATURE-----

--oKEwqg3MVUhuPv5O--
