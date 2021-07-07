Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC03BEC47
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhGGQdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhGGQda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:33:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 212E761CC5;
        Wed,  7 Jul 2021 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625675450;
        bh=6q+hWWacieAshKe+FazOGS4+liEhM0sS2Dz2WwbaioM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6XE8rJ8eCIjEuW/OTCcINKwbPPXVtpu1wnpjWfrXvuqb0kQuKtiQNyTRuRVFW2X/
         uLnAP3RX5HV0Wia26RBwkuHUZ3QQ6KfsxbYp61H/6MRs+R4VBUPzhgdWPQwWKcKGmc
         /twuV2LZBQJOnNy0Cd3DjWIa3X8yN9h86d4hcbZoisFFLMqMJ09K2IhG3DMrX/Ox2G
         V6hUjpJPbqVvo91IoYq6Ym8XjI3f9hkxViihmEmg2O/+Gciek/fWIhwpRKkn/8LPZa
         EriIi+C4sXCftiOqtC8gP9HSlEhTAzgNOTaW4O6h5ChjwNkgiMkzoW4LJctP0RGV5R
         a+rP5Xlfv7PdQ==
Date:   Wed, 7 Jul 2021 17:30:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Alexander.Deucher@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/12] ASoC: amd: add ACP5x pcm dma driver ops
Message-ID: <20210707163018.GH4394@sirena.org.uk>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-8-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Content-Disposition: inline
In-Reply-To: <20210707055623.27371-8-vijendar.mukunda@amd.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2021 at 11:26:18AM +0530, Vijendar Mukunda wrote:

> +	/* Group Enable */
> +	acp_writel(ACP_SRAM_PTE_OFFSET | BIT(31), rtd->acp5x_base +
> +		   ACPAXI2AXI_ATU_BASE_ADDR_GRP_1);
> +	acp_writel(PAGE_SIZE_4K_ENABLE, rtd->acp5x_base +
> +		   ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1);

This isn't connected to the kernel page size is it?  If so we might've
configured to 16K or 64K, or possibly even some other options - I know
those two are out there in the wild.

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDl1poACgkQJNaLcl1U
h9BiQAf6AtJK2Ffb4vUcYoiF04zy8sKGtW2lCQKie6xHafUl64QvbDcxF977k09V
Bpu700qytonU3CYdFtqWcgiHpOT8XkSubup2Dswx+XkSp4oygFj+tG08oEUyw78I
tNBSG8PYuLBjAQukjrvs59MUieYz2QkGhQLWnJhImCtM8rM0JVWP+Qb1Vd9U3pYH
CDxQz8fKZKJGo88Ng9xJhxzfW+nTyxuxIfJVDgDyAj+8a9vlWz1uV/Q6VS9FdGXj
W+4uFwf96SUfICTOmQxgE5Tcm9cfLZ1ITHSdC4vzFq+6dalxF91u/Rekfh4+xb2v
NGJDu6PyrHM9EzxLM73YYa1f0VSa2w==
=iaY1
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--
