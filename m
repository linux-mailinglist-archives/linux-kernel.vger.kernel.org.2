Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A143BD6AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhGFMmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239962AbhGFMb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:31:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9561F622F8;
        Tue,  6 Jul 2021 12:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625574556;
        bh=Sut5QXr6y+C9xjy3IeaZ+BbqPrn67rDwl5hTIz19DpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MfeTK+TSk4iXPcoww75x6O8k4ZpyHSDTjSwjtYi9Mq18ISjNvsvh5PGzk2oUnE283
         pBwZUER+m5xVAW0cBoxwtBWflcX90aFgQdnHU1W3dfJBmQrfz30o+AudgdVzYVyLfZ
         K1ovcu7ggBHKWBfy1AKUs3TPY3tNOardF7W8eY0k5jNcM2RAPksK00Zi19GB8PLW5/
         wsY6RGYGGJVdXMu2l67coLwFSzDOxSZrms5owRNuZetmpBvm4wWWrZ3+3e3wJEiQxY
         0dGAocnZiGPPGJSL62Jqv/hLK2mvZRu5nxrlLxVrleOvYdalQlWqb1HhoK6h4ptQx8
         j/hSE4vQxZ6jA==
Date:   Tue, 6 Jul 2021 13:28:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>
Cc:     peter.ujfalusi@ti.com, alsa-devel@alsa-project.org,
        amistry@google.com, nartemiev@google.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: add stop_dma_first flag to reverse the stop
 sequence
Message-ID: <20210706122844.GD4529@sirena.org.uk>
References: <20210705193620.1144-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20210705193620.1144-1-vijendar.mukunda@amd.com>
X-Cookie: Some restrictions may apply.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 06, 2021 at 01:06:17AM +0530, Vijendar Mukunda wrote:

> @@ -982,6 +982,7 @@ struct snd_soc_card {
>  	unsigned int disable_route_checks:1;
>  	unsigned int probed:1;
>  	unsigned int component_chaining:1;
> +	unsigned int stop_dma_first:1;
> =20
>  	void *drvdata;
>  };

This still doesn't seem like something which should be controlled at the
card level, I'd expect it to be configured at the dai_link level.

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDkTHsACgkQJNaLcl1U
h9CbbAf+JVrUPOvyKgDMgQ69A/T7wiXFEz/9WjR1Zxoo8tKXGnUogQkoZ9ZdKXG8
FjLHNmtEOv92CiJ4ziUNH+22/erswHAKWXmGWF2k+9NKvZKlZCu6zxLrVGHaPgqA
awxZFA6k1j5NS/fLCfa9BdSo1n7XAeltqkb4YhH5kTwhUYaNiMnFTifPFeriFQLp
ASaJP9+Sh3bG2PYiDyUc+MSoIQ4Ak+QI0VAZppePeEtbvi17zoCMeXJVLkEqNBF1
Q4MQMo1VTefu/0eK3zxjeA8UmxN9uRrp5MHQ5iqjUiwsVp8bSikfX7Pj4rwlm56p
buaM9OpzPE+D4sujnw8oRB/dqAyNAA==
=7N7D
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
