Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372C236AF5C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhDZH6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:58:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:44781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232888AbhDZH5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619423767;
        bh=om5PRL8UafhLprySFFbXRzIlQADwjEfcalTzlfxsW+Q=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=P0rGMpzPPf0Hay04E7bB7f9GgGbtn+RHQLgmHzmKTt4APj/0HztmocdiOwlH+O2E0
         DCp7ajL6x8Xduqfk4WEaL0K4wJACLPMKEMOpTiwW8gxA01UNhxOjMvytucePthPICo
         d0T6Q+EQEvj1raXpmVke99ja0jioxkTh8/w01g/I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.179]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1l3oCq1qmZ-00cU0E; Mon, 26
 Apr 2021 09:56:07 +0200
Date:   Mon, 26 Apr 2021 09:56:06 +0200
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
Subject: Re: [PATCH v2 2/3] misc: eeprom_93xx46: Add new 93c56 and 93c66
 compatible strings
Message-ID: <YIZyFnld4LcR6+Nd@latitude>
References: <20210424212543.13929-1-linkmauve@linkmauve.fr>
 <20210424212543.13929-3-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UFa4UN+jBQ25xRM5"
Content-Disposition: inline
In-Reply-To: <20210424212543.13929-3-linkmauve@linkmauve.fr>
X-Provags-ID: V03:K1:pkx4Hz0M8xu7WAynTE+RaCSoH27Z6NKiSHEsOxJyuZB1H2V8kLK
 wmdU/JGDuy5e8pNzOvJ9WDHRLPFYqbx+yF46Ej1Vw87GQVdX2UL2mc8JppaBTiZBNrXSc2B
 gxNYbcuo9AYsiCHFqmQG7isEXnWBg96E2B4QE4kekwobxucu8JDm4p8Z6IrTOERqvNESMm4
 O3oRumCCi5RVeexwgaVIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/LwhLExP9TA=:+WNj5sR7XdDk/JFnNfiUM0
 hhgWOiSPvLLqxsWaUk9keWMsHcxBPcjU0cIXfzJYmHdvacXvYqQOn/dSizcLhpJzU/k774DoA
 O+OehGrd5HjAJhMHZMJ1G//0U/KBGQxGRJvYW/i4VRXlG+2mYekxAAdvMYymOKH8A0dRgfb4a
 LioGBWw0qmOEssHVmvXh+62AsgkWYFNVt0nyCivxuAPi0nsgX8LMvZV9Mv25zIGQjo6UzCCg/
 I5fwdya18Q1LSRAX678YsP/Kj7sFk4ANQHVwARBfFruCHAhNmk9HVr0IX6eGu57U6P62Ws5NV
 5ug0F+TtXl2mrxhqpxgQ9Ko2ZfGo/yUC2fuoS8aEE082LFvigA6tTwNO207y2dgz9EH4TpJ53
 6LRcT4vhb1SxxIaHJa09JaedHmF0KzZ+KpbE5ifRpnkKG513upBg/XksSBnbv/6HQlRyEDM07
 IP+fo/DZrwJLACeNYTvz0GVa6dRIjoGEB8dv/1KYxIVh5XIxmFE5T/X593UfzQkF2RgpmRetq
 a4q5faGYHvldFAeA8Rm12jrhr3yFZkwXgk8v17EE6b8Dl9ACsRy+hlc0fHTMZKbm5yJN5BGpJ
 o9734U8A97el7+AAK9CnsBPC7mes1kHwkc+w/PqEvIOtF6Y3QErBqzuCXO0g8WCRx+nDoINmF
 CxhBZCAp1MY5u3r4PLduzRXE94FF+wMIGVnjH5Q2rwQHQry7tOAbsatxoVoo9plZTp1q6BzeQ
 0P934269QA8gpVd1VGKIkgbHzk6VeBoR4jjD7Z6Aee+rojben07dxRqYjKpNAli7wFxr83Q1m
 B1tvRXY+a+utZVD1B9SUzq+/nXTu6D+CpLcerMshNH6Zm/7+cHoSc5d5J4FYaHwXzbQEFWg8y
 MX7zuli4wdIlnL6ZEiNHa+L4J+JEBGKmT2/31E0DqJILfHbLLh59OFj4T7vXRuoATlS544iw+
 /RCGYXFfm0lVEsX58bX22cmsrfH1qlzJnLUfuxqajATPnrok/wxLTER20Ya4Kuj9cGvpbcJyK
 DESbgClsABceQnZaox/ff9o1SVnIjf+9mYMxFLcx2hfe04mEUswR0xrb5buaFao2ZsUZpcQsA
 jvIhMlpVJGiY8gDxZAElXwHU2R9nmDkAckz+P7LNsNmEWEKCSEML4r3XoWrn7g+x9lPmHEHl6
 Jx/wBEVXIoHU5rv6SnqjP5WPvdsYeNqdYLePQyhCBTxyXynYfPUGEEevitt0TfFSzyp9ian3J
 LxoCqvYaJ2Md7//Ll
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UFa4UN+jBQ25xRM5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 24, 2021 at 11:25:42PM +0200, Emmanuel Gil Peyrot wrote:
> These two devices have respectively 2048 and 4096 bits of storage,
> compared to 1024 for the 93c46.
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


>  drivers/misc/eeprom/eeprom_93xx46.c | 35 ++++++++++++++++++++++++++---
>  include/linux/eeprom_93xx46.h       |  3 +++
>  2 files changed, 35 insertions(+), 3 deletions(-)

One thing, so it doesn't go unmentioned: There is another driver for
these EEPROMs, drivers/misc/eeprom/eeprom_93cx6.c, but it isn't
stand-alone, it doesn't even have a probe function AFAICT.
In that sense, I agree with the decision to extend this driver instead
of the other one.


Thanks,
Jonathan

--UFa4UN+jBQ25xRM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmCGchYACgkQCDBEmo7z
X9soRBAAkFp+GvM0Yv9DG9aRjrGI3XRpyfj4yVEWIiYxrn6psi9ZwsBunCiie0j8
CDRVGQ9yt60lO9Y2FfMXowAeE9Y4q7NHPLR2rmPpuWZYLSYmI9i+7uTbbeHxmUxU
cPYGXMx1rAr/Cnp+OdUHidyxGwo0cLVGgEbn/WnEX3AmWDiFWKVgfR1zEg42Ws4Y
D21tcpWaTZjex8lNmQA14VKVftIQ00biEz7bv3m6gy15p+/kC8aXkr/O56SJz4xz
HbU+PAjmKLTBpBXxJZTO7V9AtN5xO6PFB13tfozftte9TJxJzqyvWQd5RPRCN7Wt
X77wKa6QOLGtvNAPh4/UVD4zsCL3Qxph7mwyyG3PCF7e+U/LRSxRe0Co9/Zvj8+V
b2QPJmdAk5bxB4k6wcrae/v+B7fzJaXHFuzI+HxGlXx7/VZFGHoaoTNecWzKpKb2
k6wKWvWP1hV7cQA+UqaNQrBEUpoFYvpBYkj4tAZVOJZ9+0q4Bot3Dz1eUf9w8pbY
KofTcU8L84ib28+xzVHjajBMFoLBfxSmE7fFn0TcVt4TJUDXnUHs8omOMqHa3bPN
QoDKUUg73Ou/JzRpjCUqoWvzJIH0et2X6TuXge/rERP/Wv9M2LihWKEYAzVIBj6t
fWOqWE8fdrLHQaDJTrZJXXdWCxNMFyuk7czPh7MStX/TO0hi+08=
=rJaS
-----END PGP SIGNATURE-----

--UFa4UN+jBQ25xRM5--
