Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FED30FF07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhBDVCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:02:45 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:58916 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBDVCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:02:39 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 864111C0B77; Thu,  4 Feb 2021 22:01:41 +0100 (CET)
Date:   Thu, 4 Feb 2021 22:01:41 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.osdn.me>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210204210140.GB7529@amd>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu>
 <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com>
 <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I think there were 486s with up to 256MB, which would still qualify a=
s barely
> > > usable for a minimal desktop, or as comfortable for a deeply embedded
> > > system. The main limit was apparently the cacheable RAM, which is lim=
ited
> > > by the amount of L2 cache -- you needed a rare 1MB of external L2-cac=
he to
> > > have 256MB of cached RAM, while more common 256KB of cache would
> > > be good for 64MB. Vortex86SX has no FPU or L2 cache at all, but suppo=
rts
> > > 256MB of DDR2.
> >
> > There are also some newer (well less than 30 year old) cpus that are
>=20
> (less than 10 years actually)
>=20
> > basically 486 but have a few extra instructions - probably just cpuid
> > and (IIRC) rdtsc.
> > Designed for low power embedded use they won't ever have been suitable
> > for a desktop - but are probably fast enough for some uses.
> > I'm not sure how much keeping 486 support actually costs, 386 was a
> > PITA - but the 486 fixed most of those issues.
>=20
> Right, we have "last of mohicans" (to date) Intel Quark family of CPUs
> (486 core + few i586 features).
> This is for the embedded world and probably not for powerful use.

We have open-hardware implementation for 486, AFAICT, thanks to MISTer
project. I'm not aware of open 586 core.

Being able to run recent Linux on open hardware sounds fun.
									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAcYLQACgkQMOfwapXb+vInqACgkjLbN2uUqZLXo2W9Cd3FXVon
dyoAoIhEHuOXjjaQz6PaPWREnmtzlUD9
=iKmM
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
