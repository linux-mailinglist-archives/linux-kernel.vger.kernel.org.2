Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CA73C893A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhGNRDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhGNRDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:03:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3BFC61360;
        Wed, 14 Jul 2021 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626282025;
        bh=2Yh56rokhtnChKoXBgGoK3szFykAatn8ETxrAzG6D90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8d2w3l9JSQPlrOxY+WoCrSRKNhxqEDEwSjJsx742/zPLn1398HGY3l3qAIETVKxP
         ApcOyDW6/dKVzCHhCBNk9KzEwjPOyQiaQ3EVDhjpmNK7bTzsG5ZeSQp3A7Xn+MskPq
         n8u46jpyztxBZmAo0esyEnKFKqqnzMvuXcDu607Er1DQW8VgGtbjccFa0tDb+rlDQc
         lMuinIa1SBAGMzGronnkEpJHMHQXIsXyQpjWAUU2OdQrTZDVtMbyYOZm8CgPpXZsjY
         iOA+s8h8V3hC87aTB1GJbHnP/k36V3sNQ0EMsQHQtJiDr1RT2GK+a1WGAgyRzvIs8Y
         xx7zgjKaRIkUw==
Date:   Wed, 14 Jul 2021 17:59:48 +0100
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
Message-ID: <20210714165948.GG4719@sirena.org.uk>
References: <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
 <20210713181837.GE4098@sirena.org.uk>
 <YO6RTh8ngNKZxzj+@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"
Content-Disposition: inline
In-Reply-To: <YO6RTh8ngNKZxzj+@pendragon.ideasonboard.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 14, 2021 at 10:25:02AM +0300, Laurent Pinchart wrote:
> On Tue, Jul 13, 2021 at 07:18:37PM +0100, Mark Brown wrote:

> > Like I said in the other mail fwnode is a nice hack for systems that are
> > using ACPI but have hardware that's doing something totally outside the
> > ACPI model to allow them to reuse work that's been done for DT, it's not
> > a universal solution to the lack of appropriate support for describing
> > modern systems in ACPI.

> fwnode, as an abstraction of ACPI and OF, is quite useful for camera
> sensor drivers for instance. They need to read firmware properties (for
> instance to identify whether a camera is located on the front or back of
> the device, or to what port of the SoC it's connected), and being able
> to do so without duplicating OF and ACPI code in drivers is useful.

I'd still say that's a bit of a hack, it's the sort of area where ACPI
just has absolutely no handling at all and so picking up the DT bindings
will work effectively although it results in something that's really not
at all idiomatic for ACPI since idiomatic DT and idiomatic ACPI don't
really look like each other and AIUI this stuff isn't getting adopted
for actual firmware (as opposed to swnodes) outside of the embedded x86
space.

> swnode, on the other hand, is indeed more of a workaround for a
> more-often-than-not broken ACPI implementation. It's ironic to think
> that x86 ACPI-based systems, touted as being superior to ARM, are now in
> a worst state than OF-based systems.

The unfortunate thing is that ACPI is super limited in what systems it
models, making assumptions that only really work for fairly simple
server class systems.  Outside of that the models it's offering just
can't cope with actual hardware yet people still insist on building
those systems with ACPI system descriptions so you end up with huge
piles of platform quirks.  Audio support for modern x86 laptops is just
an endless procession of quirks :(

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDvGAMACgkQJNaLcl1U
h9AABAf/X5/zmvTpTbxrHYky2e3ncNx3jV+gWD3ovZuT/ERhQx/EsGOk/mGoEOje
TnpqJcaqeXZwOEKi7XlTjiqQvKLDyT3zNVonQ8hHbTJpoYGMtbAw+Gr8/3N3ehsT
Pc9Y4wjQFLF+lUNqkXfH36dbdpCkYVx/BEra3ZyNn/n8i4o2pO9j4I2Hyclpffqj
FtTBvYHPC7b7jATh65FUV/C9JMYCqorVANoeB+teBhbe8rqDCUJF5SzqI88GTws7
l4LY+N9FM0cR4GREH/xLWVXv8PRo+4/1FeFvCw3MBppUR/5WOUAQiY+qP2BSLSIX
I1xdv7oR2jUk7PTTur/4c0S4cN+PLQ==
=9/h5
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--
