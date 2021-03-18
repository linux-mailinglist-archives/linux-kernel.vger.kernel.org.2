Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2476534063E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhCRNC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230498AbhCRNCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F27764EE2;
        Thu, 18 Mar 2021 13:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616072550;
        bh=ZFQF+laYvm+ZClm6EkbR9Ee/ERLjMMRX4Nb3NdC/5Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iB2Lu8Vjwd/thYCWHV3yxujGYt/KZkp8h4k4qVXzIgoP1ypB1ZaKSiIWc1NJGVqRj
         32SiqcswjrDWqO3mlj7d2ylDGhAMakrrtMuHz11/SVZsZeUZf2ijBbWnJZA3neSNev
         0Wjz/Cf0y5vja7/ZiwR0KuB7VaEQGPW1vO8ay4lVMa2+HjgaZAH4OaGNYc3wIcqIrD
         cfG3xcXV+7evtVx2MXZAiE783tP+9tno15vygWV5NdOFLipeAv/hpIKuvrvGNYkAaC
         DOxDOvowsx3a9C/Wur6qbKnHWfNETv3P8iMevSR4KlHWyjMGC/GdBOk3GbJSuqkE2H
         JWb6VsX6HGpIw==
Date:   Thu, 18 Mar 2021 13:02:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, shumingf@realtek.com,
        flove@realtek.com, derek.fang@realtek.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] ASoC: amd: fix multiple definition error
Message-ID: <20210318130227.GE5469@sirena.org.uk>
References: <1616013238-12254-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1616013238-12254-2-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <1616013238-12254-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Cookie: You are false data.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 18, 2021 at 02:03:47AM +0530, Vijendar Mukunda wrote:
> make W=1 ARCH=x86_64 error:
> acp3x-rt5682-max9836.c:(.text+0x840): multiple definition of
> `soc_is_rltk_max';
> sound/soc/amd/acp-da7219-max98357a.o:acp-da7219-max98357a.c:
> (.text+0xd00):first defined here

In general you should put fixes at the start of the patch series, or if
this is a fix for patch 1 that was spotted by the bot when it was posted
on the list then you should just roll your fix into new versions of
patch 1.

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTT2IACgkQJNaLcl1U
h9BS0Af8DcLM2FIfs4Rv3pWvsFaF/tPu+0hRmIk82qqi9HQoGqOxL/G4LueA+Kzu
NL98mcpzwCRFt/trUJ06UziT7hfLdvUZbexm8KmhVtVE4zX3pL/aIqlKtkWcbxPw
j+36ScveHc44qMpL1RNjzHqPqPtJLwZUEBOKRWa5NEI/GHt773dV+JAX8+8/LpWE
BD6SPelxK35BKzS+dVCguUj6rrp4XQnZOo5KDP6uNVdkjL2LYEbMaG5RRq5V7W5y
3TlkCVqprM4s0ft1GvaPSxgwtokbt1ayQIaQXvQn0vwq5IdVonZ5mKuChHRfMk1n
BeKioPGGxfUDmioGd8ETQajjkVXDEQ==
=wlPn
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
