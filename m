Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25A942BF48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhJML6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhJML6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:58:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBB6761040;
        Wed, 13 Oct 2021 11:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634126160;
        bh=cAN+tog71qOFvOetsmSk0T5LVIdrumWHX3E93X1jboI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uENrnGTWu3ftPzGh0aLTpbD7KfE6hC6rXGQrCX5a/cbvuH2SyGDwsgPic7o21nPRL
         JB5QhvWH6o44Rtn217XNNuYWKw4uHXFbWZMpdH+Z2AjIyZJ3R/MLMZQeEvYL56z++1
         GMw5ub7OCX6dR0Wr94s1PnXu0Im9/NsCaPaHZ/YhRDD0KA6l1vmExkDHT0Ig9ESYYB
         69Bapo5b5rdtGDUaCbVUrz46W+Bz+S7SSOJB8rOoYTevHFBNrCH5D9zv6VxmCugC9W
         IeEof/s//iYWw+4ifaCzNULLBxYCDd/sKWuZ1F7xuERBtm/OBHTBTKjTCtdElOqNAg
         xgf0yzVl60JWA==
Date:   Wed, 13 Oct 2021 12:55:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     George Song <george.song@maximintegrated.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, arnd@arndb.de,
        alexandre.belloni@bootlin.com, jack.yu@realtek.com,
        jiri.prchal@aksignal.cz, shumingf@realtek.com,
        pbrobinson@gmail.com, lars@metafoo.de, geert@linux-m68k.org,
        hdegoede@redhat.com, paul@crapouillou.net,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        "george.song" <george.song@analog.com>
Subject: Re: [v2 2/2] ASoC : max98520 : Added AMplifier Driver Signed-off-by:
 George Song <george.song@maximintegrated.com>
Message-ID: <YWbJTgI3Jpo7LiJp@sirena.org.uk>
References: <20211013071616.18592-1-george.song@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ku/5dXV8PYOYncmB"
Content-Disposition: inline
In-Reply-To: <20211013071616.18592-1-george.song@maximintegrated.com>
X-Cookie: Where do you think you're going today?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ku/5dXV8PYOYncmB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 04:16:16PM +0900, George Song wrote:
> From: "george.song" <george.song@analog.com>
>=20
> ---
>  sound/soc/codecs/Kconfig    |   5 +

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

You've also sent two different versions of patch 2 but only one version
of patch 1, please don't do this - if you need to send a new version
please resend the whole thread otherwise it gets very hard to follow
what's going on.

--ku/5dXV8PYOYncmB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFmyU0ACgkQJNaLcl1U
h9Dd+Qf+PlCO66assozKLwJoeEHfTSPv5V5u5jCgEhW1MBZHV42rMIXPsghW524P
yl14RiN5BS5zoD6OupGuKLns4Cq/egs5U4FG7qM3QpxdhKVGt0828pl/IiokebTV
ZwEe0IgORmE+0VhuF4mx8/gVqX+DVsDQTsXH1lBbKvMt8W81ahLmec78B9Mut3UV
fh+V7h6DtneIUNbwJOyGvmx0mEQymqhtM+JhtUcopkx+iD2KMUvBQ6IM2s9+CZm/
P9Ka0Fwsf5Xo5iSQBpy3FnYt4i6mCN+oKORQKztP77UxNfWbNjOH8aFiafFYBfJ2
pisCrGEBwbm8cpehNinbcbYqZ3DsHw==
=c71Z
-----END PGP SIGNATURE-----

--ku/5dXV8PYOYncmB--
