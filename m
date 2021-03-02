Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63D432ADBB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359905AbhCBWFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:05:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1836078AbhCBThF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:37:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E719664F25;
        Tue,  2 Mar 2021 16:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614702816;
        bh=xuU9oMOeaz3Es42maf+w61Cm4/OCct29YfV5FhwR8+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYcBHc3MSnXRinTI9QTMqPu54FjYbHx8k1uXD7SgUcEGwI4xZOvlFKknyaomFzdIQ
         ggitlEo3cO5iw2hdnUSiGZcCOhDpV5SshdBk53X4K3Hv/wGszqyaZDzS/rIG3MubKg
         qKrgL0R/ajRpiFPEFLaXELfh/rmNU6tQxiTaH6vhMlFqP19xHu8wgbK4+tsFwxYEPw
         +fYl8rCu48D0aHTwp87IOd/A3ASFF6bhuGCpAosno97hXg1yBpcXF3rvnL6qVRYlp0
         YdIuIe3VpCL3EIUBkTX2Opz0H2x1Z6+6BXtH2xxqQ5UGbwuRVRH6jrMjshYMw/NFyF
         pGkrQXjdyl6hA==
Date:   Tue, 2 Mar 2021 16:32:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
        kai.vehmanen@linux.intel.com, stephan@gerhold.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: simple-card: Add dummy dai support simple sound
 card
Message-ID: <20210302163229.GN4522@sirena.org.uk>
References: <1614254912-15746-1-git-send-email-shengjiu.wang@nxp.com>
 <20210225131533.GA5332@sirena.org.uk>
 <CAA+D8AO8_ESHSyODXhx4Wf1Z5MbtxWRUa-k2d6wKSeA0yzD5uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline
In-Reply-To: <CAA+D8AO8_ESHSyODXhx4Wf1Z5MbtxWRUa-k2d6wKSeA0yzD5uA@mail.gmail.com>
X-Cookie: Friction is a drag.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2021 at 02:05:29PM +0800, Shengjiu Wang wrote:
> On Thu, Feb 25, 2021 at 9:17 PM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Feb 25, 2021 at 08:08:32PM +0800, Shengjiu Wang wrote:

> > > If sound card doesn't need specific codec device, just
> > > dummy codec is enough, then we can link the dummy component
> > > directly.

> > This is a big red flag - what circumstances are these?  If it's a simple
> > CODEC with no control then the general approach is to provide a driver
> > which announces the capabilities of the CODEC and can be bound to as
> > normal, the dummy component should never actively be used.

> For the DMIC, SPDIF, HDMI ARC device or other
> similar device that there is no codec connected,  then dummy codec is
> just used for registering the sound card.

There are logical CODECs there, and we already have devices set up for
those (like dmic.c for example).  All the above cases have at least
some constraints from the spec for the interface.

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA+aJwACgkQJNaLcl1U
h9B/agf+NuZkSLk0hEvuBLZfN8yHn0Pdiykp2X9jERm3iqFpvGWqNegsoouoydfm
GPnSAmiaz41sqB5B0F9JKWXBKTQ1aJX4Enptx8zIxoc4E/vRi2V2vq7TI2egODqV
OnPbth/fcTuva5m345AtS8uC4PQN7QvYibNVos1ZOBnLqxWuSGVP96fdQ0dUzQ8c
6ArphB631y2Vv6SJZ88UU3PhJmfhU1wBsTw8ww4YoLl1C8N77bQw6u+jIfyy/H0X
C5gRJTlLzMAWSXPCjOhPJyReEvkgiN24H50G52+gs9F/bPyMudjK6uZO/F1LCFWP
ScAb6CP4dkWqHs+uIqFYVRRKNx+XJQ==
=XYXx
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--
