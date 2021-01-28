Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F9030801B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhA1VCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:02:17 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:39794 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhA1VBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:01:54 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 315D81C0B77; Thu, 28 Jan 2021 22:00:54 +0100 (CET)
Date:   Thu, 28 Jan 2021 22:00:53 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc5
Message-ID: <20210128210053.GA6722@duo.ucw.cz>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
 <161160687463.28991.354987542182281928@build.alporthouse.com>
 <20210125210456.GA196782@linux.ibm.com>
 <161160923954.29150.8571056944016500691@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <161160923954.29150.8571056944016500691@build.alporthouse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

/-/blob/master/kconfig/debug
> > >=20
> > > Here's a boot dmesg from some affected machines from just before the =
merge
> > > with rc5:
> > > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/shard-skl1/boot1=
8.txt
> > > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-skl-6600u/boo=
t.html
> > > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-bsw-cyan/boot=
=2Ehtml
> > > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9676/fi-bdw-samus/boo=
t.html
> >=20
> > Is there any way to get early console from these machines?
>=20
> 12:16 tsa : none of those have good hook for serial
>=20
> Nothing on the console and no serial console option, and panics before
> netconsole.

In some experiments I was successful with console=3DttyUSB kind of
setup...

=2E..and I kind of wonder if we should work on getting it workig on more
machines, at that seems to be only reasonable way.

Umm...

Actually, we still have VGA and can put console on that, no?
early_printk option should really work quite early on PC.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYBMmBQAKCRAw5/Bqldv6
8qs3AKCYdBVDEdZN/s3T2Fwo0iL2X0u4YACeJKEH/7SPSIdQblxqmeABu0wS3dc=
=2OAd
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
