Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE3B3BC324
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 21:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhGETdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 15:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhGETdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 15:33:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8854061369;
        Mon,  5 Jul 2021 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625513423;
        bh=DB18MTojD66qAvZOaE3kuj3EZ+WCMq11kM2ci8j+Co4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=om6OQVknqj6I2FaQpOU2sbXe9jJSzOnntKpaZWZhpjBXS2iOAZkeNZgylpOpFqz71
         qGqINkPyFtsG7KgHMVtsMdtdGW72/5qQQOPIRWK1F1Fz8/ZIrU5p5Q4BTvAiQ/RY8O
         0oWD9HFqOLF0KTZOa5SMZaLeG0OnvXQsj0Got1XeIyfpN3I94Zt90bKjYQXO+LzmWr
         N/xbBOsUMCEhcgP9yQhgvo91IdY+G8JSKMwEWShjD/u5nEfiLWNqeag/OjRXj2Euv/
         SzNkROqfU2QO76qBOAh6tHyNctsvocqG+zvg+nW7T98SrApmD2aWsHwkAFPaBm+dU/
         y3UYJi3TjPpKg==
Date:   Mon, 5 Jul 2021 20:29:52 +0100
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
Message-ID: <20210705192952.GI4574@sirena.org.uk>
References: <20210705155830.24693-1-vijendar.mukunda@amd.com>
 <20210705174241.GF4574@sirena.org.uk>
 <7f1ad1b3-b509-24cf-00d8-f82766aae0d6@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8/UBlNHSEJa6utmr"
Content-Disposition: inline
In-Reply-To: <7f1ad1b3-b509-24cf-00d8-f82766aae0d6@amd.com>
X-Cookie: Star Trek Lives!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8/UBlNHSEJa6utmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 06, 2021 at 12:30:10AM +0530, Mukunda,Vijendar wrote:

> As per our understanding by going with card wide option is easier rather
> than checking dai link name for re-ordering the stop sequence for
> specific platforms.
> We will rename the flag as "stop_dma_fist" and will post the new version.

Why would we need to check the name for the link?  Presumably all
affected AMD cards would just unconditionally set the flag, and other
systems could do what they like?

--8/UBlNHSEJa6utmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDjXa8ACgkQJNaLcl1U
h9BlPgf/ZQVPYklcHm8QzPLEpDWpJUZC9CvQKtgmhHbuo7hVxQdv90n0D69R8ZKe
y+HyvIkOKIpvbfQgZbZL6rQpSQR5vye5zwurlKf7sa0NTJiKgSgxd9vbKMD0KVNx
ydPeeuWIUp8uaSlwXnOrCBeVr3uOUDwERlCpasLP4AInu4GLGZedRPtAxFNBOLQk
ydgfWoOcNmnMA4wtFuggF/F+trNXyfQFwsEunRnAepmGL9dcsNfb1DPXmwdslsQw
y4KA4KvyGJ7lPLs3hPHRZFBVVNQlyDQrVe8E7eQQHPXdWkahyeAA7jCn/g397reB
gee7H/24vthbZVCTESTZy7kVzyrzKQ==
=9bmK
-----END PGP SIGNATURE-----

--8/UBlNHSEJa6utmr--
