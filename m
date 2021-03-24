Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97C234820F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhCXTjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237661AbhCXTjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:39:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18C04619FB;
        Wed, 24 Mar 2021 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616614782;
        bh=K7lclq9Ur7+JomjNBUZNWpB07jY6eFWk04UbS/jYjTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUxbHooDCY67q0rkp6fGz+LrhytyIdt//e6NHU+2+G+DMio70/OeHqbo/lgpBBx+n
         sNRtkYrpfHSvr6tq7bdbJJT3q0w+ZPt9SJpLk8SHW9/eeyqDu2JmPKfRig+ptckvZW
         /O1xF7BYrRmO9dk7V8mOtlXRTEMS4Up8GqpT3nO4Ec8tqTaYVgA5qR5ylq6RqfuOy7
         CxWnqlroAGSC4CSSH6Oxw20ExOs6vMKjEzyaBD5PGUJ6vjco0i+cKkVG6P7jpxl6oo
         lZ6pLv9yjvs7RX2v17/u1ne9ecGOxNRn1rsQNHFHJxUaKtm06xOz49vOaujmNUrvNI
         AFZLydSQOkN8w==
Date:   Wed, 24 Mar 2021 19:39:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, shumingf@realtek.com,
        flove@realtek.com, derek.fang@realtek.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] ASoC: amd: update spdx license for acp machine
 driver
Message-ID: <20210324193934.GA4596@sirena.org.uk>
References: <1616118056-5506-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1616118056-5506-2-git-send-email-Vijendar.Mukunda@amd.com>
 <1038aeb4-d9da-6b45-2b09-b0bd399d752f@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <1038aeb4-d9da-6b45-2b09-b0bd399d752f@amd.com>
X-Cookie: The eyes of taxes are upon you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 24, 2021 at 09:49:02PM +0530, Mukunda,Vijendar wrote:

> I see in the same patch series patch 1 got merged and this patch hasn't been
> reviewed.
> Should I resend the patch again?

Yes.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBblXUACgkQJNaLcl1U
h9ATAAf+OJ95Ec2wUekesYTW7ReP0rxlq8HFnqHbAvVdwaxxNVfOpR9NI45bZ81F
Kr+5Fz3hkCdaT23h6B5Nz0eyjG7bEScPSFnqBoFt2V1JM8oDm+Evt3UA7ZsvZGs/
kAKXTZEXIBBrelPUHLOK3T837O+ES7527HVUqyNyiCfg/ogKX7IRj0WNxiQLeJVO
97IDHzXR70yHeccV84ztVRlTSnN3KmJzXQ7zavNnpEAqDOoDXLercY/V8qnFWJ+7
5VvdkI0YQ3fNYuvLZlAHrehmJw6d7h2MvLMsJetYdKOTtD5jiziItlYzzhAGBdwI
dL5xAS4LdtybjQ/zIvz1NZ1W8PHEnQ==
=368L
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
