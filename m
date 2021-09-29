Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1389741C75F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbhI2Oyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344618AbhI2Oyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:54:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26F716108F;
        Wed, 29 Sep 2021 14:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632927192;
        bh=ZXFeAykbe3FWDJHs3l07s5lyMtmL1ik905y6YTUAdNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5WH2FzwlbnIS26FrCLvV1Ue7B7uJLnZiLu5E+PDWI/pjjZlFm+dIDbeNMansdXOM
         3x+2Dp/nv4IN+/ct0CRn4oBM9JZ6EjOyQnlcNcubUnRVhkJmhJ/ljbhaFweqLJ8wlA
         cmSK+9sEWTsI2AsRt+hKhl99cCtTr/1PBQp2rx8f2ZVp2vhSmluDRXswcYTBtALvY5
         /jACyU5Ia/jF9x2CFJq/MEFAYlSioLpNcuLRaVLwJJjH+Z4Q6mYiGaYvRDS8qctIty
         ssibvFEZCyT2HL+qEqmO+IC/CyyR2UBJ52BLuYbzpw5fGfOfML/OJcMxXgpP2BPIYY
         RsNrxHVSNPorA==
Date:   Wed, 29 Sep 2021 15:52:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Simon Trimmer <simont@opensource.cirrus.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Fix compilation when debugfs is disabled
Message-ID: <20210929145222.GR4199@sirena.org.uk>
References: <20210929145040.793252-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5xr6Gr0irOxp3+3c"
Content-Disposition: inline
In-Reply-To: <20210929145040.793252-1-simont@opensource.cirrus.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5xr6Gr0irOxp3+3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 29, 2021 at 03:50:40PM +0100, Simon Trimmer wrote:

> +#if IS_ENABLED(CONFIG_DEBUG_FS)
>  	cs_dsp_init_debugfs(&dsp->cs_dsp, component->debugfs_root);
> +#endif

The more common pattern is to declare a static inline stub function
instead of the prototype if debugfs is disabled.

--5xr6Gr0irOxp3+3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFUfaYACgkQJNaLcl1U
h9BWVAf/cHwn2KpyrGKblOiTYsbswKKh0yuTZvFgjjc17LMet2Y4XSv+dV1NDVnO
9JJt1mhlTU70VtE9lgVP5e1nmQNMSoGKgPBgg9FvgITYXDLEEC14tjhd5MQOynld
INPOk+XVQRWSejSrdkm+OTRbe6HyoDtbi2xnEcOhuwdEew5aidefO20IxpReCN00
iFTebQGL43HZuzy+8km4YvwUpGbwNrB4OhKIvr1wmycq9BSr5Rsnaz8F/fTy6fJn
tr+cuySzDXT4Rzw/My4Q3s0H/cVqDVYyhF6pYgI9tr+Gg91P/I0VJEFkGTt06MWo
su8Dk2aTjTZ0Z8Ud9bEfRzaLzI++4g==
=xvyI
-----END PGP SIGNATURE-----

--5xr6Gr0irOxp3+3c--
