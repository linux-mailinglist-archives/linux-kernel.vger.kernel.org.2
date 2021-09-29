Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E65D41CD76
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbhI2Uhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345611AbhI2Uhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:37:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6BB261159;
        Wed, 29 Sep 2021 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632947770;
        bh=3lllaYs+S6Ey09XkIhSNMU+u/KeAbgR4JlFyct3EyMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEh3fKbfFwZaC46YzBr4VbejltCE5sWcEokQFoQ8JRQ7ZfUkHPRAo62l2NHzlmDfn
         PWadAGZ7pxuVyGpQ9+3eJT4uO7AhL3QzFomxZrBQDt2EPdHKDETSAv0AJK5uAH5IVf
         5deud42kP9EBbABaH64DcP4OBC3Yq0Vyx3uQm0mv9kbBXEKli+o+xXn1HfGwCmWJGg
         CHGFQwOuUe0RsB6IPn3CKbQrqDq5/OmwcN3op81/ohvYFKf+5iJ9JPoMmxvZW+XbPK
         +Q1IcuenlJ+o8kQ5iyEry2f1SmXzSvMWjQaIjRhWpy2IMtGOcPaBYUpr1MjyiWYxFq
         9tIfQr5X0QK4Q==
Date:   Wed, 29 Sep 2021 21:35:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Simon Trimmer <simont@opensource.cirrus.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        'kernel test robot' <lkp@intel.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Fix compilation when debugfs is disabled
Message-ID: <20210929203520.GV4199@sirena.org.uk>
References: <20210929145040.793252-1-simont@opensource.cirrus.com>
 <20210929145222.GR4199@sirena.org.uk>
 <003301d7b546$7e33c860$7a9b5920$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="22hJjvOmZW2O/jbw"
Content-Disposition: inline
In-Reply-To: <003301d7b546$7e33c860$7a9b5920$@opensource.cirrus.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--22hJjvOmZW2O/jbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 29, 2021 at 04:27:19PM +0100, Simon Trimmer wrote:

> Yes there is one for the cs_dsp_init_debugfs function though the compilation
> failure the bot
> detected is with the parameter dereferencing the disappearing
> snd_soc_component member.

At that point just remove the conditional definition in the struct, it's
not like a single pointer in a struct we are likely to have well under
10 of in the system is going to make an appreciable difference to memory
consumption.

--22hJjvOmZW2O/jbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFUzgcACgkQJNaLcl1U
h9BIigf/XIh8MnRPfBjtHh63Awrd2Rw/P/IQoyYPxJPTrgwoK04ilK4fnuHAL1Fh
4ZblmurDm7b/3Q95k/T/Ip3Cb6GjF4uSdUxkCfPoezHLfTMMztmiEqwvVOdJ/bOn
AIs74ei31AYNh01OIIB6NgGlNOI14MNnqjaa5fCYy7XTrt4xxa/iKDKYMVZmLvD4
OeXYXf8pOvZ3hXtZoJ6GEsbMLkYifX3X9Hx/5En1WLSd550zM9kV3oswuajmET49
uoByxHrsXfUayHNFVxi9P3qv39FyY/qpy7UTZ1+F+8qFCyDls5N0jEGlSt6/+NMX
ST5JORCK8oDJs+Gh9JnqlYEdIsWB/g==
=pGRN
-----END PGP SIGNATURE-----

--22hJjvOmZW2O/jbw--
