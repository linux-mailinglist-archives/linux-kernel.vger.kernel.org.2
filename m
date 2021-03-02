Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E7C32A716
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449033AbhCBQDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351142AbhCBNcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:32:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D9CB64F12;
        Tue,  2 Mar 2021 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614691310;
        bh=iytCnS3/Fqm59AJCTx4Td5YHfFiyyY8XF5Iqi/De8P4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvfE4cxhrvhQNG1uiT0poBGzhekrWpbOlIxK5VePyKISfBBW0lWl+QjPPnYMDsQxj
         aLVRYCTHbYDFDa2i6U5CLy2RDtw++OtYk4lMJGB3yevFI4N1u4lDm47+L3H2JvSsTe
         d7CIVghk8hBQXjor5pOtpUj70VWid0EEzCgnKx1sgW7t6Seh0kCpSNYNGWstspbKEg
         jS7hl04Q9dvcbiRQrPgAn7j1ZCP04AllSdxWPUzB2w1W3EAbHoz8BN2VGepEoV0IHj
         1zFWHOJPzbnVV/lKcKtt8XuUeX/J4s21r4JRqXFQWr75enJiCzOKUdrnPgGIfUJtz0
         HLYJf/BOR4FQA==
Date:   Tue, 2 Mar 2021 13:20:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     tangbin <tangbin@cmss.chinamobile.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codec: Omit superfluous error message
 injz4760_codec_probe()
Message-ID: <20210302132043.GF4522@sirena.org.uk>
References: <20210302121148.28328-1-tangbin@cmss.chinamobile.com>
 <K2DCPQ.25EEALUNZ4K3@crapouillou.net>
 <76c87931-094e-0804-9405-ad4841fae2d3@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <76c87931-094e-0804-9405-ad4841fae2d3@cmss.chinamobile.com>
X-Cookie: Friction is a drag.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 02, 2021 at 08:55:25PM +0800, tangbin wrote:

> Yes, I would have written it in your ways, but considered the variable
> "ret", I gave up, and just deleted dev_err().

If it's not used any more it can just be removed.

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA+O6sACgkQJNaLcl1U
h9D3Qgf8DCZVmc6ugbe3U+nU/APz1o3uNlnfvCBUw0+J0EN+fkVj0Aoj493A0viD
IuXCy7XCPmam3JE4yIYbnA/FzmIs+PJ36/CnKNOH22e63WxWd5zdFk1S4dW6LA1m
1ucckj2XD3+y6xGscd7FIdgX7EPoGYvKC2zB6QYBypL4mkNk09S7bjStYApaZKNK
q+3wIjc/HoGFrKwG+L5v/wDeoMA6NX+x526O+3BDCv46JClza20O0OtHg8iSE8hL
oKJxwBcluivy3SW/McFFmCIHnS8t+6B/UZ72PsSKjFkyKSqB8lgLNE5Dez/F10K8
VFuCsAchxsyOWBiVzHCjrZsDDKze1g==
=uM7f
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
