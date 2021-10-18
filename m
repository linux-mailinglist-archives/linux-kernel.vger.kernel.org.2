Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9435A432834
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRUPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhJRUPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:15:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 534D4610A1;
        Mon, 18 Oct 2021 20:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634587986;
        bh=+lS5kHIyjwnfYHKgJMTUauxWdHZgSV9xSrTbK54/hj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvPMuTr60m7GPIQet8CRTOHntnvIggo1HyHAkse+yblsZZ0vemub+ArHz+GQwazsx
         6FDAAlLuaGGTvkfqCuYQANqrMewR+NnpM5t0YLwInA3HGw9yKzqVflh+TVI/uw3Lyw
         xfWZLnWhpyEUcBHQLrSzoskvoGDQYlgpx2zwl1vmc5zV+0q9Tx/emr4URFcVvplE5b
         fxFSihtDn39mvMhq7EQAmbuzKwdp7seZ1uZVR3XQCPh4Ku0C7oTTRen16Vaif49o2R
         +nAqg/nCL/1WnVzwkxHWXWTjHAC7WdQlP1EikjRMvCR8Jb07siRXhEdFBGN1RmRJ8F
         UWQLupkcd+zww==
Date:   Mon, 18 Oct 2021 21:13:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] ASoC: amd: Add common framework to support I2S on
 ACP SOC
Message-ID: <YW3VUMT9Rjs2+A1G@sirena.org.uk>
References: <20211012071939.97002-1-AjitKumar.Pandey@amd.com>
 <20211012071939.97002-2-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UAG1RRAEZBUpbXJS"
Content-Disposition: inline
In-Reply-To: <20211012071939.97002-2-AjitKumar.Pandey@amd.com>
X-Cookie: An idle mind is worth two in the bush.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UAG1RRAEZBUpbXJS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 12, 2021 at 12:49:32PM +0530, Ajit Kumar Pandey wrote:
> We are using legacy way of exposing dais and DMA configuration that
> requires separate driver modules for various ACP SOC with almost
> similar hw configuration. Moreover the legacy approach requires
> separate I2S and DMA module platform devices registration and need
> machine specific quirk to control various I2S endpoints. Add generic
> dai driver and platform driver for I2S controller on ACP hw block.

This doesn't apply against current code, please check and resend:

pplying: ASoC: amd: Add common framework to support I2S on ACP SOC
Using index info to reconstruct a base tree...
M	sound/soc/amd/Kconfig
Falling back to patching base and 3-way merge...
Auto-merging sound/soc/amd/Kconfig
CONFLICT (content): Merge conflict in sound/soc/amd/Kconfig

--UAG1RRAEZBUpbXJS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFt1U8ACgkQJNaLcl1U
h9A4FQf/aEjjqZ34431puWcsp5Booidsz7yFPt1mzexZ/OJS9X5ZnyqhENI4+2CW
6/TTKq1ktGKVHGP5Ty+06MTY3CKH0Z8OEBWi6tu7hsWdVBji4yNT/jKfzJDlRm8j
jx86ZJjt7VLTtmjxY5crM/K0hProILbfKk0KnBBJs5VFHfHgxX2yvNzhVy81dMcj
G0XVnC+fAEUyBYWZ0Y5ZMOG6Nx3ufkLhpEwqqEPeyEuETtftSaN67n30aUNUeeo5
mnvEto51AE/Stk5s9M9sNlt7gLQRDs6ifBBRORH1VkRN+E4g/R6F8KO5LILU3k/O
1fHxa2r4XHLpqFL12BjLyj06+plLug==
=dfrz
-----END PGP SIGNATURE-----

--UAG1RRAEZBUpbXJS--
