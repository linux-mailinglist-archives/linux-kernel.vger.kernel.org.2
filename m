Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3893A7DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFOL5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhFOL5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:57:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 863D660FF0;
        Tue, 15 Jun 2021 11:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623758097;
        bh=Ryg5gVD62jasf3/gyRRVCZbE2fmZc8ABQmAVPplc3YA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2rvcPjFxkpDpzhUpoLfrAMqWsulNem2IX3ZJDmuUWk5+Cxf8x4Rl87KomsEp9RK+
         +W3y7leleoManvGA37ngEuDjurweGrouI3y7HpPq34Ct2kjbQPYJI0Vd5d53LWTa0T
         Wr/bQB0ffYDxBGH2bqtsy3BeUHMAMsTUNAObO8JvnfrK/JmJVVx5uHNMEK5SyPGsJr
         8mj1L5oTHhTuF7wOggMK2Iw6fpVqDwGLTzLSWNTyN89zP/GjMDXEBshNza6BS+l5Yn
         awpcsJtM97d0lezlo9+QEFDCR8x/1Butyy7fQsZqR0300FKqbhR4Bw0GuGxtSXDm8p
         RU/FLDkjswD2Q==
Date:   Tue, 15 Jun 2021 12:54:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Claudius Heine <ch@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Marek Vasut <marex@denx.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ASoC: tlv320aic32x4: prepare driver for different
 device variants
Message-ID: <20210615115438.GD5149@sirena.org.uk>
References: <20210615094933.3076392-1-ch@denx.de>
 <20210615094933.3076392-2-ch@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <20210615094933.3076392-2-ch@denx.de>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 15, 2021 at 11:49:30AM +0200, Claudius Heine wrote:

> With this change it will be possible to add different code paths for
> similar devices.

>  static const struct i2c_device_id aic32x4_i2c_id[] = {
> -	{ "tlv320aic32x4", 0 },
> -	{ "tlv320aic32x6", 1 },
> +	{ "tlv320aic32x4", (kernel_ulong_t)AIC32X4_TYPE_AIC32X4 },
> +	{ "tlv320aic32x6", (kernel_ulong_t)AIC32X4_TYPE_AIC32X6 },
>  	{ /* sentinel */ }

It appears that the device already supports multiple variants?

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDIlP0ACgkQJNaLcl1U
h9CYOwf/SlCmc7TAjtDwrSiQvdXEdliXBwxX5qNaJe+XWlWNKdt6nxq00rCJ4kH5
YOfjOL/FvF9oCEnUqdQSBOKiiLTPxtUVZPbUCZsaLC9h6euOxLVvmsMWRGvGBYeb
O7Mfcuvik8fX4TtQPrlN+VkSKuHNprrMeyBlVV8t5r84ED39c63uWDa56WvY5J6S
P/ZRzT1ZVVpJC0418lE+y+dnnzegalwiZTn2u4mFxyN+CrD7OC2GfDFROFO9IAcT
0PfaHIHrj5k+JdNqQUVGKeAgp77W7Tb9fdepVkGxYK4lw8RTlgFqjpSPpPVu2WId
PPiI4st8jlpxYJOb9fg8ReQfQ9MMyQ==
=F81b
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
