Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91C13CCF2F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 10:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhGSIKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbhGSIKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:10:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFC5C061768
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 01:07:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m5OJ4-0006eJ-8w; Mon, 19 Jul 2021 10:07:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m5OJ3-0001mg-CJ; Mon, 19 Jul 2021 10:07:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m5OJ3-0007V4-B6; Mon, 19 Jul 2021 10:07:17 +0200
Date:   Mon, 19 Jul 2021 10:07:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        kernel@pengutronix.de
Subject: Re: [PATCH v4 5/5] bus: Make remove callback return void
Message-ID: <20210719080717.7gbcs6jvjvasvum2@pengutronix.de>
References: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de>
 <20210713193522.1770306-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nssln74zoufx2rqg"
Content-Disposition: inline
In-Reply-To: <20210713193522.1770306-6-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nssln74zoufx2rqg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

[trimmed list of recipents]

v2 of this series got a few late acks that I repeat here to make b4 pick
them up when you take v4:

Acked-by: Wei Liu <wei.liu@kernel.org> (For hv/vmbus)
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de> (for ip22-gio)

(see
https://lore.kernel.org/lkml/20210715123636.ychn4zea2dltnwxg@liuwe-devbox-d=
ebian-v2
and=20
https://lore.kernel.org/lkml/20210715130221.GA10298@alpha.franken.de
)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nssln74zoufx2rqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD1MrIACgkQwfwUeK3K
7AnFBQf/eJaCPCQp5BDa65UaeyqXNzXHPAWe8G70Y7CWYszdMQ5ZYG4zDd6caHb0
XrOKwqL2RLPYWCRPDHKDqW/jm4+3xE4BUH+/bFhZUxAH9Ow1KXzd0PLtErz/Bvgg
13ZxfqOWfoc8YmN8ezvSCk9d+3EIwQXt7RuKQYl4fX2UGzoMdZVKh3VB2NEigJqc
67kW9g74Fcefa92pO8yxfu+mq536iUvHapgPBhgkwVb6VG73YFOSYMTQ4EasS0ov
A9hWZcbMs4jwUJz1abyisGeZQFHGVFJJ4axEcrgAtr2fCkClvxYrOS/UhMCGCmIH
fmavIHhwrsZ4CMWgkyX/0IEm4LY2RQ==
=tEa1
-----END PGP SIGNATURE-----

--nssln74zoufx2rqg--
