Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE07455F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 16:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhKRPXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 10:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhKRPX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 10:23:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12FB86126A;
        Thu, 18 Nov 2021 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637248829;
        bh=cMcvKYH5LkNoIqxLg+suH/3z91LsgDq2BGWCMh42s7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiA9e11LlrVx0CeXHKB9NyrOdT2bT2e2Ld0n3O63SUwFSHcQZgPHPPwqoaJeNIL9g
         s06WUfMsCwrYiO8wPmh/WcHiH7FHLhNID2uC6U9lmBZCqcfXelxpo88Y20gdoSAGln
         7DEyOT1WrEz539LXo9CjBG83z/tYMIY6aGb5op5pyxdDUJ2oe/NADhAoijlA8I+dij
         riKM0dWScrLPyonFqf0V+XjYq3pmUiKGbUJ8n+Pgxsy2kwjG0PGiBPTWgmVXvtaRau
         DTYX1pzKctww/LGXgARJ715lQYdbEl1ZKwggkushrFeQS2UMB2NdD1fQuqjLsjJUIq
         hLNQ4lceokCJQ==
Date:   Thu, 18 Nov 2021 15:20:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] regulator: irq_helpers: Allow omitting map_event for
 simple IRQs
Message-ID: <YZZvOdci9Y9p1gJq@sirena.org.uk>
References: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
 <2a5d9589c1c76ce537f795ee0aa6d3a7a6093283.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
 <YZZWh1aIg7TAdOUX@sirena.org.uk>
 <f5a5cd1c-763b-4dc1-e40a-dafbc47a1eaf@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MizyrGJg3EpOEaYN"
Content-Disposition: inline
In-Reply-To: <f5a5cd1c-763b-4dc1-e40a-dafbc47a1eaf@fi.rohmeurope.com>
X-Cookie: People respond to people who respond.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MizyrGJg3EpOEaYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2021 at 03:14:02PM +0000, Vaittinen, Matti wrote:
> On 11/18/21 15:35, Mark Brown wrote:
> > On Thu, Nov 18, 2021 at 01:48:26PM +0200, Matti Vaittinen wrote:

> > This isn't the usual pattern, normally we would have the driver assign
> > the helper operation.  We can always still do the check based on finding
> > the expected map_event set up.

> So, do you suggest that we export the map_event_simple() as a helper=20
> which drivers can provide to irq_helpers? If yes, do you think we should=
=20

Yes.

> leave out the sanity check regarding the conditions (only one common=20
> error and only one rdev)? Or should we compare the given map function to=
=20
> the adress of the map_event_simple() and perform checks if it matches?=20
> It looks a bit strange to me. Or did you have some other vision?

I don't really mind either way on the checks, they might help someone
but on the other hand having them based on a check that a particular
helper is used is a bit odd like you say so I wouldn't mind if they
went.  I don't really have any other idea for doing them.

--MizyrGJg3EpOEaYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGWbzgACgkQJNaLcl1U
h9COEwf/YCY4pG213wFZiBzGOlNoyh8EKjOjZXApAqx9aS3C88qsPJhu6OQqQ09P
+mP5YWIApRtGHM2ccCkTc85aq5DUqaVnrfJBRhxg2I47xx6ydRjB7iYseL5Q1gvn
V5aSgnRrTytacaRUrSK5jFgL9VLOvT2+NAZjiW6fFejWivGxZLsDQboLLnZscnKw
2YdnwLl6MefqDX8hlzP93iuZX+z5NGAPlCT0BrVJPLbPx48thEl8oGu79lcC2SLE
WqpdJbADJdlu/HaQQ6gK92QdlDG5P4vnL18gmU4Y9qysjiy/mPb9nRQJkWC01hHK
txzq+J2CeB611hdaGNRWcpalKACYyw==
=m/0o
-----END PGP SIGNATURE-----

--MizyrGJg3EpOEaYN--
