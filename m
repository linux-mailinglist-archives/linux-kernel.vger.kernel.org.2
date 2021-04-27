Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0376236C414
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 12:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbhD0Keb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 06:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238179AbhD0K2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 06:28:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFFF0610FA;
        Tue, 27 Apr 2021 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619519262;
        bh=PkbpQPCMTjoIh2VV3B0ik4ihg1MqxO//wd5qNPWSajQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esm7a4wIjmb0MYb1yVcV+YdpeaSw5kx5CkV6TUm2Bs5dAYuArnS2g3WjhzEtSN6Sb
         Uu8smaSC5Mr1KTantZ8agoaf3Rp6m3I7PEeuPqGnPMwdb70HixfuLbf/UVvT+9iy1t
         Jx8gF+DcoGNGsVQjs7G6ZHc8Llahu2VgNDoiq4MwHyDwkiziwLeqcsfkleel55lRGk
         6ZICk8TooqPKjx7RV6K7nQIwKFFmxMT/SFmOoRsk6vKtc0Smt9X8ynIuNwSJ6AwSMh
         Fl0IXRfeLvpxS+WnjmvU0xFRw8iNpslScEJdQhutNdr/R6Z07FpmkGXs9tje18yoBO
         xmistmWvDYsRw==
Date:   Tue, 27 Apr 2021 11:27:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ASoC: da7219: properly get clk from the provider
Message-ID: <20210427102711.GB4605@sirena.org.uk>
References: <20210421120512.413057-1-jbrunet@baylibre.com>
 <20210421120512.413057-6-jbrunet@baylibre.com>
 <69eaa840-ed77-fc01-2925-7e5e9998e80f@linux.intel.com>
 <1j7dkon8jy.fsf@starbuckisacylon.baylibre.com>
 <1jim48jdee.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <1jim48jdee.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Don't feed the bats tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 27, 2021 at 11:16:25AM +0200, Jerome Brunet wrote:

> Mark, at this point I think it would be best to revert patches 1 and 5
> while we work this out in CCF. The other patches are not affected.
> Sorry for the mess.

Sure, can someone send a patch with a changelog explaining the issue
please?

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCH5v4ACgkQJNaLcl1U
h9CrLwf/SCo0dRr48IRNPpomWWQ9h2CLsqPKI+ft4yDGNCxY6gQG7+oWDQFDFC/n
c/XxNm9Y6rf/Ml13SMpKz1Qi4ioqJz43A3wubc0RO3aBJVNBHs6wIs7ht8LRRStf
B2t7nBwNu0WW+8CRj09hqEBiFmhriNQ0r356ieWk49L15xbDf5G8xZhj+PG4vRXR
6NC6XnoGclZrHR1M5ttkvPlEMPnaAkMPZcrREYue6SCXFTPDSgnZ1+sWA8TGIBjn
R23roMb9m8TrOZ8wp6acDw00F2F+yd1dUBhoHh/cw44jCquBh9hqpthMOq6kOM8L
iqPMWM3C+rDnpTFoff26DDm2vV8vxw==
=dm6N
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
