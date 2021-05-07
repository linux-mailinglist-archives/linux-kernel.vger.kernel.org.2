Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54D837682D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbhEGPjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237994AbhEGPju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:39:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D133A61474;
        Fri,  7 May 2021 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620401930;
        bh=qrB6z45lJne2TH1vK2BagutxMHoB7qI70gJjcuVXP6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/wUMMPFAzmGPQS9fu/dK0tPuntOfc3jqxO0tA6DadA/qwJ6gCAeMV1abHMPR8R91
         3gMAnf2WXl3JSjfORVpUCmk4y7WV13qbTSY85ZPibtJeqO7maVqxNIaLuOcqeBb6Co
         MXZc7TfaqQbEwy5Is3dzdTJpAlFZVhs/6gtpNnTt4O1HqnNT8mNRxEQtdHxc+KVHfP
         BdBMxaqsZCcd+NSbfA/W4ukWcBYoxhKNrSHgkgGXyG6kHoZUTBXVg+m0FLrd7WwKZ+
         QOV2aj6UKkraoYYZU2t6x8PCZjCrokS0KWQ+XrBG9hWzeIb45fhnBhWGnvPvwVZrHi
         5l+KZvPPbEXbw==
Date:   Fri, 7 May 2021 16:38:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: make HSBIAS_SENSE_EN optional
Message-ID: <20210507153812.GD6383@sirena.org.uk>
References: <20210507141748.742037-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <20210507141748.742037-1-tanureal@opensource.cirrus.com>
X-Cookie: Postage will be paid by addressee.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 07, 2021 at 03:17:48PM +0100, Lucas Tanure wrote:

> +  - cirrus,hs-bias-sense-en: Configures HSBIAS output current sense through
> +  the external 2.21-k resistor. HSBIAS_SENSE is hardware feature to reduce
> +  the potential pop noise during the headset plug out slowly. But on some
> +  platforms ESD voltage will affect it causing test to fail, especially
> +  with CTIA headset type. For different hardware setups, a designer might
> +  want to tweak default behavior.
> +
> +  0 - disabled
> +  1 - enabled
> +  Default = 1

A boolean property would generally be present/absent rather than having
a value...

> +	ret = device_property_read_u32(dev, "cirrus,hs-bias-sense-en", &val);

...and read using device_property_read_bool().

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCVXuQACgkQJNaLcl1U
h9DnoQf/fhx607K3Ic6jTRvxIvSmJltZh9VYh8D2LQ4ilAtNFfRsshkN74XGW7UU
szJk6CUGeWykTDQHf0ZXNeX+XrcTXpiL8UwFSRA8krK2zCn3NhmKsiM8D6ApkFka
OelzY67sdXGqISRscr5HBjqEt1hmsqDpmY5a3LkldrpHoxI2nxoXD77y589nfZrM
4TEecX5JTJvDIM9HvYVjekUbXlP/pQ3Di47RAFV4skfS66BQw9EB1OllHURjJqcM
xYaZajfrDOeIcQ30Sui7oAWEcPFnJSKqUWHb8Kjm5ARMzm0miJKKpMWqhAcPA/RN
EIsFq6UpT04oTfuEnCKUQOYveYjxUg==
=HTbi
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
