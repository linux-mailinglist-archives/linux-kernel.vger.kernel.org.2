Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2DD44511D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 10:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhKDJc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 05:32:56 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40547 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230410AbhKDJcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:32:55 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5A196580881;
        Thu,  4 Nov 2021 05:30:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Nov 2021 05:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=qYCY7tttcemIZgcojAlZUXbTUNV
        NVtf/FEcSNSxidEo=; b=ti54t+gBbZVWISv3Jrb2lUE9jcs840yKwzRgKPqto+i
        dyzTrPXpmInqIea+1dpmYei7g9abeESIBj/6UX/Dds5P7VbFKzTy4F6myN0iF7Eb
        73y/eT7DRInhfL9iRduWzdHQEzXdjcfJKLpmSgW8VDy5jmI4FI3U4CQJ5N/Wrcct
        /D6aFyYHvy4QYirnpiFDvGawCWXuDZmvLDGroEMqrDWIEDlwYZQOd+hU3DhHoME0
        qcp0W5pZoQrws7caYnAtfYHxPYBPwF25Ce6jgc5vGmx6q8MG9x6rL5I+8gxXzRIm
        W8dXEESC6+BdyYSgfM6gT+nDwJroBUWKKP/KKGyDwWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qYCY7t
        ttcemIZgcojAlZUXbTUNVNVtf/FEcSNSxidEo=; b=enq4j17WhFBFEgYNiXpZv4
        byWi20QvDq2Tr3q1BH9RcodcPniXzwekDF/LHtZcREVXKr0WpnJ91wrS1vCsu1Ar
        0jqVUZ9dmbzh36n5RVEJBXU6ZDrx2BASB4kSrZ//v9LQw+jzEfwdZYiOwpl3UM+r
        2H71TTgYxaYr3QbBuhLeQKi0x47/EDCZ0mxT/SXd8IeTWPD6TbZWRXKuH9W1m7W7
        yUoKXTRJuEZhR0sBjnE0miVKL3nxk9XfEHohKXMYE+zQ6Dr+KvTX5y6oquH8P08L
        DcLg5PLjqJuDr1Ia3g3St/tbtWutrP4A2dkT9mv4kM0AOHFnU7Lmv1szAVwPqiIw
        ==
X-ME-Sender: <xms:KKiDYUJzzV7vWYg7opkojjVIH8ayQkJFNLIc6tTVimmTbyIoXN4WCA>
    <xme:KKiDYUJ71bepFVH-ot2Gd2oUO0z7ewAM6UzszVKNUZaMQ9hb2MkZ2HGQsk47ZfX96
    a_GhWmzImYJZ_spzqs>
X-ME-Received: <xmr:KKiDYUsf2-YGb3EBXhtrCIbkvPPyPbZs9nkLjfR9WGwOFWaCagEBhCb1AHl-CWpuxpKk_VeV4RQpqhWztXZ64yJnxmoE7-5t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeggddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdefhedmnecujfgurhepfffhvffukfhfgggtuggjsehgtderredttdej
    necuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehsth
    iftgigrdighiiiqeenucggtffrrghtthgvrhhnpeekvdehudevkefhuedvteethfeflefh
    vdehiefgudegvdfggfetffevkeetudegudenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgr
    thhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:KKiDYRYhcVFDnQN_AQKAuZLvAO1xtvlOxfIFHi-pzRNm8iEZtOVJzA>
    <xmx:KKiDYbaecCGBal_Ga-tC-QR1Zi5Y_pZsyChJmgiiSVdDRpatWzL_Tg>
    <xmx:KKiDYdCzORA1vRwKPTZwlRzJF60SYSpzqM4onLB8hVLyAEtnxpC37Q>
    <xmx:KaiDYYRKtBkdVcvjyrkctFy02Y0MueW0VJ8azSpn2kgu7N5wyhIL4g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Nov 2021 05:30:16 -0400 (EDT)
Date:   Thu, 4 Nov 2021 04:30:14 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Howard Chiu =?utf-8?B?KOmCseWGoOedvyk=?= 
        <Howard.Chiu@quantatw.com>
Cc:     Howard Chiu <howard10703049@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH v1] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Message-ID: <YYOoJgXyOdgNmI6B@heinlein>
References: <20211103071417.388388-1-howard.chiu@quantatw.com>
 <YYKatBCCroiYxLew@heinlein>
 <HKAPR04MB40039608E14195D859DE7EC5968D9@HKAPR04MB4003.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pNxo54Czgw/SMy95"
Content-Disposition: inline
In-Reply-To: <HKAPR04MB40039608E14195D859DE7EC5968D9@HKAPR04MB4003.apcprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pNxo54Czgw/SMy95
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 04, 2021 at 03:30:08AM +0000, Howard Chiu (=E9=82=B1=E5=86=A0=
=E7=9D=BF) wrote:

> > Is this board using 64MB or 128MB modules?  Many of the newer systems
> > have been
> > starting to use 128MB.  I just want to confirm this is correct.
> 1Gb SPI flash, MX66L1G45GMI-08G

1Gb =3D 1024Mb / 8 =3D 128MB, right?  Shouldn't we use the 128MB layout?

> > > +	sled0_ioexp: pca9539@76 {
> > > +		compatible =3D "nxp,pca9539";
> > > +		reg =3D <0x76>;
> > > +		#address-cells =3D <1>;
> > > +		#size-cells =3D <0>;
> > > +		gpio-controller;
> > > +		#gpio-cells =3D <2>;
> > > +
> > > +		gpio-line-names =3D
> > > +
> > 	"","SLED0_BMC_CCG5_INT","SLED0_INA230_ALERT","SLED0_P12V_STBY_
> > ALERT",
> > > +
> > 	"SLED0_SSD_ALERT","SLED0_MS_DETECT","SLED0_MD_REF_PWM","",
> > > +
> > 	"SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_D
> > IR","SLED0_MD_DECAY",
> > > +
> > 	"SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","SLED
> > 0_AC_PWR_EN";
> >=20
> > In general, in OpenBMC, we have a preference for the GPIOs to not be
> > schematic
> > names but to be named based on their [software-oriented] function.  Ple=
ase
> > take
> > a look at:
> >=20
> >=20
> > https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-na
> > ming.md
> >=20
> > Any function you see that isn't documented there we should try to get
> > documented
> > before fixing the GPIO name to match it.
> >=20
> I intend to delete them for now if I have to document them first, because=
=20
> most of them are platform-specific GPIO, not for general purpose and also=
 not
> suitable to current OpenBMC.
> For example, OpenBMC believes there is only one GPIO to be used to power =
on=20
> the chassis, but Bletchley has six.
> I define gpio-line-names for gpioset/geioget/phosphor-multi-gpio-monitor
> usage, and they can be replaced with gpiochip number and offset instead.
> The disadvantage is that they won't be human-friendly when TEs develop th=
eir tool to test these GPIOs.
> > > +		gpio-line-names =3D
> > > +		"SLED0_EMBER_LED","SLED0_BLUE_LED","SLED0_RST_IOEXP","",

Deleting them entirely sounds even less desirable.  If these were just for
humans, then having a schematic name is better than nothing.  But when you
suggest their usage to be "TEs develop their tool to test these GPIOs" that
seems to indicate this becomes ABI and we want stable, documented names, to
limit the churn on users.

I don't believe the gpiochip/pin numbers are considered stable ABI.  Our te=
am
has previously had to do an abstraction between 4.x and 5.x kernel because =
of
changes in that space.

My initial preference would be that you leave them in as schematic names, f=
or
human purposes, until you start using them in code at which point they shou=
ld be
well-documented and using the style we've set out in the document above.

Re: "OpenBMC believes there is only one GPIO to be used to power on the cha=
ssis,
but Bletchley has six."... This does not make it system-specific.  Yosemite=
-v2
has 4 independently managed systems, with their own power sequencing.  There
should be work going on by that team to expand the GPIO documentation to co=
ver N
sub-chassis as well; it just might be that you are ahead of them in documen=
ting
it.

It should be trivial to expand the `power-chassis-control` and
`power-chassis-good` documentation to support sub-chassis.  I can do this f=
or
you if you need.  Many of your GPIOs were related to LEDs which are also al=
ready
covered by this doc (except might need minor wording for sub-chassis as wel=
l).
Can you let me know which other GPIO functions you think you'll need that a=
ren't
already in that document and we can work to get them added?

> > > +&i2c13 {
> > > +	multi-master;
> > > +	aspeed,hw-timeout-ms =3D <1000>;
> > > +	status =3D "okay";
> > > +};
> >=20
> > Was this intentional to have defined a multi-master bus with nothing on=
 it?
> There is a OCP debug card which is a hot plugging device.
> We only need to specify this bus with "multi-mater" property for IPMB sup=
port.

Got it.

--=20
Patrick Williams

--pNxo54Czgw/SMy95
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmGDqCQACgkQqwNHzC0A
wRnlOA//RV+35oOn9wEW+jO6oZi0M5yL51mdYiahoSlrSbjn9M3rydZPeCHA2Nfo
nn+TpAalJ6fNmAjwGdGyQCcorRGgKb4WRw1WW91lErBydFRTSIbL0lJ4dIIQsdjh
VtRhivTCz1UDMsGYGy+rFc4f/NAIXq3fFDaY5ek58BBUZtHMHHpvaQhvEzg982kS
iOSsQ79dInmoX/1m5PQDGt67Fx/lcuJCVmlVl5OFuD3UTmpeSckgbs/kT6S4jiiF
Y/SUWHGOrx9rWwRsNdDgCFJLmWjwTFpopI8hwkw/PkP9w5Y3twv/Ulng4FG/wvuR
eBLc0bYY69bPXfOWP6UVg3ChnJAiE1mNQNlUwNrbvCF/Rc3NtBM4hIOZ6zDLBc6g
l54ITv6DLl07KARnYICr/eVCRvSV2znMHxju3c6Lcsql68T98h3+KGsMzX62dd7Q
O+diXES9DbmR4yMxXN//LN+adaqiRVCo8ubSZ5dnK6bgqJJqd+repyl48XwQCoTU
KES8EeT+s/rye5AG1o877GEt2yoVjdaETlYzZGZTBRO9tKJ1CVrVBs71J1JFaMP0
lCI3rDGGz0vzZjNzVMw+xUO/EH8ddOh9wGBCEzypRNAE5ikipidbms5s2BehMWU/
mPiI/oQk5RHl4q5dxeWi42QScTkXHq3fToJ7ZBoeJN9Oy5Xz4l4=
=cy2B
-----END PGP SIGNATURE-----

--pNxo54Czgw/SMy95--
