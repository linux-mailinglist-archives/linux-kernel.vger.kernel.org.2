Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7373F0A93
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhHRRxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhHRRxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:53:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0707610FE;
        Wed, 18 Aug 2021 17:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629309192;
        bh=1PdxaWp06Zf1Xx0MXjBNoAEoceqXLG1oWGBvQ2KKlOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLd31OBjz0uHbH9KlXK8JfjhPgOz+fH3TPjxJpsFbRnXfcn7OiQ87tgPBI27jOhi0
         +WrXL+xU+PO//dKLvHCTGnBxVmCl1SWh8Efs26bI9aOpHZVpczVpdmF8k5WrLp+QXM
         7XQgbPEjfwMVwWrZvP12m0WXRKYK7GSiCwvSnCkf4g0iyJ13REzyfK78DM/VZsonV2
         0LTs45/dt6pPeFqxrcrXFRqJpL6JLm3mlQyNkpAB6/wIo84cnCu8/KxryEo8jo4vjG
         o/kep2w6uY4h+do1hGEi8mMMMziO89FDzVvcS8nBgagD63cSjdhF8bNPWepurPyrok
         nOmYyfgtEZ4Cg==
Date:   Wed, 18 Aug 2021 18:52:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        vkoul@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
Message-ID: <20210818175248.GH4177@sirena.org.uk>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com>
 <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com>
 <20210818134814.GF4177@sirena.org.uk>
 <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
 <YR0nAcC3wJd3b4Vu@kroah.com>
 <be1ea414-b2ad-162d-192a-7b55e40b3754@linux.intel.com>
 <YR06L+gTzyiYY/rG@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <YR06L+gTzyiYY/rG@kroah.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 18, 2021 at 06:49:51PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 18, 2021 at 10:53:07AM -0500, Pierre-Louis Bossart wrote:

> > It's been that way for a very long time (2015?) for HDAudio support, see
> > sound/pci/hda/hda_bind.c. It's my understanding that it was a conscious
> > design decision to use vendor-specific modules, if available, and
> > fallback to generic modules if the first pass failed.

> If it has been this way for so long, what has caused the sudden change
> to need to export this and call this function?

The usage predates the hardware that requires firmware downloads -
that's very new.

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEdSPAACgkQJNaLcl1U
h9DBxgf/amTh9hfO6aFUgwqDOv0qsAVXUkdiweHKmeTccre1+YQ2bhp2YsUM/gB4
hUEYHxhRPUJcTiEN9dxicfru+l/6Rm0tMpdUok8KtpVa+x7NK87yy14ce02vpjiS
G9G3k6IHU/R9xP9sXYLFTkY1+Odq1JJYNok+vgdsl39D1pXXOEDpOa0ynOOmAR0+
/Hs6Rsr+D4SwEjpBHPPeW/xW4g+MnXNzoIh/WP+K+goZAvRXfBIFo60ZjzPf7aHv
Taq3g9xwOdFXHHHFmTyrZ+4wSNxsEQokzq0O6qKLN79ITljb0hjiy43MN20yeDsG
h6ygHH2+gfeAdDG2rcHpinneo56wLg==
=69mB
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
