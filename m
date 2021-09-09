Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2F40595D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbhIIOnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244637AbhIIOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:43:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32323C0386D2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 07:12:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOKme-0003qp-6F; Thu, 09 Sep 2021 16:12:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOKma-0008Cv-Lj; Thu, 09 Sep 2021 16:12:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOKma-0006dK-Jq; Thu, 09 Sep 2021 16:12:04 +0200
Date:   Thu, 9 Sep 2021 16:12:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: scoop: move EXPORT_SYMBOLs to follow their funcs
Message-ID: <20210909141204.bixmhjlsupb73iuz@pengutronix.de>
References: <20210727130547.141310-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ewqlok4q65lkdrlt"
Content-Disposition: inline
In-Reply-To: <20210727130547.141310-1-wangborong@cdjrlc.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ewqlok4q65lkdrlt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jul 27, 2021 at 09:05:47PM +0800, Jason Wang wrote:
> Usually, EXPORT_SYMBOLs should immediately follow their functions or
> variables.
>=20
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Unless rmk objects I think you can send this to his patch tracker.
(https://www.arm.linux.org.uk/developer/patches/info.php)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ewqlok4q65lkdrlt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE6FjEACgkQwfwUeK3K
7AmaFAgAg2yqYdNuzfJoYpEYmr1V7TgGV0VySbNbKJVoMc/d5XZH1ZbS8cUjzT8U
TisGnbExvUvyfDpgTEEne1V9VHAn9Qe0ODwHk7XvsBYupp7pRZ7zsPbzEhSKxQ48
7jKtEWGeNZaXLYiXS7geQvCV+yabtCKJfcjgylYpi2povvHHsw9UztB1kt6sZjHt
MYPbTKOpaK08ZoZpUsN9NYjB6gSOjmQ4X6LGU3n9B4Pz5Ke86Mbesgett7BcwYCc
p1n2JQoemPyc+b1F6LIDPyGHKtfo/U3perJdIMCBnM396APzBVwg7YOtMNcd5+5K
BzSDAIyi4pkzXOgf5gXOm60t5y121Q==
=Uw9m
-----END PGP SIGNATURE-----

--ewqlok4q65lkdrlt--
