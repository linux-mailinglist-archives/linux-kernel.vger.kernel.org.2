Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A592645A370
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbhKWNIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbhKWNIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:08:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AFBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 05:05:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpVTl-0007Qs-Le; Tue, 23 Nov 2021 14:04:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpVTl-000bH4-GB; Tue, 23 Nov 2021 14:04:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpVTk-0008Mo-8l; Tue, 23 Nov 2021 14:04:56 +0100
Date:   Tue, 23 Nov 2021 14:04:56 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V2] tty: serial: imx: clear the RTSD status before enable
 the RTSD irq
Message-ID: <20211123130456.7qohjyiq6bpaaah3@pengutronix.de>
References: <20211123104528.7781-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ff42tak3jtq2ieuu"
Content-Disposition: inline
In-Reply-To: <20211123104528.7781-1-sherry.sun@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ff42tak3jtq2ieuu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 23, 2021 at 06:45:28PM +0800, Sherry Sun wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
>=20
> Clear RTSD status before enabling the irq event for RTSD in
> imx_uart_enable_wakeup function.
> Since RTSD can be set as the wakeup source, this can avoid any risk of
> false triggering of a wake-up interrupts.
>=20
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ff42tak3jtq2ieuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGc5vUACgkQwfwUeK3K
7AmrpQf8Dt10VM1GBZwkRVw5qAQLTTft65QWMrwJ3WKNf5u70Ou2BGqRZ5fOX5+v
8CUWnS3CbFj87dCH0lHOB3ZSGgdBnwrxTb8Vrh6kzPy8iSeast4OjUPkLbCSGymG
FJej3Sz85+Mv9FzdcPpg9o01kKdvFHY1zwxD2CB3xk/pJuEBnQcvO7VLnHKUraVI
y0zU2EA2/f1IEReAua+zUD3MptAX6w/UgZ9wKb7xzWMrQftuUnkoAcFvXdBG4tsL
TRoxm085IzifqjO863IrpOjvGJOWceRgtjxzuF7hqipxkHll8TE7hn+hqDpa/j3e
JViTK1DA6Z7pfT7lPZbErEROHjTq0A==
=tSoe
-----END PGP SIGNATURE-----

--ff42tak3jtq2ieuu--
