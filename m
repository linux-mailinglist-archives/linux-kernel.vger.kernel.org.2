Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031663131EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhBHMOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233466AbhBHLwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:52:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D08864E56;
        Mon,  8 Feb 2021 11:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612785124;
        bh=khj0Ksstxc70pqDkTZPUJ+hyC/Zp9C28p+//y1Izqto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VvzvTa2CGSU8UkdTZrHmjfVeGkhd0XP7bI1HvBXw/V8QYFT1n9oPXWw3P4dCeh9dp
         tCULJOL68X5Z3jNqhPLL5AEiqe+lcpuCh0agkKYK3FJT0wybkh7Bp19yf91R8Pflak
         HOI0rKKPO3vrtR1vrzPjMbolzWlDN4nZj8thr4+cuqzyBbIs1RGwzEjP4Be9M8emAP
         Lv5vFes0K36m8a+xQE4YITlivDNLMTIHb99O1Ra1Gvlg2qvfXNE4Q+P5X0jlVlz4JX
         TmJYjy+CZiQ0J+AaWkwPO36/DYtDMUkkEQ3cIPSo+79MspG7YMmnOTet1h+C9B91o3
         AwBHSmtUNL3kA==
Date:   Mon, 8 Feb 2021 11:51:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, linuxppc-dev@lists.ozlabs.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio
 base on rpmsg
Message-ID: <20210208115112.GD8645@sirena.org.uk>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: You will triumph over your enemy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 07, 2021 at 06:23:50PM +0800, Shengjiu Wang wrote:

> +static int fsl_rpmsg_hw_params(struct snd_pcm_substream *substream,
> +			       struct snd_pcm_hw_params *params,
> +			       struct snd_soc_dai *dai)
> +{

...

> +	ret = clk_prepare_enable(rpmsg->mclk);
> +	if (ret)
> +		dev_err(dai->dev, "failed to enable mclk: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int fsl_rpmsg_hw_free(struct snd_pcm_substream *substream,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct fsl_rpmsg *rpmsg = snd_soc_dai_get_drvdata(dai);
> +
> +	clk_disable_unprepare(rpmsg->mclk);

hw_params() can be called multiple times and there's no need for it to
be balanced with hw_free(), I'd move this to a different callback (DAPM
should work well).

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAhJbAACgkQJNaLcl1U
h9AJqwf/X2Soo9XPi4+IXcHpXJMeYJEz2SrnSt4si8m1Bri4Ow7pyiSeFmffguOV
s768sMvqLorPsUHuRjMXB9NHG9hAkV/avnPqptxPH722QegXhi7ej0+kxrhrtyhf
ZefpKevO5qjvYMagXCqbRUBTHZMY0aACqCvWfLqsmC0LtSA4OHCiSHJFQKvsdxIA
MJmUyvPr9KP5z4mwD+yRO6jdTztZw4693lVUyYcRLDuCHelBhDZ0Gs4R3QGPTuI6
PKLJlxZ2P6R95mLc4ygvk4AUbsm8z5yzFoMzF3zyifwrD2PLe3X/0x/TGeUniLPZ
xAu7MVI9SOtCn+IlfAcoHK43UmMJgg==
=LRAl
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
