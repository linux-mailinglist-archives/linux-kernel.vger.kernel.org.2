Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710233C2805
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhGIRHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhGIRHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:07:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A269611B0;
        Fri,  9 Jul 2021 17:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625850300;
        bh=3MIvlgM7Pep+oN8czuF6Ie0rH7/jYQOo7WsCFv5z/AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQ74sLgCunCPF+x5zXhF8b47XY0e5wrs7r20dQ4aLBwjJP3+79OWzgW/BJIEhGPOU
         GF/teFKTIFqw0bWo6+stC0HoTXfA40FXwKfVEKAfOAs5CQ/iq0ixnfWZUHQMzFYZbS
         Q29gOCi9bL8VGc4lg/eTTksV3eej6ZbjM24wAWLs1seHK5ehzyt83ChJgNxzDV5L/w
         vY49fHpDDH0q1VZey/KRlqdzXDjDa6k0JksYh9c8VtfpfMCeawt5HMs8alihIlkCoS
         Lu85dswNOO0j6+sYkSpj2TUpZg7jXI7jRSkUzpOaQexG77h79xmd0NiwUwNnBlsYgR
         hF4LGb79kND/w==
Date:   Fri, 9 Jul 2021 18:04:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hdegoede@redhat.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, lgirdwood@gmail.com,
        andy.shevchenko@gmail.com, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210709170426.GC4112@sirena.org.uk>
References: <20210708224226.457224-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <20210708224226.457224-1-djrscally@gmail.com>
X-Cookie: This fortune intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 08, 2021 at 11:42:24PM +0100, Daniel Scally wrote:

> See previous series for some background context [1]

That's a link to a series "[PATCH v5 0/6] Introduce intel_skl_int3472
module" which doesn't have any explanatory text as to what it's doing in
the cover letter (just an inter version changelog) nor any obvious
relevance to this series, are you sure that's the right link?  In
general it's best if your patch series contains enough explanatory
information to allow someone to have a reasonable idea what the series
does without having to follow links like this.

> This series is a prototype of an emulation of the device tree regulator
> initialisation and lookup functions, using software nodes. Software nodes

What is a software node and why would we want to use one here?

> relating to each regulator are registered as children of the TPS68470's A=
CPI
> firmware node. Those regulators have properties describing their constrai=
nts
> (for example "regulator-min-microvolt"). Similarly, software nodes are
> registered and assigned as secondary to the Camera's firmware node - these
> software nodes have reference properties named after the supply in the sa=
me
> way as device tree's phandles, for example "avdd-supply", and linking to =
the
> software node assigned to the appropriate regulator. We can then use those
> constraints to specify the appropriate voltages and the references to all=
ow the
> camera drivers to look up the correct regulator device.=20

So these systems lack an enumerable description of the system provided
by hardware or firmware (or given that these are ACPI systems I guess
the firmware description is just broken) so we need to use board files.
Why are we not just using board files, what does this new abstraction
solve?

> I'm posting this to see if people agree it's a good approach for tackling=
 the=20
> problem; I may be overthinking this and there's a much easier way that I =
should

I don't think I understand what the problem you are trying to solve is
so it's hard to say if this is a good approach to solving it.

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDogZoACgkQJNaLcl1U
h9ANAQf+M9TONsSRsQlmFBCA2aVGotSOwxvK2eI+A5nP2zHCa4CxUR10Y1P80SvC
iPCQxqN2JO0E3jgcMgbXubCMN38zqMGKDVY1EQ9J4l8iChUdwshdGqjIRAy1Xtib
d2QWqJ2ucO6fjzPfFh5SB9nbPCI23nOipXuPmu7Cz3qWCGj3otBwPHSf51mLRdbV
vzO5L1KV2DAxcJ5vhP1TUZLWvOfbhgeAxYoLXrLdK/lchq0bcthknQt2Ml64b9CF
UgzbKV0hDjRKcUsatCD9VMqp5UBVIgjFzf9+pVN1Ad1pT5RZR/ZbMS2BThys5y5A
jsdef9OYk/m9QNn6TRIhW3dEtKSFXw==
=2klv
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
