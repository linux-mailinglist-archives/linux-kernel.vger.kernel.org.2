Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACFF35C6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbhDLM4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbhDLM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:56:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EE9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:55:53 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVw6S-0000K5-Ld; Mon, 12 Apr 2021 14:55:44 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVw6R-0002Vu-MH; Mon, 12 Apr 2021 14:55:43 +0200
Date:   Mon, 12 Apr 2021 14:55:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        billy_tasi@aspeedtech.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH 1/4] dt-bindings: Add bindings for aspeed pwm-tach.
Message-ID: <20210412125543.xhnitijeumddqdmn@pengutronix.de>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
 <20210412095457.15095-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="72zyimz3jwqrdzfk"
Content-Disposition: inline
In-Reply-To: <20210412095457.15095-2-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--72zyimz3jwqrdzfk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Apr 12, 2021 at 05:54:54PM +0800, Billy Tsai wrote:
> +  - Billy Tsai <billy_tasi@aspeedtech.com>

I object because the MTA at aspeedtech.com doesn't know this email
address.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--72zyimz3jwqrdzfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB0Q0wACgkQwfwUeK3K
7AlClggAkJzxzLk6CyBb65jTrLt6GHUVsNktatzSSRR+W6qXEyPzt1Snay/1HEex
EDQicnfgTL16yXBjHLHwWEqg7ek82wnO3I8weSNFcM9xs3J49dcGUnMII6gBCDFK
/UAD5sugnnHfDaaWDvj/OGT9uGQlPBtaA1LJBb6EGb4qeaSINwc77ySfzIqZyMeQ
R+I6nNRvID/fJYg6cbpe4AUgr+jBnZ9YFxkkMdKjl3Wz0Zy2p0nIoqBFl3H8/NFs
Xwk3HkIWwZ/M0YbVcBcHj4YVKC+TW47Pno+QGfmbTTxwBaTABKPkD2uTQOtg5Z5U
0KRgU0CZnI/F2/IhLd0Qiz+V57VnMg==
=x1yQ
-----END PGP SIGNATURE-----

--72zyimz3jwqrdzfk--
