Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930DB3F745C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbhHYLb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232304AbhHYLb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:31:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D0C1610E8;
        Wed, 25 Aug 2021 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629891042;
        bh=HNOC9P+m4Gc4SN5G4ASwhTGEIT9YqxP+5GJ2GfjgiTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SylBGTbX+xaUeCoF0UKWy1aQZpWOZggEIiFw7BjEbmYZ4lT+zkUcXyPouEgvZ9K/I
         WYhBJcRnrBG2klgW8shWz/yyOc2pjLItGKYqTOUtZ0NGmZsMkkDm5BqyQ9QmHuYrlC
         YrIOPKHS/ICAih6i4CG8TPHUdcJh8VirmfQ6jvz88KIGVOoq880hqn9S9200dUwM6p
         uJnkZ2y7Q2iwCShn51cGo55d1i6Hx+WqOTIlLLejGdr/lOOgrmoiyIy6bURyMYDlRA
         SBYoIVIQLwecL5AJhfJscyrdrZHHbiXsWiLME4IqgNlzD7/Wua+TEfuN9tO/U9RFc7
         D89SpM1hokvCQ==
Date:   Wed, 25 Aug 2021 12:30:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
Message-ID: <20210825113013.GD5186@sirena.org.uk>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <CAHp75VdHpjbjz4biTP11TKT6J+7WQi-a1Ru3VLuSxM5tSLCB3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <CAHp75VdHpjbjz4biTP11TKT6J+7WQi-a1Ru3VLuSxM5tSLCB3Q@mail.gmail.com>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 25, 2021 at 02:10:05PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 25, 2021 at 1:34 PM Mark Brown <broonie@kernel.org> wrote:

> > DMI quirks throughout the drivers like we currently do then we should
> > have a way for boards to just store generic platform data for a device
> > and then have that platform data joined up with the device later.  This

> What you are describing sounds similar to what we have, i.e. fwnode graph.
> That's how v4l2 describes complex connections between devices in the
> camera world.

> But IIRC you don't like this idea to be present with regulators (as
> per v1 of this series).

No, what was proposed for regulator was to duplicate all the the DT
binding code in the regulator framework so it parses fwnodes then have
an API for encoding fwnodes from C data structures at runtime.  The bit
where the data gets joined up with the devices isn't the problem, it's
the duplication and fragility introduced by encoding everything into
an intermediate representation that has no purpose and passing that
around which is the problem.

> So, what do you propose then?

I propose what I suggested above, providing a way to attach platform
data to firmware provided devices.  Don't bother with an intermediate
encoding, just use platform data.  Or just put quirks in the drivers
like all the other systems using ACPI for platforms where it's not a
good fit.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEmKcUACgkQJNaLcl1U
h9A7AggAgjXkogVPUZ2ElSP+d58XTGKHJDC/XysVmVQpiA6enh9IEz7N/rSdQBnK
hrky5sFIGg0LEBGX3nkZZCeaIcCJ6NsYWrwNrDLJXDEMzTf40mxSRB2s2PUX2gV9
HGsRx3p+ZY7su1y+8N5z2qX2bVbumVsx8mM0jqyZDB6ZrUwv9e/k68lavmV//TYv
/IJ9wxso6OcCpyLIHHx55AZGVnqwe80/dokbWEBD7h9HNqfPWNXz9caSAUpTJEKi
bHurxgMMBXjV56VKtKvK3VFQx5jsw3F3pg0njvWWqUXWKZMQ7DXLKDR+8dGEld6r
1l0olltqQetl/zJuTL3xdXJgPL61cQ==
=c2LJ
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
