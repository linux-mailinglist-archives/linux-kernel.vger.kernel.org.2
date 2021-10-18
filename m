Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744F84319C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhJRMtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231548AbhJRMtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:49:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A48160F8F;
        Mon, 18 Oct 2021 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634561214;
        bh=G+OtVSihKHgS3rS/qDD5HXpv3eDV+Hn9lxSng8pjIB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkUwXAuB5mLgOixx5LY7oUOpM2KezFLhdaVcdBsGeHANlA3B9aAqlsN0S/cfbvBVf
         kuHSG8felsWBIwwuC5kRgDHgN6oAbjuCVgBM5Ugb6wZrEdXieWp9GRqluj9kF5WM3u
         hXcKkyjgyize8KNVfyrekZ9FHrPNBFJn7E4OIXq71AyvIERRk9czHV7FB1I3fErZeU
         CklDxxcChO8YiQHdos/MqrmUgsLtYIOxZrqA8tI+JnLRB1+fxL+URqlXsOH/5s1pWI
         EV+uM/NfVqmc3RWYAa4bNLNR22jUQun+VaJGc5AYeCNk8K4/kJT2qSVLavuLkvg7SA
         CMvK31BQlzWRw==
Date:   Mon, 18 Oct 2021 13:46:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: Re: [PATCH] ASoC: rockchip: use generic DMA engine configuration
Message-ID: <YW1svMVSgBJygfpV@sirena.org.uk>
References: <20211018114844.1746351-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LLIdPGt+BVjw3+wI"
Content-Disposition: inline
In-Reply-To: <20211018114844.1746351-1-john@metanate.com>
X-Cookie: Here there be tygers.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LLIdPGt+BVjw3+wI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2021 at 12:48:44PM +0100, John Keeping wrote:
> This effectively reverts commit 75b31192fe6a ("ASoC: rockchip: add
> config for rockchip dmaengine pcm register").

> There doesn't seem to be any rationale given for why these specific
> values are helpful.  The generic DMA engine provides sensible defaults
> here and works well with Rockchip I2S.

> In fact the period size here is really quite restrictive when dealing
> with 8 channels of 32-bit data as the effective period size is just 256
> frames.

Copying in Jianqun who wrote that patch.  If you're reverting a patch
it's generally good to make sure the original author is aware,
particularly if you're unsure as to why the patch does what it does.

> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  sound/soc/rockchip/Makefile       |  3 +--
>  sound/soc/rockchip/rockchip_i2s.c |  3 +--
>  sound/soc/rockchip/rockchip_pcm.c | 44 -------------------------------
>  sound/soc/rockchip/rockchip_pcm.h | 11 --------
>  4 files changed, 2 insertions(+), 59 deletions(-)
>  delete mode 100644 sound/soc/rockchip/rockchip_pcm.c
>  delete mode 100644 sound/soc/rockchip/rockchip_pcm.h
>=20
> diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
> index b10f5e7b136d..6a3e61178152 100644
> --- a/sound/soc/rockchip/Makefile
> +++ b/sound/soc/rockchip/Makefile
> @@ -2,11 +2,10 @@
>  # ROCKCHIP Platform Support
>  snd-soc-rockchip-i2s-objs :=3D rockchip_i2s.o
>  snd-soc-rockchip-i2s-tdm-objs :=3D rockchip_i2s_tdm.o
> -snd-soc-rockchip-pcm-objs :=3D rockchip_pcm.o
>  snd-soc-rockchip-pdm-objs :=3D rockchip_pdm.o
>  snd-soc-rockchip-spdif-objs :=3D rockchip_spdif.o
> =20
> -obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) +=3D snd-soc-rockchip-i2s.o snd-soc-r=
ockchip-pcm.o
> +obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) +=3D snd-soc-rockchip-i2s.o
>  obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S_TDM) +=3D snd-soc-rockchip-i2s-tdm.o
>  obj-$(CONFIG_SND_SOC_ROCKCHIP_PDM) +=3D snd-soc-rockchip-pdm.o
>  obj-$(CONFIG_SND_SOC_ROCKCHIP_SPDIF) +=3D snd-soc-rockchip-spdif.o
> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockc=
hip_i2s.c
> index 7e89f5b0c237..a6d7656c206e 100644
> --- a/sound/soc/rockchip/rockchip_i2s.c
> +++ b/sound/soc/rockchip/rockchip_i2s.c
> @@ -20,7 +20,6 @@
>  #include <sound/dmaengine_pcm.h>
> =20
>  #include "rockchip_i2s.h"
> -#include "rockchip_pcm.h"
> =20
>  #define DRV_NAME "rockchip-i2s"
> =20
> @@ -756,7 +755,7 @@ static int rockchip_i2s_probe(struct platform_device =
*pdev)
>  		goto err_suspend;
>  	}
> =20
> -	ret =3D rockchip_pcm_platform_register(&pdev->dev);
> +	ret =3D devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Could not register PCM\n");
>  		goto err_suspend;
> diff --git a/sound/soc/rockchip/rockchip_pcm.c b/sound/soc/rockchip/rockc=
hip_pcm.c
> deleted file mode 100644
> index 02254e42135e..000000000000
> --- a/sound/soc/rockchip/rockchip_pcm.c
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (c) 2018 Rockchip Electronics Co. Ltd.
> - */
> -
> -#include <linux/device.h>
> -#include <linux/init.h>
> -#include <linux/module.h>
> -
> -#include <sound/core.h>
> -#include <sound/pcm.h>
> -#include <sound/soc.h>
> -#include <sound/dmaengine_pcm.h>
> -
> -#include "rockchip_pcm.h"
> -
> -static const struct snd_pcm_hardware snd_rockchip_hardware =3D {
> -	.info			=3D SNDRV_PCM_INFO_MMAP |
> -				  SNDRV_PCM_INFO_MMAP_VALID |
> -				  SNDRV_PCM_INFO_PAUSE |
> -				  SNDRV_PCM_INFO_RESUME |
> -				  SNDRV_PCM_INFO_INTERLEAVED,
> -	.period_bytes_min	=3D 32,
> -	.period_bytes_max	=3D 8192,
> -	.periods_min		=3D 1,
> -	.periods_max		=3D 52,
> -	.buffer_bytes_max	=3D 64 * 1024,
> -	.fifo_size		=3D 32,
> -};
> -
> -static const struct snd_dmaengine_pcm_config rk_dmaengine_pcm_config =3D=
 {
> -	.pcm_hardware =3D &snd_rockchip_hardware,
> -	.prepare_slave_config =3D snd_dmaengine_pcm_prepare_slave_config,
> -	.prealloc_buffer_size =3D 32 * 1024,
> -};
> -
> -int rockchip_pcm_platform_register(struct device *dev)
> -{
> -	return devm_snd_dmaengine_pcm_register(dev, &rk_dmaengine_pcm_config,
> -		SND_DMAENGINE_PCM_FLAG_COMPAT);
> -}
> -EXPORT_SYMBOL_GPL(rockchip_pcm_platform_register);
> -
> -MODULE_LICENSE("GPL v2");
> diff --git a/sound/soc/rockchip/rockchip_pcm.h b/sound/soc/rockchip/rockc=
hip_pcm.h
> deleted file mode 100644
> index 7f00e2ce3603..000000000000
> --- a/sound/soc/rockchip/rockchip_pcm.h
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (c) 2018 Rockchip Electronics Co. Ltd.
> - */
> -
> -#ifndef _ROCKCHIP_PCM_H
> -#define _ROCKCHIP_PCM_H
> -
> -int rockchip_pcm_platform_register(struct device *dev);
> -
> -#endif
> --=20
> 2.33.1
>=20

--LLIdPGt+BVjw3+wI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFtbLsACgkQJNaLcl1U
h9CjRgf9F+1fSarPqDt2LrsQCEJcgFE78KkSwsP7XCT32GaDY2NnjgXK+nVA67eD
VD1St/hwPnZEeVfebQ8xA/koS9D3KVThkt6UEpoD1XOI3BIBhc2pFMCifaZC+rFX
IO8CV0Uh/AEIR8rjjnvXp1UfAHJcwhh9bNuveQKrIksLn0ugcGam0PauIYHpIgQU
6hunuhaO7qH9lwW2Ba5mRB3/+q5bvKIL/6yBmAqLIxBpitqrTaLsTBr2J1D7mFJU
yHkdigqW5y05+RMkJ/csW/ile0qeWQZ9fMSN5epOVpkMob7nuO37gXcfze5Lq0AY
elcIUkNlkR+iYcbu0ruxERwy9tjq6Q==
=ej6A
-----END PGP SIGNATURE-----

--LLIdPGt+BVjw3+wI--
