Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45493D3B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhGWNZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 09:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233663AbhGWNZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 09:25:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EAE7608FE;
        Fri, 23 Jul 2021 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627049169;
        bh=aOlW7HflLLCB43LLa1QBe7XH3wZ0g0g9L9bhVoxp6OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCgPkn06oMpesYXjNUonsk8Oee7bC8Zioxog0T7k3BHdW9g8fFGAVP4NOg1/01Hat
         khE+bqmg/0Yi/2JI0uTGZ4KXAO6P5NnljWbhhGMDdK1Nexoa09fuRb/z5O4YlG0sCq
         DzViw2a+XjG3bVb0ByMSSFr2YDfyqMwQ5Zetl3p+IE7cgj3Kbs91XBCqn9ubpvkek+
         C4QIua1dVqNK3jPPBtMSl3c1g1JJq/lFPjSYGIfWeplLm9mcsm7XVRhuSL/plD4Rzu
         xz27MzUyjNBY0UqhDM+FsXfLuYWrF4eB+kqJU50zh+onyDGVjgJgc4iGnuXp+XG47k
         w7Msjxyf+eNDA==
Date:   Fri, 23 Jul 2021 15:06:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: Duplicate calls to regmap_debugfs_init() through
 regmap_attach_dev()
Message-ID: <20210723140602.GE5221@sirena.org.uk>
References: <eb27b79ce46bde0202a4e7b047a3aaec8338fb6d.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EXKGNeO8l0xGFBjy"
Content-Disposition: inline
In-Reply-To: <eb27b79ce46bde0202a4e7b047a3aaec8338fb6d.camel@ew.tq-group.com>
X-Cookie: Integrity has no need for rules.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 19, 2021 at 03:53:38PM +0200, Matthias Schiffer wrote:

> With recent kernels (observed on v5.10.y, but the code doesn't look
> significantly different on master/next) I've seen the following message
> on boot on i.MX6UL SoCs:

That's not recent but anyway...

> It seems to me that there is no correct way to use regmap_attach_dev()
> from outside of __regmap_init(). In particular on a syscon regmap that
> may be shared between different drivers, setting map->dev looks wrong
> to me.

Yes, trying to set the device on a regmap that already has a device is
not a good idea, if the syscon code is doing it transparently as part of
lookup then syscon users shouldn't do it by hand.

--EXKGNeO8l0xGFBjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD6zMkACgkQJNaLcl1U
h9DdOQf+IFCCmuyjvdU07qtZveGKpzQ3rYjXfzpvmcAgUP45gWCpomIlz2rSQjcS
bUHdGQ/pUQNx7IY7NjbMJrCi2EiolGihLU7WB77VhT1tHItzx2MtohzpC/Q5veSm
t2YZHAW85GOsqM6OfSbled1s+J8jD+Gsn1iz5sDcbKtIRDq0DaYtD1Peh+etW3SB
P9bYqQNBhDYbTVYohISzRarAerdUSNd3DfmTrFjVbdsvAonRAKTGTcA89rTonTC8
5PdIuQ2bxdvwj53w1N+Kox6/0TH9wDAzHdSsCQmWL/3bUdwFutX6RF8SWzoY3U/W
qrCXBWuT2Jfze14QuArNDg6a96UBOQ==
=43yC
-----END PGP SIGNATURE-----

--EXKGNeO8l0xGFBjy--
