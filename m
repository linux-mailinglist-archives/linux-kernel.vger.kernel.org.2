Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B61031F58D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhBSIBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:01:14 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:51194 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBSIBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:01:12 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F1B751C0B8A; Fri, 19 Feb 2021 09:00:27 +0100 (CET)
Date:   Fri, 19 Feb 2021 09:00:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Willy Tarreau <w@1wt.eu>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210219080027.GA12434@amd>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YC55t1vkRuC9uXcx@kroah.com>
 <20210218205534.GA10201@duo.ucw.cz>
 <202102182343.36276.linux@zary.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <202102182343.36276.linux@zary.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > For me
> > > > only way to get properly working WiFi on my laptop computer is to
> > > > compile that Intel out-of-tree version. Sad, but true.
> > >=20
> > > Why use 4.19.y on a laptop in the firstplace?  That feels very wrong =
and
> > > is not the recommended thing to use the LTS kernels for.
> >=20
> > Well, that's actually what distributions are doing, for example Debian
> > 10.8 is on 4.19...
>=20
> There's 5.10 in buster-backports. That's probably the easiest way to get =
support for new HW.
> =20

I can compile my own kernel, too. But if you go up the thread, it is
about iwlwifi becoming broken in 4.19, and Greg saying it is wrong
to put -stable on laptop. And -stable on laptop is norm, not the
exception.

								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAvcBsACgkQMOfwapXb+vKULQCgryFXGNNKGnpKT+FWWox4Hbfm
9zMAoMHBptdPbLf7wAbiADdEp2IiWZB9
=kl2U
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
