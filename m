Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB5E3C89D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbhGNRcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhGNRcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:32:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 005B360FF1;
        Wed, 14 Jul 2021 17:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626283763;
        bh=oQjr3iu7tXHT5XdQo184Sz9Za+0jKH7IEfRHCYXDz+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nj3RIkuBjAv5n5GsY1kvCcGysnYPrRwqsSBrBuoL+5LQGPoDVPH7Z931cIsuNf5Ns
         b11jOWmf7+8v+Un8z/76dXF0gt3ZBn5pqDrZFr6Szxqg0qKdG6ruphcaLkOiMIFTPc
         8VSkZBPEfnCp3NLw2erMloz1P/xznvy2vE+NRO3dTbwVMfJnbd8xP0U7r/xoSQklRJ
         J44GIefwjbDwZWDpMi/U6dxiFeh0zPSyRkJuIMizejTTKMySCgU2GumI/CkUKBwYUu
         4ItRQZ8HR4LIc4wMl4B460FCDAkw5R8DybW8FN7ay/1BuTCSzZvxUN1kIG+Aslkqnh
         z3tCWhUnRstqQ==
Date:   Wed, 14 Jul 2021 18:28:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210714172846.GI4719@sirena.org.uk>
References: <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
 <20210713181837.GE4098@sirena.org.uk>
 <YO6RTh8ngNKZxzj+@pendragon.ideasonboard.com>
 <20210714165948.GG4719@sirena.org.uk>
 <YO8cVWNmUvU/LKGi@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
Content-Disposition: inline
In-Reply-To: <YO8cVWNmUvU/LKGi@pendragon.ideasonboard.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 14, 2021 at 08:18:13PM +0300, Laurent Pinchart wrote:
> On Wed, Jul 14, 2021 at 05:59:48PM +0100, Mark Brown wrote:

> > really look like each other and AIUI this stuff isn't getting adopted
> > for actual firmware (as opposed to swnodes) outside of the embedded x86
> > space.

> It's only one data point, but we're seeing adoption of the ACPI
> DT-in-DSD for camera. It's still not pretty of course.

By non-Linux system vendors?  My understanding has been that for audio
people are just unwilling to provide the level of firmware description
required to avoid quirks, there was some limited stuff with the NHLT
table but it still required system software to quirk things.  If there's
progress elsewhere perhaps the relevant people can be persuaded to have
another go...

> Once travel will be easier again, we'll plot a take over of the world in
> a bar. Dealing with ACPI requires lots of whisky :-)

Indeed!

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDvHs0ACgkQJNaLcl1U
h9BpVQf/ZwDGOuXDd1Ddz3ZHe8HDdBd9aiLpP0rIGJD5b97HQ29Cen4aLxkStQ1l
8rLMCNuA452jN+AOWKio8TgRDYx9fK80kzkXGzjErsjax+G1yLLstMWpR5SsCLTB
nsPXpMXyE+GXqT7BNJYHw4PUhwl6QhGKrJkTmPVz5G2CUrq1hjF9kZ5idBMNsM8E
U6jXpXFuyaN2ur6HUtNad5SUKsCJ61UG7SpDvkUmRvxoS9cKFH/6q1dhNN6nT23f
kMud9UAYs0RSaOqaZ8iCCgtv6zmQ6yt3/o5Z9uiJZCVIq9PZMoNoSZAi9+vYIk0L
auWi/xr0KSW6p6E9XzdwTCZVtVHn8w==
=4IKh
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
