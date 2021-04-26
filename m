Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343C836AF67
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhDZIDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:03:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:37751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232278AbhDZIDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619424167;
        bh=dZ2uOtsx9E3If2h5+xZ+eF7qzov0115q7dr5zXfhyec=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Eq16TZ1yg1ckzOWM7vtc/0xvME3JEXwcEc+sJEqbSNsWoqd1R9n9eaVBW2xc0kJAb
         zaze5qbivCPulwAIvN7qcdmEnt9yYet3pbQXnrXaDcK2vzcP2M7BAwy1UNrytqdgjW
         0eZzx+7VRZZDTuFZwztsnWDe3ixP+wvC/r6Lu2Bs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.179]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1lUeeS3INd-012EXM; Mon, 26
 Apr 2021 10:02:45 +0200
Date:   Mon, 26 Apr 2021 10:02:45 +0200
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
Subject: Re: [PATCH v2 3/3] dts: eeprom-93xx46: Add support for 93C46, 93C56
 and 93C66
Message-ID: <YIZzpbhJpRqt7HLs@latitude>
References: <20210424212543.13929-1-linkmauve@linkmauve.fr>
 <20210424212543.13929-4-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vKo+Jxg2MG6O7TAF"
Content-Disposition: inline
In-Reply-To: <20210424212543.13929-4-linkmauve@linkmauve.fr>
X-Provags-ID: V03:K1:S2cqWoll9RtEDDdTygExONVJv47EGOvXrnDgeXhfGF8Lx8/nodM
 ryFlaZauZGxobcyso2QGZFEGL02dz+2H3EP3JcEvT2ssX9uLA9BI4DJEHtZww3V3lJT4rUZ
 jeagvzMUt+/8VOdEIM0unJEBgd8+8FIdtD4eWBok8I9SFeUPlHE06QkjHJoJ9QsIxxkO+bJ
 aWxqkGvpBptv4FCzQXdWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FpR/1zzxpDY=:P5fJYWbro+eh28o7ZuEvhD
 I0QJr2ImMYSXNmca7I0GGirhQNdoDGk0ndLFXHl61TAAutMDkEgCPUUU6KAVGZrp4I1xA+P++
 wdeeSS9N8VnhQW5Iwve0UHFVOwxcFp4UazzdMfilKc8CFBChvFVGfeGEyBcleVtsWcudwiJtV
 5DNLDBYCwlrhKHQRSfmcDNnvh0GIfFIEJ3udhO2leOe4U6GGGHDhxJQwyv2LTfmhhl/xeuhWL
 lZn8dObtwbW+73D/ZG6RjIIDMLcT4VBK8JAS0VlkYvcoeAW8qi3/265ZG+rTyYxMGzG1G7YC2
 l0KrdBBCMejSokOsU8/yIv4PHaUJl5XSuktN6k4I8zOwhd/MfxAtuli3kECqYc5yxrbNsPiek
 QhfttKekqXefdbuYPqSmk8ymdARiTePsnwbX0R9KBEimIpU9hYrfjGrYbgTol0HeWe5TXezEV
 vNgbh241WeAfVCvrNrNf3UeDoJwSf8WsHNRBXgmF6dYIIYnIGqSEw/6CNKHl8Yl8gzLmzAGUc
 7DXLLaJ4o+c0/4j/Vl+2pydwrEjBQRrR9Myzc02UxiCGzwZqJ2pVf1FjY7fKmbhyvrZvmLJ+K
 HXph2qraVQwr11lZpGiuTRjLFqifJTqZepJNdvJVqiSfs/IKDHsQu6iKTfPpylKeAQwQAjY9d
 HkqY5Ui2/F3DhkOQEHtaTNGLEmh5ZZ+5pMDAt22lcTRmIrGKReP4rIvX5URh62eRMNKscQGlY
 3MEGsTFqmGLR3RM3T/X0OuzpYOK28y2OafuLwPPzwBBuV6DWUv89nl9ps20Y5iEi02BfDsDE2
 2jGW6Ma5fSVwejKUCOKVek7DwVauNADZviwBvfqPC94Xa9dFOW/WRlsgnpR0N1OJ3XhcEgMGB
 kEw4nuyk+lsqpOFgPW1zjGx39d+KuD8kuaX149XRJAy9C7c1MCbZ4TJNhYXxc+iir0KJ7kIUu
 OuJeBjnOMxJashTGn0dNTxpZTB37Mp/TEUI4GS/GOy3N7z/W1rBqb1CPO+yelmlXax8Uq0gfJ
 f+oUU8TozklDAM81CPjS5e2WS70QYx2lbFR+fSZgrm7Uz6/75CvKhNHdUdjyl+FOrBUpeiBnA
 FYc861Xf2ZtnMIxP0uXC45oga/RbY14EfIfQyu2ivxqDt4PRuiSGblrcfxGzNoxzuL0kEgBXp
 bJ6A78rauhtk58koiwFiwZfqurJwIeIzQEnuPalocn07v6Pk6ATnuao2wST5MXQSHpk+2ClxT
 n99MArQmxQAyS1TZGcetoAu5p5ygkCezJnlOF5E/RXgwvkJbnsUhlAPHTOa6N/s9wbvHChGak
 45Xuy1/XBk+V+1qnmPPbii/cJvb4TA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vKo+Jxg2MG6O7TAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> [PATCH v2 3/3] dts: eeprom-93xx46: Add support for 93C46, 93C56 and 93C66

The usual prefix for devicetree binding patches is "dt-bindings", not
"dts".

Other than that, I think the patch looks good.

Thanks,
Jonathan

On Sat, Apr 24, 2021 at 11:25:43PM +0200, Emmanuel Gil Peyrot wrote:
> These devices differ by the size of their storage, which is why they
> have different compatible strings.
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  Documentation/devicetree/bindings/misc/eeprom-93xx46.txt | 3 +++
>  1 file changed, 3 insertions(+)
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

--vKo+Jxg2MG6O7TAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmCGc6QACgkQCDBEmo7z
X9spSg//cVDNhUfS5Fu75lQbMwTNKKHJDWTHx5x4wPuYc4eJ6/J09xkGqvavpHwt
q7G/1cUUxKS2gKp7f3nx2OohQ7YqG7IPsQxzknnbYFpvzhAjJLJFyqda2M5mQj7p
Flgj9y7OD6DuspK+Rsa35MRh8BadYbCYbuaADXCURBO/5rrYPVdFDVWZl4Zj+Aur
Cu8zICJ9TXWNxHN/yodMNLsTWJFbxVahwdyxirlx/copZ3PMDxvaN+W/zCKOCu30
d3iMus8e0y5AYWRjyPc38zICSi/T4t+oSFb27yjOwSICe2OIJY5ZiEIYsal7o+Q1
FfBPctghG+eMFdYZOV4MKkannqfx1A+dkE350RO8Yf+mB6+x6g5k/Ew8WvY2G32L
0H0HT8Tl32V5aJB/7E+oD65zFNO+AbLKa8Zn/Jbh0t+UtDMPqsCO8mtV/AvMqnk9
ik6OG0urBlzkNNlO5gEm3dpuWK6hKxwp090Hsg7IrzYe7aq7t/lknBeQUEQdXX5R
wICH8VZM4/CJTkfrXKfWZ1nzcQ0/iNNRNxbFba1akwZphNRG8xsbbsXypn9Wv+Pi
HW88BgsJSHrkzTlxmRSy1iAlJyG2YVlQ8v3VJdJZtKPzpI2fIJx69WdZZzGqoKeD
2itno8oY7gmLi4Iw7uW09Pfw3ib7ty8XtDa26V36BgBUTPsxpfk=
=xGd5
-----END PGP SIGNATURE-----

--vKo+Jxg2MG6O7TAF--
