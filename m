Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC39C39D787
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFGIiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhFGIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:38:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F0C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 01:37:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqAkl-0007B7-4f; Mon, 07 Jun 2021 10:36:59 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqAkk-00061i-QQ; Mon, 07 Jun 2021 10:36:58 +0200
Date:   Mon, 7 Jun 2021 10:36:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] reset: bail if try_module_get() fails
Message-ID: <20210607083658.d7r52g7dwxyyckgj@pengutronix.de>
References: <20210607082615.15160-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wsftedyz2nptrgs7"
Content-Disposition: inline
In-Reply-To: <20210607082615.15160-1-p.zabel@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wsftedyz2nptrgs7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 07, 2021 at 10:26:15AM +0200, Philipp Zabel wrote:
> Abort instead of returning a new reset control for a reset controller
> device that is going to have its module unloaded.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

LGTM:

Fixes: 61fc41317666 ("reset: Add reset controller API")
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks for picking up my report from irc :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wsftedyz2nptrgs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC92qcACgkQwfwUeK3K
7Amjhgf9EqMIq7gcqmFNbO/sI5GgpRzMoz2K1Bv1j/RZQtM/5PM0YXuGi1+F4fd7
LTx3noCuSgEIYrTVuhiNpoFslfvJTwaaJVGdRtc0aT7Hnj0WiqkyeSqwiekzXOxN
OkYks6ATTMTGHj689QJVytNtgv3r6F6Kqw7+EzBWhCvkWk1UhJz0i+l5WZVW4Iec
ztqROmAJBLfBe80AD36/NQD04ua9iXbZwLd+D6/8UN9mUbZplxj7hSd73gNkwwGW
j2jf3UP9AjZRDwk529HHbLpWjXJx02A2qrTbSLxn8/f+oFaE6oT48CNIf51h7kAl
zS/dCPCoPNE5CoB91tDytjeORFAJmA==
=fnMr
-----END PGP SIGNATURE-----

--wsftedyz2nptrgs7--
