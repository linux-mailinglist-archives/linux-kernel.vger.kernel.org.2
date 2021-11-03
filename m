Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70822444350
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhKCOXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:23:17 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57869 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231517AbhKCOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:23:15 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B779558064C;
        Wed,  3 Nov 2021 10:20:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 Nov 2021 10:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=tlyyf9ABd9leYDuixOZBsq3FaRp
        fxSPQhOflw8Bwob0=; b=p7/giRW05Py516639NaVVmYpMrp5zRfPdHpCQEWmbsR
        ffm1PNdqgBZfS2IXS+yxL95NlZO2vJnbbrHtJzW3a+Jjctc70t5VwF5FlO4jprLZ
        wW59rWt0d5jsKLKNzRJZc0E0NEjwP0cewUjv/egBujVcHiplj7bbFZeV9f6Twnyg
        Ewt3oi64mK1kAvvFcgQ8rtNGnG4r7h8HSXDPllTgUgSX0dxdx0MrUWOgEL+HS060
        rM2G4rBtm6h9Tb6hS1dKmb+4zU9fTsuveEXNNpBhqPq+bnPsCD1VhphRIhJqCuss
        yLHjBLJdRwAuB7hur85uMiMi39RbrOsYH9gH9cYffCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tlyyf9
        ABd9leYDuixOZBsq3FaRpfxSPQhOflw8Bwob0=; b=A/QZnJdt1b0fP0jEDlZgk4
        TbZfm6lf8yaaVRWLse2RLROqdkSyeVbpWVUo0iPTxhxuXGDRyobBPKxn2nC2tcVV
        xHzxbWKCMa1j06klCrn7kTeyub+SUQzhs/E7SM8Z+jm07RsPlDObdPVvq9O2D2MH
        mhWJItocf+SAE2tWaJYcaplX5BC/yiOE9d+ARAHMS5R21eugOUQyLPKuN8rfhLBj
        ekWtW6TuEW3K0y6ydTnb3KN2WF59qalWpLz0Q7swwFP72MUFSD1KfB/5uZ0zRxYB
        7Nywt11QdfXTDCPMAuf97K94RFLua8LGs/QcE1FpOaofQ48NEekHCvLsyIB7LC6g
        ==
X-ME-Sender: <xms:tZqCYQGxC79otChLtyCmedivQQ-5zLuab2lwn1Bzf8m0Gz-nF5IrkQ>
    <xme:tZqCYZVf4yv9_qqOJdwSROfotXzrnW59sEmNw5osWN6E52WnHgeVRaUhXyeJIAXxC
    m8KWVi8a03etkB70qY>
X-ME-Received: <xmr:tZqCYaLoa0L3JgGrsfFYQjYvkCG7cq2faahcp2flLULzc17fKcIBg2z17-2J-Pr_jNbP5JgE7Kw0ONNs4qpz4hV_UeidK9om>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtddvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdefhedmnecujfgurhepfffhvffukfhfgggtuggjsehgtdorredttddv
    necuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehsth
    iftgigrdighiiiqeenucggtffrrghtthgvrhhnpeetudehleehtddtjefhgedtjeejjeeg
    teefjeefgeeukeeuheekteekhefhueetieenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmpdguvghvihgtvgdqthhrvggvqdhgphhiohdqnhgrmhhinhhgrdhmugenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsth
    iftgigrdighiii
X-ME-Proxy: <xmx:tZqCYSEFL3E_hx0YCURMLUgRpfQkz6VMzBoSyfvj_BE6wriGjrxHlg>
    <xmx:tZqCYWWZUASLhsptBp1ZJqS8Lv34kv3h75A8jDFkL4N7aFAN13dGzA>
    <xmx:tZqCYVOqJMD1VS-sfJbbsMUjJYJR7P_e3G95YY8A86TbSUU0iws-Pw>
    <xmx:tpqCYfNO1KsHb2QKngE-D9TMWlgLjKY9dtAy_NBJArE38DHfPwEy_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Nov 2021 10:20:37 -0400 (EDT)
Date:   Wed, 3 Nov 2021 09:20:36 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Howard Chiu <howard10703049@gmail.com>
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Howard Chiu <howard.chiu@quantatw.com>
Subject: Re: [PATCH v1] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Message-ID: <YYKatBCCroiYxLew@heinlein>
References: <20211103071417.388388-1-howard.chiu@quantatw.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="76EoKyP6xdfx7kPV"
Content-Disposition: inline
In-Reply-To: <20211103071417.388388-1-howard.chiu@quantatw.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--76EoKyP6xdfx7kPV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Howard,

Thanks for supplying this.  I have a few comments below.

On Wed, Nov 03, 2021 at 03:14:18PM +0800, Howard Chiu wrote:
> Initial introduction of Facebook Bletchley equipped with
> Aspeed 2600 BMC SoC.
>=20
> Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
> ---
>  arch/arm/boot/dts/Makefile                    |    1 +
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 1160 +++++++++++++++++
>  2 files changed, 1161 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e0934180724..2cc2d804e75a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1474,6 +1474,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
>  	aspeed-bmc-facebook-wedge400.dtb \
>  	aspeed-bmc-facebook-yamp.dtb \
>  	aspeed-bmc-facebook-yosemitev2.dtb \
> +	aspeed-bmc-facebook-bletchley.dtb \
>  	aspeed-bmc-ibm-everest.dtb \
>  	aspeed-bmc-ibm-rainier.dtb \
>  	aspeed-bmc-ibm-rainier-1s4u.dtb \

I believe the preference is to keep these sorted.

> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/a=
rm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> new file mode 100644
> index 000000000000..af30be95fb23
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts

> +
> +	chosen {
> +		bootargs =3D "console=3DttyS4,115200n8";
> +	};

Do we want this to be 115200 or 57600?

> +		fan1_ember {
> +			retain-state-shutdown;
> +			default-state =3D "off";
> +			gpios =3D <&fan_ioexp 13 GPIO_ACTIVE_HIGH>;

I see a number of references to 'ember'/'EMBER'.  I think the intention is
'amber'.

    amber: a honey-yellow color typical of amber=20
           or a yellow light used as a cautionary signal

    ember: a small piece of burning or glowing coal or wood in a dying fire.


> +&fmc {
> +	status =3D "okay";
> +	flash@0 {
> +		status =3D "okay";
> +		m25p,fast-read;
> +		label =3D "bmc";
> +		spi-max-frequency =3D <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"

Is this board using 64MB or 128MB modules?  Many of the newer systems have =
been
starting to use 128MB.  I just want to confirm this is correct.

> +	sled0_ioexp: pca9539@76 {
> +		compatible =3D "nxp,pca9539";
> +		reg =3D <0x76>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"","SLED0_BMC_CCG5_INT","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
> +		"SLED0_SSD_ALERT","SLED0_MS_DETECT","SLED0_MD_REF_PWM","",
> +		"SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_=
MD_DECAY",
> +		"SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","SLED0_AC_PWR_EN";

In general, in OpenBMC, we have a preference for the GPIOs to not be schema=
tic
names but to be named based on their [software-oriented] function.  Please =
take
a look at:

    https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-na=
ming.md

Any function you see that isn't documented there we should try to get docum=
ented
before fixing the GPIO name to match it.

> +		gpio-line-names =3D
> +		"SLED0_EMBER_LED","SLED0_BLUE_LED","SLED0_RST_IOEXP","",

The LEDs are ones I know are already documented in the above linked file.

> +&i2c13 {
> +	multi-master;
> +	aspeed,hw-timeout-ms =3D <1000>;
> +	status =3D "okay";
> +};

Was this intentional to have defined a multi-master bus with nothing on it?

--=20
Patrick Williams

--76EoKyP6xdfx7kPV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmGCmrIACgkQqwNHzC0A
wRnw0RAAqViUSHmkD6lssoV4YyVBcAqa+5giq26JKHUQKTAIJO/dBK8OHWeWEAbU
+qZEU3xhNiZjaUl2ZBKVS2kdZzDfRwOlFvkT+v2o+Vt4c7vfNkK5u20Q8M6NCJBy
HbkRTun38Nc2MS/aUAdcoQm2DsfRxHtlxIQDXmSDEpIDtI3ttduZw1jwjtFGjpF/
z8LKJMOi0GXGj2C29KG10oAEjpC4vmFyqFsjc7DlErmmRP9Qb1rx+0dVNVhhb+Kj
eUMkRZoRBbhJvN8fIE999aeaYW3T1uhhNVI/lWJipbrRgqgaFkq0WG6vfnHbtwVl
8iOUcjGYpDsuUuU2SabVZWaX/8pl7EIS1QGsb4l1ue9L45zGXSZY5rrylctXs3Nj
TzsStgS8eoDdrceiV9R+HCJi2mTwf7Lw6i7XbRVmm4YTsTmib3BC/jMu7Eve192a
k7ZH/W8e6865N5evshoVgX0NlogxNKa/qch0DiFgS5Ep1ISyBAJKQwaTS5ZsqKqr
fuNaQGh3efTzmdlQQ/spa1XOUJUWfw5B1nuCXz5ZdtOXhKpqyjN9H4JaRtio3ORS
FEYS85xF8j4mz362uauFtZanTTLlPPoPzg61QVumk2oOU8Vv05fEOkT4+pJtae48
wi2kfsRMOYrJ1Kem1LGNnGT5/tuK31FkOeqmybFcwhbMuLArh1M=
=qzaE
-----END PGP SIGNATURE-----

--76EoKyP6xdfx7kPV--
