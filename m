Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6339936A164
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbhDXNfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 09:35:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:51807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhDXNf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 09:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619271277;
        bh=ulIDD+xQc6+8GBV4wi22wgy4MiW2fFsXSgHY05rbB8A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LSMBeMihAcOmMfXZ3Rpry6hb5aXv8bG2G60jZPozbGz1N65VeW+B3bLu2Z1FcEY8o
         hSnPciMVunriijoxoz1svA2SLnYIiWTsIX3/DoSF4tyVfxAVve1btGm+Ho7ikmHSYg
         LBDq9KXuUm9d+D8ctEcBQGG2+iZzz+2rWJ6pLuBs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU5b-1l6RWo0QoF-00ebHC; Sat, 24
 Apr 2021 15:34:37 +0200
Date:   Sat, 24 Apr 2021 15:34:36 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] misc: eeprom_93xx46: Compute bits based on addrlen
Message-ID: <YIQebBIPJhivwhhv@latitude>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
 <20210424123034.11755-4-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NGXTi2LOohGo7DxC"
Content-Disposition: inline
In-Reply-To: <20210424123034.11755-4-linkmauve@linkmauve.fr>
X-Provags-ID: V03:K1:Erj70blt0wu1mtru+/8Rf7fnEBblp9ALtEFRkyc9F3RhQCYDCTU
 eljGOG7TmSFpRS8j+/EY8KPifMkzViLBl9we3Ny4/Fj9a2+YN5ebOEuvT79UIu6JVm8/92P
 M0O+SQM9tmiPJuAzzxkJ6ZBzDo4Z8hFmbS0z1YkAA0kxBAqO+4C1V5B22fvTxJrgRvNfsD5
 QQxXAHHjAA9QHUCQpgWcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fbB8668e4SE=:W9VANtQCrRL2NQ4Xhk9jkm
 f2IeJkDwnJIgHVh3l5uCGGqGTT0sQEMOWwVnsSysZNL96Eunpk7XfjapAX9irIByKzbPSY4o9
 hl0hOMBYmTLfCYPHQXhVMm49DjR/9wOYEqknC9uGnx6xFdpicS4DodJqkN+iQiCNOHbG9aiKH
 s4BxrvWZtDjBpBXXDbW+Wa/Ne5O52LpxbABxP6yU0yuCBl/3BuKgCRg/6RqM9DI4DIzD7fLC1
 q5aKtmCixc06yuAIoWX3R0yMk70f9n2wIyBxInMyQh2OVZQb7aNLqecPRWgU2jpozNH/MWhIr
 t/HlmeFTWrrQvvx65uUHwDJKBKZLZ9YvjR4r0+XrdvvCgjVF5Cacwm/aC8dioZoQoZPtp8f+X
 buLmZ8z0i1ay3v75W5HCqXHEK98vZUzDEvQDszK1+3gdeedqWNg8RgDuSF3NQV5HbeuXKDqpr
 +Xn2HqH8lnZDNxvvp6HZLYWC05jN3QfzyUFO9VWF/VgPdX8XB/FXudMX3tGx+IjGk7+RfvzGb
 vxqRZZ5gueEhO0lk6YdeYe6Gh0+PN+qijuNtSDagJ5QuxS/btGXu5NhtvgI04dJIf2vtLE86c
 tOpIjfN7D/XLQf+GuCZq7ZSwGyyMnojZaD34mheYSH2gN/uYM8Fob+OBeRZf+HdRpXp96OXlq
 rTcYzDPqYx2d3EzIwM/SZ2v2b95/M+NBcTFjJhoKAwnPEdz2FK5wDaJaMA79fMDDR9N1nlfd9
 uH+jd5+4G85SDpYBzFHma+60T+Gx8iMdk49NsEeIuiubxXnmHcoXno3Anb5s3RjpWZivjM1Dm
 C/bkPoxb7+4usmpXQsLFsx14xUjnByOiSBt6tAY648hdgIX+Zrq5NKbN83/s+lquYRk8UfK7z
 55Aw/LErnZa6URiigv2hpZ5L2o/cfVHFHjkiIUin/H0WqeRAVPZ8YNHxSdCnoifqjgmIbGGVh
 7xQODy6uVaB7Ey5pAxbYL7CXTGc11AEsfLFQlEmvy36V9ePvr+BtH/rZgvaSavchtlGIpwCyG
 +1WYVSXqqLtvGuqbPbUNyfNY6LC6CtF/pIrXE6X0BFQPu2BDIZ7QePGrJcJ+R/tiPIW5covO8
 Ut6GBtlStnh5vDochkmVYYDYU7jSz73YRmq/KDOVzVhBeDar+NSc/QQ+g7rGrXmC4ta6G5QTh
 hFy93XWzvLaudv6/i6+jU8wJY876Kj8by8fYnGoS0uJaPBFvZAcVS21ys/KAyUhCWWdpXm9ki
 RFhq+g1d7UANcOANk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NGXTi2LOohGo7DxC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> [PATCH 3/4] misc: eeprom_93xx46: Compute bits based on addrlen

It's not obvious what "bits" and "addrlen" mean, without reading the
code first =E2=80=94 can you perhaps rephrase this in a more meaningful (to=
 the
uninitiated) way?

Maybe:   Compute command length based on address length

On Sat, Apr 24, 2021 at 02:30:32PM +0200, Emmanuel Gil Peyrot wrote:
> In the read case, this also moves it out of the loop.

I think this patch could use a slightly longer description:

- What's the rough aim of it?
- Is it purely a refactoring, or does it result in different observable
  behavior?

>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  drivers/misc/eeprom/eeprom_93xx46.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/ee=
prom_93xx46.c
> index 39375255e22a..2f4b39417873 100644
> --- a/drivers/misc/eeprom/eeprom_93xx46.c
> +++ b/drivers/misc/eeprom/eeprom_93xx46.c
> @@ -86,6 +86,7 @@ static int eeprom_93xx46_read(void *priv, unsigned int =
off,
>  	struct eeprom_93xx46_dev *edev =3D priv;
>  	char *buf =3D val;
>  	int err =3D 0;
> +	int bits;
> =20
>  	if (unlikely(off >=3D edev->size))
>  		return 0;
> @@ -99,21 +100,21 @@ static int eeprom_93xx46_read(void *priv, unsigned i=
nt off,
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
>  		if (edev->addrlen =3D=3D 7) {
>  			cmd_addr |=3D off & 0x7f;
> -			bits =3D 10;
>  			if (has_quirk_single_word_read(edev))
>  				nbytes =3D 1;
>  		} else {
>  			cmd_addr |=3D (off >> 1) & 0x3f;
> -			bits =3D 9;
>  			if (has_quirk_single_word_read(edev))
>  				nbytes =3D 2;
>  		}

The if/else looks bogus as there are now more than two different address
lengths. This if/else seems to conflate two things:

- how the command/address bits should be shifted around to form a proper
  command
- whether we're dealing with 8-bit or 16-bit words (nbytes =3D ...)

> @@ -168,13 +169,14 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_de=
v *edev, int is_on)
>  	int bits, ret;
>  	u16 cmd_addr;
> =20
> +	/* The opcode in front of the address is three bits. */
> +	bits =3D edev->addrlen + 3;
> +
>  	cmd_addr =3D OP_START << edev->addrlen;
>  	if (edev->addrlen =3D=3D 7) {
>  		cmd_addr |=3D (is_on ? ADDR_EWEN : ADDR_EWDS) << 1;
> -		bits =3D 10;
>  	} else {
>  		cmd_addr |=3D (is_on ? ADDR_EWEN : ADDR_EWDS);
> -		bits =3D 9;
>  	}

dito.

> =20
>  	if (has_quirk_instruction_length(edev)) {
> @@ -221,15 +223,16 @@ eeprom_93xx46_write_word(struct eeprom_93xx46_dev *=
edev,
>  	int bits, data_len, ret;
>  	u16 cmd_addr;
> =20
> +	/* The opcode in front of the address is three bits. */
> +	bits =3D edev->addrlen + 3;
> +
>  	cmd_addr =3D OP_WRITE << edev->addrlen;
> =20
>  	if (edev->addrlen =3D=3D 7) {
>  		cmd_addr |=3D off & 0x7f;
> -		bits =3D 10;
>  		data_len =3D 1;
>  	} else {
>  		cmd_addr |=3D (off >> 1) & 0x3f;
> -		bits =3D 9;
>  		data_len =3D 2;
>  	}

dito.

> =20
> @@ -311,13 +314,14 @@ static int eeprom_93xx46_eral(struct eeprom_93xx46_=
dev *edev)
>  	int bits, ret;
>  	u16 cmd_addr;
> =20
> +	/* The opcode in front of the address is three bits. */
> +	bits =3D edev->addrlen + 3;
> +
>  	cmd_addr =3D OP_START << edev->addrlen;
>  	if (edev->addrlen =3D=3D 7) {
>  		cmd_addr |=3D ADDR_ERAL << 1;
> -		bits =3D 10;
>  	} else {
>  		cmd_addr |=3D ADDR_ERAL;
> -		bits =3D 9;
>  	}

dito.



Thank you for cleaning up this driver!

Jonathan

--NGXTi2LOohGo7DxC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmCEHmMACgkQCDBEmo7z
X9vh/A//QUsL+tG7JlG304ma7HwNUdmUlv4NMRRnFN8Neir1oc8Bj3LfDWzBkoAP
LrFwHjVZUumEAoSnwmSWv92cdu6ACjACOVyKh2AvkD0w/3KP8XrtNJVgNyy0ox4W
fWziAlKqMyh/9v4luEH49f/FswaGzQSQzGAp/b3rrAxSKjoMw26B1aLtBOGV6FmN
vFO827NbJGM5lml2tOQLTflWTNGO9DfjdaJaPpEIrOy+fDZLzNHne1p0vbsg3qn2
oOeWyx6m9Zk3738fpy6EJQDC8hWH854w4AMan4aa2VJPg71ws+xYDBbZmHgGD71H
vcifN/w2DZ7msm5j2kXBDj/CioKZ0013X2D82fM9U7r7D3RwiKTA/GCAQ1hjru3C
j8n1smvPZAq1XX07O63BJxLyDpDzHcD2taDwW+ukRfJW4s0xKXp0ZdY+xRSOUjQa
WqKxmLRmnEI6cIT1vRB/UMFAKPk3DLgU1Cngl1zZqd0hyFXDaKuBTNkHc1xyjBgF
AoKE1N1c+UkJN5Oni0kNYcVomG67Ess7mBGbHio/WEv6M/kOvJp/FYSWml9mIyk/
5gskHkR3e+DafHc2+LKI0yGInVCDd2w8T8dsCDuM3PZt7qasxgHjyM7xMCNGmAIl
OKcs3xywlnM05tc/fGxISgpD1sDJDeHYl1idvAfYk5OVaEeCKL0=
=ZPVb
-----END PGP SIGNATURE-----

--NGXTi2LOohGo7DxC--
