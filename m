Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41B37B022
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 22:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhEKUiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 16:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKUiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 16:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FDC361625;
        Tue, 11 May 2021 20:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620765428;
        bh=/y1LNczX8cc7a5JT53+KpFEJ0FqXNBnUXYDbg0bXdpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ME1PJuFCJD1NB0CrAdpNns4SSjWiaKbM0BEQo4Atxc4h5ndnFkMJch+tWBp/XK6RK
         mgEzLs9roSCYT8hs8pVD7TrHzAlfCCadQ7rktJ5XGxTSMzc0Swxo1QXpmUXqkNolGe
         oQf1bQAMXOoemPc834iB+lPA1LdIKb/BYyGxje3S/MNpKHtklD/SDXJiAguQ4lBvzT
         X2nWyHKTh1wuqiiu84jkuGXHqqz1vxm5mwpRu0HAztfV6FIA4TAYrCxXc6a5rDgrhL
         b67QtrE0qkhZw81ANto2eKecIv3/ckrlsht36GTESLD7rqgHGX6NOfNxLghEywVxe5
         JDN+QB+BHSbiw==
Date:   Tue, 11 May 2021 21:36:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Revert "ASoC: q6dsp: q6afe: remove unneeded dead-store
 initialization"
Message-ID: <20210511203628.GQ4496@sirena.org.uk>
References: <20210511190306.2418917-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dUqh8vgUBVXHzm9w"
Content-Disposition: inline
In-Reply-To: <20210511190306.2418917-1-nathan@kernel.org>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dUqh8vgUBVXHzm9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 11, 2021 at 12:03:06PM -0700, Nathan Chancellor wrote:
> This reverts commit 5f1b95d08de712327e452d082a50fded435ec884.
>=20
> The warnings that commit 5f1b95d08de7 ("ASoC: q6dsp: q6afe: remove
> unneeded dead-store initialization") was trying to fix were already

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--dUqh8vgUBVXHzm9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCa6ssACgkQJNaLcl1U
h9DIUgf+MIzhdPlCE4pqiMs8Z8GCjZzrob0CFLVObb8Yd/af0k9sJih8nRwUU8ky
SjtaSKw5YKGxmJrxhdwvHJkHbHxEiFOWGx3vU+N+VfQF/V1T8gLPckD7NRHMpCjf
M4MTyx+Ng8hAl1VG5pel0cKGvQjjtnt7e4BZMi5aTCVdHaVii8Lej1d5dRiD1Nye
RGeeZiJO4CyTvgak0gqsWvg0TsNIPmnS4rwl2iLkL6WyU9JPHPrFJucLC6rN/XQt
LhK1MpMwI1j+gCZrfqZBQh73b+xU0GPSMfHxf/R7lyRrlZ978bND/HhNFomLawW+
y8KMd3DO01gob1VebP0hSoXn/++2wQ==
=V9XP
-----END PGP SIGNATURE-----

--dUqh8vgUBVXHzm9w--
