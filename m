Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833E236B52B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhDZOny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhDZOnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:43:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C08D60E0C;
        Mon, 26 Apr 2021 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619448191;
        bh=NEeQ4EruQnOHxrjpszRpyZMHSQFNWSJbOxCIXxRd3Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1AcrUkbTKcWLHCBLnQUOtT3SeGk2ZvzLVhfIJ8ur6FiRdUyvm5zxYuTrmyPrWDZ/
         LXL3tT7K+rwHwiuPkXOZstveSIUrJW4XKZRGPwcBi9fsk8+/Vk5zZW/5CEawBByYLn
         PnJ0a76ZpHQB4AYc0UjwAtzWpa2EYvACwBRJXQ1IptEDzisRuKwCNrIym9E4ZxnDp2
         /wk8Gw56dEKzZyhHK86znfOaF/Wp+514hsaBpa2dvlnzOVyyEpS5dIsNHhFwXmOqrW
         L7XQsbj/lrwYACp0D2he5G46hnJt+47iFblGg41AGewPb/F0Z3oapJLv43oXQE1Gco
         tIDbkFwo8tL4A==
Date:   Mon, 26 Apr 2021 15:42:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci-results@groups.io, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: broonie-sound/for-next bisection:
 baseline.bootrr.asoc-simple-card-probed on kontron-sl28-var3-ads2
Message-ID: <20210426144242.GF4590@sirena.org.uk>
References: <6080e82c.1c69fb81.cd60c.2a13@mx.google.com>
 <3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com>
 <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
In-Reply-To: <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Zeus gave Leda the bird.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 26, 2021 at 09:41:02AM +0900, Kuninori Morimoto wrote:

> I'm not 100% sure about kontron-sl28-var3-ads2, but it seems
> below doesn't have .name, and I think no one add it to
> sai->cpu_dai_drv.

> 	${LINUX}/sound/soc/fsl/fsl_sai.c :: fsl_sai_dai_template

> Maybe it is the reason of naming "(null)" ?

Seems likely.

> If so, all sai1 - sai6 are using "fsl,vf610-sai",
> all saiX doesn't have .name. I think it should have different name.
> In your case, at least, sai5 / sai6 needs to have

You could send a patch along with re-adding the three patches I dropped?

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCG0WEACgkQJNaLcl1U
h9BjDgf+ONWBtF7V53jG5s2MEtMAaQGjYMPl4mrsbu99hpJx4ecmmcHyQpETITl/
7NUfmiuxz3O/fmXCY2aPCQ6NvLVxnEfDhUKpWaqKEnHZBPZLdNnxxrUHrMbPXj2k
bDL/spL8mEWSgXzMlIPQtVH/pjPLaTopevlpJ/Sbbw+TuJ/9EhhEwfsn9Wuozica
1fr+rnisgDTopQiwiqJb3SbH8gNjQhWlvdja+y14Wor7R4Cl9n6uxupbYKTMw1vx
rlLeIIMzbZNr3fdSkxnK4aYiczBQ8XqfE7blXy3e+/TS9JDEDLrvC465A26fIt2g
3E4Jf6Z5BRtRb8TeFSAb6bA0/sEQYQ==
=DKxv
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
