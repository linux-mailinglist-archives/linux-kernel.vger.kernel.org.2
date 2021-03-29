Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5934D5AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhC2REO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhC2REB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:04:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F58C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 10:04:01 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQvJ0-0006TN-0S; Mon, 29 Mar 2021 19:03:58 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQvIz-0006VR-NZ; Mon, 29 Mar 2021 19:03:57 +0200
Date:   Mon, 29 Mar 2021 19:03:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <20210329170357.par7c3izvtmtovlj@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ilk36xqvfaxvav3n"
Content-Disposition: inline
In-Reply-To: <20210329125707.182732-4-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ilk36xqvfaxvav3n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 02:57:04PM +0200, Clemens Gruber wrote:
> The PCA9685 supports staggered LED output ON times to minimize current
> surges and reduce EMI.
> When this new option is enabled, the ON times of each channel are
> delayed by channel number x counter range / 16, which avoids asserting
> all enabled outputs at the same counter value while still maintaining
> the configured duty cycle of each output.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Is there a reason to not want this staggered output? If it never hurts I
suggest to always stagger and drop the dt property.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ilk36xqvfaxvav3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBiCHoACgkQwfwUeK3K
7AnRIQf/W5F4T5BkG5hwd2fJ5VZkg6UaAlvJQfjxLY83XqP3GfgxSNGGb5Wr6kZt
SciiIuQggfvOY7hIMJS9p8NcCRyMg39GSlYIuabQn/QjPOL22cfXsBe1w+oSTOxy
PbxbcM842qyGRXGHGQD/OTXK9rpFwsZdOTg3LlSAPh+oyXLbPYk/UImV7Pu+8Oe9
ViFMITfK0z0Gm2elPu5P4tAWfvQKdN5zCWsaF4TwG9LdjjTzsErhm1sg2bLdzIS5
3mrquF1ApuV3GnxywZrrq6WL6u9gZonLjSeFIzh1zrj9iFsA/Lr4OlHa1nF0e8aB
Sg+AcjNDbh/9iY/7flzedDV+v/TUuw==
=H/BD
-----END PGP SIGNATURE-----

--ilk36xqvfaxvav3n--
