Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DC240C706
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbhIOOHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233698AbhIOOHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:07:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D18A9611C1;
        Wed, 15 Sep 2021 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631714743;
        bh=Ws9yGIaeY4LwjCKo4SCOy48ayUoiS/Ue1HGfmbl/G/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AwCyOdY0bug+kZb37qkxGrSn09F80r7jrtyHZoOvfS8WY9+KV6ZJ3vn/N01LXXRyo
         AE0/8tZE+ULn8n9nWNAfU8qdHwlrBx/9ySa+Chh96mA3HpaF5WxzF9Yq4yLOzOul8n
         u0wPrzEFzeFAGuQenmebT0HFDH+Bjl1nQ43JrWELInXP5MfO3hphSWkeWJyJAIiBB9
         VbdYpIB/5atHU23obtf9gc5oYdLoi5EV3umla/+DkQgPEtTfp7YP2874RE3UH5fjad
         JwPsSZwtOvhBMSKf+WBcO4s3X1BWHOXbEUoN9whm8+0NDJrPmhHLgV6PnCGU3S6k4U
         C4zKFMMbJiKKg==
Date:   Wed, 15 Sep 2021 15:05:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/4] ASoC: rockchip: add support for i2s-tdm controller
Message-ID: <20210915140502.GB12513@sirena.org.uk>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
 <20210903231536.225540-2-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <20210903231536.225540-2-frattaroli.nicolas@gmail.com>
X-Cookie: The more the merrier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 04, 2021 at 01:15:33AM +0200, Nicolas Frattaroli wrote:

A few fairly small issues here, nothing too major:

> @@ -0,0 +1,1832 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ALSA SoC Audio Layer - Rockchip I2S/TDM Controller driver

Please write the entire comment as a C++ one so it looks more
itentional. =20

> +	xfer_mask =3D (tx ? I2S_XFER_TXS_START : 0) |
> +		    (rx ? I2S_XFER_RXS_START : 0);
> +	xfer_val =3D (tx ? I2S_XFER_TXS_STOP : 0) |
> +		   (rx ? I2S_XFER_RXS_STOP : 0);

Please write normal conditional statements to improve legibility.

> +	spin_lock_irqsave(&i2s_tdm->lock, flags);
> +	if (on) {
> +		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +			rockchip_enable_tde(i2s_tdm->regmap);
> +		else
> +			rockchip_enable_rde(i2s_tdm->regmap);
> +
> +		if (atomic_inc_return(&i2s_tdm->refcount) =3D=3D 1) {

Why do we need to use atomics here given that we're inside a spinlock?
Surely the spinlock is already providing adequate concurrency
protection.  I can't see any other points where we don't have the
spinlock already, and I'd be worried if we did.  This looks like it
could just be regular variables.

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:

Please use the modern SOF_DAI_FMT_CBC_CFC defines.

> +	delta =3D (ppm < 0) ? -1 : 1;

Again, please write normal condiditional statements for legibility.

> +static int rockchip_i2s_tdm_clk_compensation_put(struct snd_kcontrol *kc=
ontrol,
> +						 struct snd_ctl_elem_value *ucontrol)
> +{

> +	return ret;
> +}

This should return 1 if the value changed.

> +static int __maybe_unused rockchip_i2s_tdm_resume(struct device *dev)
> +{
> +	struct rk_i2s_tdm_dev *i2s_tdm =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D regcache_sync(i2s_tdm->regmap);
> +	pm_runtime_put(dev);

Runtime resume also does a regcache sync so why are we doing another one
here?

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFB/Y0ACgkQJNaLcl1U
h9Ayxgf+JrmINVP/kRYs9tAdJd1AAk2R/J6FzgsqYkoGs1jumY4BJKwqI6hCOlZP
1fl05QVBxFQwiYMCZpt4Rk/rCY43ZjcgmN78GEniVphrvsTMxBuU35HdFsmEehSp
CxSXwX9Uvza+9IHrMV/G/HFFUpoCpGj8DSvOXsgcfiRI4fZ0es0j7MPxftXt5uvs
dRzCtJDj/nXm5lcadR2TMJQ5GBQ9x8UyaEzG2E4bEJeKyARlx0NQAf2am3nArjWn
l97mreV2jf+77Jy3IA9Y2eyaCQQHLIbL5F5JoxyZc4IX5fWxXdW/PWUzTw6sWAwo
p2PZXOYxFwZY/TkFeZ9UkKROFucb4w==
=kat+
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
