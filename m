Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5BD3C8892
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhGNQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhGNQ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:27:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A573461106;
        Wed, 14 Jul 2021 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626279856;
        bh=ydb3bROEvCOilFapPnKxoGtuhQaXeTXNdteDjVKfyIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKnUVgN5Vuj1Xmz2RRwq631aSQ4uiLZdgsPhSjSkXWpj/uHQ8Jmy3IvnQmSUEfPwT
         11m8uzFLs7Cw/BEjuHqNR8m9LlynlV32YhjUp1eGR+h5c18cIOlv0U3x+7Fe/uv/gb
         9SaMsAzCIQboNDfl6sQS4RTAtZsTggaa+wDI7z7JvPQv7SF6iJRpYtigVKmvr9yuYB
         N5lhzQileVGiG/ISOyLZm1k9ievTEcE3X2AQH4UcBq4OYvuSPX/thWnXcpmtd5XGUy
         3W3L+/PeJT2OwQpRBl/G5Nakb/ggDmUSs7gDiSR74LO9mHPrHogj9H5JtZPm1ULIT1
         w0KlfpiSsmGQQ==
Date:   Wed, 14 Jul 2021 17:23:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com
Subject: Re: [PATCH 10/12] ASoC: amd: add vangogh pci driver pm ops
Message-ID: <20210714162339.GD4719@sirena.org.uk>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-11-vijendar.mukunda@amd.com>
 <ce03f4b3-874f-a286-5523-7793722a6ee7@linux.intel.com>
 <b754ef05-065d-ee7b-754f-1498f7c6cff6@amd.com>
 <38def9e9-5161-9441-c88a-43b21edfec43@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline
In-Reply-To: <38def9e9-5161-9441-c88a-43b21edfec43@amd.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2021 at 12:06:38PM +0530, Mukunda,Vijendar wrote:
> On 7/8/21 5:11 PM, Mukunda,Vijendar wrote:
> > On 7/7/21 10:04 PM, Pierre-Louis Bossart wrote:

> >>> +static const struct dev_pm_ops acp5x_pm =3D {
> >>> +	.runtime_suspend =3D snd_acp5x_suspend,
> >>> +	.runtime_resume =3D  snd_acp5x_resume,
> >>> +	.resume =3D	snd_acp5x_resume,

> >> use SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS?

> suspend and resume callbacks implementation is same for runtime pm ops
> and system level pm ops in ACP PCI driver i.e in suspend callback acp
> de-init sequence will be invoked and in resume callback acp init
> sequence will be invoked.

> As per our understanding if we safeguard code with CONFIG_PM_SLEEP
> macro, then runtime pm ops won't work.

That's not what Pierre is suggesting though?

> Do we need to duplicate the same code as mentioned below?

> static const struct dev_pm_ops acp5x_pm =3D {
>         SET_RUNTIME_PM_OPS(snd_acp5x_runtime_suspend,
>                            snd_acp5x_runtime_resume, NULL)
>         SET_SYSTEM_SLEEP_PM_OPS(snd_acp5x_suspend, snd_acp5x_resume)
> };

Using the SET_ macros doesn't require that you duplicate the functions,
it literally just means changing the way the ops are assigned. =20

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDvD4oACgkQJNaLcl1U
h9CFSAf9GXJDYHFf1ZYbjnC5Y/psNti5ZQIkL894y7bQ1oR/KwYUHFEUKag4zOJa
UxaEGAEFQe2pcFefvMz8jo6MtARR3jgsoetUVHCQTLdoaEcdsP98XxCQX+cr3yXq
41LkTiKUl1EEiThrDUkDxPlVxzn46R17ilHVQquyAcUgdnZqNb2Ggk2I/HWySA/x
ZkSjs8O7cIi0Z90c9qLVoFJRMY4SPvZ9hcf6aEbu/0eo24kWnt21bxD0V03y9u9D
fN6UlPF3anejGy3w+B78Ih651m4khWzqqEGYTtXcF6yAll7CYGOSHdMIQVKCd3AI
VI5Maa4nX676OciEdgu0YfOmZx3VUw==
=9L9r
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
