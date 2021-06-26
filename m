Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165263B5087
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 01:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFZXg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 19:36:29 -0400
Received: from mout02.posteo.de ([185.67.36.66]:56767 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhFZXg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 19:36:28 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 87E5D2400E5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 01:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1624750444; bh=JeORn0wzi/Pu/QO65imy4jO5dUBCfYL8bqgtjgUWze0=;
        h=Date:From:To:Cc:Subject:From;
        b=G0rvLrMD8U9cmFSF3dhOSHQs8Sgk7c12GaCw+B/FnCBkw/dbRDY87FMP8s58A0yP7
         f7OQfF5t3lGh+vq5BcPML3l+5onT+kVHskAZEtsanYWU11+AZdzLl5syf7m80iqh+o
         I+Ae0rIh7kO71qPbZnBsDNGmC4TmIplCA0kLMLTLMxajevZK5nXQIZSQ2elwtfAbzM
         RdyfZPNk3xF/YuWPO5O8fyhwCzHCbLSZq9eBG6bngnGrZT7euEUTQj6YHZ0Y7oplt+
         hq2Ob7QbrPLfBvR6Lr8N1nxfJbOiuDXN2lAYNvCz2NkxfZ10c0nY67cf8UdO01XHww
         Bdq3AYzwFttjA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4GC9Dp28q1z9rxH;
        Sun, 27 Jun 2021 01:34:02 +0200 (CEST)
Date:   Sat, 26 Jun 2021 23:34:01 +0000
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
Subject: Re: [PATCH v2 3/4] powerpc: wii.dts: Expose the OTP on this platform
Message-ID: <YNe5aW55SrXFGKFV@latitude>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210519095044.4109-4-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AdirIyIEOXEflO+W"
Content-Disposition: inline
In-Reply-To: <20210519095044.4109-4-linkmauve@linkmauve.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AdirIyIEOXEflO+W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 19, 2021 at 11:50:43AM +0200, Emmanuel Gil Peyrot wrote:
> This can be used by the newly-added nintendo-otp nvmem module.
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  arch/powerpc/boot/dts/wii.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
> index aaa381da1906..7837c4a3f09c 100644
> --- a/arch/powerpc/boot/dts/wii.dts
> +++ b/arch/powerpc/boot/dts/wii.dts
> @@ -219,6 +219,11 @@ control@d800100 {
>  			reg =3D <0x0d800100 0x300>;
>  		};
> =20
> +		otp@d8001ec {
> +			compatible =3D "nintendo,hollywood-otp";
> +			reg =3D <0x0d8001ec 0x8>;

The OTP registers overlap with the previous node, control@d800100.
Not sure what's the best way to structure the devicetree in this case,
maybe something roughly like the following (untested, unverified):

	control@d800100 {
		compatible =3D "nintendo,hollywood-control", "simple-mfd";
		reg =3D <0x0d800100 0x300>;
		ranges;

		otp@d8001ec {
			compatible =3D "nintendo,hollywood-otp";
			reg =3D <0x0d8001ec 0x8>;
		};
	};



Thanks,
Jonathan Neusch=C3=A4fer

--AdirIyIEOXEflO+W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmDXuWkACgkQCDBEmo7z
X9tvzBAAhBVGIh0LX0XckUdyK/Mf844H2Sz6NoqeJvEeiEAgrqri2Lu+4fCoeXER
d8Ll/zsvx97oEN7D5zpJd8OkDTVAJm/Mi+wGxJpEoAA9YpcwUgy6u6iHOGDne0Ad
XObW1M5WEIoui+A520Rc4HWU8L18gAnGXS8gy8Ekh7SFkr7S+hQECo+x8ssLEX6d
pct1h4Z5kPHvj38nTmIzNUhi8WWPihvVvlE+zhrhR+FOpFFQTBPBqe950/1tGic6
qOpPa1eeuQIk7T9NDlF5a7i3eMoPwL9OMfz8i/jhb5ALM45trbEo/A09GD1kjtLE
fx1G86a4QidPN4ps64eMQbHgeE6ciI+nTtZl5ntXwFm+6N5lWxZRN52Kh0ibpUQK
F8oFj+2i3eNA+KjO12TD3ZKpAGQiZhTx4JIrGni6STRPnvYrNwSJ9TfpiEzs0wJ0
L6ZLMf/yLzoLyHqk8N6DvZmQN79ZbvvF6tqAHg0qX/EIbx1k7kLuqJ3gd1spOtsh
UE/3WQfqbZBxfFJIDewzCHtCWcFA22e1HSPgevKZXFL+fe2ePIiO4Q/c8MmXTY1P
bpLjTyaFDrZ1mG9K3x5PwHOlBI3uOmpCzSm9zIysu5rOKVQo96CaNGhkHUOAdJNK
MALu5woA7Chz0z4P9G7+pAuqOJBHzcqRaqLpdXZ/S0BHJibHLSQ=
=EH1y
-----END PGP SIGNATURE-----

--AdirIyIEOXEflO+W--
