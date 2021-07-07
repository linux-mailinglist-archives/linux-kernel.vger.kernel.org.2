Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1C83BEC57
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhGGQiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhGGQiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:38:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00DF761CCD;
        Wed,  7 Jul 2021 16:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625675739;
        bh=wC1t42xqWGR0RBPg6A/QyuiDHZS2a+3Q6OIeA/572BU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LoFsrlWlJB19jNSBTDCnly/dtCrjarMSikpPrNi/demCkZs5tBR72NUMmbj+RUEz7
         Yb7Pua10fb9XZKk+FRB3miS2GvCB9QZLalrrWVlzqIpIIA/EnVkNcI3e7+nrhUiHZS
         ciRa3EneQicv9o/3Igf5XJlnEdgs6KJ5pxvejEuwU8h8j3tEB7tHAxOIrCG1jRvG6p
         d9BGX2sw7YI1oMFPZWppiDYGLG0PC0Y5XWudKL3SP37nQRRLCsfBtZajFCy8ri+srC
         Zc5X/VXfX4ylnlOU+gnNBt0EP/cb9Hg9PVyUUFWpbkcJ01343ToAf0YH55NlVWYLxf
         NccjmLr0mPhNg==
Date:   Wed, 7 Jul 2021 17:35:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Alexander.Deucher@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/12] ASoC: amd: add vangogh i2s dai driver ops
Message-ID: <20210707163507.GI4394@sirena.org.uk>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-10-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZVh52eu0Ophig4D"
Content-Disposition: inline
In-Reply-To: <20210707055623.27371-10-vijendar.mukunda@amd.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZVh52eu0Ophig4D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2021 at 11:26:20AM +0530, Vijendar Mukunda wrote:

> +	mode = fmt & SND_SOC_DAIFMT_MASTER_MASK;
> +	switch (mode) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		adata->master_mode = I2S_MASTER_MODE_ENABLE;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		adata->master_mode = I2S_MASTER_MODE_DISABLE;
> +		break;
> +	}

As part of moving to more modern terminology it'd be good to move to
_DAIFMT_CLOCK_PROVIDER_MASK and associated constants (with a similar
change for the driver local constant) - see f026c12300 (ASoC: topology:
use inclusive language for bclk and fsync).

--YZVh52eu0Ophig4D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDl17oACgkQJNaLcl1U
h9AGwAf+PFey2i5kbYJ5CSOWJMW6PdybzvDUculaxKRphsGDic7OZk42xdyt2XzO
uraai+eNmVN+w9gpt+i1XAH8GPsmjzTWpB7QHGy8DWulldVFORxf9amqM9FVjKuF
L3mm58KZ62FFU3Ubrk/c79hfVToGGP4cAEC2jMW7+VLQYZ4boQYu4MiMynQkqt1X
kCtPm9CEtvcEGivIxFaCXtZQDmCAvP12TmR2dVVmjmOtubSbsyupiLy7PtsBtAud
ayN2859J3wztUuUUrGp3j6oXKmYL6MOF/m2tszsJAUBbeULDLuETuS23oNCIDX+u
nMadzz2vMFjZ9FMdocrT+xfISQEyIA==
=XEl9
-----END PGP SIGNATURE-----

--YZVh52eu0Ophig4D--
