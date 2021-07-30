Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3143DB2BB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 07:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbhG3FTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 01:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbhG3FTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:19:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36DEC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 22:18:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Kv8-0003HC-P6; Fri, 30 Jul 2021 07:18:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Kv7-0004To-1a; Fri, 30 Jul 2021 07:18:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Kv7-0005G4-0L; Fri, 30 Jul 2021 07:18:53 +0200
Date:   Fri, 30 Jul 2021 07:18:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     patches@arm.linux.org.uk, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] ARM: move the (z/u)install rules to arch/arm/Makefile
Message-ID: <20210730051850.v4erhjhrfxr6hb3n@pengutronix.de>
References: <20210729140351.442678-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oq7pwxvlfu5omslo"
Content-Disposition: inline
In-Reply-To: <20210729140351.442678-1-masahiroy@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oq7pwxvlfu5omslo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2021 at 11:03:51PM +0900, Masahiro Yamada wrote:
> Currently, the (z/u)install targets in arch/arm/Makefile descend into
> arch/arm/boot/Makefile to invoke the shell script, but there is no
> good reason to do so.
>=20
> arch/arm/Makefile can run the shell script directly.

I didn't test, but I think this works in general. There shouldn't be a
principal problem as e.g. mips also doesn't have install in
arch/$(ARCH)/boot/Makefile.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oq7pwxvlfu5omslo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEDi7cACgkQwfwUeK3K
7AlHhAf8DMPkrcCyAHgKhcZL5lWJQzYOfE26BEfGaT1zW/N2oDuLTHmiL47V5kCA
+NVQ+9lbqylWbt89go2IArfkn+MFZQRPRXQ1LjvfBkczXjaLBAKUQDOK/NfSLuJT
ck6DCYKxOLayzkrhRJRXX4ACVT+Y93IxCGl/6LTGHBvqgrmWHOjqU+yQ3+sVa+Ao
7N6U+aFzDR6exCoC4qQYHdkCv079m24atunhtg+SLWH6ody1WeX09h7DINBM38MG
BJ1RO6qm0ukeZbp8UdrKGHCYOAlP+tYx9uoDJe21pooe3Oh84oaBNDxiY7l7Qh0H
YpgkUqsQ2LkO6CGyUI7esggS42QYjg==
=p2Qs
-----END PGP SIGNATURE-----

--oq7pwxvlfu5omslo--
