Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD90945A385
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbhKWNTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:19:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235664AbhKWNTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:19:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E178860FE7;
        Tue, 23 Nov 2021 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637673373;
        bh=q5aZR96jnTB2l0bMhRdAixmuwxPR6NrPz6OV1iqoeDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqqby0l8iIJ+KPPE3VrACpPiqzWJyc0lB6JH6e6q2w4jA4tWOalQL2Ifm6u2+oNCl
         NU2HXpPxAhK95CoEmUSkPCm2VO9LLk4UBXLNV0BDn/BO17WxXe7NdukUwAdCCMZky+
         y5EOyGiMYctY53lznnjuNtKUrfDSkqv724qI6jiDIjJ9pBjEBj4Yz0U7YrpNnGy5ld
         Z69DmzwbOOx3yYvIrDY/k5oprxgFrrbPRbCt5n2ZD4QeklQ3WtDZUKu0CHJ+3KOlZ9
         ce50fuzQId+WbOHlsFNZh4y6wpmwvOjQnpEj6M/JaGNciqNMmBh5HdQswkafbqp1ik
         w01qBqasCnReA==
Date:   Tue, 23 Nov 2021 13:16:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH 1/2] DA9121: add DA914x binding info
Message-ID: <YZzpmPfnZ/I2ZdZk@sirena.org.uk>
References: <cover.1637669927.git.Adam.Ward.opensource@diasemi.com>
 <49e5f47c79c0fc1d2b52ffdf7f5872f0adfa5ba5.1637669927.git.Adam.Ward.opensource@diasemi.com>
 <YZze1uynsB+d1YWx@sirena.org.uk>
 <VI1PR10MB316716A5C73693A95EE120F3EC609@VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8lYysKkgiV4LEiCQ"
Content-Disposition: inline
In-Reply-To: <VI1PR10MB316716A5C73693A95EE120F3EC609@VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: A closed mouth gathers no foot.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8lYysKkgiV4LEiCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 23, 2021 at 01:06:23PM +0000, Adam Ward wrote:
> > On Tue, Nov 23, 2021 at 12:30PM +0000, Mark Brown wrote:

> > This is removing the existing DA9140 compatible?

> No. It's never been recognised in the driver itself and shouldn't have been there.
> Detritus from an obsolete test.

So by "no" you mean "yes" then?  In any case you shouldn't be putting a
change like this in the middle of an unrelated commit without mentioning
it in the commit log, if you feel the need to remove this compatible you
should make a commit doing so.  Please see submitting-patches.rst for
details on splitting changes up.

--8lYysKkgiV4LEiCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGc6ZcACgkQJNaLcl1U
h9CDXwf/Qy02pcVJe5qcNOHJPPhiIYoYythiM6O3Z7eu/5tH2Ln5hraZabNbVq6w
JndWc9OsYSg3k3W5evxxIUfxRxAt/c978i9HOh+5JfCTtZ9BkPuJKgDSZzFS7zFO
XBsuLcSfcnkR7Pf/9PdT8TjNxq2j3nDYGRpyO9flp3xd+cjhG1hJ4DJZPGgqnDoI
4LvxmL1esoxgNLmWvQH3lbqZ44vEEJ0tBWBkfy48f4m9G49YSHjGWrjY+RhyGSsU
RTmItMtDN8N7HoXvd3c2S5P0EeIOFEXL8cBaaNAOPHeIfF1axE3ZxHsBZn97EpWo
qaKko1Vwc3Q17mjRHjSVt/tm7UJzIg==
=AArH
-----END PGP SIGNATURE-----

--8lYysKkgiV4LEiCQ--
