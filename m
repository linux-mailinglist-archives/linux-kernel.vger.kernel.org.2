Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4809735DD95
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 13:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344211AbhDMLSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 07:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237455AbhDMLSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:18:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3A0861042;
        Tue, 13 Apr 2021 11:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618312682;
        bh=OvNQM6IzRqdh+yn7nQwJNg/YLF9PnNkxrdQ/ThWGjc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htgGNyWtADlGcCPiJP5fBSZhNRgAP9DbAFrZhvgLiryC1QRZlhGvJXNZDD+IIoBNI
         YUUNKK/nXIE9FpLQXqnHcHRSUiJl03dgeG6ns3XsK3sIdyO22ABpkHgjvuA616eeAU
         wT2975oa+rTorepMsYpRm2/xf2k0xLd6GUTFQ3Wbu9sy3uslPOBpT1Veubj8PJhsVt
         4ykAGmiFYX0Cect+JMR6Eh3OxDz0VGjxseL0INNTq7YDGCCyce8Ws06dhz7G9Cl8T9
         +qPNBcUezQhHnLQgyLUXPgo0brB3b1Pmj2q9VmQ9Rvk3DOqKPCnW7qCG41MiG8sUom
         mvbKSM/MDDwmw==
Date:   Tue, 13 Apr 2021 12:17:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ak5558: correct reset polarity
Message-ID: <20210413111740.GC5586@sirena.org.uk>
References: <1618293991-6611-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <1618293991-6611-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Shake well before using.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 13, 2021 at 02:06:31PM +0800, Shengjiu Wang wrote:

> Reset (aka power off) happens when the reset gpio is made active.
> Change function name to ak5558_reset to match devicetree property
> "reset-gpios".

Please split the fix to polarity out from the refactoring, the
refactoring completely dominates this patch so it's very hard to review.

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB1fdQACgkQJNaLcl1U
h9AZMQf8C+Dzhlre7G7rflNnG0xa6JsHdDP7W7C7EqGltU5gMyqxmtEyDgrvbO4y
2ww8ck76dmT6S4xm8QWVfkxuSWGFntwg52fZzCqg/lIirPusSY8FI5fEZAhjQTDs
Y9Biodef+9uS23aH4Ga7qwQ6da1tVAPOOVsMwAf6dwVB65qMQIwzvyu1ZXPC/itD
OX1rMqBRVEWzpTBRhd5gqOLCiSran9pTOreC3GxVAZ8H/gPpKbwiZDBSjMMkW8hI
emSeeHsb/qeeuoBd64tFgiS/5l9SRuP/fNeJ0ZebUjWekKg+jZ/REgVAVQgKSuzV
OdpFIr7Si0sE/VHdvtMnG/uH1prYAg==
=85l7
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
