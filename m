Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CFA36A97D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhDYV0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 17:26:22 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51228 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhDYV0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:26:21 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EA4EA1C0B77; Sun, 25 Apr 2021 23:25:39 +0200 (CEST)
Date:   Sun, 25 Apr 2021 23:25:39 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Johan Jonker <jbx6244@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Marty Jones <mj8263788@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 2/2] rockchip: rk3399: Add support for FriendlyARM
 NanoPi R4S
Message-ID: <20210425212539.GE10996@amd>
References: <CAMuHMdWYrS=YT7F7erM-e6xhDME4judx-T7rdFGi7CpW1_iqkg@mail.gmail.com>
 <20210316150033.15987-1-cnsztl@gmail.com>
 <CAMuHMdU+agaOdf4hQhn5JQDHCbuWm3dETJu01baxfDAY=nikow@mail.gmail.com>
 <20210316193839.GA28184@duo.ucw.cz>
 <CAOP2_TjFtBqBP8wOY-wxSd89yYuYF4bwqWCP4c6FXNMNH=2t-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <CAOP2_TjFtBqBP8wOY-wxSd89yYuYF4bwqWCP4c6FXNMNH=2t-w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> However, Documentation/leds/leds-class.rst says the form of naming is
> "devicename:color:function",
> and according to the given examples, as well as other dts(i), would it
> be okay to use `green:lan`
> etc. as the lable?

Yes, that sounds right.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCF3lMACgkQMOfwapXb+vIQIQCeJAnhQaD+6C5WI8aWAXre7RwC
aoIAoI4TlvVGlbltGWFqqE4qwOwY4Ajg
=pphU
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
