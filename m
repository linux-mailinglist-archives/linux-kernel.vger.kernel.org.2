Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0839DBC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFGL4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhFGL4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:56:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0900610A1;
        Mon,  7 Jun 2021 11:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623066902;
        bh=3xG5H70gzAGJZa+uqO4tVIxQCBVUkYcKpQMuhAUcI5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cc1Gq7HPTo2dwV0SjdQGZrfxl9bIlIuuEg8y7kG4dk4h+SfLBdZL/f8qP/x1lxzYh
         FlZlquHZ9/UhEAWEWW0tBQ60OoOdl8rDHGD9LCEohKvOZonk2/u72GkIixOMsE0Xyg
         uLXcHgyZpDTU7YY46LrRo1YOlDY5ILdsqogo5UvYTWVAIef5CyVcHbU81wgKZcXSkA
         s1IuoUvTtqSL/F77UGHGmqGaZa5d2ZMzBMD6pqezINM40Y9QrO8UDnhyTkIeLNPqlU
         XCNLWP/ecTU/6PsuM4zXggLQasM4w35yMaFBmBgW1iMcFH4hOUW0W6rXhOW5g4bC9z
         NX0qMWLDLrnqg==
Date:   Mon, 7 Jun 2021 12:54:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Clause-22/Clause-45 MDIO regmap support
Message-ID: <20210607115448.GB5705@sirena.org.uk>
References: <cover.1622743333.git.sander@svanheule.net>
 <20210604172515.GG4045@sirena.org.uk>
 <8899fbf306051fa3cdd8bde92634de8134bce0fb.camel@svanheule.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <8899fbf306051fa3cdd8bde92634de8134bce0fb.camel@svanheule.net>
X-Cookie: While supplies last.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2021 at 08:16:53PM +0200, Sander Vanheule wrote:
> On Fri, 2021-06-04 at 18:25 +0100, Mark Brown wrote:

> > I think these registers are in practice going to either need to be
> > volatile (how most of them work at the minute) or otherwise handled in
> > regmap (eg, the page support we've got).=A0 Having two different names =
for
> > the same register feels like it's asking for bugs if any of the higher
> > level functions of regmap get used.

> This is actually an issue with a GPIO chip that I'm trying to implement [=
1]. To
> set an output, data is written to the register. To get an input value, da=
ta is
> read from the register. Since a register contains data for 16 GPIO lines,=
 a
> regular read-modify-write could erroneously overwrite output values. A pin
> outside of the RMW mask could've changed to an input, and may now be read=
ing a
> different value. The issue I was running into, had to do with a RMW not b=
eing
> written because the pin value apparently hadn't changed.

If the hardware isn't able to read back the status of the pins in output
mode (even if it's always reading back from the input circuit where is
it getting other inputs from?) you're probably better off with just
having an open coded cache separately than trying to make up fake
registers that rely on current implementation details to work.

> I didn't use the existing paging mechanism for this, since (I think) then=
 I
> would need to specify a register that contains the page index. But as I d=
on't
> have an actual page register, I would have to specify another existing re=
gister
> with an empty mask. This could lead to useless bus activity if I accident=
ally
> chose a volatile register.

This is clearly not paging, it would be totally inappropraite to use
paging for this.

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC+CQcACgkQJNaLcl1U
h9AE1AgAhMKUNF2DyiBOoBYa/DqxzE4ouOLjYKLw58GY7fnALqCkGtXCoa/+UBEa
NxWjLfRgRhwEk2+vksQhsXUi52MegM098o2eAU0jCEYwS2GlX4L3k0GSRUyxdzCS
RdBIiuhwp9p9NOKCclkKqgLkS7lUZQ1ZSS+DbkcnyYTaa5k0wHwRTicTclzJQw3P
iQVWDg2dzlhTG36n0oxtDKWTGVSTi5uh3OZSP60DyRtWyJthvITuN/zStIfEAA5L
u1Q1FLzETCZZn8KJDiFXHDOn3oIxBA7HBBMvoUicVrUnQWLBqEvaLwBzD27GxekZ
nI6jGbS9nqFen2h+LkitT5J69/dRAg==
=FcTV
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
