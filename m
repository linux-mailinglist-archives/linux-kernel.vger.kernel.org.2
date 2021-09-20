Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B0E41149D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbhITMhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhITMhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:37:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DAD260F4B;
        Mon, 20 Sep 2021 12:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632141386;
        bh=ywph2O72bB55A0SZOZeKnv7szm1alhRoV5amvQ+xdmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTCnsEGVHfxv7QPlvq9V/ADyNY1gD58w0YYnz6K82QCLN3WSrOpG6nJiegqCZCQ63
         Ztix/126YwnBRKjAaPv5qDC5WV1fH7gqbKJhOozE1nXIDCP1p4I0aypn/CjBUHO+c5
         5HNI1booHeRADuJ7eLDAQVVU8ydqH3vKbUeea4VxcPe+RL5DG4TqWgdfWoYV6nlMeN
         XzrCEJ4Yrs0XA21xUyqjIlExj2T201bpD00DfJbostrihBT7SyZFTymelI6smm9v4h
         YW6utw6HSFtrd7IDzQVvsqCbDzpbJOqC8gpvwOZdRfVOBB0epBek1gDQjcnCKdOiTj
         N8RXyfCGtY0Vw==
Date:   Mon, 20 Sep 2021 13:35:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: mt8195: force COMMON_CLK dependency
Message-ID: <20210920123542.GA14852@sirena.org.uk>
References: <20210920100206.1418649-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20210920100206.1418649-1-arnd@kernel.org>
X-Cookie: The only perfect science is hind-sight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 20, 2021 at 12:01:58PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Without CONFIG_COMMON_CLK, this driver fails to link:
>=20
> ERROR: modpost: "clk_unregister_gate" [sound/soc/mediatek/mt8195/snd-soc-=
mt8195-afe.ko] undefined!
> ERROR: modpost: "clk_register_gate" [sound/soc/mediatek/mt8195/snd-soc-mt=
8195-afe.ko] undefined!

This doesn't apply against current code, please check and resend.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFIgB0ACgkQJNaLcl1U
h9CgTwf+MjdtdtiCsDwjnRIAJ8Zkv9hB5KXV0gHoCPjSyFF5tGeALEPdRb0NkkV/
SJJtvwBCG7RiNaaERXhF6hsxIXjivKxoz4gk8RmNLCgWrXxCEVJdSCO9ck/7dBtU
v4qjpA6YwPs6vNNmdRCqco+ftpWaCsfI+/WUvkYuyWX3nVFctr1/36ZX1bNpyIKh
yGkM1sSaM0hFA76VEsbTuL5DWZmwhcU4JmAf1xJXV/PwnCtk6qI37uptD8jI2Boe
g3ocEvaCCN0VUfaCW63TTAKvNmnsuQYItaBFEtmkoJlZqAi2toQmPtRGvp4Hzl07
AfnIDu5F+SVROur48PzSi2k9eeNkCA==
=FMjp
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
