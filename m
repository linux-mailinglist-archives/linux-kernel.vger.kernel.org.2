Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F099F408888
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbhIMJvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:51:07 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59176 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbhIMJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:51:05 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EA6771C0BA5; Mon, 13 Sep 2021 11:49:48 +0200 (CEST)
Date:   Mon, 13 Sep 2021 11:49:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] raise minimum GCC version to 5.1
Message-ID: <20210913094947.GB12225@amd>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit fad7cd3310db ("nbd: add the check to prevent overflow in
> __nbd_ioctl()")
>=20
> raised an issue from the fallback helpers added in
>=20
> commit f0907827a8a9 ("compiler.h: enable builtin overflow checkers and ad=
d fallback code")
>=20
> Specifically, the helpers for checking whether the results of a
> multiplication overflowed (__unsigned_mul_overflow,
> __signed_add_overflow) use the division operator when
> !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW. This is problematic for 64b
> operands on 32b hosts.

Please don't. gcc 4.9.2 is still in use here.

Plus, someone will want to prevent overflow in -stable, too, and you
can't really raise gcc version there.

Best regards,
									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmE/HrsACgkQMOfwapXb+vIE3gCgw0HkhidmfYw6S+rmXZktbNr8
/oYAoMTOKfFL+ay0TnpmYFWqDgrZVoBY
=ZOqT
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
