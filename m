Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892153CFCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbhGTOYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbhGTONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:13:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE61C0613F0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:49:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m5r3u-0004tk-QQ; Tue, 20 Jul 2021 16:49:34 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3120:e42a:5796:3403])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 73D13653103;
        Tue, 20 Jul 2021 14:49:33 +0000 (UTC)
Date:   Tue, 20 Jul 2021 16:49:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 1/6] arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
Message-ID: <20210720144932.5rtvpkmjooma7zae@pengutronix.de>
References: <20210720141642.24999-1-a-govindraju@ti.com>
 <20210720141642.24999-2-a-govindraju@ti.com>
 <20210720142047.mfqssyj4lwh3yi2k@pengutronix.de>
 <f3560ac8-8ffe-87d6-a21f-87f6251f1750@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hpvarmjcpm2ogbfr"
Content-Disposition: inline
In-Reply-To: <f3560ac8-8ffe-87d6-a21f-87f6251f1750@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hpvarmjcpm2ogbfr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.07.2021 20:00:32, Aswath Govindraju wrote:
> Hi Marc,
>=20
> On 20/07/21 7:50 pm, Marc Kleine-Budde wrote:
> > On 20.07.2021 19:46:37, Aswath Govindraju wrote:
> >> From: Faiz Abbas <faiz_abbas@ti.com>
> >>
> >> Add Support for two MCAN controllers present on the am65x SOC. Both su=
pport
> >> classic CAN messages as well as CAN-FD.
> >=20
> > Thanks for the patch!
> >=20
> > Why don't you disable the CAN cores by default in the dtsi?
>=20
> As far as I know, in the dtsi file we mention all the subsystems or
> periherals present in the SoC and in the specific board dts file we
> enable or disable the DT nodes depending on whether the  pins are
> brought out.

If you disable the subsystems (that need pins) by default, you only have
to list and configure only the used subsystems and not disable the
unused ones. But it seems in the TI land you're following the rule you
outlined above, so go ahead.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hpvarmjcpm2ogbfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD24noACgkQqclaivrt
76n/7Qf+PEg9CDe1udrXT9AkQwMz291wPkLCnJ1ovwadeNE9O2Ntj0lqsFsdJikZ
Q6LXdiePRSKNgG0QaWasd4fU4sUOdBOXLvKCfvssW5GA1UfsMRYT+gECt4XaVdJ7
iGK+3T8PcygTvoalU8FrISpysm42BErouKENRQMa59yYJtAszH/RnB5VdtoM3M7u
x/NRGqcof/YZlx+UmtHhMsK2Tq1KdaUH+xH9B7Qi6HGcEXPFTTRehMhKZf5Re8hK
Ho91ZVWJfGQVPwHjP4C1MgXY8injX4Ib0ETYT4Psa8KPwE44YM0FrPq/ThwNR+Ff
97NPOogt5LaeAZXkztY32U7f5CgDkA==
=mTBU
-----END PGP SIGNATURE-----

--hpvarmjcpm2ogbfr--
