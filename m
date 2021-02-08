Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800C3313D83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbhBHSa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233699AbhBHQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:10:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D07B464DF0;
        Mon,  8 Feb 2021 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612800562;
        bh=0r7EFWA3/TE6ZV9vLRgre43wSwtaomAWRjcEc4vmFu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOvsbfwF4KSVBmzD/1qj4FjM38TK1t5Mvh9JUpyQ8/rWuP4AbY9ZQ234D9hMWuxPi
         ZQDRRW3D0YqpDvdEu9pyPdr8yi7M5E965qVK6m/xw10VroMsJHINt+phllwzSbabAZ
         ZG5XHx1V2KDv3iwXStGR1mW4kj/9jpVnl6yrskiwJu7TgbBYnyaSjKbiCj/Ti+UcHw
         UYlDmkR1+og0vCa8oJFfFSToxWLUihPaeSCmkU01Me5b6FPAdPJc7eJ6wOrDVKSdEL
         9c0HPaCdP/TiW7R49Xqyh+tyF1/Na2v9at03ihoek+vHRa4hYENnfs5yBKVpbRe4je
         VKa6dUO99bQug==
Date:   Mon, 8 Feb 2021 16:08:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 2/7] ASoC: codec: lpass-rx-macro: add support for
 lpass rx macro
Message-ID: <20210208160830.GI8645@sirena.org.uk>
References: <20210208141719.23305-1-srinivas.kandagatla@linaro.org>
 <20210208141719.23305-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Content-Disposition: inline
In-Reply-To: <20210208141719.23305-3-srinivas.kandagatla@linaro.org>
X-Cookie: You will triumph over your enemy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 08, 2021 at 02:17:14PM +0000, Srinivas Kandagatla wrote:

> +	SOC_SINGLE_EXT("RX_Softclip Enable", SND_SOC_NOPM, 0, 1, 0,
> +		     rx_macro_soft_clip_enable_get,
> +		     rx_macro_soft_clip_enable_put),
> +	SOC_SINGLE_EXT("AUX_HPF Enable", SND_SOC_NOPM, 0, 1, 0,
> +			rx_macro_aux_hpf_mode_get,
> +			rx_macro_aux_hpf_mode_put),

These are simple on/off controls so should end in Switch AFAICT.
Otherwise this looks good.

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAhYf4ACgkQJNaLcl1U
h9C62gf/diIBpdPwSy/dQ9FyjTxlRvQ8YgXHyIgxJph8g1/PS6SiP9o8g6UWFbtM
8ZVD5mqT1L+WiczOlCGy+uQwgXLL2y5GvtzcuaogTizMvjf3Vm0Qcv1CLAgxw3bj
U/PIbxNxDuAF2v8wp6GIrtrHGYQ4oPoSWv4nq5joooXiKB+77i+XjQu2/nYsnqEy
gBDDCYetYYdhekoQZu5E1B9neZWC3svCFG0h8lgfYnZ/WwMDc72Ix99Cvr/bW5yC
VDHX/qrExutLOlXY3d2SWOfGgQG56p+zof74szk2A8we1LHEOfFBzN33sYBS8xyA
jpu0IqyQTDgLc/3Huy7tCeQxaPPdvw==
=IuI7
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--
