Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C560633DDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbhCPTjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:39:16 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:32864 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbhCPTim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:38:42 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C00841C0B93; Tue, 16 Mar 2021 20:38:39 +0100 (CET)
Date:   Tue, 16 Mar 2021 20:38:39 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20210316193839.GA28184@duo.ucw.cz>
References: <CAMuHMdWYrS=YT7F7erM-e6xhDME4judx-T7rdFGi7CpW1_iqkg@mail.gmail.com>
 <20210316150033.15987-1-cnsztl@gmail.com>
 <CAMuHMdU+agaOdf4hQhn5JQDHCbuWm3dETJu01baxfDAY=nikow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <CAMuHMdU+agaOdf4hQhn5JQDHCbuWm3dETJu01baxfDAY=nikow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2021-03-16 16:34:50, Geert Uytterhoeven wrote:
> Hi Tianling,
>=20
> CC Jacek, Pavel
>=20
> On Tue, Mar 16, 2021 at 4:00 PM Tianling Shen <cnsztl@gmail.com> wrote:
> > On 2021-03-16 02:23 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > Personally, I'm not so fond of the <foo>-%u node names, and prefer
> > > <foo>-<function>.  With the former, it's way too easy to have a silent
> > > override in your .dts(i) stack.
> > > Cfr. commit 45f5d5a9e34d3fe4 ("arm64: dts: renesas: r8a77995: draak:
> > > Fix backlight regulator name")
> >
> > How about using `lan-led`, `sys-led` and `wan-led` here?
>=20
> Documentation/devicetree/bindings/leds/leds-gpio.yaml says "led-%u"
> is the preferred form, but that anything containing "led" as a substring
> is accepted.  So I'd go for "led-lan" etc.
>=20
> BTW, you can validate your DTB against the leds-gpio DT bindings
> by running:
>=20
>     make dtbs_check
> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/leds/leds-gpio.yaml
>=20
> Background info for CCed parties:
>
https://lore.kernel.org/linux-arm-kernel/20210316150033.15987-1-cnsztl@gmai=
l.com/

I don't care much either way, lan-0 is okay as is lan-led.

but...

+			label =3D "nanopi-r4s:green:lan";
+			label =3D "nanopi-r4s:red:sys";
+			label =3D "nanopi-r4s:green:wan";


It would be good to have common labels, that means LED_FUNCTION_LAN,
LED_FUNCTION_WAN, and figuring out something better than "sys",
possibly LED_FUNCTION_FAULT?

Thanks,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYFEJPwAKCRAw5/Bqldv6
8oJXAKCPwj7rucsgGyf7XZK9sfEne3jGTQCgqNLsTvXmKfFgv9fd007fRTCH1mM=
=HMgP
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
