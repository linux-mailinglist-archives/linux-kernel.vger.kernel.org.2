Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763963C766B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhGMS2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMS2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:28:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F08F601FC;
        Tue, 13 Jul 2021 18:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626200720;
        bh=IQfDA3nMscoDfTsnxUrZjXrPXJ9ASjeGuNtZQgnPzKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmVrqOE2MxV+BInmj0mN5BiHb8LgIclMeUJkW86w3vYcOGH2DWYQ3xu6QINiMTSoG
         4VSS6xPJf2ikd3/jX7gpDEnMJH4BVM+0lGJlKVp0eKh99AT+JznEC1DRr00gfkE4bH
         6ONfV4wmFuxtsZVKR1iZrvq0fwxhtxmCL34Mu1M8u8MftutNk6XzIp2ruugx99bzG+
         7ZyUwqXr1G9iNxRihcyDi+VJF8Nnra2E9/+v4a8GL2S9NdtvwW9WFOwkSU+6YVwY8s
         7VIZOWl/4XTdGk2+CdW6nVf1jt7gX2/KmC/8r/J/Dijnj4+hZk8L1bRbM4RkkWZbff
         s2OD13g3Y8oQw==
Date:   Tue, 13 Jul 2021 19:24:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210713182445.GF4098@sirena.org.uk>
References: <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <YO20aXWkqLgwHkku@pendragon.ideasonboard.com>
 <20210713160259.GD4098@sirena.org.uk>
 <YO25/IAD0J40R7bH@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline
In-Reply-To: <YO25/IAD0J40R7bH@pendragon.ideasonboard.com>
X-Cookie: Keep away from fire or flame.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2021 at 07:06:20PM +0300, Laurent Pinchart wrote:
> On Tue, Jul 13, 2021 at 05:02:59PM +0100, Mark Brown wrote:

> > > To make sure I understand you correctly, do you advocate for suppressing
> > > registration of the I2C devices from ACPI and instantiate them from
> > > board code instead, or to somehow supplement the I2C device with
> > > board-specific data ?

> > No, to repeat yet again that is what I think is a terrible idea.

> Which of those two ? :-)

Suppressing the registration data.  Frankly the way that ACPI systems
rely so extensively on OS provided fixups on non-server systems while
still being deployed routinely there is also a substantial failure, but
it's not quite so bad.

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDt2mwACgkQJNaLcl1U
h9CzZQf/WWsaoTKwpAmcDK5OieBy/NO01P/xPTHASrZZPX/PggTwK9I53p1jcWsY
tcl5a0kjn5oSewTuaiy2/Xr3AbgiJGwNDNELdyn7xHzp3yOHlalqiNE3+iaw3DmU
BngVVe7sfg6SQnptFukN2HMmb4MyAfyZZCulQwTC+5DE/mWK8aaD0zZ+Z0vCYGoE
t2ms3qLN0St4i4X/Qty6OMelAUqDM0VSXycds3TfeWvWa790rHHvdvfzqpbD1S2B
4MSDncETZ0VA/NpkRib5G7SdMQ/eE+CYd93/mdOelK/+mN7kQ+uTnmM1uMOxD5pa
GDlx6AUVZ5Lw8nEmXqJn4uvJdqIQ/g==
=52Rr
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--
