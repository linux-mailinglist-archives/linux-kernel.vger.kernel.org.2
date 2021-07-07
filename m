Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF93BEBE0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGGQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhGGQUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:20:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2240461CC2;
        Wed,  7 Jul 2021 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625674682;
        bh=3CVrcJTXPYuxSS/j2wHuKVTsifDFv5fStRhTCq4ZIIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nz2KU2Jb2fjznSkmLR8T9eDTn35e8u1QGCxa+EVbAOiZiF6mNLovNDfRyF2Aki1zL
         4Ea9K2/HwQupgDchxi7HyO9FwwaC8bhFJtKlmQx4OjetRf5hzv9AFcQbh/wULVMp79
         3xoXc+DBmO7qv3lT041wIZ3ZwyOReyC2UabOq3CRqV2tAM7QSRvAgZZ8bU/LcnS/Xx
         3C+sXLNRFwEchBJSPxkhtBlIsuVBMmnLdf2KcKwoWBntnqR326JTgp9buT2Zrg4Qqw
         5I+XqcmTUKLXBpINc8xY1mN2DDJCZ6VBp6sr8Z6w20QsW6+xaBcXZXjoXyM8Yuvdgk
         hYlTm3mW27Rag==
Date:   Wed, 7 Jul 2021 17:17:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Alexander.Deucher@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] ASoC: amd: add Vangogh ACP PCI driver
Message-ID: <20210707161730.GE4394@sirena.org.uk>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-3-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <20210707055623.27371-3-vijendar.mukunda@amd.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2021 at 11:26:13AM +0530, Vijendar Mukunda wrote:

> +static inline u32 acp_readl(void __iomem *base_addr)
> +{
> +	return readl(base_addr - ACP5x_PHY_BASE_ADDRESS);
> +}

I see this was the same for Renoir but it's weird that the read and
write functions are substracting rather than adding the base address
here.  A comment might be good.

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDl05oACgkQJNaLcl1U
h9BQ/Qf+I44B9D46yvA5DrXifzyD6B4n/K2QaDtHbog1HFtL1zbtiiATxdhLtYIS
yXeKEGxzcSmW+DgUaIMLf8kYbnoVTv1CIuAb6EpYWUVKIWlGHQ3n9QPoYuYIutvl
itaiB/rrOuisxmm1W8IQb0XL3DKywXFFRjnfqiC4d0z88U90gh58Ox3P8NgWMAsY
m84CWKyIJTagN7j0SXN8YizkoD/yBIS6eXa5l/jZ5lw9LlF2EqwBqEB7JegjnyqB
7Pf8CArQHsjn4+4IaPBVga6RmVukipqH4N+CfaXmOV8GbhvGnLEyvk7thJ4MbmvY
5BeHPpwe/hgvPfHZqDSFVOL84r7wsg==
=m2hI
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
