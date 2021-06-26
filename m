Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C2B3B5047
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 23:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhFZV36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 17:29:58 -0400
Received: from mout02.posteo.de ([185.67.36.66]:42475 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhFZV3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 17:29:50 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id CCD5C2400FD
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 23:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1624742845; bh=41rpbSn2Uyn0qALHKbYOc9/feymQyErjP+9elyuLFbA=;
        h=Date:From:To:Cc:Subject:From;
        b=bvIgsWtJyxdeZctJnYvxWGSrZkSp6GCM+gRxywmYrAsrxvdIiTN2jZ8Bpdmw6feVr
         q0oAhT4o5GwqR//64oIF8NWv3eDtLxt7WPhwUQ0zlekHXa258m7ywtnijON1ql5Sse
         2Y9x9BDRm4rq4h07Yz9TYR9HPSBSwIbEGFztQ6cdxKYgPxM2JF1NWEcKSAdJy0fQwr
         mviXH07Yx9r5sKgyeQGQE/P1xD/xA2UgBXCa9T4UJTzrjf6BWj5jzj9cxAxD+O6h7j
         hqADP6VO/WAvoVkNdS+snLgj517Tu2fDmYvPmmHRFhYxExHKqxKw0pkNTndSUNyTCZ
         gIlnEPlODTBHQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4GC6Qg0r7lz9rxL;
        Sat, 26 Jun 2021 23:27:23 +0200 (CEST)
Date:   Sat, 26 Jun 2021 21:27:22 +0000
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
Subject: Re: [PATCH v2 2/4] dt-bindings: nintendo-otp: Document the Wii and
 Wii U OTP support
Message-ID: <YNebuj3J51FbWC1n@latitude>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210519095044.4109-3-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7j5plNaFnrRdIOyG"
Content-Disposition: inline
In-Reply-To: <20210519095044.4109-3-linkmauve@linkmauve.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7j5plNaFnrRdIOyG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello and sorry for the delay,

On Wed, May 19, 2021 at 11:50:42AM +0200, Emmanuel Gil Peyrot wrote:
> Both of these consoles use the exact same two registers, even at the
> same address, but the Wii=C2=A0U has eight banks of 128=C2=A0bytes memory=
 while
> the Wii only has one, hence the two compatible strings.
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

A link to the (third-party) documentation for the OTP device would be nice.


Best regards,
Jonathan Neusch=C3=A4fer

> ---
>  .../devicetree/bindings/nvmem/nintendo-otp.txt     | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/nintendo-otp.txt b/D=
ocumentation/devicetree/bindings/nvmem/nintendo-otp.txt
> new file mode 100644
> index 000000000000..b26d705ec52d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.txt
> @@ -0,0 +1,14 @@
> +Nintendo Wii and Wii=C2=A0U OTP
> +
> +Required Properties:
> +- compatible: depending on the console this should be one of:
> +	- "nintendo,hollywood-otp" for the Wii
> +	- "nintendo,latte-otp" for the Wii=C2=A0U
> +- reg: base address and size of the OTP registers
> +
> +
> +Example:
> +	otp@d8001ec {
> +		compatible =3D "nintendo,latte-otp";
> +		reg =3D <0x0d8001ec 0x8>;
> +	};
> --=20
> 2.31.1
>=20

--7j5plNaFnrRdIOyG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmDXm4sACgkQCDBEmo7z
X9veGhAAy2IY+Vkls/q+6+hkbYXDroy+O6Ogd0JYudibYnde3Y0McY0c+7nRHSBP
jFIcSJfAEzdBk1X+g18nVJsB/ysvDZ3eMbWjGoOb2e5nNhT+G/Xhvpl0bSInHpel
SqhHoCj3iSCzmZGlUiyKewjGEVboi1/iQR7Wq5gFctNgpDmwapb8w6RRYY8vjg/E
+iI4gSDqgWLkWkDqQengP9AP3X+IKYgs2Xg+ZbXyGl1kx3ZRwxT2G1UEao1T2l1o
WKlUAAdlB30+qigZVuCkFkuGTMUn7eSLVyWm3gAzu1toHtMChz3faac4ZnYIxcjl
1kJKnu3dcMySRO8ITQIPsbIxwweWoSoRST0kEGueFylSzo5Kgh93DCBeChoGIcCG
WeyP7gspFkcm3c6iR4yG+7W+VdKmO3nhSMlMNnttH8mRIO66quV8qV9k0tfVD6DH
litoyTLmNT4f34T1+kTo0lzo3sRDRcRYt4ZikEqFXVQOHCCAylo6MLjvXLbaFAFd
3PGKz9tYf7RtT82DDuvnVje1S13hTZ10eOO6HDvSGWPB5zbTks15zNEAE6H2Un3Y
Xy1Jewlg/9EgaQTM6JzQjz9DG5/z3v26QpfJYo3Kpqg0ssCr9TXkJ/SPSCtq5w7e
Qmf5ZZpL5hbPj32UremiOB9lLHloav3l8w8E7HS0lVv6tszVyk8=
=CJPN
-----END PGP SIGNATURE-----

--7j5plNaFnrRdIOyG--
