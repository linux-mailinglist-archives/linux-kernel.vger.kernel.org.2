Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B50F3C6201
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhGLRfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235721AbhGLRfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78517606A5;
        Mon, 12 Jul 2021 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626111163;
        bh=VtGEF+ZZROmXiAjI6Vgr8SHZ3R5D6D8GlzKCE5P9jNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gU5DP/H6vV/hR98Y71TuN3Sf5Lc4/CFIim5CLt2kqn/gVAuVkJdTi80w56phLHXi/
         vvoht6AyduTE13L4uvzrEdGc5O9JnnTltLyOC7wj9xsKDbBWNzqseHNN1fNbP+31Ax
         hoh92BovgXHy9AvlleHw9KXX5tkru6ekx8W4MRomclMoqLyRXPfUP7EP391yHjVWaw
         43uOhGIHZqOGz9+4ORtbP1oJRPHKhMlzTrSHjTBqMZkR3xkE4EVbByWv2ADzhCtOOd
         hbUN6Vx+hj6l66SNffZxot+EOJU9L0JoTUKZKzNao2SaFNpvFuEjjo5gJQYIt5gUlN
         U+JcXeqWryCWg==
Date:   Mon, 12 Jul 2021 18:32:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, hdegoede@redhat.com,
        mgross@linux.intel.com, luzmaximilian@gmail.com,
        lgirdwood@gmail.com, andy.shevchenko@gmail.com,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210712173206.GH4435@sirena.org.uk>
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210709170426.GC4112@sirena.org.uk>
 <c95da883-581b-d1f4-4c8a-2162b8b58b64@gmail.com>
 <20210712141528.GE4435@sirena.org.uk>
 <YOxz+b/giZTKoJkk@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Uu2n37VG4rOBDVuR"
Content-Disposition: inline
In-Reply-To: <YOxz+b/giZTKoJkk@pendragon.ideasonboard.com>
X-Cookie: Hailing frequencies open, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Uu2n37VG4rOBDVuR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 12, 2021 at 07:55:21PM +0300, Laurent Pinchart wrote:
> On Mon, Jul 12, 2021 at 03:15:28PM +0100, Mark Brown wrote:

> > Like I said elsewhere it seems a lot easier to just have the I2C driver
> > set platform data based on parsing DMI information like we do elsewhere.
> > I really don't see any benefit to introducing an additional layer of
> > abstraction and binding here, it just seems to be making things more
> > fragile.

> The idea behind software nodes is that individual device drivers
> shouldn't care about where platform-specific data come from. They can
> use the same fwnode API, regardless of whether the device is described
> through OF, ACPI, or software nodes created by a board file in the

That's much more fwnode than swnode.  fwnode is a cute hack for letting
ACPI based systems that don't fit the ACPI model reuse DT bindings which
can work well for some things which are just outside the scope of ACPI
completely but is a really bad idea for things where there's specific
firmware modelling for the thing being handled, in those cases it should
be avoided and firmware specific handling used instead.  Power handling
(including regulators) is one of those areas - ACPI has really strong
opinions on how it should be done and we don't want to be encouraging
systems to go against that model.  AFAICT swnode is mostly just a way of
patching up firmware that could be getting away with fwnode but didn't
for some reason, in this case we don't want to ever see ACPI systems
trying to use the DT regulator bindings in their firmware descriptions.

> kernel. It allows grouping all platform data that should be provided by
> firmware in a single place, conditioned by a DMI match, instead of
> distributing DMI matches to lots of drivers.

Like I said in reply to Andy's mail if we're essentially filling in a C
struct through a massive pile of indirection involving writing C code
containing a bunch of static initialisations of less specific structs
that doesn't seem great.  We can probably arrange to pass the init_data
=66rom different files rather than putting the quirks in the driver,
that'd be fine if a bit more work, but swnodes only seem to be adding
problems here.

--Uu2n37VG4rOBDVuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDsfJUACgkQJNaLcl1U
h9Abjgf/Vk3i0rqEkOhCAV+ivVYXecph/yluBT06Xil1LFQhiK9prVwCfZJ93k0S
D6dkPcnM1RZKmFQq3uRBfDY/5SNQlka3uoCrZqJuNhMnphjOviUgOp6HxTXVnalQ
Fsx3Pp/khYOcwjmt7Me3i8xKcIrvphG2FddKYqGTrH3R5MuDDVRvFmtF9Ay74BMG
6+g2XUmTLF8G4MhVMHH3SS9U0bzkbhNaFzFrShf/aVtjgZVo5RL858KqsQZ2PSr7
H4h7d0nJxvjqMQUo0pkH5VB+tiX+tUvo52nnAIYpo3gi1abz6IpuhXIAfY0vNoCD
WTNUTLOqkY4/N7AOKj8dvfFlOft15Q==
=BBO2
-----END PGP SIGNATURE-----

--Uu2n37VG4rOBDVuR--
