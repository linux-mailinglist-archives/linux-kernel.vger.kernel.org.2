Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79799400345
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349365AbhICQ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350000AbhICQ2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:28:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 852A660EC0;
        Fri,  3 Sep 2021 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630686433;
        bh=YsCr1vi/hG7WlJPP12tFvf6pbI6chrdQlXh9KKuB6uI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOcIvFGWrtOWgZleS0Rnbzp01QM8+3A9zZY5XVlCQdlgiKg6B9t12/Jh4ps73kDId
         Dkp2JFGIqdWug3uDMw7bttpV57j4xkBKbkfc4z3hkJgSGNZ2k+LMnYo8aIzVurzZat
         hXdiGfyQwk65SiMTJkC3sJ207it2pabDCMUduJ8cO5evggROWdzVjM0267Uk/h/akZ
         DJtQaDwY6mTwWse5ffIRdrsL3Qc2jvHtwfS0WMcFZKjzsdCMcnM7XEQXYhqMtXdQLA
         5iPawVHuGaxoWE/5H+wBe2L+vvkcVz3XQ+I/LB9NpkGNnkipH7G8PCD517uTCfeZzT
         1EsluH5f1S42A==
Date:   Fri, 3 Sep 2021 17:26:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH for-5.15 v3] ASoC: Intel: boards: Fix
 CONFIG_SND_SOC_SDW_MOCKUP select
Message-ID: <20210903162639.GM4932@sirena.org.uk>
References: <20210802212409.3207648-1-nathan@kernel.org>
 <20210902181217.2958966-1-nathan@kernel.org>
 <20210903102738.GB4932@sirena.org.uk>
 <YTI71k5EsyTgstkn@MSI.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="um2V5WpqCyd73IVb"
Content-Disposition: inline
In-Reply-To: <YTI71k5EsyTgstkn@MSI.localdomain>
X-Cookie: Darth Vader sleeps with a Teddywookie.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--um2V5WpqCyd73IVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 03, 2021 at 08:14:30AM -0700, Nathan Chancellor wrote:

> For the record, the documentation for sending patches has the "Explicit
> In-Reply-To headers" section, which frowns on doing this for multi-patch
> series but never mentions this for single patches. I have never had a
> maintainer complain about me doing this in the over three years that I

I don't *mind*, there's just a chance I won't notice a patch that
appears in the middle of a thread which submitters tend to mind - the
issue is that I'm blissfully unaware.  It was more that you were doing
the exact same thing again in response to it being explicitly identified
as an issue.

> changelog section. Maybe the documentation could be updated to frown
> upon adding In-Reply-To headers to new versions of patches period? I can
> draft up a patch to clarify that.

Not everyone has a process which causes issues here (and even for me I'd
only notice if the old thread was still in my inbox), but I certainly
wouldn't be against it.  Note that if you're trying to make everything
super rules based you also need to cover the case of people trying to
incrementally fix a series by sending new versions of patches in the
middle of it which is an even worse mess.

--um2V5WpqCyd73IVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEyTL4ACgkQJNaLcl1U
h9DZhwf8CTpPqMVMNlBp0ILOIUynnedLfqBM8DUbquKMsQ18R4nQxPK1F+axx0q1
1Ya36cGShO54vRHMQYNekWi58MwDyLB4Nik64vhQEyn5hAWYf5ydL3GxuAyXePGV
f2wD7AFE2FDx475lWV3GMKJHN2g0kZeiDQDTFe4h5wEEME/g+eShfRnnPISn/0+x
SRE8fSs1eEkdScgs1e5p3cJ+w3QnzvhvHuPaxCbDhkQ4viSfJ1tcmcISpGqo5jVF
shdWTiy7LXn/g/eWqKv/ZAXrJ8DVRkK4yfUxhrrxcw7SDGV8EwD4GcOc1J3NYVZy
/L1J7J8UDsqXUyd5Nsba4f7RVZT7Iw==
=3M0P
-----END PGP SIGNATURE-----

--um2V5WpqCyd73IVb--
