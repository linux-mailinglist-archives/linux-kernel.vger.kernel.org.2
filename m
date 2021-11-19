Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6755B456ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 08:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhKSH2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 02:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbhKSH2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:28:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94A1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 23:25:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnyH7-0006ij-NO; Fri, 19 Nov 2021 08:25:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnyH3-000QpB-TL; Fri, 19 Nov 2021 08:25:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnyH2-0004YY-Rn; Fri, 19 Nov 2021 08:25:28 +0100
Date:   Fri, 19 Nov 2021 08:25:20 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tony Luck <tony.luck@intel.com>, Colin Cross <ccross@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pstore/ftrace: add a kernel parameter to start pstore
 recording
Message-ID: <20211119072520.azm7qm7xfxqk7goc@pengutronix.de>
References: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
 <163725891549.1179817.6546871118396864090.b4-ty@chromium.org>
 <202111181030.A6A1469@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ldkcahby6xks6lvq"
Content-Disposition: inline
In-Reply-To: <202111181030.A6A1469@keescook>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ldkcahby6xks6lvq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Kees,

On Thu, Nov 18, 2021 at 10:31:26AM -0800, Kees Cook wrote:
> On Thu, Nov 18, 2021 at 10:08:38AM -0800, Kees Cook wrote:
> > On Thu, 10 Jun 2021 10:21:34 +0200, Uwe Kleine-K=F6nig wrote:
> > > With this knob you can enable pstore recording early enough to debug
> > > hangs happening during the boot process before userspace is up enough=
 to
> > > enable it via sysfs.
> > >=20
> > >=20
> >=20
> > I refactored this patch a fair bit so it would use a common enable/disa=
ble
> > routine, but otherwise the original intent remains. :)
> >=20
> > Applied to for-next/pstore, thanks!
> >=20
> > [1/1] pstore/ftrace: add a kernel parameter to start pstore recording
> >       https://git.kernel.org/kees/c/8d74118c9441
>=20
> Hrm, sha shenanigans. This is actually:
>=20
> 	https://git.kernel.org/kees/c/a5d05b07961a

\o/ Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ldkcahby6xks6lvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGXUVcACgkQwfwUeK3K
7Ak2VAf/Ui2wrdtYoCgJufGyHlLDLhorcZOEF4Hc647CIl1SgAGXgJfxlTt9i6ZD
WMWUu5wRJhVQlgK8kdPeaDicIkLMt+++EHxwOfbCe9SabNB7YICM5SEc1vQVxHhu
vOLRFomXtdPZAETXkagyLxsoE1s2PYOAwoNcb79IwjCXPrAGqsK3D758m6LFBMzJ
yrnyoPXoBtY14D0PP3ifLzd5TozzUiEu+oNZT72vO+yVW7/k0QkGJjYTml3fVJBc
A15nO7k3uLdpKE95KyvHUyNqbG+BJOwWrzCJOwmysdiC9qntGCAaPTTHMuqGkjfe
vAZ6EE4cRn453+Id7Y2jDCvDK2qhOw==
=Mjvk
-----END PGP SIGNATURE-----

--ldkcahby6xks6lvq--
