Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BC536B20A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhDZLEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:04:06 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50328 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhDZLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:03:59 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9FDB21C0B77; Mon, 26 Apr 2021 13:03:16 +0200 (CEST)
Date:   Mon, 26 Apr 2021 13:03:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Marty Jones <mj8263788@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Bauer <mail@david-bauer.net>,
        Johan Jonker <jbx6244@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Message-ID: <20210426110316.GA13974@duo.ucw.cz>
References: <20210319051627.814-1-cnsztl@gmail.com>
 <161640742725.808893.3666594351389773587.b4-ty@sntech.de>
 <20210425213321.GF10996@amd>
 <CAOP2_ThcRMkgSm872q2By=gALoK-qAjq92FtNQkDO999pZR8kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <CAOP2_ThcRMkgSm872q2By=gALoK-qAjq92FtNQkDO999pZR8kg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > > > - Fixed format of LED nodes
> > > >
> > > > Changes in v5:
> > > > - Dropped the empty PCIe node
> > > > - Dropped useless `/delete-property/`
> > > > - Renamed LED nodes
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
> > >       commit: 1003888415e83e15ddb63d1d96189b4f2c5f1d48
> > > [2/2] rockchip: rk3399: Add support for FriendlyARM NanoPi R4S
> > >       commit: db792e9adbf85ffc9d6b0b060ac3c8e3148c8992
> >
> > Sorry for late review, but:
> >
> >
> > +                       label =3D "red:sys";
> >
> > This should be red:power based on the discussion in earlier threads.
>=20
> However based on the introduction from FriendlyELEC[1], this is not
> the "power" lamp...
> "LEDs: 1 x power LED and 3 x GPIO Controlled LED (SYS, LAN, WAN)"

It is always on, and "sys" is not a valid function.

I'd suggest labeling it as "red:power". Feel free to make other
suggestion but lets keep existing functions.
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYIad9AAKCRAw5/Bqldv6
8rTHAJ4nA4Fv8pKz5+41IbOTLBjIMzKo5wCgniy+wweKJ3Bq1M+lSS+ghFLC/5A=
=/ktb
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
