Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B3D41CD35
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346469AbhI2UJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346412AbhI2UJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:09:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17624C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 13:08:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVfrr-0006o2-DC; Wed, 29 Sep 2021 22:07:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVfrn-0005oh-9u; Wed, 29 Sep 2021 22:07:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVfrn-00030S-8f; Wed, 29 Sep 2021 22:07:47 +0200
Date:   Wed, 29 Sep 2021 22:07:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Eric Tremblay <etremblay@distech-controls.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
Subject: Re: [PATCH v2 0/3] Handle UART without interrupt on TEMT using em485
Message-ID: <20210929200747.vpymjmq6ssvltmh4@pengutronix.de>
References: <20210204161158.643-1-etremblay@distech-controls.com>
 <YB1UEHEPVQCAjsMO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t3hgl3lpu4nlbuht"
Content-Disposition: inline
In-Reply-To: <YB1UEHEPVQCAjsMO@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t3hgl3lpu4nlbuht
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Feb 05, 2021 at 04:20:00PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 04, 2021 at 11:11:55AM -0500, Eric Tremblay wrote:
> > Thanks everyone for the comments. I apply most of the comments on versi=
on 1
> > but there is still a pending point with the Jiri comment about the safe=
ty of:
> > struct tty_struct *tty =3D p->port.state->port.tty;
> > I thought about adding a check with tty_port_initialized() before acces=
sing
> > the pointer, but I saw some other places where that same pointer is acc=
essed
> > without further protection, at least from what I see.
>=20
> Thanks for the update. Unfortunately I'm a bit busy with other prioritized
> stuff, but I will review this next week.

I assume this fell through the cracks as "next week" is already over ...?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--t3hgl3lpu4nlbuht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFUx40ACgkQwfwUeK3K
7AkodggAoY+CelIz/suqEOF7jym9eQcdHO3wgmNhoA5A3z+B7LfLqBWt2QB35q3X
nl6xJeMttbCcMWkZLC0IpfzpOY6NUmmDK6VFhZ1DaOBFRSxje/HYb8OxhyL5af3V
NRYZmnKAu25D5X/TG26BqG2dkgwBbb8qMqSnz+RBP2iuvjLCjX/IggUVgHpBXgvl
PmSQeAE/H/NC1hsOgjKLBE1723dzQ7GOaWkYac1fiOnoWJgvGRIMV7Dwv53DcYKf
4D+MYFrXEBdI0kTGCAWpqN0SzBcWl/iEYstw9rwb+4XXD4ECJ+s7FAq8VsMWWy36
n7oXgeYy0On2l702iiyp6O7mHFPV3A==
=oPdo
-----END PGP SIGNATURE-----

--t3hgl3lpu4nlbuht--
