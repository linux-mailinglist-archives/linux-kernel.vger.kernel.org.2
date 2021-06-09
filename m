Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084463A1445
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhFIM0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232502AbhFIM0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:26:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4B4561287;
        Wed,  9 Jun 2021 12:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623241457;
        bh=U1MDs+UL5sFxn9c2FvbnP8LQunhPXbOYOAhMsgqr9tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQM/FiDFVkX7N6Iq421wceAlpVslKzZdjczMMp8hykQXNhW1nHccAygOJAOnUtlLm
         BOz46weyqsl8jSPrxtMrOMT3mfouBuGrt0FJB3Ud0Q2BnnQdIg+Ch9WOEHzPXSsgOo
         8Uhwv5UBG2E62aS6c/1laeccQI70ZwauFhtRr2rJGOIf+9pt89m+rnu9HBXpNtuBOq
         NrXaPqUd9DGsmsGzFXLELu1L/7wE+tWqt8iYWPPsyKfhilxKie/gPf+z8yQ8vk6q2/
         qr/V0ceIye1pbqu26JBx9IaUKvemXEswOAswHHIkBNuTttyb9uZl4A9YvgRXOkAqot
         kwJd7E8o2UAsg==
Date:   Wed, 9 Jun 2021 13:24:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/2] Revert "regmap: mdio: Add clause-45 support"
Message-ID: <20210609122401.GA20286@sirena.org.uk>
References: <cover.1623238313.git.sander@svanheule.net>
 <deed937f8fd63285e95acdfa8ca327638057811f.1623238313.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <deed937f8fd63285e95acdfa8ca327638057811f.1623238313.git.sander@svanheule.net>
X-Cookie: You have taken yourself too seriously.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 09, 2021 at 01:46:05PM +0200, Sander Vanheule wrote:
> This reverts commit f083be9db060fbac09123d80bdffb2c001ac0e2b.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> There are currently no (planned) regmap users for C45 register access.
> Remove support for now, to reduce dead code.

This then creates a bootstrapping issue for anyone who does need it - I
can't see any way in which this causes problems or gets in the way?

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDAsuEACgkQJNaLcl1U
h9CaLgf/X0SDbGif8QPn1Fi8PR61Ru6IqZin3ylBku6Aq5/WtjJPg6bqIYUG85+P
t1mP8Xtg+U1BqM6blak5a3i7ZA0lgRcvw7sa9Hi8lcGYkwfEbe3YDREKIagotw3g
9zDEU/158tNQQ3VBBQLeB6lyUQ7RJ1Z6VauRjF94g7Dt6HTPgVoHCR4hnes8+/hs
g8J1zHvJRgafL7NSrwW+ix4VZHJ7wNHdHHRnuHBjXWpMlBX1CDMLTZAnLToK+yC4
8aT5LHB+LZV5ZzHtq2I78jjuqpEY3UoXtYmLogxmYQGsexxye/5IKyqSNBSaM1tp
IASyI+iaFrMO0Xbrl/tEnQX8b1o2HQ==
=pr7F
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
