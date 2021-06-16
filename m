Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926F13A92FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhFPGq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFPGqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:46:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35068C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 23:44:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltPI7-0001bY-AI; Wed, 16 Jun 2021 08:44:47 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltPI6-0005yW-Ng; Wed, 16 Jun 2021 08:44:46 +0200
Date:   Wed, 16 Jun 2021 08:44:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thorsten Scherer <t.scherer@eckelmann.de>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 1/1] siox: Simplify error handling via dev_err_probe()
Message-ID: <20210616064446.l76d7evhgf55iy52@pengutronix.de>
References: <20210616061736.3786173-1-t.scherer@eckelmann.de>
 <20210616061736.3786173-2-t.scherer@eckelmann.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="teiijl2r32naonrj"
Content-Disposition: inline
In-Reply-To: <20210616061736.3786173-2-t.scherer@eckelmann.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--teiijl2r32naonrj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 16, 2021 at 08:17:36AM +0200, Thorsten Scherer wrote:
> commit a787e5400a1c ("driver core: add device probe log helper")
> introduced a helper for a common error checking pattern.  Use it.
>=20
> Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

@gregkh: You used to take siox patches, can you please do that for this
patch, too?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--teiijl2r32naonrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDJndsACgkQwfwUeK3K
7AlTQAf8DIpwKHYPH8UQlY/XbHO/6gVtd8dwnMt0pP1zLYJCYuR7LK1DqXNNbTYU
wzPiP2K6Klfcsl2RuXl9RMeY56G1dLAkmpIX0JWX8xnHV6iR2nDnIKDGAMdoc+OT
apggAf/V+5xTjhNTz/pHrJZEh/8ep7sOv3v9ZbSAgkn8YQIbPK02YTZG1d9s5Oh5
Pcy2mU/++bwLUw5tQ+VOWj6bPd6Sr6Ox4ArhlKJMnKFo5fNvffBa1Swd5AiVDalK
rjM9SNDX5yTHHJFRPDTukcuOa5gtE2XchSN1i6JSsK+UTt167TYNreOv1/m+yXJc
Bo41HOWiaRegyjupI+1k3WN7DOkXhQ==
=/3vF
-----END PGP SIGNATURE-----

--teiijl2r32naonrj--
