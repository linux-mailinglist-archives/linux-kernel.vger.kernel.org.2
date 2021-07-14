Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482543C8B89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbhGNTWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240041AbhGNTWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:22:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B88F86128C;
        Wed, 14 Jul 2021 19:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626290372;
        bh=beLOUwWVLHcFi6OQ4XgMyD1YDiMXWf0uyYl982G2sBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlmBx6/t/oNjv+7kXRaETo7xe5BslEzIiNNDshcfiR3jHF57acOW+Z2Uyk9PSijRa
         vSm5nGhAcbEPXYcrfe1Y8CLZyd0fv54EyT1i694xMBy4c/EbAM1NZE/8nvAbsDEQyE
         Jo4hxCKMRriVg2/iviJNlpg+R3cTY9RO+ztISNzzsZaUv70XwG568or4IumFI2g2Nz
         vf3/WE/HoWvuu2i5zi9cR8Kb76Xy0rdlnrL53vjIJnz/T0SNepbILF3cFzaafKzMVc
         j1vQz+apGImddp8z38/oWq9WH13L3UzWhtM1FX4TjaUlyt5A/Et2uNj0xic6YRcL/o
         hhKfvs5aqPeWg==
Date:   Wed, 14 Jul 2021 20:18:55 +0100
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
        kieran.bingham@ideasonboard.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210714191855.GJ4719@sirena.org.uk>
References: <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
 <20210713181837.GE4098@sirena.org.uk>
 <YO6RTh8ngNKZxzj+@pendragon.ideasonboard.com>
 <20210714165948.GG4719@sirena.org.uk>
 <YO8cVWNmUvU/LKGi@pendragon.ideasonboard.com>
 <20210714172846.GI4719@sirena.org.uk>
 <YO8hxyrHqY7K43wp@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Content-Disposition: inline
In-Reply-To: <YO8hxyrHqY7K43wp@pendragon.ideasonboard.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 14, 2021 at 08:41:27PM +0300, Laurent Pinchart wrote:
> On Wed, Jul 14, 2021 at 06:28:46PM +0100, Mark Brown wrote:
> > On Wed, Jul 14, 2021 at 08:18:13PM +0300, Laurent Pinchart wrote:

> > > It's only one data point, but we're seeing adoption of the ACPI
> > > DT-in-DSD for camera. It's still not pretty of course.

> > By non-Linux system vendors?

> For Windows-based machines, yes. It's fairly new, and the information I
> have is that those machines may ship DSDT containing both Windows-style
> (read: crap) data and Linux-style data for the same nodes. My fear is
> that only the former will be properly tested and the latter will thus be
> incorrect. The future will tell (I'm as usual very hopeful).

Adding the Intel audio people - it'd be good if we could get some
similar stuff started for the audio things.  Sadly in these sorts of
cases AIUI the Windows thing is broadly to match DMI data and supply
platform data so it's more a case of just not having essential
information in firmware, a bad format would be better TBH (assuming it's
accurate which also requires loads of quirks...).

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDvOJ4ACgkQJNaLcl1U
h9DBDQf/SwJ2OWeD+iAMUkoL0J1X03nE6813Cn0bcaAbWca8fSOF3fyoda7+J0+R
CN93zStnEUI5WjEA5RnWXp7cA95uNuky9m/h7ngmEYnuyK/73DuOTo3SZM8FOLIb
hqAohnFWrNqpM4wLWKIkWhnYJYASKE+NcOez3QD1sAyeFCIvN7wHmy/gRciIOBx4
70HKVhb9H/xPKt3TWR5TXeoLDexF2wqWf3n+NIOjbaJ8mUPiNakx1la7xyaKoZHf
U7G7WNEXl8OtFhh1z+QyAW1MZwe9+NgLXcHGT1z58y7hhSbclBb5oOvr4W9vCHQ3
/NdcFTYHbGeS+cPiKIpTRGR6yr1k6Q==
=+e4p
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
