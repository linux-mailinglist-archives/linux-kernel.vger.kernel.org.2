Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837583F77D1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbhHYOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241879AbhHYOxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:53:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A37A5610CE;
        Wed, 25 Aug 2021 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629903180;
        bh=Ny4c5rNADRMZ/j+L4vt+4ELwpZlSHorximr3vmfw2wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYDglXzkY2lrkunRtfOvEGBcpqs6i5OS9BTj8UvR1mf8i+Asjb4Ti5WS0YTgSMbgt
         8+p6sdoarjPbT1ufltbw+qOc7Mq9gZqdaJ3cjC7BZBvpBKHUozbu+Jf9golVAZ6F9E
         uMAKFsRgHLQlOXpjGrKnFdWJYE7BhiX63gIsr2gPuF5UmZxQfMFI9vB+5U0uENdzez
         Bnjha1AYoLAZ9Z/o8ODkq8hJvPAM5wkTI03Td/7s0PwqF8ljpb1kxXLA4aszC0Nd3G
         oeLAd8Qt9esTWNbSAtnSe8RkJIeK+iNP5nUanH6dNQyaCSXSZZY/tW72MQ+/4I3bAl
         kfi39ymRsnqlg==
Date:   Wed, 25 Aug 2021 15:52:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
Message-ID: <20210825145232.GI5186@sirena.org.uk>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <CAHp75VdHpjbjz4biTP11TKT6J+7WQi-a1Ru3VLuSxM5tSLCB3Q@mail.gmail.com>
 <20210825113013.GD5186@sirena.org.uk>
 <CAHp75VfKJgux8k_mPauYB3MHcEOcnnzhSpoUDi4mVFDgtmNXeg@mail.gmail.com>
 <20210825131139.GG5186@sirena.org.uk>
 <YSZMxxJ76vF316Pi@pendragon.ideasonboard.com>
 <4ac0acb9-83ea-7fcd-cde3-669ba3b699c6@gmail.com>
 <YSZSOZXxSac307/A@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y96v7rNg6HAoELs5"
Content-Disposition: inline
In-Reply-To: <YSZSOZXxSac307/A@pendragon.ideasonboard.com>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y96v7rNg6HAoELs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 25, 2021 at 05:22:49PM +0300, Laurent Pinchart wrote:

> a very large number of regulators, it may not be too bad in practice. If
> I were to maintain the regulator subsystem I'd probably want a
> centralized implementation there, but that's certainly a personal
> preference, at least partly.

We already have some generic platform data for regulators so if it
doesn't want to define anything custom all a driver has to do is forward
that struct on to the core for handling, otherwise it just has to pick
the generic struct out of whatever custom thing it defines.

> On a side note, this RFC looks quite similar to what the GPIO subsystem
> does, which I personally consider nice as differences between regulator
> and GPIO in these areas are confusing for users.

My pushback here is that if all we're doing is providing a mechanism to
match platform data with firmware provided devices we shouldn't be
implementing it per API in the first place, we should have a generic
mechanism for system level quirking to pass platform data to devices
which works with anything - it could also absorb a lot of the DMI based
quirking we have in drivers already which boil down to using a DMI match
to pick some platform data.

--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEmWTAACgkQJNaLcl1U
h9DKXwf/dMpnjpe16heUgEu/y6oLmyrmLPbFe/hEtser4kVWV55hAdmKootw15AR
0LiCOkBmLTxd30GcAYCTgEsWOYOWDDZBITGDAgOiDNxSy0/lLGJm1FBOoo4H/Cx2
9bGJgDJ3BXdL2wvyJQbACfQKXatkbygpDS0R6oWehA0pe882YULckV8U2EpdmXUJ
G/yQA5TS5NAMok4ubxXoiW5Ey5ln5C/qgS/PEjnSj+XXLvYBMcgoW33jCstLEtfR
lIKTaR3jU5LoawQTerJjjwlxC8YIkWT4FO8nYNH5NSjUYRi2kOgkuTHV/gMxTILW
xmR40YYJ2abYC8Vs/BjaHfKw8fK6eA==
=JpfI
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
