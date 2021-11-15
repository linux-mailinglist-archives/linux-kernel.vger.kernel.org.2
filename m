Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99B3451D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349442AbhKPAZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:25:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349817AbhKOUTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:19:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8ACA261BFB;
        Mon, 15 Nov 2021 20:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637007403;
        bh=EFJ5NEEe6AqTZtAipr4LPDuaZJt/yymu0pVh28kfRjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJnpysfcYWDtEYrxCsNoZdd1qfgqJ0FqcB8Ho1rdMfX7WG+QHN0sqncgFGNla9aRz
         FnK0i39+cz382IXjnNWtm5LlylMv+xVkZUQHpcLsqr8eo61X6yUc8TA4qksRJVxnOg
         VjdcCpktNps2nocuOGTb6oT0l2e8fyritvyL+o0xydNDVGnkR9owKr6TJ4dZyvwCan
         xDE/dA2sesmxiK5fLgv5aadO5RHRJOctrkzmTglNcsdSm4aKzJc1IMvKObYZDqO4pT
         qLkI0OPFVZA/kMaQg+3GN6btA7njqXzUN52WtAFcSu/rorJMAMf50ndeXY3Ptxk9f4
         jfqJyak0NthWA==
Date:   Mon, 15 Nov 2021 20:16:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sunxi: sun4i-spdif: Implement IEC958 control
Message-ID: <YZLAJi12yBLgYSCD@sirena.org.uk>
References: <20211115200833.452559-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mmo/3jm4MWZQwArs"
Content-Disposition: inline
In-Reply-To: <20211115200833.452559-1-jernej.skrabec@gmail.com>
X-Cookie: Custer committed Siouxicide.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mmo/3jm4MWZQwArs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 15, 2021 at 09:08:33PM +0100, Jernej Skrabec wrote:

> +	regmap_update_bits(host->regmap, SUN4I_SPDIF_TXCFG,
> +			   SUN4I_SPDIF_TXCFG_CHSTMODE |
> +			   SUN4I_SPDIF_TXCFG_NONAUDIO, reg);
> +
> +	return 0;

This should return 1 if the status changed, _update_bits_check() can
help here.

--mmo/3jm4MWZQwArs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGSwCUACgkQJNaLcl1U
h9BB1wf/Xv2qocY6b/8HytgoXLjYqLMkxgRWEizu9WKx5MDTpypAatJEY4DMaTna
CIs11POVpXEzW/7nYBQcPMtX1y87JFQf5oAyde7FlnlDcLOuRHH9xd8fm9t6uytR
pFi52RwI8jXD+43B3hvftQIeoGczmj4eviR5waX/C708V1fxhugbJqLYZqJwReMQ
4THbpkQiy1OD5mWTGYuzFkRHyYvn8tMEkJxav5bfWGs1RBlqDhg8sY1A1MsAXOmv
2lioByjfhvxJAcddBboQGjAZybRlO6cbdI2XxHpFLglgjV8CkV6wKDyN3wqaJV+w
NEprdmOKl39kPOkyWKrfw9KDE/NFNQ==
=XKK/
-----END PGP SIGNATURE-----

--mmo/3jm4MWZQwArs--
