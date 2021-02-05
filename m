Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69DA3107F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhBEJdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:33:31 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:60382 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhBEJak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:30:40 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 96D231C0B77; Fri,  5 Feb 2021 10:29:58 +0100 (CET)
Date:   Fri, 5 Feb 2021 10:29:58 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Message-ID: <20210205092957.GA24839@amd>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu>
 <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com>
 <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
 <20210204210140.GB7529@amd>
 <4f53ce214f2c498fa47794327a8f35fc@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <4f53ce214f2c498fa47794327a8f35fc@AcuMS.aculab.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2021-02-05 09:13:03, David Laight wrote:
> > We have open-hardware implementation for 486, AFAICT, thanks to MISTer
> > project. I'm not aware of open 586 core.
> >=20
> > Being able to run recent Linux on open hardware sounds fun.
>=20
> Putting a 486 on an fpga might be 'interesting'.
> But it has a lot of 'cruft' (like 286 protected mode) that
> you really don't need.
> I'd bet RISCV comes out smaller.

Well.. RISCV may be smaller, and there are open-hardware RISCV
_cores_, but not complete systems.

> Most x86 ports are actually IBM-PC ports - so you'd also have
> to sort out all the peripherals.

And that's exactly what they are doing, and what makes the project
important:

https://github.com/MiSTer-devel/ao486_MiSTer

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAdEBUACgkQMOfwapXb+vLw2gCfWSwgmm3JEf+uyuraRX3lFEmG
rM4AnjtclN7RIns+TGG/0llsxKhP4KkN
=rAts
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
