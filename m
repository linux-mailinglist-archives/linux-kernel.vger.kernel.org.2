Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0933D88C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhG1H0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhG1H0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:26:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC456C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:26:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m8dx8-0006Mb-Qy; Wed, 28 Jul 2021 09:26:06 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7213:487e:ab4f:842a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4AC2D659EF9;
        Wed, 28 Jul 2021 07:26:05 +0000 (UTC)
Date:   Wed, 28 Jul 2021 09:26:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     "Menon, Nishanth" <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 0/6] CAN: Add support for CAN in AM65,J721e and AM64
Message-ID: <20210728072604.ruev36qwx2x2krlu@pengutronix.de>
References: <20210726101012.26983-1-a-govindraju@ti.com>
 <f5abf985-d953-a9cd-f6e6-ee86d3a0f398@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qjhroa3tm7qxtywg"
Content-Disposition: inline
In-Reply-To: <f5abf985-d953-a9cd-f6e6-ee86d3a0f398@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qjhroa3tm7qxtywg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.07.2021 10:49:58, Aswath Govindraju wrote:
> > The following series of patches add support for CAN in SoC's AM65, J721e
> > and AM64.
> >=20
> > This patch series is dependent on [1] and [2] and I have requested for =
an
> > immutable tag from the Marc Kleine-Budde(maintainer of net tree).

I'm the maintainer of the "linux-can", not the "net" tree.

> Here is the tag in [0] shared by Marc after applying patches [1] and
> [2], linux-can-next-for-5.15-20210725,
>=20
> [0] -
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/lo=
g/?h=3Dlinux-can-next-for-5.15-20210725

That tag has been merged by David Miller into the net-next tree.

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/=
?id=3Dd20e5880fe9df149a9159673d9fec57aab43ac61

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qjhroa3tm7qxtywg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmEBBokACgkQqclaivrt
76mBDgf/fqptD4kLBB78HJyWa6U4mZI/QSm+ZckJV794i9Cmm0Pagn+cgGtNjsjq
i7rOS5cJnUEJ3SGhJByvz97xqyqolXVjoGr/ZHufdH9PJ2HJo6JshGRiVutbzoJ2
uy2YF8pRgUVPm4K+PKiTcXHk67CdbI3GoP+a+NU39/qkM+FfqP6IO2bk0mYDyrYF
QmpZMXyHKf3xkt1xZMfMrgOA6yTOXfgrFhK8mZJqYK3kJdN/ByJ7x1wcL3aIjI0q
QlPah/kcjJQB3Q7DCuTa3T1y0wGtQIhyzp8k1iKaxb6q+Zi96FvA8iVcZtXVUKNM
lv9HpEOmss/wdbVQap6yQszISYr9GQ==
=l/pF
-----END PGP SIGNATURE-----

--qjhroa3tm7qxtywg--
