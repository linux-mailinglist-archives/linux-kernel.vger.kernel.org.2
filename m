Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898893D747A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbhG0LmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbhG0LmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:42:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A10DC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:42:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8LTZ-0008Fl-7Y; Tue, 27 Jul 2021 13:42:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8LTY-0006DO-EJ; Tue, 27 Jul 2021 13:42:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8LTY-0004no-DN; Tue, 27 Jul 2021 13:42:20 +0200
Date:   Tue, 27 Jul 2021 13:42:20 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/5] nubus: Simplify check in remove callback
Message-ID: <20210727114220.7drjl6xvvlwetaod@pengutronix.de>
References: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de>
 <20210727080840.3550927-2-u.kleine-koenig@pengutronix.de>
 <d74ccd1-116d-9450-5ee4-8d5074998872@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3qa463uuge64uyhr"
Content-Disposition: inline
In-Reply-To: <d74ccd1-116d-9450-5ee4-8d5074998872@linux-m68k.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3qa463uuge64uyhr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 27, 2021 at 07:50:39PM +1000, Finn Thain wrote:
> On Tue, 27 Jul 2021, Uwe Kleine-K=F6nig wrote:
>=20
> > The driver core only calls a remove callback when the device was
> > successfully bound (aka probed) before. So dev->driver is never NULL.
>=20
> Are you sure dev->driver is non-NULL for the lifetime of the device?
> A quick glance at device_reprobe() makes me wonder about that.

Not for the lifetime of the device, but as long as a driver is bound to
the device. device_reprobe() calls device_driver_detach() after which
the driver is considered unbound and dev->driver is assigned NULL. (via
device_driver_detach -> device_release_driver_internal ->
__device_release_driver)

> > Apart from that, the compiler might already assume dev->driver being
> > non-NULL after to_nubus_driver(dev->driver) was called.
>=20
> I don't understand how a compiler can make that assumption. But then, I=
=20
> don't know why compilers do a lot of the things they do...

Ah, you're right, there is no dereference in container_of, so I might
also be wrong here. I will send a v2 without this last sentence in the
commit log.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3qa463uuge64uyhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD/8RkACgkQwfwUeK3K
7Aly9gf/X/9+HHgTAce8RPe1LYj8/3GYbuadCfJ0vOWrFRpxQOdRflGtxFeRhvIl
4+BchXWByjjnMCH6jkZVgyMdSZQRmHTA266AWnOu4xW+ujr+qX+hlcyFD4p6PI/c
xFM1HnW8EZESlb/8vbXSNLMMI6e9QbMVXVgNEgyiXNmXhCAW9lL1c8lqop8XS8rB
d2xvZ35+qVAryL83AjAI74nIOtx99/vrdWZqEMjPQJQS/owTV8hG0UFzKZkjf9bt
1fiI0u+n3RIHM+rkOLABH9v1lfQZvqQJJHv+jtO06yzHXRuoUS6TEchO3xPyQjot
uy+j3AhFCJQ8sAyp6f7/tDfROgtB8A==
=lQGM
-----END PGP SIGNATURE-----

--3qa463uuge64uyhr--
