Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4181833928A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhCLP5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232233AbhCLP5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:57:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2B8064FE0;
        Fri, 12 Mar 2021 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615564621;
        bh=ojGrFLtmo64nYFR3VEaVz3HJGIRiCZA8lbBQOasUvlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JQPcyht+hkriUsqzARGtHarLDLqucOxZk3Ax6yi9PSB9eDXY7CmN6yI9nJZfswjgh
         Q9d5KVGZvllDfJKyulFG9Q8IY75/fmcEtydpXrVXjCJzaUDTpPk/HeDnclvFqJL5MI
         yF6lYdNYTUHKiITOwf+JXVwe+e4tOeeYmyR0Ng1BSclGknUOTOhEdWdd0Q1OWY7PG8
         R+gWBTxpH8CqkeqP64E7tupY0i6tonndMPxAnwC/jy81cP+0MwJr5GbzgNaSCFlYX5
         +adE1/O1rjTMp8QKPfW8sdm+vMalHKYSJev3P+1wVe90xCcdOGAN46E0UiKUEGmV4h
         NNqNrWFbFwpZw==
Date:   Fri, 12 Mar 2021 15:55:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH 4/7] ASoC: codecs: wcd938x: add basic controls
Message-ID: <20210312155547.GJ5348@sirena.org.uk>
References: <20210311173416.25219-1-srinivas.kandagatla@linaro.org>
 <20210311173416.25219-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRtZRu2mMGBZ6YQ7"
Content-Disposition: inline
In-Reply-To: <20210311173416.25219-5-srinivas.kandagatla@linaro.org>
X-Cookie: Lake Erie died for your sins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRtZRu2mMGBZ6YQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 11, 2021 at 05:34:13PM +0000, Srinivas Kandagatla wrote:

> +	if (wcd938x->variant == WCD9380) {

switch statements please.

> +		if (mode_val == CLS_H_HIFI || mode_val == CLS_AB_HIFI) {
> +			dev_info(component->dev,
> +				"%s:Invalid HPH Mode, default to CLS_H_ULP\n",
> +				__func__);
> +			mode_val = CLS_H_ULP;
> +		}

If the value can't be set an error should be returned rather than the
input ignored.

> +static int wcd938x_ear_pa_gain_get(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +
> +	ucontrol->value.integer.value[0] = snd_soc_component_read_field(component,
> +						WCD938X_ANA_EAR_COMPANDER_CTL,
> +						WCD938X_EAR_GAIN_MASK);
> +
> +	return 0;
> +}

This just looks like a normal operation?

> +static int wcd938x_ear_pa_gain_put(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
> +	struct wcd938x_priv *wcd938x = wcd->wcd938x;
> +
> +	if (!wcd938x->comp1_enable) {
> +		snd_soc_component_write_field(component,
> +				WCD938X_ANA_EAR_COMPANDER_CTL,
> +				WCD938X_EAR_GAIN_MASK,
> +				ucontrol->value.integer.value[0]);
> +	}

Again, values should not be ignored on error.

> +	if (wcd938x->variant == WCD9380) {
> +		ret = snd_soc_add_component_controls(component, wcd9380_snd_controls,
> +					ARRAY_SIZE(wcd9380_snd_controls));
> +		if (ret < 0) {
> +			dev_err(component->dev,
> +				"%s: Failed to add snd ctrls for variant: %d\n",
> +				__func__, wcd938x->variant);
> +			goto err;
> +		}
> +	}
> +	if (wcd938x->variant == WCD9385) {

Again, switch statements - I'll never understand why people seem so
intent on writing if trees :(

--wRtZRu2mMGBZ6YQ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBLjwIACgkQJNaLcl1U
h9BaJgf+P8wVqvc+n6yTGoXc3vb0A59dDMzjY3jznMvKhtpHuapGd3Lfp7ZVKvab
JN2wkUtn2CYfScb53MvCNCb7hdmrL0vZdW/YwukyVzlvh8jkf430ylyjNQItQ+wn
VEK0OlhBwum8oYzi7QPxv3N6iI8xT5B6W5wf8IrPhfmXZBO7xtIojNb8MkWqz4VX
K3hkUgjhUFtTw8L2s0hxrurVCnp9R5lOm2SvAdnzxD+d6XLgAUwVPfEIWV21Bcvo
6BU73FDLauHJY5EtBfgZaOksCfuUBrRJ92yw+dKcXaU4AIsQhPmevJmD85DUPS8n
yajJqMi8LIWffoXD1CHbp+H2UJEZfA==
=AoLL
-----END PGP SIGNATURE-----

--wRtZRu2mMGBZ6YQ7--
