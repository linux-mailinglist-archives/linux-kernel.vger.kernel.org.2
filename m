Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6218453886
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbhKPRbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbhKPRbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:31:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D61C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 09:28:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mn2G8-00014a-0v; Tue, 16 Nov 2021 18:28:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mn2G4-000KQv-9X; Tue, 16 Nov 2021 18:28:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mn2G3-0007nB-Dd; Tue, 16 Nov 2021 18:28:35 +0100
Date:   Tue, 16 Nov 2021 18:28:35 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        kernel@pengutronix.de, Colin Cross <ccross@android.com>
Subject: Re: [PATCH] pstore/ftrace: add a kernel parameter to start pstore
 recording
Message-ID: <20211116172835.r3puikipzryxnsoj@pengutronix.de>
References: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
 <20211116120603.4e0c04c2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3v5e3fxrzi2lvohf"
Content-Disposition: inline
In-Reply-To: <20211116120603.4e0c04c2@gandalf.local.home>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3v5e3fxrzi2lvohf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Steven,

On Tue, Nov 16, 2021 at 12:06:03PM -0500, Steven Rostedt wrote:
> On Thu, 10 Jun 2021 10:21:34 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > With this knob you can enable pstore recording early enough to debug
> > hangs happening during the boot process before userspace is up enough to
> > enable it via sysfs.
>=20
> Is this still needed? It's still in my internal patchwork, and I haven't
> seen any responses.

I didn't see any responses either, and unless someone else implemented
something similar somewhere else, it's still needed.

The change was actually useful to debug a clk problem, where the machine
freezed when a certain driver was loaded.

Thanks for keeping track of this change. I would only have noticed it
missing next time when I have to debug a similar problem.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3v5e3fxrzi2lvohf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGT6joACgkQwfwUeK3K
7AkHDQf/fNU67siXsSYQC23dj2owDqfmkFmWztn13/rUvRVqGma1PLhp5aYKfMPO
fzZ6PimB/ukOg/xl6bx0uJonshLVlZ0WRf/V7mooJuBQynNOwDd0vWiHsKlv521H
TZVYZ0YqLWSGiK2LDmFMoqwPiBXJDeQbwlOYU10PLLxdQYgwE5nPP4BLa66M/MT+
Z0pjzlQPwhQ47X7gvQra9rEA5NJltPCVvi6T+fECQwtFMfZoQ4Hi86cIZ7iIpVzx
TMwwQGirGKP2Z23zfCR3cnxhsabHxbKsPoSjfiv5mVBv8/7Yv74tsKPDCs0J7ARS
MUjK9UnbFPjO+aeotufGEtX+dmpB7w==
=lJo7
-----END PGP SIGNATURE-----

--3v5e3fxrzi2lvohf--
