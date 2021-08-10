Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE843DD404
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhHBKlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 06:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231854AbhHBKlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:41:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B92060F9E;
        Mon,  2 Aug 2021 10:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627900854;
        bh=DSvgIx4J8JKOg4XXggMVa7s1UrkqGDWBAGiVCWCSJ4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHzmvqtcEqLSPKqPm3+sAmkHab6hc7Lq6m3VR1X5GlwJzz995Dx7KneRxEuU/SDcc
         kZTGSj4U3lXFkEDPsoU8yrtRdulO8dguNtU4tPI/QwgIo87U+MNjC70t9wLdodwYf8
         kOgwHhv8ZTIPApwMnspvIu8B+WS8i3RXEXJjSJ6s90g+2GLT6RZjsHiON4Y6zy+Ljr
         0BdzHzlSM2HUl4jLAkHtFG8EvTRlJevScSITi4l7hfxeZ3Cq/PW2It7dUvM9iPEv4e
         xm+KqVVmBf4LEZHvGbHXdxUEHQ3sGhiZnl4BsH90z4/Kfub4lUWSOcHoCbjuEyxcPP
         fxZkeMq87satg==
Date:   Mon, 2 Aug 2021 11:40:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Jon Nettleton <jon@solid-run.com>
Subject: Re: [PATCH v4 0/2] hwrng: Add Arm SMCCC TRNG based driver
Message-ID: <20210802104040.GA4668@sirena.org.uk>
References: <20210731204845.21196-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20210731204845.21196-1-andre.przywara@arm.com>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 31, 2021 at 09:48:43PM +0100, Andre Przywara wrote:
> The "Arm True Random Number Generator Firmware Interface"[1] provides
> an SMCCC based interface to a true hardware random number generator.
> So far we are using that in arch_get_random_seed(), but it might be
> useful to expose the entropy through the /dev/hwrng device as well. This
> allows to assess the quality of the implementation, by using "rngtest"
> from the rng-tools package, for example.

Reviewed-by: Mark Brown <broonie@kernel.org>

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEHy6gACgkQJNaLcl1U
h9Bqywf9EVanqIq47OwESeX1a5x5DLZ5KBiLRnOiL75URea8aWsz72lG6O6A9tBr
Zf4cPpH0ly00lyarQ6K559N9vZm5NAP9rGobOBsT8WxT4XCOVaAxMdxmfmsTNoFs
hZXlStAh0OcbH5vpYxmx5FA0wqkwco2rhzQmCzq/6tRoheMajWt5DBRcx7SNlH5H
AyB92bvnqihN4PnXInCFUNE+Dhzfd5bCqniB/sOBmIAOsg9fTtjdD/E/NVLGTgGN
lTLJI7Pt8KHv5P7/7FC/Nwb3IaCSVJfNinYdEo83ugvvNcd96dw92dr4lWXx1QRe
svHUca46A8lsLiJTWL/7dh3yIoZ9Fw==
=3gNq
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
