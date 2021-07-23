Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5B3D3A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhGWL6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234601AbhGWL6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:58:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DBF860E53;
        Fri, 23 Jul 2021 12:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627043935;
        bh=0ZhPfnH1OhnF/cYjLRYyMudFiGrvs2geVpsqJ7x/D8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+pkMfAxaUT820kt6s0AoMLNUnxBV8oz1QyTBQrWQGbpKx2qO2tfiIKEmymHpdxC2
         FF0FQLgYEGDeEYgRDScBsdLIunvVlxGPPDLMnCKrFjo7+fRPgdWs+JHUrwS6K9MV8V
         TT2w+ve90LzI/CNG9TInNb3viQ9dF650MmY8OY0Q+BoTidOw9cSZUfVEei6ROKJy/7
         gyJzgtPRzeh+h625uMyq3AbogSfQEdoT6giSh+/LifMMbaATdDzeoHWg0w/9QiOrWt
         HVbs1bcNRXU0U/I1OpYpC2n0vfkJp3ibLyDqXp4qsT54IYdK+1XJhpRX2kP7UCqT/G
         e3C1LgBevobQw==
Date:   Fri, 23 Jul 2021 13:38:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        markpearson@lenovo.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: amd: Don't show messages about deferred
 probing by default
Message-ID: <20210723123847.GB5221@sirena.org.uk>
References: <20210722132731.13264-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <20210722132731.13264-1-mario.limonciello@amd.com>
X-Cookie: Integrity has no need for rules.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 22, 2021 at 08:27:27AM -0500, Mario Limonciello wrote:

> This isn't useful to a user, especially as probing will run again.
> Use the dev_err_probe helper to hide the deferrerd probing messages.

The reason we have these error messages is that they are very useful to
users if they ever find that the device isn't instantiating due to some
missing dependency or something that leaves it stuck in probe deferral,
they give some hint as to what might be wrong.

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD6uFYACgkQJNaLcl1U
h9C20Af/W9aBN7CTPXDnMpzPeDXvrk4xTgYBRCAuOojPAcX73L1AKsQISSiW5fRn
mNRwRQxiO+pD8gv43kncC9qJVaqlE8R6mXZ6t2EAyBYs7Uz0/eb0yRuBz6gbUcZa
uCoM8qmJeHDANkKCHeXkJltREk+7a1e9A0YOmgRyL59NUvAscx3pUlUWftx5T/sb
YXzIa0NG3Vmt/kKGTQHx0pSihwKBhHacZvta73KVeJkON1Kso9zwGUBQvPLIr4Ic
OqlcdFsv2OMDUVg079+1piHS3VRJPypTMbmq1zsDFgQK4h5v4rUjCgkVBnHdUGUS
XZns8VNDHxbNPNnM9hyIQUfygv6GyA==
=TmFf
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
