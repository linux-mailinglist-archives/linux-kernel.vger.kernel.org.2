Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A6936A988
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhDYVeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 17:34:06 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51746 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhDYVeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:34:03 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 426061C0B79; Sun, 25 Apr 2021 23:33:22 +0200 (CEST)
Date:   Sun, 25 Apr 2021 23:33:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Marty Jones <mj8263788@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Bauer <mail@david-bauer.net>,
        Johan Jonker <jbx6244@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Tianling Shen <cnsztl@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Message-ID: <20210425213321.GF10996@amd>
References: <20210319051627.814-1-cnsztl@gmail.com>
 <161640742725.808893.3666594351389773587.b4-ty@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <161640742725.808893.3666594351389773587.b4-ty@sntech.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Changes in v6:
> > - Fixed format of LED nodes
> >=20
> > Changes in v5:
> > - Dropped the empty PCIe node
> > - Dropped useless `/delete-property/`
> > - Renamed LED nodes
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
>       commit: 1003888415e83e15ddb63d1d96189b4f2c5f1d48
> [2/2] rockchip: rk3399: Add support for FriendlyARM NanoPi R4S
>       commit: db792e9adbf85ffc9d6b0b060ac3c8e3148c8992

Sorry for late review, but:


+                       label =3D "red:sys";

This should be red:power based on the discussion in earlier threads.

Thanks,
									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCF4CEACgkQMOfwapXb+vJQ4QCgsESGSah/NLxeFhe7TcU4rW46
V3kAnRCDC3xFN6qYlETWQRVFFWa4iAEm
=/jIt
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
