Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A7C36C766
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhD0N6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236074AbhD0N6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:58:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5594613DA;
        Tue, 27 Apr 2021 13:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619531855;
        bh=jPeMa6bQgcvHjGoeGNbSJl4MmWawTNbeg7cAL28NsDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQCMYwAotMQoKidFAt2uEgtgE8u5agPtgjQHKrO0C8onNioJm8qTTHOItOV/04MaQ
         0+vabOzj4zViGDd/fvqdN8QXqHMTGA4y+r5pWdRQO82WuMVRuLGu1Anff1byWRNnmd
         UYQmkVqHaKCuSfOtHvEZyO0bcysM3lEnbszCyjh+XyHa/VYw7rVGwG0GLtBjSkEzMX
         8rOauMOT7sK40U4vT/PL+e8LoQf7xfBM6vvByY7mb9Yhla4anK2o7V1+pw3b5WGZHi
         lPwqg9rc+uAY7dqXeLJdqs4QDZKnCDGx7qUCWvnwjR2jVqh4QWiSjR0dyjcuA/MOh2
         0yfaav+O/EGzg==
Date:   Tue, 27 Apr 2021 14:57:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci-results@groups.io,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: broonie-sound/for-next bisection:
 baseline.bootrr.asoc-simple-card-probed on kontron-sl28-var3-ads2
Message-ID: <20210427135703.GH4605@sirena.org.uk>
References: <6080e82c.1c69fb81.cd60c.2a13@mx.google.com>
 <3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com>
 <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
 <20210426144242.GF4590@sirena.org.uk>
 <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
 <20210427101926.GA4605@sirena.org.uk>
 <ea2b6dae-3087-67d3-8473-410255a51e23@collabora.com>
 <e20b9c8a2715b5d091a8d1f37ba890b4@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline
In-Reply-To: <e20b9c8a2715b5d091a8d1f37ba890b4@walle.cc>
X-Cookie: Don't feed the bats tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 27, 2021 at 03:43:42PM +0200, Michael Walle wrote:
> Am 2021-04-27 14:51, schrieb Guillaume Tucker:
> > On 27/04/2021 11:19, Mark Brown wrote:
> > > On Tue, Apr 27, 2021 at 07:28:34AM +0900, Kuninori Morimoto wrote:

> > > > > > If so, all sai1 - sai6 are using "fsl,vf610-sai",
> > > > > > all saiX doesn't have .name. I think it should have different name.
> > > > > > In your case, at least, sai5 / sai6 needs to have

> > Heiko, Michael, is this something you can please help with?

> Sure, just put me on CC and I can test the patches manually.

There was a question from Morimoto-san (quoted above) about the hardware
configuration so he could confirm what patches to write.

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCIGC8ACgkQJNaLcl1U
h9C15Af/QNfGiyPJ2VGFceEZARHChEBEgKKDaNzmi1eSlJxQVCeXRhagH7OB9NlY
EJ4bWQsZr9apBwi1EWw3QB9NW+W9oaDte8C6InH9+s5F6q4DN7XxtInRiUVuaV8M
vItMEHyVyHLP11dbOid+aSI+7TfakpjxiswnC6ABzslg6398XaV8e46vHdDeZaTR
zObQ2B/LvM02rn6kR79dn3BtuuKFnuB6B3x4+gm8THsO+T4/EGgVY1rgQvcWZpaM
wc8Hrv5uU0CCH3BBTSVgVsGAI/kqKrNHV9MC4Fyc5OKf6WwzbchiCehgJC/S28kr
8rrhgHz9tcsKSjbnjX+2K9X2VMgJ8A==
=WHgm
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--
