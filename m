Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC3E3DD0CF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhHBGwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhHBGwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:52:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BD8C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 23:52:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mARoI-0008JH-60; Mon, 02 Aug 2021 08:52:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mARoH-0003Xl-0D; Mon, 02 Aug 2021 08:52:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mARoG-0006s8-VY; Mon, 02 Aug 2021 08:52:24 +0200
Date:   Mon, 2 Aug 2021 08:52:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 1/4] nubus: Simplify check in remove callback
Message-ID: <20210802065224.n2tarfx6hzfamdyp@pengutronix.de>
References: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de>
 <20210730191035.1455248-2-u.kleine-koenig@pengutronix.de>
 <dd248ad3-87b-ead8-957d-aea36cb01058@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5fojauxrhuxtr35u"
Content-Disposition: inline
In-Reply-To: <dd248ad3-87b-ead8-957d-aea36cb01058@linux-m68k.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5fojauxrhuxtr35u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Finn,

On Sun, Aug 01, 2021 at 03:04:03PM +1000, Finn Thain wrote:
> On Fri, 30 Jul 2021, Uwe Kleine-K=F6nig wrote:
>=20
> > The driver core only calls a remove callback when the device was
> > successfully bound (aka probed) before. So dev->driver is never NULL and
> > the respective check can just be dropped.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Acked-by: Finn Thain <fthain@linux-m68k.org>
>=20
> BTW, aside from nubus, zorro and superhyway you can find the same pattern
> in many other busses. You may want to patch the following methods too.
>=20
> acpi_device_remove
> apr_device_remove
> ccwgroup_remove
> gio_device_remove
> hid_device_remove=20
> ibmebus_bus_device_remove
> macio_device_remove
> memstick_device_remove
> ntb_remove
> pci_device_remove
> pnp_device_remove
> ps3_system_bus_remove
> rio_device_remove
> slim_device_remove
> soundbus_device_remove
> ssb_device_remove
> tifm_device_remove
> vdpa_dev_remove
> vmbus_remove

Did you find these by hand? Or using a coccinelle match?

Anyhow, thanks for the list, I'll add it to my todo list but if you're
motivated don't consider these cleanups as my property. (Please Cc: me
though to prevent duplicated effort.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5fojauxrhuxtr35u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEHliUACgkQwfwUeK3K
7AmrvAf9Gj/ycetiy4CpnD54L0WCnwWHBfM5j7ugv1yT8W21V/oUlqs7OjPF16i5
gEPGZ4tYdiOd89M++P7zgfVWSnD3XDpdRfP9hgJu30KrUyUz8hQi3Y3caGaSzx3Q
aTP4I3v94qeRRR79t0ckMqw/wnCH+UsdODv0dUxfChw9udvY9XufHfov3WSiL0ep
e3CJn3im7m+znXugiQchPaO8DZ5anT/rW0Y9gvCMqeh0vlO4lnM5ut5p7iYh275E
rHpQb5eoehumjDLuP5o8wG/U9O0caRG64Usgaq+9oCrBvL7w1GumI2B9WeaTezdO
NNn9NnWx9YLgUnrN0gEdujSGYHqFFQ==
=iJUA
-----END PGP SIGNATURE-----

--5fojauxrhuxtr35u--
