Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8F13F186E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhHSLo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238449AbhHSLoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:44:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DF0361051;
        Thu, 19 Aug 2021 11:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629373459;
        bh=e3lEhURg/hiaUb35KU1h6MRMH1E0R15z8wlq3UiVLq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPsJpOklS9cft3N7j6zhJRUJEKu6LqlhSot5JArR0YYMwNX9phr7a2rZaCQFce4Th
         A+FAff0Jm2ITTdnvI6LDyOAEvGLhamY7fdAzKPpJC8oAibh4/o6WVdsObhCrUFBRGw
         YlnrwdV5eR08ODe+398DNcwijThRRJcrBvAzRpUtWYNMNgMbrNoroQRSKXEaribBNB
         uxYmV3JdMJmrxGNFfUPjBZI3kWH7VcQ2NAPtTaffBI4/FG+RIG4YRDKw4fRZmqRhPU
         ZqQt6OKiXFdTRqQNSCRr/5Ez74GuWi2/97Uk1HP2qpFZZO6b3myeVB2EwhC6qufdww
         j3oCIZ9q+KNrA==
Date:   Thu, 19 Aug 2021 12:43:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: Minor regulator documentation fixes.
Message-ID: <20210819114354.GL4177@sirena.org.uk>
References: <20210818041513.GA2408290@dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi>
 <20210818121709.GD4177@sirena.org.uk>
 <67f6596f54fd2ea168d71d0747ea4a521dda5384.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DXIF1lRUlMsbZ3S1"
Content-Disposition: inline
In-Reply-To: <67f6596f54fd2ea168d71d0747ea4a521dda5384.camel@fi.rohmeurope.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DXIF1lRUlMsbZ3S1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 19, 2021 at 08:06:48AM +0300, Matti Vaittinen wrote:

> I was thinking of that. I thought that it made less of a hassle with
> single patch. After all, both changes were doc updates - and I didn't
> think the typofix warranted backport or a Fixed tag.

> Could you please educate me & explain why would you have preferred two
> patches? (I see you any ways applied this so I guess there's no need to
> split & resend - thanks).

It's two changes that don't overlap in any way.  Part of the reason for
splitting patches up is that it reduces the cogantive load checking that
the patch actually does the thing described in the changelog, with two
changes in one patch you need to hold two things in your head at once.
The more trivial the patch the bigger the extra effort relative to what
they'd have taken otherwise.

--DXIF1lRUlMsbZ3S1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEeQ/oACgkQJNaLcl1U
h9AltAf9Ej13ZF+d5Wy72pVod8tcqx7VTXN7OhakcB6z16Z3La0hx/UncCmqrAdH
nBQOHdFkIU2sHqX8nJ5FAm5M38TvAm9g2yFBzzBWcGIJqRapDTYdpVpTDOA2hmng
y+RR6wdPXdp/E2N3iAurTpn/6DZESW2J54XXKLdI5Ky4EK923TUO+UE2iM/bTC7w
3v/NwGQOWCZAA5DwoTTHYOOgROJy+n3VEl/Ebk3+IWJqGd+pnisam+rQzgLI1+6m
+w8dzZl369pyFF26HJ26wGLT33DUWUbEaL7wk76VL3pxKgmryPZ0QlfLu4EBQJf2
U9WUfCnrxZN0RqH9UDKtn2TWYCLW1w==
=XLeD
-----END PGP SIGNATURE-----

--DXIF1lRUlMsbZ3S1--
