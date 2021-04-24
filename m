Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF38536A150
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 15:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhDXNDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 09:03:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:50793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237214AbhDXNCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 09:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619269322;
        bh=6j87ZiVhbf3L+4QHqB4bt1hhsibj3XfVjHEjvMHhO+o=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=f+9iWSynn3hA8co69brRGW5djtsyzq59Y1vLfYDHZBAWofPl3uGjefu4DlGfih+Tu
         a0NY/MUU7WmiZGnwEsZ9qjTp+siQecJ4SujPo+bpuyQobjaK4r/jcD3DaFfFZT+5Kb
         79LXzD0H6L7VHvv3fF8VVCZxpUuxuPKzxrUWhTjQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1m5iga2A9i-00VSx2; Sat, 24
 Apr 2021 15:02:02 +0200
Date:   Sat, 24 Apr 2021 15:02:00 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] misc: eeprom_93xx46: Add new at93c56 and at93c66
 compatible strings
Message-ID: <YIQWyDuWTfL3Eqp9@latitude>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
 <20210424123034.11755-2-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sopQoswJR2Pf33wk"
Content-Disposition: inline
In-Reply-To: <20210424123034.11755-2-linkmauve@linkmauve.fr>
X-Provags-ID: V03:K1:mlOjkZ8S9wLUVtxKvL+Q+w8NBmHDUOzTRX+8jjHnAWBY17clLYH
 cpsw+yPBfN+CitYFoQS6xTku6EpAHr3/u+mIM0Ybej8wVn+dx3y+s+mVafFm+Ozjy/y6CQs
 8OWIo3/ociojziee2iFFaJ7ZNTcqcC8adSSvHca6ssJH5GXZocP0mSTwb9HQCHjOzRYIS8b
 xQN1oao1dhlih36t5kHnw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RoReX/gfcEA=:bZM76oPEqCpm1XNO98wHF0
 f4+wrmC6TXiCcVokdvkjCLTXZPRW0NM05cGqwAW2YEbiXtjvWWtkzxIwVup7YUt5dDsimKgHA
 Eb3Gmbhj5mxSU66y0/3rk6hfvf9pazTxFGxzZpYlcW+ZYK+OSIudygVhaSDSbOna792LcVMoo
 /xvLTOz5pvnXqfmHvVazPRhI5sE9DQz8gHbbJPBVrJLzD/AMy55h31JNuUV9UK7plUzxN/YQ0
 j3uOWpn/eK9BfUsuAZJaxg24HlrOkwsFAygwd7VvdoxWLqyfeR30mtkwzJsX0BKgWYJd+rqL3
 lZ2LAXrZqF3Fj2g8HtMP1/W2jG756a1A27ADg8Uy9CaYK3AhbqaBK+APA/lTPLwQN3aA1QIIN
 GCoPdiTO55aEhJkS4FOZl+VX9xxFIqaWf0lqRU27Y7lfPr18cvZcGwZkNSHi1UORNfRIkEy+s
 ShzfYoVWWWlrYNCLeqDTs5kiOVXolIL9lhtivuHG7MfvbM8gFzz1lrAseGDaokeKKNdwXQkOf
 Pe/ppYSf5fi6wT4QVaFynO6oAO/vkDP5ml6zaRSy6WBnTjFrpdi0jBvti0dwp/ufCZb6aohtU
 UhBXNUyBwqpFfgkHK039C9yqUaOTIE7xfX4VpirSkVzUlvxmQ1h95X+wfNfR8G1qWtrJ0ktl9
 1BnyKjCAtEKnUhzRTrz6iESbAH74RCt0Xo4S0r9zjpITRPV9RHMW70pZknAfxzqHm5qfkMigR
 PCGT53RqGntQMs4yMNGa6rZq0DExAV15HPiyYqphHpYuV1VZkGd5ilsbQeNdz/tY0TiQRsg30
 /XVZyog5pUUsx2B3Ga7qx42Apz4rW1fgQBcxDbKFi/P3QHJDOHgDLSiUg/Wfh0fY0o04264w7
 KgKaq2OwhIIJRyFnJ5yOb1Fr21pGvpQR1wcepS3DDVAQ+RR065fbtnElFaxZeqrR03hg6TjXp
 QUDVmgBn/rJ6kyjavq+Nz0j7JLDvJUDlQ6bRUfk7Y9rOMIu+egTabf+iPqL+gOcbDodBLM/to
 wWJEMqtsNYaBWo2eFGkA9ofRW5/Ar1/HjzE7+FvKDcDoXQpyfb/a4BVfZgNJ1GZlJyFiUU1Uu
 AK3NygC1qeQ8A+h3xInDmFAawPHvH2774F2FIbst5n4xrn0gFzuSvTFxpGaglfmTbqVS3MfD2
 t8aXI1f06hdP/CKrIQndWjD5OtPgzZrjCM9Va7rI+r2g5yi21Sx+6yrsFgsJLSZiP8dH1fsma
 V+b+6MJTsOqKVRymq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sopQoswJR2Pf33wk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 24, 2021 at 02:30:30PM +0200, Emmanuel Gil Peyrot wrote:
> These two devices have respectively 2048 and 4096 bits of storage,
> compared to 1024 for the 93c46.
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  .../bindings/misc/eeprom-93xx46.txt           |  3 +++
>  drivers/misc/eeprom/eeprom_93xx46.c           | 21 ++++++++++++++++++-
>  include/linux/eeprom_93xx46.h                 |  3 +++
>  3 files changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt b/D=
ocumentation/devicetree/bindings/misc/eeprom-93xx46.txt
> index 7b636b7a8311..72ea0af368d4 100644
> --- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
> +++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
> @@ -2,7 +2,10 @@ EEPROMs (SPI) compatible with Microchip Technology 93xx4=
6 family.
> =20
>  Required properties:
>  - compatible : shall be one of:
> +    "atmel,at93c46"
>      "atmel,at93c46d"
> +    "atmel,at93c56"
> +    "atmel,at93c66"
>      "eeprom-93xx46"
>      "microchip,93lc46b"
>  - data-size : number of data bits per word (either 8 or 16)

The DT binding patch should ideally be separate from the driver patch.

> diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/ee=
prom_93xx46.c
> index 80114f4c80ad..64dd76f66463 100644
> --- a/drivers/misc/eeprom/eeprom_93xx46.c
> +++ b/drivers/misc/eeprom/eeprom_93xx46.c


other than that, the patch looks fine to me, AFAICT.


Thanks,
Jonathan

--sopQoswJR2Pf33wk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmCEFr8ACgkQCDBEmo7z
X9uCHQ/+PKHNjXQ9DCtGu0hrrdbXktP6m5IgpDU44oF2VJxcYE0l+Jq2gf0f0yt7
nUMkH7g2dbX3zHaV+V+4RMPFqSmNWm6ei8IzZY1AuRN7Y1TmTX5ArvEIfHp95G9i
65cAqOyV8o8wyoXFoc+NSlA3D8py0cqPxg5tygjVqnAJGpnMRqLp/4PhbeQmZlGW
qbZ1VsNfrxk+jmHEAn7xwJjvrFKaZCR9FY78k0jKPQTiTD8XDlj9OfmsFc+M3I6L
CPbbp5zpgQeqWTcCNzqwEqw5+A11PLUQfgn6JpHB+cvLDhhhXLH8V1Z65YUguwwJ
6DkydwQvpayFCWTX7dC2GLkFZzIkFH3B+KWiPbjrXb9WGAO6dYIqTBmkOPS782Ct
uKOod0i0Fpn6KwPjme9oXUwJZy5I7qPgnwGj8LuTK6kS4bioY0hvvWAIgl3TDgEv
CrZt0oxic4bMsW88SkWOsemZovJgMZuM/gKXukuR1YOHkBEGK10tmdC6mdVo6ZzZ
P+hWXyxKhqr+SHUEKbgGrnStJBokjVY7cCe4hbo3aBfz6w7Ri0u0xsIhUcSq74p2
ghIpj5ZzyATX0M8RAsbrs23dH4p+qsocYiMMPtgVlKirG5u84qnnrPebh7MzYO3v
dd8EijnBpKh0uP5guXo3JlAG9STOpNs1EEhxldHW+15y1dr6GBE=
=rQN8
-----END PGP SIGNATURE-----

--sopQoswJR2Pf33wk--
