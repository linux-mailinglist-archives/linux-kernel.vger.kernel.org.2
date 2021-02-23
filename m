Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477A2322C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhBWOYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbhBWOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:24:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED14AC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 06:24:01 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lEYbS-0007HK-FP; Tue, 23 Feb 2021 15:23:54 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lEYbN-00015y-R4; Tue, 23 Feb 2021 15:23:49 +0100
Date:   Tue, 23 Feb 2021 15:23:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     dingsenjie@163.com
Cc:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>
Subject: Re: [PATCH] tty/serial:Remove superfluous "breaks"
Message-ID: <20210223142348.7wsgp4qdpkmkcmmz@pengutronix.de>
References: <20210223080630.44644-1-dingsenjie@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4rajsn7332ydbelk"
Content-Disposition: inline
In-Reply-To: <20210223080630.44644-1-dingsenjie@163.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4rajsn7332ydbelk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2021 at 04:06:30PM +0800, dingsenjie@163.com wrote:
> From: dingsenjie <dingsenjie@yulong.com>
>=20
> Remove superfluous "breaks", as there is a "return" before them.
>=20
> Signed-off-by: dingsenjie <dingsenjie@yulong.com>

You are at least the fourth person who sends this patch[1]. The things I
wrote in reply to the latest submission still applies:

 - the Subject is wrong, it should use a prefix similar to "serial: imx:".

 - I personally like the breaks for clarity.

 - If people agree enough to outvote me, please at least add an empty
   line instead of just removing the break to visually separate the
   cases.

Thanks
Uwe

[1] https://lore.kernel.org/r/20201026125142.21105-1-zhangqilong3@huawei.com
    https://lore.kernel.org/r/20201020130709.28096-1-trix@redhat.com
    https://lore.kernel.org/r/20201107140129.kpfhanzjidvdg662@pengutronix.de

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4rajsn7332ydbelk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmA1D/EACgkQwfwUeK3K
7An1PAf+KRAeBqmMbZhGgAEM0v7spL0lyXu9maeri0joayo1+9Ri4yDKIVXbqK36
OYazFmkD7mj+OmYaMyp++j0HYP8nZsnHk1VL+vbln83aJycrhL/dbheFpWUHQCna
ccVRn/QM/HP0FQ+awI7nePf2VUpIzx+QF211ZrvrOGgd+1lxbhm+rQOfI506yNyS
moRgn4FK2X4LIG5N0yfr3x31L6CTwVcyDIYgHBgUnrSquerA64dJtJQaxdoNStZF
6XevK2O4+qSABuX+VQGU/SWQGWPrWbTu5fYs5OhkP4zHW//DSTo0l+23+A5zTx8o
UmXHPqWySu8/5Th2cFacssJ7s0/68Q==
=GXNd
-----END PGP SIGNATURE-----

--4rajsn7332ydbelk--
