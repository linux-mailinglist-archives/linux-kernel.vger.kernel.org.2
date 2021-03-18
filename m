Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5633340639
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhCRNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhCRNA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:00:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6BEB64DFB;
        Thu, 18 Mar 2021 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616072423;
        bh=qiLGY8HKokEXMDj9gmWP7GdBd9E0/I3VxuXUFnw4L4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JF6SY/csVQv0pg+Gd1+TcERHzfl+AMRRfa+cnAtakWdGQVzQ/GQu1si2wPKv0cxRV
         ZCX32ZPvXYuAi/xwzKgpM4efzek1g6nDXaAkuxvXFSDVn9SOUkOrnXTJVZxDy0o1U/
         FKeDK9CruE+rnFXJQCb3BRQTEtnkpa9/uK+sM4l+VWLmtq9KW6xsSdOey2Uw1UgT5h
         rLaj811weo4yy/XDyJdyPL/G4jq3KOwvGGtIPVtL+UZrmm+olCB1GQyOg3QuUSyLCo
         9/U9Yo6vAwzxjA+D5PI6s9oz0BPJ78+Xh8B7O/gb6m1xE9Tevr0OxNat0dfQv5WmsR
         5TN0oedTGC1Rw==
Date:   Thu, 18 Mar 2021 13:00:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, shumingf@realtek.com,
        flove@realtek.com, derek.fang@realtek.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] ASoC: amd: Add support for RT5682 codec in
 machine driver
Message-ID: <20210318130020.GD5469@sirena.org.uk>
References: <1616013238-12254-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <1616013238-12254-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Cookie: You are false data.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 18, 2021 at 02:03:46AM +0530, Vijendar Mukunda wrote:
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -1,27 +1,8 @@
> -/*
> - * Machine driver for AMD ACP Audio engine using DA7219 & MAX98357 codec
> - *
> - * Copyright 2017 Advanced Micro Devices, Inc.

The conversion to SPDX really feels like it should at least be called
out in the changelog, and probably a separate change.

> +	/*
> +	 * Set wclk to 48000 because the rate constraint of this driver is
> +	 * 48000. ADAU7002 spec: "The ADAU7002 requires a BCLK rate that is
> +	 * minimum of 64x the LRCLK sample rate." RT5682 is the only clk
> +	 * source so for all codecs we have to limit bclk to 64X lrclk.
> +	 */
> +	clk_set_rate(rt5682_dai_wclk, 48000);
> +	clk_set_rate(rt5682_dai_bclk, 48000 * 64);

The driver should really check the return value of clk_set_rate(), it
can fail.

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTTuMACgkQJNaLcl1U
h9DN0wf+NKVDPN2KDugCF3BfHq/kxUZElE/b5zMal0As5PwF39C8vSdRLZrIlNAc
yUUKO253/08URkdQcn6YySagM3E0xhITI2q4QFukAbIfhVWNb0HsJ4HuN3PLN+cR
FFB5RGdTW3ZmKOtjyvN09BZBbRemWqc+ppXvrIvi44XW5jvxIEGKrppDqGPGGX38
VjivFZg05OEk0eL52pZNlHf9FQVVKQ/I9+Y+uboyccbd+vApRuy4oXXxjyUsQZYq
b3FONTatPOutdnGp7aYSuo+aN1OOgE6/G2u6/qaIXHQJ4bmJq4LyAiebevNaYL5H
3E34/fGw7sNYA6VDfdBHaz9yR4E/dw==
=g1k8
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
