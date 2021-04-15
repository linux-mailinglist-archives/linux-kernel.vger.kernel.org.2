Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D12F360FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhDOQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233734AbhDOQE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:04:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB74161152;
        Thu, 15 Apr 2021 16:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618502673;
        bh=VhD6RKqtsu7rzG1GFxVGJoN3lqK7UBy9qUrvzK2nO10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yfgvs1iSpGPuFXEGSt2UOVvJObvxY/+g6TkEbBKUcdgcCfuk2Bmb82MG/ofYQ6Man
         MsOxF3a3ci1Yd5hQrmMOqzTMBDUXONX1Ac6pGjNYsavrBoTJzp82sN7mCP2umafjVX
         z8+ikszUDa3cKzml3wp7OchGD9IipoC4S4pOvynmCJJieodU5xhUl05ZbCs4sYqQN2
         b1gF4/mW4N8zO6suLzcufVsIFqV6tA3eM/UPLesZ3kW6m9De21OquoxLwof646ijXz
         gEyiMQHN/H472b9/8+jZdHLaEKxLLIIiWhk3VA9MRCxgHyyt0saasSkx8YLyQd97RI
         V9mbGSsLXSKqA==
Date:   Thu, 15 Apr 2021 17:04:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [RFC PATCH 2/2] ASoC: da732x: simplify code
Message-ID: <20210415160410.GF5514@sirena.org.uk>
References: <20210326221619.949961-1-pierre-louis.bossart@linux.intel.com>
 <20210326221619.949961-3-pierre-louis.bossart@linux.intel.com>
 <PR3PR10MB4142E8DBB9313E751DA52DD0804D9@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <PR3PR10MB4142E8DBB9313E751DA52DD0804D9@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: VMS must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 15, 2021 at 04:00:48PM +0000, Adam Thomson wrote:
> On 26 March 2021 22:16, Pierre-Louis Bossart wrote:

> Apologies for the delay in getting to this. The change looks fine to me,
> although this part was EOL some time back, and I find it hard to believe anyone
> out there has a board with this on. Wondering if it would make sense to remove
> the driver permanently?

Unless it's actually getting in the way it's generally easier to just
leave the driver than try to figure out if anyone is updating a system
that uses it.

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB4Y/kACgkQJNaLcl1U
h9A/eQf/a+AuW/wdA7h1NEPo7bdjlp1RtuPF+QM8UnlWMLsXDYWN8pPMCeDIf5X2
lQvH9kzTWD2tGg70PPgkQXDY0rljNHYrMZVU2yktmuSlmJHJraw7SuTCWAk28ujx
QQuKNwIfFu0P95DHCLHODG6sGXuT8asRlB2jS1UJJVgSaWJkSPPeB1jdrA/6F9Fs
uDF6gVvNYpt91x53I7le86YVD7iZfqqxSSKLdGIUejiV9ozhCUkwt8yXDEKRdlOq
4O8wOiJ+409SuWfwEZDX8WA+6pMvo+9wvROWvsRn4tumMtMKp0a2x8DDBl/h6Cbi
+YpcN0/zwJeye7ecVmj1sE26WqcW5g==
=jQj2
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
