Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CCA3BEC05
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhGGQZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhGGQZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:25:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61C0061CC3;
        Wed,  7 Jul 2021 16:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625674958;
        bh=U29NvKLbcyYlcwK2WiH8Qg9N0ElTvijubsFCX8RsD9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uYN+Gk7VQwPPove29S/489tRyCRhspLDGXO4/Ccs0UVHj6wBCyqy/tmhHNI2YBa3H
         lJDJ/oUOuDxRzplHWfaAcQb6ocN0GRPo71cmSer1Zm9O6ZRP7kPwfY7hzcI/NOZHAr
         lCI82roMiHqzTRpEVmDJFKyUYMfuXfgC/rMoocj3cV5NoIOMHJ30N/RYYpq7z3LsBA
         mPsBJS7vXT37b3LI8Fbtm34+GZSUDK1sXDEgR8PWgfyB8DbXtx2O6QIZZ0psX0D1X2
         9TiDwI5CYyEEEZnrAO6ELHSgbrj05kBOBw4eeR5QU4SjozlZM003I7cbmHxJ68OCwY
         FLXmM0KBlH7UQ==
Date:   Wed, 7 Jul 2021 17:22:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Alexander.Deucher@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] ASoC: amd: create acp5x platform devices
Message-ID: <20210707162206.GF4394@sirena.org.uk>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-5-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline
In-Reply-To: <20210707055623.27371-5-vijendar.mukunda@amd.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2021 at 11:26:15AM +0530, Vijendar Mukunda wrote:

> +#define I2S_MODE 0x00
> +#define ACP5x_I2S_MODE 0x00

All the other constants are namespaced so why the plain I2S_MODE?

> +	val = acp_readl(adata->acp5x_base + ACP_PIN_CONFIG);
> +	switch (val) {
> +	case I2S_MODE:

...

> +		break;
> +	default:
> +		dev_info(&pci->dev, "ACP audio mode : %d\n", val);
> +	}

Given that anything other than I2S is basically unhandled should we
perhaps print an error rather than just an info message?

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDl1K4ACgkQJNaLcl1U
h9DWMwf+MVbmxxNWKlGb8aozFC2M2Dp6VTwCCLIhTlRCW6L6EFSLxLLsBUyJ0LKN
H+AujbMfenRvP8qX3Vw+CoKzoJBF3mEWty7IOgeIXn/b/52JbMb+JMoz5bO76WNh
bv78UzpEzlKoCd3tssHeEvmD0hhiytjLu3yku90M+H4EtToNr11dtj1aJJI9ZF+e
j4TtxE79SaR9/s5Z7MJ6Y+3cJTCPWckqn6QyrjA5oanKFuvqjaQDIg1Su9/7xpMo
qE3cQsMKhV84R3qMU0yZ+hLOGW8mJmtWSTSDq26UH2zha5HqnzX2Bk+mKIX86Jdu
FgbUlzggVIj2T8TMxclwAx8wpE0KSA==
=nmcF
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
