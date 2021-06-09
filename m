Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8146C3A157A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhFINZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236226AbhFINZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:25:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 681F66124C;
        Wed,  9 Jun 2021 13:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623244998;
        bh=qZZ54d39TiFbhQpE8H0JV/13poWZQXPY6mO/t430Wl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNhiXuREgICawyLWD1zL1HTuRIkpMd87vjH3N2YhXlgQGVrZ1qNo/XjRxnTna0H2J
         qhy0ScV9Nof7F6ioAsHpHS9ZwXZH84sc421wPusFtegrsYGFX157afWCXzEgpP6G0R
         pV4BIP04aAJe/hM6XTxBMDXcN9eBJk6Aomw+diSSVTJVikBhdIE6HfFTN20dUHTJY/
         A2Mr3UPYvCCDIpwpbA7ntcGnP8RtaVns7bPI0Mhicara3PhHNPZrp/ndDjZwbT7kkD
         SnERnQJFbU/idzwHg1UK1J0er1fqxglfMj634KoKt427mtOQVG+BeDABslwvugs6DM
         DbqXvWmmWFsxg==
Date:   Wed, 9 Jun 2021 14:23:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/2] Revert "regmap: mdio: Add clause-45 support"
Message-ID: <20210609132302.GA9596@sirena.org.uk>
References: <cover.1623238313.git.sander@svanheule.net>
 <deed937f8fd63285e95acdfa8ca327638057811f.1623238313.git.sander@svanheule.net>
 <20210609122401.GA20286@sirena.org.uk>
 <ba7ef002d610ff5b5fc2c31411a1009587e2f068.camel@svanheule.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <ba7ef002d610ff5b5fc2c31411a1009587e2f068.camel@svanheule.net>
X-Cookie: Marriage, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 09, 2021 at 02:42:06PM +0200, Sander Vanheule wrote:
> On Wed, 2021-06-09 at 13:24 +0100, Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem, this makes it easier for people to identify relevant patches.
> > Look at what existing commits in the area you're changing are doing and
> > make sure your subject lines visually resemble what they're doing.
> > There's no need to resubmit to fix this alone.

> I had grepped the commit log for other reverting patches, which also appear to
> use this style, but I didn't check the regmap-specific ones.

There's nothing in submitting-patches.rst which says to skip the usual
process for reverts - the fact that people sometimes apply things with
non-ideal subject lines doesn't mean it's best practice.

> I'll submit a v2 that fixes __regmap_init_mdio, and also applies the address
> checks to C45 access.

OK.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDAwLUACgkQJNaLcl1U
h9BSFQf+JeEFVyZ7fyAaVO2H/zrC6fiFqlCxCWYdv5dUWhYcTFtfUlP9eJ6I8jRz
3n5iv8LX65jDTceUDaTdB0pwUS83l9xqOGSKKGI+cMXGXVuNl6pkYJ7pK4o3GYsM
CoOFj9KB1KjLwtRBQ545BxkOHszNzH+GIfPyEmJdfxPuYzktm9/0E51txUjX7oX/
huMeFjGgyBQKDg2S/CjRtn74b0Thc6L5tHs/T2vxKv3VzXSAnCxfKS8bscWdXGMN
y+OlgI/NyJ0+WXriaajQjGNg7R04YeGVUpXotAd7D/g7XzVv4uju5CCefFqDFp3E
kf/oWZY2xVCm+edyE4T1ftUgA6Ajgg==
=kyPO
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
