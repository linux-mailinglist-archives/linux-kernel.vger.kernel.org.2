Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985433BEC0F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhGGQ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhGGQ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:27:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BCBD61C94;
        Wed,  7 Jul 2021 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625675097;
        bh=FrZ7lnIR8kbHoEaqMeImBiQvI3K420lQpmnEhxnTXlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMdkB7cT+9jVit2hcOQ8e7hPNknUM4xT60xfWR8SUBYDRo6K/1WD7F4QHNSF7ez3n
         QUbOcYOMsxJ9Y+gNoO/4UUw0kurIo9lCyu8Q35hSy7Zz6e+0MFkoKcsCrOydJQ+G8H
         6QATKqmoC1O3RG0cYVXJvE2qBuAlwPlex1DyAQX5m2s3yEc/2/ejHvc5vgQe2epYcL
         inphohA/+IS/1q67Q+JGkiQCccvMqeNN0CpdMnarSr2qaSFFaLwki0R0t5dDVwrkpj
         JfE72CAzgz8mKrEMKG/XGT/hV4Xe0QclqVvxqxmiBXOU33/QaJYzozKodFW1+us1PB
         yv7C+e0nkRC9Q==
Date:   Wed, 7 Jul 2021 17:24:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Alexander.Deucher@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/12] ASoC: amd: add ACP5x PCM platform driver
Message-ID: <20210707162420.GG4394@sirena.org.uk>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-6-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline
In-Reply-To: <20210707055623.27371-6-vijendar.mukunda@amd.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2021 at 11:26:16AM +0530, Vijendar Mukunda wrote:

> +static int acp5x_audio_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

Just drop this since it's empty.

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDl1TQACgkQJNaLcl1U
h9Bl/wf+NASniwPTqh5edicrCqrledhvgq7OHSfBhZgkENpTfRvQXzPtY8VtGLSd
uZZVOvGkYvJ1YnkQesSJ1eqS4cyw4h89nMpkYpdSDcTUUAddx5XDzpOGaTmk5l9h
xrqiz5/8Z+5whY46ghBVeUrXGwjpTWV79VOEr7P04W0fiXptZTSr4gt3CNWQ52Pq
m16geLY7rw/pCX1CxkFUU/NbLluUXs1zOnkZ7otIpURYl3Kc+dRGL62UfR2GZGrx
uIicA++1cqgc+8EhERsf7oyUAkovp2SH3x/AEJhms5Hc8/zrGmaoH3utM4wdbADO
Pb4Nb/9NMEqLwvGBy/tjFNcALh5MlQ==
=N3r+
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--
