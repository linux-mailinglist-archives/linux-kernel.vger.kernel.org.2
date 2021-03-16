Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19133D52F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhCPNvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhCPNud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:50:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 118C165053;
        Tue, 16 Mar 2021 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615902632;
        bh=v0MQftmjchfDyMC/gsPtVSaYN1KMEK0Xi5b0nN0zZoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2iQ8AfMIkcRJMiwCyMDrEYQ+fm2BuhcqJBrRDiqtLgZgbWR6A2s9flaTfKez135q
         fdSRDHEXaqaWbIV5WoEHS3ARyh4Y+xL3xUNi+zW+teWI8G+pe/bpgpB0d/TPgyrk6V
         2b9m5gDUqiCoIqZ8pj5Z10mELK7htU7kbHpvYxm+T3euNlvollP5cYdBCrg5C58Sex
         0Zj6ic7R1OD5C9FtTyl+m4G1jnOaHtZqmbQgBxRQbWgCljhiYenYXdhL9g1ancsbm/
         mhS9jEwKaQr+8wwBBQPfjhRhVSFyl0ruRGkoOxu3DHt0qNO+TMQcwsp0w81WV5q+rL
         s3pH4/TS+Yk8Q==
Date:   Tue, 16 Mar 2021 13:49:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_sai: remove reset code from dai_probe
Message-ID: <20210316134915.GB4309@sirena.org.uk>
References: <1615886826-30844-1-git-send-email-shengjiu.wang@nxp.com>
 <20210316125839.GA4309@sirena.org.uk>
 <VI1PR0401MB22721D0D266207472B3C7829926B9@VI1PR0401MB2272.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB22721D0D266207472B3C7829926B9@VI1PR0401MB2272.eurprd04.prod.outlook.com>
X-Cookie: Results vary by individual.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2021 at 01:42:40PM +0000, Viorel Suman wrote:

> To me it makes sense to manage the clocks and reset from the same place.
> Currently we have the clocks management moved completely into runtime PM
> fsl_sai_runtime_resume and fsl_sai_runtime_suspend callbacks.=20

Usually the pattern is to have probe() leave everything powered up then
let runtime PM power things down if it's enabled, you can often do the
power up by having an open coded call to the resume callback in probe().

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBQt1oACgkQJNaLcl1U
h9BD2gf8CYq0baSLf4YPI5H7xjw4JepkHBJKPXid4yN7feW5rEKKZIlNzYx5AYT5
jh10YF8ND602x/tBHwlqL2tNdjBFzSi4dT/1QapmOaS4NqEXPAWU97VUPECfxWLm
29HZ7+Kw4LfDE2PI/2sKnBYd0wE8w0l2prCM0Ms8JT4hVal8O53kgzjJ6+dzHfpe
jisKXgGv8qtNVlK+6AMK3H+vs8ROYnTfiYTsFNR4XF1nrvGSxwwvM8KuJb+rYb5+
VNB58e4KMaolnwOyxf7QAQQpAAQ7gFl/GkRyXquIpeOlV2WER5v9N6rVV1DMpwII
0zlVO4v7O5Cts1nqzxxdfsUHu1yNjg==
=3CXS
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
