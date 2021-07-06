Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A2A3BD6B2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbhGFMnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233684AbhGFMdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:33:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDD5D619C8;
        Tue,  6 Jul 2021 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625574667;
        bh=Me4h8Svxr0oEY24HAdRXkrZoovr8uE/hMjWWvsAowfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFt0g9haQ8yyxZbpnpFN9XSyMBSA/1s8NBR8RYEIjUmHvOMolZj8hsmjpDRONuKMD
         OAmsDyP0LBvkfs/mKR2/rQ3X9oG/rLM/8C1zuripKBsxY0TTeUEbEPW3nZoQ83De/b
         GYfN+kFYYX1LIpMAglDitkCIDVOR2RPni4wY/Hkb5nGmEBvs6aQBhMP84WLL0pw97r
         apiYmJqdf7zH8pAmz6OY4QFjZvvFiZevggUHwxC9/wS/CDSnJXydFpbGTnx32lqvzC
         lS8OQsinI0qoXoTed8W6mq4UNUZ7q4vMmd8AugjxqSGXLaznMXu9DP/xKpsBfJlkz4
         XEUuJlzvx9iuA==
Date:   Tue, 6 Jul 2021 13:30:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     peter.ujfalusi@ti.com, alsa-devel@alsa-project.org,
        amistry@google.com, nartemiev@google.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: add dai_reoder flag to reverse the stop sequence
Message-ID: <20210706123035.GE4529@sirena.org.uk>
References: <20210705155830.24693-1-vijendar.mukunda@amd.com>
 <20210705174241.GF4574@sirena.org.uk>
 <7f1ad1b3-b509-24cf-00d8-f82766aae0d6@amd.com>
 <20210705192952.GI4574@sirena.org.uk>
 <48b0a8e6-ca29-3f77-2689-ad7515f8743b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <48b0a8e6-ca29-3f77-2689-ad7515f8743b@amd.com>
X-Cookie: Some restrictions may apply.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 06, 2021 at 01:40:59AM +0530, Mukunda,Vijendar wrote:

> To make AMD specific platform change(which uses ACP 2.x IP), As per our
> understanding we should only update the flag in ACP DMA driver by adding
> flag in snd_pcm_substream structure rather than adding flag in card
> structure.
> Please suggest us, if there is any better place holder to add
> "stop_dma_first" flag.

I'd expect this to be configured by the machine driver in the dai_link.
It might need copying over to the substream for runtime use but the core
should do that.

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDkTOoACgkQJNaLcl1U
h9CD0Af6Aml9JrNZjaM7DWoPKWUc6A7Eh7aC5xXuVGPp6bPnt7nmt48yswr6l9nS
FYAFulGmlW7KmNOXQ2sLEbdmNQvWyKdKbQyfsLr3KqaKkhYkVL/c6oPjzrx9jQL2
2C05Ofe+Aue2VoT+6LXeeHcrJc4zzXkdgWw7Q1amvV+uBKSyN8T1QCjaAvh2cpKl
2CZsZZz8Eq6PAvoBhvEVLjjQgrAeW5+V3BfYvWdwhEhhiTitz7MoWLO5ntq0/+qJ
43mjCbqPLFYaUcvqriafZqW6xArg5WexmDC9NiNuCuyffjW36AQxkfizIPKZAFx8
yZrsX1SAYkBUtZQ9wUITPEq8kM+/Ng==
=gGgo
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
