Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A203751C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhEFJnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhEFJnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:43:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248CDC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 02:42:53 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1leaWw-0002Md-OB; Thu, 06 May 2021 11:42:50 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1leaWv-0002Ps-Tw; Thu, 06 May 2021 11:42:49 +0200
Date:   Thu, 6 May 2021 11:42:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] intel_th: Remove an unused exit point from
 intel_th_remove()
Message-ID: <20210506094248.vkec2fcwzuudagqh@pengutronix.de>
References: <20210505203748.200499-1-u.kleine-koenig@pengutronix.de>
 <87zgx8jk0x.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hjmxu7gmwphqtvae"
Content-Disposition: inline
In-Reply-To: <87zgx8jk0x.fsf@ashishki-desk.ger.corp.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hjmxu7gmwphqtvae
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alexander,

On Thu, May 06, 2021 at 12:20:30PM +0300, Alexander Shishkin wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
>=20
> > As described in the added comment device_for_each_child never returns
> > a non-zero value. So remove the corresponding error check.
> >
> > This simplifies the quest to make struct bus_type::remove() return void.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Picked up, thanks! Out of curiosity: does the mentioned quest have a
> message-id or a git branch?

I just pushed my wip patch to

	https://git.pengutronix.de/git/ukl/linux bus-make-remove-void

to satisfy your curiosity. If you prefer a clickable version:

	https://git.pengutronix.de/cgit/ukl/linux/log/?h=3Dbus-make-remove-void

There are already a few patches for that quest in mainline[1]. Other
than that nothing special.

Best regards
Uwe

[1] git log --oneline --author=3DKleine-K=F6nig --grep=3Dvoid v5.10..

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hjmxu7gmwphqtvae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCTuhUACgkQwfwUeK3K
7Am6zQgAnl02RqnZ0Zn890JIm7sy5ZKIivF2IzAag4bPmpYuFdnAfx1XBGXwsONf
smqEOgMkvCzZrJSNDziTxZq3ImJpLUwbAVlcPzGJf8l92qwNktIxZhrEnk1VqeyZ
gKcjMhIr3fLbEzdoAtW2leYufhIYcq63CHt64bi9RV7K6t3e4RoTpVIFSGalc8hB
z7+MJVbdYyEC4adADfDgXvIgT1zm6cVoPHrivhc/gNYWRn7GX9SC8Z0yyEdCnIRT
Y0zLe2bG+vi+mSQuRDJsAC5Hah3lZLMLbG3y9kmHSsmmWrSocqgId4s4vu/+vKKq
tPrWjFYTU7HQsMclGgUw2Qc2Hrlc9g==
=ZCz1
-----END PGP SIGNATURE-----

--hjmxu7gmwphqtvae--
