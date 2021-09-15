Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4099240C729
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbhIOOO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233782AbhIOOO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:14:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DF0A610E9;
        Wed, 15 Sep 2021 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631715188;
        bh=3VliXwA8hFR5zM12Xw58dE/ygC/s5PPHveglLCGMbSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PS78lEARdU0wIKnld6n9NNWJ1mO9jd5q8hzpG6/n6ktqhPn2qraMg7zytVGWxuPgy
         uVmKlcwND4cfAlP6sZmxExrSSNzvdzZ8jrfX2gQgQqtBoFT6iN43MEWUC/OPz0jUnS
         1WU2kademhOEO1hNplPxskA8IUPJVMqD6i3snzE2scNpB5H8lxsR1AxwnXd9zkXOT3
         /BnFpEOTPo74R4EMz50aMl/flyo1oSF2+xnjVnbui+QS3Cub2xTcGYDG+1rhTHAEwK
         BvOBW3SR9VZ7IaZZK5BnSsk5Ld/5PavxG4P3Pck1VBGr1CSPzO/VF/dhwJL+E1QeGW
         2oL6+nrM+7+Fg==
Date:   Wed, 15 Sep 2021 15:12:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/4] ASoC: rockchip: add support for i2s-tdm controller
Message-ID: <20210915141227.GD12513@sirena.org.uk>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
 <20210903231536.225540-2-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <20210903231536.225540-2-frattaroli.nicolas@gmail.com>
X-Cookie: The more the merrier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 04, 2021 at 01:15:33AM +0200, Nicolas Frattaroli wrote:
> This commit adds support for the rockchip i2s-tdm controller,
> which enables audio output on the following rockchip=20

Please for future submissions include information on what's going on
with dependencies when sending partial serieses to some maintainers -
the usual thing is to include everyone on the cover letter.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
(for the bindings)

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFB/0sACgkQJNaLcl1U
h9A4Zwf/QB3O2kBDkYXbIH/HOolQ1QepbZfvybO+g3uaV9wzSVDEm/p0cTYOKmaB
uXFMNkXLL64UsvgTw/ECheXMAzmRgW0uQhhOngfsOw2opR6QaemuYaALuqI6C2Fx
aWlRrDY7nYq9nGxwwRFYh013qTxMSPOmyUoTeTopHvwYprdt20mNhm5lwLhBKaOu
5SjkcoeJoaQih5aX5Xtm3RWYL2DNy9Wf/bLUB+FZSoGSOG2ZtKWxT5rCuZLMOXQT
3iN69D9F1JtRe+BwAiqhwazUXmfr4Zd0sDnUsWVis2Nc9V7T8J7JH/+9hekw5iPW
Y+hRZc5APTVu0HPo/3WRinjld5481Q==
=eohL
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
