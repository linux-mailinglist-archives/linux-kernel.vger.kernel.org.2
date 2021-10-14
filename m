Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DA042DE7E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhJNPpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhJNPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:45:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC46C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:43:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mb2su-0002sB-Qj; Thu, 14 Oct 2021 17:43:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mb2su-00074v-0K; Thu, 14 Oct 2021 17:43:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mb2st-000453-Vb; Thu, 14 Oct 2021 17:43:07 +0200
Date:   Thu, 14 Oct 2021 17:43:07 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] clk: expand clk_ignore_unused mechanism to keep only
 a few clks on
Message-ID: <20211014154307.eb3y3sh5lca4426t@pengutronix.de>
References: <20210819121403.337833-1-u.kleine-koenig@pengutronix.de>
 <20210922081549.kit3lsek7lh6w6ji@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dh5ic32cncbw4ucf"
Content-Disposition: inline
In-Reply-To: <20210922081549.kit3lsek7lh6w6ji@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dh5ic32cncbw4ucf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Sep 22, 2021 at 10:15:49AM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Aug 19, 2021 at 02:14:03PM +0200, Uwe Kleine-K=F6nig wrote:
> > Allow to pass an integer n that results in only keeping n unused clocks
> > enabled.
> >=20
> > This helps to debug the problem if you only know that clk_ignore_unused
> > helps but you have no clue yet which clock is the culprit.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I consider this patch really helpful, it helped me to debug a clk issue
> without having to recompile the kernel for each bisection step.
>=20
> On #kernelnewbies I got some positive feedback for it (1629304050 < j_ey>
> ukleinek: nice clk_ignore_unused patch, I added a pr_err there recently
> to print the clocks that were being disabled).

Any thoughts on this patch? Would be great if it makes it into the next
merge window.

Thanks for considering,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dh5ic32cncbw4ucf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFoUAgACgkQwfwUeK3K
7Aktygf/cdio49GPc9UkYKY+3xrQTW8959xvhu4EU90eE3NquxbG6EbX82LLacD/
gzmrCE/3ZNaGEWkwjp2NQJZxlimjRA+RXqS3UsX2vXdBz0xwcOPVpx3HbJfzBdeN
uLh+ZHxTX7zeq7TRiaO1jbKzGdKa2f0VusXDTet9OChGBuZmXdvazdF0OQPbOk/K
tWvrLwDqEyEWR+6DkjxB8eI14eVHj0GwS+0gQuA+ZitdZE/J6cDEudWJhVCQq2oH
hRQcdIg4RLtNcCVoOuIpbW/xJpYrascLZzU+1BrlqvebDCRZtedqVdf5TqqO+AXt
Cx28VH+3r6ZLSBPq617FL+6IvYvPQw==
=QxHw
-----END PGP SIGNATURE-----

--dh5ic32cncbw4ucf--
