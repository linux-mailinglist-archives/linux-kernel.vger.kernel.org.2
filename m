Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138A641939F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhI0LwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234053AbhI0LwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:52:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0008260F6D;
        Mon, 27 Sep 2021 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632743430;
        bh=+6STobOuOlzOXWTxDK/LtFOOOoG8G2+aHSnbuBCAJho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5kgPclRUtZE9bpW9xN3xybcRvXEmbvbUAmGAMvdgoF9VFvVYaaRswEKGEuhlf/ns
         N8d3HyPVxp9QgAJBk67VgjLOz7I9a3Hhydet3ZKctnRrVgPhnpfuqxRpRy0FENtv0I
         AFfssP2NovJslPPq8RFHnIukWyN2sbsJRQZZ2iyd/X0CopRnPsM7vFv1+iXtCBicaK
         cOFenmlJsr2bbuMz+JVAh94sb6rm1aG2d6nZK4LB+69Toqf+X8CMa7APpMMfbBLwJC
         BwEmT24eo+SJi3SOmWfTMhUST/1KOnCOVkSQC2/GEO1/obr35tNXFMNvIxWP1j1yap
         m9wARgw1tkyCw==
Date:   Mon, 27 Sep 2021 12:49:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Add HP Volume Scale control
Message-ID: <20210927114942.GC4199@sirena.org.uk>
References: <20210927111244.17906-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <20210927111244.17906-1-vitalyr@opensource.cirrus.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 27, 2021 at 12:12:44PM +0100, Vitaly Rodionov wrote:

> +static const char * const cs42l42_full_scale_vol_text[] = {
> +	"0dB", "-6dB"
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(cs42l42_full_scale_vol_enum, CS42L42_HP_CTL,
> +			    CS42L42_HP_FULL_SCALE_VOL_SHIFT,
> +			    cs42l42_full_scale_vol_text);

This looks like it's just a regular volume control that adds/removes an
extra 6dB so I'd expect it to be a normal Volume with TLV info.

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFRr9UACgkQJNaLcl1U
h9CZOgf/f3f0pV80Z4P705daQFFWTtqcIqeFI3iyFeVm6ZdU+3nOGW4QGICifIEd
OZDcitqkMNsdjJ0nY8eAlWwsLIvN+BRddOhWNC5Olb4eDRm8akI8I+9JApOU3QC7
5hyUMRleFuTCH4Nwfyt1p56xVC8/lrDfX9Fy1mEMMyHdhbe/KvQ2Ae8oPe4tD2+6
BxCLruymgeuVMo2GeQUvmSLIvApHyXEgm98lH6DGoRjIwsb3yO4kafedXufsK/sW
2GQcI2SW+AICehFbhkxeN0ixZQVR+FJ6bkyE1JUib+EWWiN7xCOmpdgW/M3hQdMq
TUbrujHVtMXt3NTvKix1s6myspABCw==
=yWuI
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
