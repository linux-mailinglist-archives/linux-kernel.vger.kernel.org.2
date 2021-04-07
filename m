Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BBE356CA9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352463AbhDGMwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhDGMwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:52:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCC7D61279;
        Wed,  7 Apr 2021 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617799924;
        bh=cyfjEk9jthcsbMRdXa22ian2dfCApQqG6xTpove5ejg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCn0Ot8ATDqpyS4C66rj2NwsNmng3SdIotwU/xRgyy/tZ2P2byZVLVcD+/+GRWW59
         XX/AWOQW22nip9SoRXn/W+INkjDuNPFotVxX+hZYgC1Vx/Q0XuU0JIzWjlQUdRBohL
         zvReB+RpACqLQuLVS54IPk3fDzDF1GxS00o2RjCZr5Nr6LnCCwhNcvIKDCKXjzamhr
         PShKbXs4RyeuhNS2bIL8IIjniNYZlXZX6SXi4YyLZ6kGEWDALxo374XiikYIbDhW4v
         hmxtBE1ec42rJwgfEF5chbAuEqc4pEm3L+9kdHQ7ZYzPT4BND22OU6Y8gjbJvX4MGp
         i6zVANALjAJOg==
Date:   Wed, 7 Apr 2021 13:51:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: Fix rumtime PM imbalance in tas2552_probe
Message-ID: <20210407125147.GD5510@sirena.org.uk>
References: <20210407065402.17729-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <20210407065402.17729-1-dinghao.liu@zju.edu.cn>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 02:54:00PM +0800, Dinghao Liu wrote:

> -	pm_runtime_set_active(&client->dev);
> -	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
> -	pm_runtime_use_autosuspend(&client->dev);
> -	pm_runtime_enable(&client->dev);
> -	pm_runtime_mark_last_busy(&client->dev);
> -	pm_runtime_put_sync_autosuspend(&client->dev);
> -
>  	dev_set_drvdata(&client->dev, data);
> =20
>  	ret =3D devm_snd_soc_register_component(&client->dev,
> @@ -733,6 +726,13 @@ static int tas2552_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		dev_err(&client->dev, "Failed to register component: %d\n", ret);
> =20
> +	pm_runtime_set_active(&client->dev);
> +	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
> +	pm_runtime_use_autosuspend(&client->dev);

It's not clear to me that just moving the operations after the
registration is a good fix - once the component is registered we could
start trying to do runtime PM operations with it which AFAIR won't count
references and so on properly if runtime PM isn't enabled so if we later
enable runtime PM we might have the rest of the code in a confused state
about what's going on.

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBtquIACgkQJNaLcl1U
h9BQtAf+I2hjUyL/9OkE3eGicNAX7nsxLA+2RCglYcJbnP+DPP0fV9PuPWnUP/v+
AyaTLilVvUCfW/mSQXCrS8s1YZtRjmcWM+C21dyyejn5PTFp2q02jEfVZUsHE1b2
wbspUe0X+/tNp8AifCdgMfHN0i0MvxsVVwnDTwTy64sF7escwM7LaCsJXOvIo8Q3
Jfnq/TJFt40FgSRe30GEzoJEVfiWdAGmfOvggULT2iX3tp7F6Dcl1OevhObFFTmX
SETQzdLXqih7npx1k1RQBBqFPo3mKJ4syuTn3MV4pDWrWqVPFxU1Z2QsNYlslGtk
V+WLnEHAr27p/pTbLLxjB6XTo549EA==
=Tb7U
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
