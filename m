Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3409B41436B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhIVIR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhIVIR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:17:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C01C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:15:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mSxPy-0004LS-OD; Wed, 22 Sep 2021 10:15:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mSxPx-0003Il-Cp; Wed, 22 Sep 2021 10:15:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mSxPx-0004zO-Bo; Wed, 22 Sep 2021 10:15:49 +0200
Date:   Wed, 22 Sep 2021 10:15:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] clk: expand clk_ignore_unused mechanism to keep only
 a few clks on
Message-ID: <20210922081549.kit3lsek7lh6w6ji@pengutronix.de>
References: <20210819121403.337833-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s34zflirz6cxjcg5"
Content-Disposition: inline
In-Reply-To: <20210819121403.337833-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s34zflirz6cxjcg5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Aug 19, 2021 at 02:14:03PM +0200, Uwe Kleine-K=F6nig wrote:
> Allow to pass an integer n that results in only keeping n unused clocks
> enabled.
>=20
> This helps to debug the problem if you only know that clk_ignore_unused
> helps but you have no clue yet which clock is the culprit.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I consider this patch really helpful, it helped me to debug a clk issue
without having to recompile the kernel for each bisection step.

On #kernelnewbies I got some positive feedback for it (1629304050 < j_ey>
ukleinek: nice clk_ignore_unused patch, I added a pr_err there recently
to print the clocks that were being disabled).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s34zflirz6cxjcg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFK5jIACgkQwfwUeK3K
7AmWkgf+OQ5olI3IcVW3vwjRRsrEmQwZZ1Ilbn01AT2WFD6UWAOcVtdum/Jdlld6
R9Ib02OtzJTN415x4FZGQtignm13aAUgwONe7BEW3vroacDL7lX8O9l3VaSxbfi9
EkXTWR24KW+HOKYivj5B6eLG4sboBfKfwYakMwlapH6T1Mkm6XsfPH+v1Kuo+f8Z
iPrgfGbQyFhpoy6IOlnhLZaT6UtYERYZeb2F+gHogJtc6E7ct3lu6ZdO7AP1ZDgw
Y9fQU4fKgkUNTgK7fx4WI37kQRfoRNfgoYef6Jnqgwn9CXx4vjFSzrz6yHL4n2ye
phJ7tHaFEIyKle92crPC5CyhA5IVvQ==
=O65D
-----END PGP SIGNATURE-----

--s34zflirz6cxjcg5--
