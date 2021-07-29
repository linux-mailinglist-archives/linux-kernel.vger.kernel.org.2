Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268D73DA33D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 14:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbhG2Mgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 08:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbhG2Mgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 08:36:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9006FC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 05:36:39 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m95H3-0002Cb-2x; Thu, 29 Jul 2021 14:36:29 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:f664:c769:c9a5:5ced])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 30AFC65AE58;
        Thu, 29 Jul 2021 12:36:25 +0000 (UTC)
Date:   Thu, 29 Jul 2021 14:36:24 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Defang Bo <bodefang@126.com>, Steven King <sfking@fdwdc.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] m68k: coldfire: return success for clk_enable(NULL)
Message-ID: <20210729123624.gw2ktvuhdaotrkbn@pengutronix.de>
References: <20210729122702.GA27150@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z2padepaomrj2ikt"
Content-Disposition: inline
In-Reply-To: <20210729122702.GA27150@kili>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z2padepaomrj2ikt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.07.2021 15:27:03, Dan Carpenter wrote:
> The clk_enable is supposed work when CONFIG_HAVE_CLK is false, but it
> returns -EINVAL.  That means some drivers fail during probe.
>=20
> [    1.680000] flexcan: probe of flexcan.0 failed with error -22
>=20
> Fixes: c1fb1bf64bb6 ("m68k: let clk_enable() return immediately if clk is=
 NULL")
> Fixes: bea8bcb12da0 ("m68knommu: Add support for the Coldfire m5441x.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--z2padepaomrj2ikt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmECoMUACgkQqclaivrt
76nZpgf/XFXnk5puhr7Vf4BxGNVoXpFguuy/Ecq4GjPi+95H4s6jcEx4F7byOm6p
5K0r9b2Vzy2FSZrK/PxDeizD+bz7AUwlmfxuOCnjwT/pX8NI0GYfPwYz5NXJHRBC
vvoyAffrbnk5eQfWE9hyQqutScrNYfzNPROybqG3xFzlHo8I3W3x+kwpkwe9HGY3
ku9W06rAkvyfSOxB44gQC8jTh1Zzi9gF7Z79g8bGZycAD437akJHgF6Yx57tXy/i
F2mheHzAbXukHmy9NFyH+ecq356D19IbIXRFsyhHrVRg0NOtyy3pRCBeOFHX58zp
o26r1+K7mZkWJmUU5px4k8dqXUr0oA==
=ytTn
-----END PGP SIGNATURE-----

--z2padepaomrj2ikt--
