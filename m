Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DB239F843
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhFHOBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233095AbhFHOBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:01:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8E3761351;
        Tue,  8 Jun 2021 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623160788;
        bh=R9hf4ZVc2SpqzMLGCW7d9b+1S3+YNbGXeQifqiTAfl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+E6tajR6HcynJTDe6jhyeDxhcUbz8PDUe3m5Bn9ZjdTNnhwanFV1QRuBhKvUr2Kh
         2kJgKdlH3nUWAIshi2RnUvWItkIPJXX8IveiO4q2KfiUKy2R3OOnaG67XMmQc0+nXW
         Jb9Jh2d/kBCoYyqFQaWdjn6xuv8GUNKhsmSCNMhtKWevAhZebfAorUaDk/XgzkId3d
         gaD194pzsnyh4fBBGXy4V64rUv6RqBx7vf1jBylXqcM3+PxEib0lf9zt29S7pFmpbh
         C1eMYMALyAoOfmOwADs2ekTxbgD2YlDoghwECRM3/EbFSnlm9GFxnk/jDKgJ0t/u3t
         oZu3mR8iOA4rQ==
Date:   Tue, 8 Jun 2021 14:59:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v8 6/9] ASoC: codecs: wcd938x: add basic controls
Message-ID: <20210608135933.GE4200@sirena.org.uk>
References: <20210601113158.16085-1-srinivas.kandagatla@linaro.org>
 <20210601113158.16085-7-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
In-Reply-To: <20210601113158.16085-7-srinivas.kandagatla@linaro.org>
X-Cookie: Auction:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 01, 2021 at 12:31:55PM +0100, Srinivas Kandagatla wrote:

> +static int wcd938x_rx_hph_mode_put(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
> +
> +	wcd938x->hph_mode = ucontrol->value.enumerated.item[0];
> +
> +	return 0;
> +}

_put() should return true if it made a change, the same bug is present
in a lot of other drivers too.

> +static const struct snd_kcontrol_new wcd9380_snd_controls[] = {
> +	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum_wcd9380,
> +		     wcd938x_rx_hph_mode_get, wcd938x_rx_hph_mode_put),
> +	SOC_ENUM_EXT("TX0 MODE", tx_mode_mux_enum_wcd9380[0],
> +		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
> +	SOC_ENUM_EXT("TX1 MODE", tx_mode_mux_enum_wcd9380[1],
> +		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
> +	SOC_ENUM_EXT("TX2 MODE", tx_mode_mux_enum_wcd9380[2],
> +		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
> +	SOC_ENUM_EXT("TX3 MODE", tx_mode_mux_enum_wcd9380[3],
> +		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
> +};

Please don't use this pattern of indexing into arrays by absolute
number, it's error prone and hard to read.  Just declare static
variables for the enums and reference them individually.

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC/d8QACgkQJNaLcl1U
h9BaYgf/X23DLW+LGGdVIwyniq5WCdfl7Dc/btd+vAgkelUwclvB6Pl1Zw66kuVZ
0Vl+eDcoldYEFDznPWS+TOyWkSs5MGmttYtMmmf9EEznvLJvHiNnbKgmXXas2VQm
m3eu6nCCy5ZKoG0kNmsvjS8HUtMAtu3+oTS5KO4AZThEK/o0ujnztR9szPXkHP/0
pIRsfKiuDjNLis5fWeb1OAc0Pu+2mujfiII48rj0BTHzLLaPKHxiblt5t8T472TT
38wnhKbCQvQimxd5owse/dM31lcTVx0HCEGnlOIE/rSjiCgJrOfnszN4IMZLgzST
aQAeTfaRDEGkYFWDHuS/1W+9HW02aQ==
=hi4X
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
