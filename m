Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EE93DC5D5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 14:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhGaMFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 08:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhGaMF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 08:05:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69536C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 05:05:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9nk0-0006zL-DO; Sat, 31 Jul 2021 14:05:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9njy-0007dx-DI; Sat, 31 Jul 2021 14:05:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9njy-0001Ka-CO; Sat, 31 Jul 2021 14:05:18 +0200
Date:   Sat, 31 Jul 2021 14:05:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/5] nubus: Simplify check in remove callback
Message-ID: <20210731120515.xkr64yvnczchxz4s@pengutronix.de>
References: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de>
 <20210727080840.3550927-2-u.kleine-koenig@pengutronix.de>
 <d74ccd1-116d-9450-5ee4-8d5074998872@linux-m68k.org>
 <20210727114220.7drjl6xvvlwetaod@pengutronix.de>
 <4b44c8a4-7d2b-83d-60fa-2d4e4f8284db@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vbilniyjnxclcjn5"
Content-Disposition: inline
In-Reply-To: <4b44c8a4-7d2b-83d-60fa-2d4e4f8284db@linux-m68k.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vbilniyjnxclcjn5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Finn,

On Sat, Jul 31, 2021 at 08:32:38PM +1000, Finn Thain wrote:
> On Tue, 27 Jul 2021, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jul 27, 2021 at 07:50:39PM +1000, Finn Thain wrote:
> > > On Tue, 27 Jul 2021, Uwe Kleine-K=F6nig wrote:
> > >=20
> > > > The driver core only calls a remove callback when the device was=20
> > > > successfully bound (aka probed) before. So dev->driver is never=20
> > > > NULL.
> > >=20
> > > Are you sure dev->driver is non-NULL for the lifetime of the device? =
A=20
> > > quick glance at device_reprobe() makes me wonder about that.
> >=20
> > Not for the lifetime of the device, but as long as a driver is bound to=
=20
> > the device. device_reprobe() calls device_driver_detach() after which=
=20
> > the driver is considered unbound and dev->driver is assigned NULL. (via=
=20
> > device_driver_detach -> device_release_driver_internal ->=20
> > __device_release_driver)
>=20
> Are you saying that this situation does not presently apply to nubus,=20
> zorro or superhyway? Or are you saying that the remove callback will neve=
r=20
> be called in this situation?

I'm saying that if you call device_reprobe() the remove callback is
called before dev->driver becomes NULL. So in the remove callback it's
safe to assume that dev->driver is non-NULL.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vbilniyjnxclcjn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEFPHkACgkQwfwUeK3K
7AnV2Qf7BILAoOarGGMgGJE/VBtb9dxL6wS65ub8J+tDJRJgAEspQckXWjbJw4PL
yQcb8OoaGUT/dJ6ldoE+NWYIYSrxjDim24caDT0FWz3OLdjO635rtW/jSov1AHJd
TRvhp+rg2OfPc6lZKVru82B+pyIYladvWLrX752sVtRFZ+jB4+GXjpVW0kvioStj
Fv+cYA0kMrmoDdH/KjGOq7ygcTSKZwRWS4qMG3Bq0By8RjO7wnJ/mssY/VEw4DR2
IM3VWxjfcXyHZdIsFDp9Zg1DZjy80RLwsAuzWCIbAFOjA2ohHf6j0mnQfF/j8mO6
xHatOnJwJOA/hCYSpMjaX4n7kJAafA==
=mUBd
-----END PGP SIGNATURE-----

--vbilniyjnxclcjn5--
