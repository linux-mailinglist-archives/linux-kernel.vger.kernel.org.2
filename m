Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA39345DA17
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354850AbhKYMdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:33:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353014AbhKYMbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:31:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5B65610A7;
        Thu, 25 Nov 2021 12:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637843307;
        bh=u7wd6cZ5BU5UDz9AwuipntBqps4d7LfwvFZarA34cEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quk/3Oc2Gm7g0B/lK7g7JyX7XKIAAvgXetbV1/g7GP5zMM1B6yVZ1XgRSlRzSKHby
         L/EdkgPxUL98AsU1G/57wlcEGmWEMJrQYcxNP1z5cdN6kkGY5rlosPu6R6j9QhYWZC
         F14HqUY7h0LYt/WM/lWDIqlzcpysZiBxu6qmMXqq2W9JfGvvSe7KHdMiMUP/O+M9zJ
         49eGI2D1iL3nSunLWZXi4fUqUL9BbdEP731Vltf79sxRNyyqnvLbeqXPvzzqtCoZUO
         PEPLd9DHu4vx3aryYT9kbEJsQnJXvBdIiLmRQNzAwrDLAursr2tiGzYxGt+ofpj+sx
         ktLWZ5TG47htA==
Date:   Thu, 25 Nov 2021 12:28:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, Rob Herring <robh+dt@kernel.org>,
        linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 07/20] ASoC: tegra20: spdif: Set FIFO trigger level
Message-ID: <YZ+BZRB0sUC08lCs@sirena.org.uk>
References: <20211124220057.15763-1-digetx@gmail.com>
 <20211124220057.15763-8-digetx@gmail.com>
 <YZ97Qo500CrSmhXu@sirena.org.uk>
 <5670741a-1517-fc64-e390-b01c53947f25@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PdAaWwVcI9TPi3M0"
Content-Disposition: inline
In-Reply-To: <5670741a-1517-fc64-e390-b01c53947f25@gmail.com>
X-Cookie: This bag is recyclable.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PdAaWwVcI9TPi3M0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 25, 2021 at 03:04:35PM +0300, Dmitry Osipenko wrote:
> 25.11.2021 15:02, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, Nov 25, 2021 at 01:00:44AM +0300, Dmitry Osipenko wrote:
> >> Program FIFO trigger level properly to fix x4 accelerated playback.

> > Fixes like this should really go before any new stuff so they can be
> > sent as fixes and backported.

> This driver never worked before this patchset, hence there is nothing to
> backport, this is explained in the cover letter. But in general you're
> correct.

That's not going to stop the stable people backporting things, and I'd
guess it might've worked at some point on some systems - I'm not seeing
anything that jumps out as making the driver completely unworkable in
your patches.

--PdAaWwVcI9TPi3M0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGfgWQACgkQJNaLcl1U
h9C1FQf7BiHdMJId6Nyk58krgd7Aqzia9D0StBtbH6BZowb/5L9+OOyeWAuRaTGV
S5sF9XpfA67YuvZG9gKRvjUJR4dPeMfdau6zK/I0hrh4YKINnwwA7wV3EnjlPsnl
k8q4HNiynmcqW4/P4qe7tG4q5GzlNvl+jArcaNZ2VdDft3zh+oGkb9P6i6pvYrDt
AWjc2yClreO3lBC5VIa9H9Cu5m0E9y/pM6NJLvfexSnPPZZFxDQ6aQACrqNfbsTD
dRVh7TZzDXy2v8vDYgrNWfVSh7TIl9SYNzeh8KlMCE/3NLUFPQvqMFl7S3cyrr5a
mkLgh0QEBzrN+0BU2OdvQZwpIdOhvA==
=JNh3
-----END PGP SIGNATURE-----

--PdAaWwVcI9TPi3M0--
