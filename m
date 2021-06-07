Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4339DC96
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhFGMiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhFGMiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:38:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2C3E61057;
        Mon,  7 Jun 2021 12:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623069371;
        bh=G5r7/ECXjjJODsldtglcEX396NyWKuO1n0kOyfzMiQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OunTk1cwhfgW+JmTvEjvowO4FGu0riA85b8yO/86G2m/9RVn391gxsNSFGDBOnjfB
         M3aSJGdMTT85Oc0dbtQ/SVSQgscnVYOtQpY4CnVoYSq0Z/nHqLyYBo9k0vXdYKtkKS
         jLBlPKfiRHbAXNA7nhopMpeyGYuzqfGhfKcVWw8km2HBloVAOhdxuBVTuepnlovT5e
         4VH4gmGLR38hzarCSFaeMTWpK0ZZ7MWhy6ULWUE4Ns2RrRLWoboJzxWd1ruYkF8uaY
         nIqwMnv1Kn7US0qQu0vN68xeX1jhXsIwnVYQeiQBGVUlRyaNQye2X5cp/imOdFw7N3
         iiXacjoUBY0pQ==
Date:   Mon, 7 Jun 2021 13:35:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiabing Wan <wanjiabing@vivo.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ASoC: Remove unneeded semicolon in rk817_codec.c
Message-ID: <20210607123556.GA10625@sirena.org.uk>
References: <20210604142652.GA915@sirena.org.uk>
 <ACAAVAAeDkjqA4*JP7kOYqp2.3.1622854711099.Hmail.wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <ACAAVAAeDkjqA4*JP7kOYqp2.3.1622854711099.Hmail.wanjiabing@vivo.com>
X-Cookie: I never did it that way before.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 05, 2021 at 08:58:31AM +0800, Jiabing Wan wrote:
> >On Fri, Jun 04, 2021 at 11:00:23AM +0800, Wan Jiabing wrote:
> >> Fix following coccicheck warning:
> >> ./sound/soc/codecs/rk817_codec.c:49:2-3: Unneeded semicolon
> >
> >This doesn't apply against current code, please check and resend.

> I fixed this based on next-20210603.
> And this also applies against next-20210604.

> It might be my fault that I didn't decribe the version clearly.

> Should I write some description at subject line when working on ASoC of  linux-next?

I tried to apply this against my current -next targetted code, it's
possible some change happened since the last time -next was built.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC+EqsACgkQJNaLcl1U
h9CopQf/bjZfndyShnvT4WyLhTOoK0SUwQh7QykPAKEeE7ejDFja2feDqST5eXLf
8Ocu7uQby9WmuhCEj5IyC8Ld1c/tzyUrC0mv9oZEzylpGFOybcc57WUfV/aIQOeW
Q5cypacayvQiZPnqEWnQRylg49Va/rOW1J267xhzSQy+lR4TpLjMAp2YaTXKdl3D
0+MK2/YBmyXzKS1hUlb8oxfoQ632ey1NVPf9X/q4sJRQJme4E6A9v88d9jNDRdxH
JIMY/yOXGH5vs4l32ba+vNCbisD+Nm/OGxVmgmluiDpL4YqTwOaRPfQTyHK8U1eY
SdvYrgK8b6TP8cxRhezY7c7PWey6Yw==
=qVoD
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
