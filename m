Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C834243AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbhJFRIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231317AbhJFRIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:08:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22F22610E5;
        Wed,  6 Oct 2021 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633539986;
        bh=PZnbaxq69kHYjc3aakilyUEfdbtdfSaOIp4kp8liWU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUVfD0R+rR3WdH6ywZh4W0FObPq9rS6YuqePu1Zd1KGQKfQUbpWj/djDPOwXEEhQ7
         WghL5YkDaNdOazPK6j06bljx2IoC4KUF95/6CWROLWwnDRBiqsJIqZDpFYHkmDbKcO
         Xo0pfLSpCDgLjXYOdcvIQLjFHjciy6PsepjyvKuA4Ochxd8UgHm435d5n7QpeXfbsV
         hxwwRBogz3Y5UuofrQWJ9rRDPcZoGl0bJOj9zvX5l66KM/VT4xHl5x/oUZhsFKucrA
         DAN2zz05sK8Qci3ell1sWNpHBCqiZibL1xnpW/RaGxxh+bjwBSn6yc6bUisjqEuz38
         +XjlhgeKsounA==
Date:   Wed, 6 Oct 2021 18:06:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 3/4] ASoC: Intel: bytcr_rt5651: use
 devm_clk_get_optional() for mclk
Message-ID: <YV3XkLzs5VBv3Sic@sirena.org.uk>
References: <20211006150451.16561-1-andriy.shevchenko@linux.intel.com>
 <20211006150451.16561-3-andriy.shevchenko@linux.intel.com>
 <2d190513-7ac4-731c-7c9a-1f60a98f6345@linux.intel.com>
 <YV3NZnb6mg43nUC1@smile.fi.intel.com>
 <015e084e-70ed-7b5c-b103-8426ef0842d4@linux.intel.com>
 <YV3T5evF+hghuwge@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P5y5CYfh4SMnZ2u/"
Content-Disposition: inline
In-Reply-To: <YV3T5evF+hghuwge@smile.fi.intel.com>
X-Cookie: A is for Apple.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P5y5CYfh4SMnZ2u/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 06, 2021 at 07:50:45PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 06, 2021 at 11:37:24AM -0500, Pierre-Louis Bossart wrote:

> > By looking at this code only one cannot really visualize that it's a
> > no-op. I personally prefer to see explicit intent rather than have to
> > dig hundreds of lines below what this clock is optional.

> > I am also not even sure that in real products this clock is actually
> > optional,

> The code tells that it's optional. If it's not the case, the code has
> to be fixed accordingly.

AIUI with the clock API the idiomatic thing is that any optionality is
handled at the point where the clock is acquired - if the clock is
optional you end up with NULL which in the clock API is a dummy clock
and ignored.  The rest of the code then doesn't need to worry about any
of this stuff and the handling can only be in one place.

--P5y5CYfh4SMnZ2u/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFd148ACgkQJNaLcl1U
h9BJPgf/WyCnwaI1cBrz1bAWU3LhKG7Fpeirk9LCyIGjBxKx3hLF/6ZpYdgj7ZE+
IKXTNDfc3bA7UKhQ32Rck6Yi4rDJDa4MdAqwgeGf2jUrLYnZcjOechs3ckABPovb
QVu25PIwHU38QJO70K00wUhOOnleqPbFcpPbamwzIrXPIZepxtnB3uvXmrv8vG80
S1pTTSf7Rcz076AG++FbYIR+ppSPUBopUS2Y4/eiFfDpWQjIPwvsLWmB5PZ97hvm
YqyTTOWPJ0k6mG2p4qtJs7VLEbExZkHb91NvUZNtGNwnJXjSiEclJtodBCxU6xZa
kfnNG6XvDZctYdE5r1NHPX5J80XLmg==
=5awA
-----END PGP SIGNATURE-----

--P5y5CYfh4SMnZ2u/--
