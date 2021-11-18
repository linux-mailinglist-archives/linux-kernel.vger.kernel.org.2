Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B786F455D16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 14:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhKRN7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 08:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhKRN7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:59:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C1AE61A88;
        Thu, 18 Nov 2021 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637243814;
        bh=WyD60zF4TADv7Odqa4b6XduvB11Zc9zW6/nl4Y+HIfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSNT3NisYQGLoK+k8jV9XStEAIBSLtOy3AwfJ3ZsSdbitcJgpSr45ucmlAkBoM1q0
         cFrD8wtYUSDxLvO76PmxuTmrsSpE2XY+lNKTGYAo9CEqBKa7/is0HSuNRXSDeIb/aD
         eVQyF3z5QqqpTDmPvF2q90VPMs2bKGtG8Zctjs5+JwqTOLA6gZVWXqJTcgo8C624kz
         +tB42/Jj7G5+Rdv4ff29qSci9IFMLFnYxf9KOiPuXOIAQzsmYWgFQtI0q5mU24jGRo
         aOlghhOy1yLc0genpTVf7xhF9rNw0rOF0XpMWGJMF18nVklg91gQEsVE1TYKEFBKDA
         CD0553Ou1FGlg==
Date:   Thu, 18 Nov 2021 13:56:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/3] ASoC: stm32: dfsdm: add pm_runtime support for audio
Message-ID: <YZZboeQpqK8CwmL+@sirena.org.uk>
References: <20211118090035.5331-1-olivier.moysan@foss.st.com>
 <20211118090035.5331-3-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/HMgHyk9z9XITysq"
Content-Disposition: inline
In-Reply-To: <20211118090035.5331-3-olivier.moysan@foss.st.com>
X-Cookie: People respond to people who respond.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/HMgHyk9z9XITysq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2021 at 10:00:34AM +0100, Olivier Moysan wrote:

>  	ret =3D snd_soc_add_component(component, NULL, 0);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(&pdev->dev, "%s: Failed to register PCM platform\n",
>  			__func__);
> +		return ret;
> +	}
> =20
> -	return ret;
> +	pm_runtime_enable(&pdev->dev);

Enabling runtime PM after registering the component may potentially lead
to a race where something manages to go in and starts using the device
including what should be runtime PM stuff.  That'd lead to a reference
not being taken that should be.  It's unlikely to actually happen but
it's better to be safe.

--/HMgHyk9z9XITysq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGWW6AACgkQJNaLcl1U
h9CLGAf/ZPgpWw+sUfS92Ur9sKBg2iJ8B0peY+lx9xIeWYpe4VUroAOLj1ZPvJGA
FuarngOZVU6HQb9qTBibk10pwkoYkyvH5g7wqCtj54sQQLx0TCD94mxFEx10ag33
/4WbSlYmxgC4W2xLr5acaPCaik8qm2qQMMaNIYLyZpFgPya1cSAxUnUC8FMr5erl
tctUP/CIoF7vBR+u+96lVB4BDqm0kQFGo8ftUg+h1kxf1gtEV/eD/Y1gCFZ1O/SW
6IN5K1ATFMZPHNUMkEpPLt23NCLinzdkxy2/eF87sj+gkDk+7fbgya/deQmu5oLL
0y++J0llhfmrUPbM25n7D//VjII/PA==
=OGhT
-----END PGP SIGNATURE-----

--/HMgHyk9z9XITysq--
