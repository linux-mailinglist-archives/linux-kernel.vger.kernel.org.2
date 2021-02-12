Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447D6319FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhBLNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:35:40 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:54112 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhBLNdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:33:41 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B55651C0B8F; Fri, 12 Feb 2021 14:32:54 +0100 (CET)
Date:   Fri, 12 Feb 2021 14:32:54 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: drivers/leds/flash/leds-rt8515.c:216: undefined reference to
 `v4l2_flash_release'
Message-ID: <20210212133254.GA31749@duo.ucw.cz>
References: <202102120714.JSuT94C8-lkp@intel.com>
 <CACRpkdbEecZZ8UUtmBY3tiK51zv-Y7S=4wjHqqzubz4odzMt+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <CACRpkdbEecZZ8UUtmBY3tiK51zv-Y7S=4wjHqqzubz4odzMt+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2021-02-12 13:38:58, Linus Walleij wrote:
> I need Arnds help with this...
>=20
> On Fri, Feb 12, 2021 at 12:05 AM kernel test robot <lkp@intel.com> wrote:
>=20
> >    ld: drivers/leds/flash/leds-rt8515.o: in function `rt8515_v4l2_flash=
_release':
> > >> drivers/leds/flash/leds-rt8515.c:216: undefined reference to `v4l2_f=
lash_release'
> >    ld: drivers/leds/flash/leds-rt8515.o: in function `rt8515_probe':
> >    drivers/leds/flash/leds-rt8515.c:354: undefined reference to `v4l2_f=
lash_init'
>=20
> So the problem is that this is compiled in, so CONFIG_LEDS_RT8515=3Dy
> (it is tristate so can also be a module)
> but it depends on symbols from a module:
> CONFIG_V4L2_FLASH_LED_CLASS=3Dm.
>=20
> In the code I try to only support the V4L2 interface when using V4L2:
> #if IS_ENABLED(CONFIG_V4L2_FLASH_LED_CLASS)
> (... V4L2 code...)
>=20
> Is there a way to define in Kconfig that if and only if you enable
> this other module it has to follow the y or m that we use for this
> driver?
>=20
> Or do I simply have to bite the bullet, make it bool and
> depend on CONFIG_V4L2_FLASH_LED_CLASS || !CONFIG_V4L2_FLASH_LED_CLASS
> ?

Arnd already submitted patch for this one... depends is right, no need
to make it bool, I believe.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYCaDhgAKCRAw5/Bqldv6
8m4bAJ9B/zZ4wi2ShSzUjd0KExeCYG1LWwCeKgtdxcW4sZCxt+4KlVz2YT/zLhI=
=ngL/
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
