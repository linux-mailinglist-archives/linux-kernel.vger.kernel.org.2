Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25E350098
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 14:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhCaMo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 08:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235434AbhCaMoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:44:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AEFA61959;
        Wed, 31 Mar 2021 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617194674;
        bh=zu5+7E3FlVx1B02C+X7ZBz7+D9LN8HEMJnjE1Je3NZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ivif8rLiEpy+yTQbX5AQrdpFree1FdwAVyRpOZwQyWuOr7yJ0OvozGPzO6OxzoWh5
         BUsDrcq5ZR8R5euuGOtk0eX7ibhoq50adYQU1A+ZD8U8/6zFGmS3hMt92tsIuiExn5
         6nE2sIaEgSEZUxkwG3dNjjxByFGbpdqIzwQLMB3dWkh8ZJF1gHN0jCHMR8ALRdAcym
         4kQZPcpv1ntbTS6iMjGzYGqP72OXRh4/xb6fpgAFEN/Y9z8jrmU/hmBYE3YMfjtyL+
         IyNAuqJh2KhAnOAhZySyVkkBbtltARa/XVIyi13XPbZuOfYZkReX3IW4AfOceCogVe
         yjvgCqPM+nRRA==
Date:   Wed, 31 Mar 2021 13:44:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] ASoC: cs42l42: Remove unused including
 <linux/version.h>
Message-ID: <20210331124419.GA12878@sirena.org.uk>
References: <20210326061335.3234571-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20210326061335.3234571-1-zhengyongjun3@huawei.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 26, 2021 at 02:13:35PM +0800, Zheng Yongjun wrote:
> Remove including <linux/version.h> that don't need it.

This doesn't apply against current code, please check and resend:

Applying: ASoC: cs42l42: Remove unused including <linux/version.h>
Using index info to reconstruct a base tree...
error: patch failed: sound/soc/codecs/cs42l42.c:11
error: sound/soc/codecs/cs42l42.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0006 ASoC: cs42l42: Remove unused including <linux/version.h>

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBkbqIACgkQJNaLcl1U
h9CoJwf/QAjGb6XA/wFK32XB2wDQQzeicvhjhNfxqPyxmO/wmoYc805JcqgbOLTx
i+fBFtquaB5YgPCNDF7Qx+tXsVbLcRsE6IB9Wh5A24qOBZySbh9JzwIB74QkJri8
1Kdd+pblf5HHjreotAi0WRtvFEE0654Q/QK5Llb2sWF/9qTbj8j77AOmT6akewnn
0qzN2K9+LtTYdIa8muL3cLFGVeN6ab7M05jWqUnlCn4yRww26+y4/zhwmcSbMpLH
BGmwc4/r8J7aFTWFG0x+/Tg/GnmYUtvA+oBrF2zCa9ps5Uxbt+TNrBAO5yQvmJvw
Zqy95Udm0SRXT5rOcWzZHQoHrFiFMg==
=QE6g
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
