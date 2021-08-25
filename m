Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779E13F735E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhHYKed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237971AbhHYKeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:34:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB4F361214;
        Wed, 25 Aug 2021 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629887609;
        bh=wpR0x/DbCtzYvxVpAGBYbFkMbJDqJjri+N2gUn9scXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0OdyuPJX4hjJSFcJllXWw6Efd+i3Z166AH0j5r9rTGPM+leDzRnsmYXarOis0NfO
         ZXYbImyuh5m8rHg8YN94sugOIJbhTAmd3ddhlHwldfLBgMV4JaGlLea75pJrdwsyyr
         rWUqQmmgOyciIamfLzQT4YKVA8GdQFjcC+xOu1axkFSqf3eLda7VyKjKCMYeuDw7EU
         FSyoW+KtP2B6PwR0zmxx+zWfGX46KEJ7DLWGlOfoVlsdP3FPCgD0i5IRQKm+AoHChA
         TVjUyNEN+XI2zPYFW1zEr9q67nUg1LGq08bxGOogZffgWjnzqKQcKvsoqng17dACMa
         M8iU/lwSdHYgA==
Date:   Wed, 25 Aug 2021 11:33:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
Message-ID: <20210825103301.GC5186@sirena.org.uk>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <20210824230620.1003828-2-djrscally@gmail.com>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2021 at 12:06:18AM +0100, Daniel Scally wrote:
> In some situations regulator devices can be enumerated via either
> devicetree or ACPI and bound to regulator drivers but without any
> init data being provided in firmware. This leaves their consumers
> unable to acquire them via regulator_get().
>=20
> To fix the issue, add the ability to register a lookup table to a
> list within regulator core, which will allow board files to provide
> init data via matching against the regulator name and device name in
> the same fashion as the gpiod lookup table.

This is the wrong level to do this I think, this is a generic problem
that affects all kinds of platform data so if we're not going to scatter
DMI quirks throughout the drivers like we currently do then we should
have a way for boards to just store generic platform data for a device
and then have that platform data joined up with the device later.  This
could for example also be used by all the laptop audio subsystems which
need DMI quirk tables in drivers for their components to figure out how
they're wired up and avoids the need to go through subsystems adding new
APIs.

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEmHFwACgkQJNaLcl1U
h9DhbQf+JVF0IbSOLaQ9QFIb+znRpgHurw1v9h1lSfyCc1opK/J6aW26UYlclEqs
FfyJyvUF7F4aM5xeEKRSJgk/39Kv2lrfuEhAoLXBMpOusVX1vREi9+tmAyzjceQD
ZQUvU+MK318weCDlFY8YzoqsEqdeVyO6KxILsTvS+mgYndDqfSzO4fleAmxJuhR6
0tqYW3pdJeCgXxRUsCPCeMOGaV1YsGphWDfIHikWDVwMnI6sTROVKM6fBnSfiT0Y
zUOgAkCV2Ak0Z50O+Rn8qhQvAFQkRkoODJje/8pH8sxdTaWlL2QRXKauLvufhKi1
O7qlrHmGuzctC+aeCntP8bXBMMzc5w==
=Dppf
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
