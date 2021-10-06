Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036594243B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhJFRL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhJFRLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:11:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C44E60F9E;
        Wed,  6 Oct 2021 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633540172;
        bh=6LoZCnmfOdawk8d/mbX68ZiV45Qa8iZUAtYUzJb54hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fM+tppgeJW/+zgG/sYdllNXSoNpCQGKqIA/F5bi13ESDssalUZ3h94syUU9d7hTTJ
         tQtb3zHcJjuCrU8t1ghyPI3YjKf5zKD0Sg6XwUJl2W+cikrE1qILLzvHO9ihw4cLVb
         18uwOADiU5pZwB63/UH//os/FU7JFGuzKawdVr5ymCJFXs87sHbARZdxsFkICy2CKn
         1JVaiapTc4Ol4Fbx1bWWqPXERnsVll0iAhosryhrAurGFQLHyDBnmCoDjk0gkJaMIA
         fZ31chl6X316JjMq8Z7YiNLg38uWIfDkmVG2JWnY3PwMNtf1IWoPOyc7dSLR/i5Jiw
         UnBqcNc8lzw8g==
Date:   Wed, 6 Oct 2021 18:09:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 1/4] ASoC: Intel: bytcht_es8316: Get platform data via
 dev_get_platdata()
Message-ID: <YV3YSkowPpy9xYSo@sirena.org.uk>
References: <20211006165228.1692-1-andriy.shevchenko@linux.intel.com>
 <20211006165228.1692-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IcOuXY1o624mX8Lx"
Content-Disposition: inline
In-Reply-To: <20211006165228.1692-2-andriy.shevchenko@linux.intel.com>
X-Cookie: A is for Apple.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IcOuXY1o624mX8Lx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 06, 2021 at 07:52:25PM +0300, Andy Shevchenko wrote:
> Access to platform data via dev_get_platdata() getter to make code cleane=
r.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Pierre-Louis Bossart <pierre-louis.bossart@linux.com>

Not sure that's what you meant by adding Pierre's tags...  :P

--IcOuXY1o624mX8Lx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFd2EkACgkQJNaLcl1U
h9C76gf/apERD2LCsA/qRYAncIQkaP714egkph2JhEdQ3juDQYqZ2FDEaILj6YgJ
L9NaUmFYq0V5C9jEgPkB6rwiS75/44Fobj6AjCGQbNN9eTT/fm6GttJ+ZRrN7SW+
086s4FksY6JOsYoI5aBks1qZPv5H/S1ZCm8ZSwH8fzCfmvqNpSLngIq9kSfwN+2h
ddIs28MuSSiegH+jMNo5Q4QBNfv4sokj1HAI5Wea++nFSq9d6P26OhNJ4UzU0anv
8+9sCMqUivgKlYXabSDQstu0fXIhCGUgIrxGdu4Gz4//8SxmdKHyOo5RLfvPsCeV
j1BWpJppSoio8lEwveILllmB/B502w==
=ASKS
-----END PGP SIGNATURE-----

--IcOuXY1o624mX8Lx--
