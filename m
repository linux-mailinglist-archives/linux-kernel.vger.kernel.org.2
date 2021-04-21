Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE831366E88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243350AbhDUOyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243716AbhDUOyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:54:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7156F6144D;
        Wed, 21 Apr 2021 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619016809;
        bh=Rq82vrOd0gGtOy0nf0E4TRqH3UGATYbb8m+uexVRy0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MTTRKc+JSEHj+29bEHr0Pxqz/90Yy9ivBF1MU/bLfASb6xep4eBXrQ7IpCtsTDWAz
         QUa/V0XcI0tV1WP4O2QXyZBYT2CsBl1rTiKb0RrRT1OpL1cCTdZK8wQUx8L8VsaraX
         TAp/SmO3Nnq3ulLPnulnecv2R8rJ5AQiugkeWNTZ88qF+7RCbF0jvw5gH1raoXZhWC
         +p6AB8jxFPF868Q5hmcIaueYpE6wGUUrcGTvWDG9qVJEw0VBUKVmsiA0mnA/ptWu9n
         4fAaeoa6rrcxQrWCehlI65g9IpzgKPEii32qvkFeVO4xG5rSTmrcRfYHwLGs5sd5sM
         3KGo5se5j4vHw==
Date:   Wed, 21 Apr 2021 15:53:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Fritz <chf.fritz@googlemail.com>,
        Axel Lin <axel.lin@ingics.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: bd71815: select CONFIG_ROHM_REGULATOR
Message-ID: <20210421145302.GA36124@sirena.org.uk>
References: <20210421135433.3505561-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20210421135433.3505561-1-arnd@kernel.org>
X-Cookie: TAILFINS!! ... click ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 21, 2021 at 03:54:27PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The newly added driver is missing a dependency as shown by this
> randconfig build failure:

This doesn't apply against current code, please check and resend.

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCAPE0ACgkQJNaLcl1U
h9A/dQf/Va+7veGjMI0j2RhiLcRsN27pXRkckAe47ZwNHKMVHVHnlhVXfl/uEu8y
o4Ko/aukXbnefdIJ3EfDKplQOhJPaWmpkwgyPBepQd19zZWC5PgzBpna3ixobJB0
fNLCsDoQc5BzKQGeyDCg5uPZGRsOcvyM8cK42jEjAof2ziMsZ5y1Jn6PeFDoyo78
LAGsJ5K1awXP9Ni/npEot+wIXLX97fE2YHHxGxeW2ClOxKze5LQYnzpwsKh+5PpK
XPPlJf1St6rHnipXcv9VOcUOrSOIeb6zNjL/Tg5YMibwvVQkP4LR7DVnn3qClTwu
tkjbn4OUVo1GPcBVCoTna/s2o52iUg==
=+Flc
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
