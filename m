Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8DF453B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 21:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhKPUzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 15:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhKPUzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 15:55:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9EC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:52:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mn5RW-0004Xw-JY; Tue, 16 Nov 2021 21:52:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mn5RT-000Kfi-CO; Tue, 16 Nov 2021 21:52:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mn5RS-0000B9-34; Tue, 16 Nov 2021 21:52:34 +0100
Date:   Tue, 16 Nov 2021 21:52:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        kernel@pengutronix.de, Colin Cross <ccross@android.com>
Subject: Re: [PATCH] pstore/ftrace: add a kernel parameter to start pstore
 recording
Message-ID: <20211116205233.m4j47haadkgdjdwh@pengutronix.de>
References: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
 <20211116120603.4e0c04c2@gandalf.local.home>
 <20211116172835.r3puikipzryxnsoj@pengutronix.de>
 <20211116123705.7f99e35e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lnrebxgfpmbxckuz"
Content-Disposition: inline
In-Reply-To: <20211116123705.7f99e35e@gandalf.local.home>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lnrebxgfpmbxckuz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Steven,

On Tue, Nov 16, 2021 at 12:37:05PM -0500, Steven Rostedt wrote:
> On Tue, 16 Nov 2021 18:28:35 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > > Is this still needed? It's still in my internal patchwork, and I have=
n't
> > > seen any responses. =20
> >=20
> > I didn't see any responses either, and unless someone else implemented
> > something similar somewhere else, it's still needed.
> >=20
> > The change was actually useful to debug a clk problem, where the machine
> > freezed when a certain driver was loaded.
>=20
> Perhaps I should ask this. Would anyone object if I just take this change
> through my tree for the next merge window?

I don't know.

(To be interpreted as in
https://math.stackexchange.com/questions/1884607/does-everyone-want-coffee-=
propositional-logic-problem :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lnrebxgfpmbxckuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGUGg4ACgkQwfwUeK3K
7AnVKQf+Lhg8MBQaAKlDoFpuzTEu2mw4B6b3iEPfUJlDcPJfvpvMSTw54/BTH+Hh
8a5pOyJzIDY0skgs1TL7498hY/x6J5kFvIBLBoUbwvlnP3aO45KxjmLVtNoLhkmd
slbAp7pNrvP+NlucM8MurYSk3c8SsMoq1Q5eXfaXGhnydsGvUwoP20v/eSTc9zR3
FMzErwSzdbmmzEq3n411ubeGhyXLAfwDf4gOAxaoXDcWoJVDiLOcT/L/P0XuF55p
18uWvl59QWP3Kz8/ZtTJZoRB9QPJXbSGIROiY7kP+NwT106g8l+iRWvg3ddnFJ08
cQwmyFHH36HnQXCiaqzE89tuZx/fDw==
=97OR
-----END PGP SIGNATURE-----

--lnrebxgfpmbxckuz--
