Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EF64225C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhJEL4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:56:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhJEL4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:56:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AAAB613AC;
        Tue,  5 Oct 2021 11:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633434864;
        bh=+2OSnE0Kr91GcrXvhuQjMdAzGdAq6B3bBRFlwkKTpOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jpd+EsT6P9uNMlqfEruWHWhA9La0/5UFlz2V48k4grtIEctzN/oyscT/AVoC+ZUKN
         aBHnBVWc8xyIjklYuznB+unbARUB8tLkgkoHW/SterEG3mVnbKemhXilt14Jn+E62z
         tf7m1q/Z6fhuYQZ2nmiOP8SXzVqFE5chdAbelqRYN7Y57L91TN1EbX/GD1chv4YF64
         OqqbcOMUonBky7WEj/LAdnb4NjkWHDMh+3Me6O4kEGrwsJVxILnRRVs+2fKQbp7vtG
         DMZhg2wUio0M9ilwqO4aztu/Bbhn3aD/OXcupfknfqCNmP6PJbZOJWbDAUtfKi352h
         QZr87f4JiORuQ==
Date:   Tue, 5 Oct 2021 12:54:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        allen_lin@richtek.com
Subject: Re: [PATCH 2/2] ASoC: rt9120: Add rt9210 audio amplifier support
Message-ID: <YVw87lc4uXSvCiyC@sirena.org.uk>
References: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
 <1633396615-14043-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ouBpf3Mq+3kYb9Jg"
Content-Disposition: inline
In-Reply-To: <1633396615-14043-2-git-send-email-u0084500@gmail.com>
X-Cookie: A is for Apple.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ouBpf3Mq+3kYb9Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 05, 2021 at 09:16:55AM +0800, cy_huang wrote:

> +static const char * const sdo_select_text[] = {
> +	"NONE", "INTF", "FINAL", "RMS Detect"
> +};

Why not None and Final?

> +	if (event == SND_SOC_DAPM_PRE_PMU)
> +		snd_soc_component_write(comp, RT9120_REG_ERRRPT, 0);
> +	else if (event == SND_SOC_DAPM_POST_PMU)
> +		msleep(RT9120_AMPON_WAITMS);
> +	else if (event == SND_SOC_DAPM_POST_PMD)
> +		msleep(RT9120_AMPOFF_WAITMS);

This should be a switch statement, it'd be clearer.

> +	/* Default config volume to 0dB */
> +	snd_soc_component_write(comp, RT9120_REG_MSVOL, 0x180);
> +	/* Mute by default */
> +	snd_soc_component_update_bits(comp, RT9120_REG_VOLRAMP,
> +				      RT9120_MUTE_MASK, RT9120_MUTE_MASK);

As ever you should leave the defaults at whatever the hardware defaults
to, the defaults for one machine may not be suitable for another so we
shouldn't be trying to do that in software.

--ouBpf3Mq+3kYb9Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFcPO0ACgkQJNaLcl1U
h9Dw3Qf/SX+lIekuho/ixTdkaTjTJBjrs2hjM66+6dC7EoRZkCReeR/Vf/bfoBkB
MN6oEMFVxp33H0v6yDnE2LmIHY28R+arRVfH+Rx9JGjwKvwas6HoyOi3pgTaywsv
tgJiH06/876Tvd0LxMpsdpUlPZygTQWJli5C1Vw6/UTtOAshot/CnUbR2SkcvcWS
MbkyBaJ9VQsZCibDZO0oZyj9iFU3ENFUwdzRkB+rWaxcG3g3373OxtQNqZqdmR+T
s73E2hTKN49GeG3K/Uv4RrzOi4D8adbMQViKx0X927aDadVv+dRusbwPvKwv94jP
Vv98XzywFxKbNP473nHdYzEMcqcXtQ==
=QGV+
-----END PGP SIGNATURE-----

--ouBpf3Mq+3kYb9Jg--
