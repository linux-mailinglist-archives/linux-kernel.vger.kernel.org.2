Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03FF366EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbhDUPUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:20:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243922AbhDUPUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:20:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB42B600D1;
        Wed, 21 Apr 2021 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619018407;
        bh=HWhvnssITHYMFlL/4RLZozTot8Jt6F+Tluq69jLq6Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNRkVOmf+WdtsV99f1zX2N9BVDfsmDp34we/NqC62qF0QVHNsKGw29UBOtlA0cSpZ
         ix1/svSA3cwZ8xQU9+omBt1mFmotQNGMIwLeS8o55MiQBOxTJEDeUDXlO7UE2Eny7F
         5i6WWByQe72YhjmB73Hr/o9crSxV1gShidpisdzqWxqPwmaaFxm+A/JQzgBN0orn0P
         lj92XGa2jpSEWYyeyLB29Sr3FWDvMtrPJTD4KXQ63pSmqAThA8Qx/a3lqcJmN/AhmT
         mZvYuxWsv3MOwGZniBxwaYc/JRP2f5HylGzUGdQbVrfGD4dUgrtSQbB4TMuHs8Qh5m
         aw+XAHEV2EzcA==
Date:   Wed, 21 Apr 2021 16:19:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Fritz <chf.fritz@googlemail.com>,
        Axel Lin <axel.lin@ingics.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: bd71815: select CONFIG_ROHM_REGULATOR
Message-ID: <20210421151940.GC4617@sirena.org.uk>
References: <20210421135433.3505561-1-arnd@kernel.org>
 <20210421145302.GA36124@sirena.org.uk>
 <CAK8P3a3FoAEAQYoccqMNJ-TbScnen6Mm5y+2vE5ZPOjsag8tMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3FoAEAQYoccqMNJ-TbScnen6Mm5y+2vE5ZPOjsag8tMg@mail.gmail.com>
X-Cookie: RELATIVES!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 21, 2021 at 05:16:36PM +0200, Arnd Bergmann wrote:

> It looks like something went wrong in the coordination between the
> trees, but I'm not quite sure what.

Dunno if it was this series but Lee did send a pull request for
something which wasn't based on a dependency series from me that it
should've been.

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCAQosACgkQJNaLcl1U
h9AgqAf/ZV/PGVrtJs/9P0NBmN0QPFtbbPneb6SyyRkiKP33Ntwm8y0yGQJDZ47N
L2qB9wvrxoA8FcTKKqRwKYxdaCm4/9RLCJppQJ/zD7Fz6/B6ytZUKFQbjEkdwrv3
FqAGo3JEdbC3FcV84KyT6CUj8JDq7FRUNysWBXcPfiyI3qiLD0RIgr1iG4E/b6Ro
cmwXPxEoamc2sw4rFerrN7fkynSMTZ/Cj1Nz0KDuY20IHSJ5KAUbfxnjPe8uE0qT
XOoHh9TNNvL4BNccaFwVKtJbYGN3LDb8LqlHT42/FL7zpKvBCC69lwNAIXt0dzDh
IB80cw2cj017zeth1z9YV5gAWQ08XA==
=d/yl
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
