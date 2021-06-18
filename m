Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05C23AC9F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhFRLfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231247AbhFRLfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:35:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E68B610CA;
        Fri, 18 Jun 2021 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624016024;
        bh=9s2RQDW9wanQqORyAIBE9pVzVvO91REtRxxPhTclx3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SqlXqi54Wb+yJCY85fbszND337jMrH1YM9XsF+vWgllGBpqb9VlxWeoQIneYKtmoL
         DDWw6wt7vpYW0ktptOHD07s18Z7MKMyqxG+QttWQ+0Vs2sUxhpzUOOPOfsT/wModgb
         KXCsOEO7f9llPwPii+Ae6A6fRw2dlavWsuGTs3GxHsarnYKzEzSFsGSjK7tZq9E9nB
         aijS9ai4jkTUI2U2HTPCWoqjIGzZ2KpEeJPAT0iO0F5xtCjm/IyRptmvk+3pMiwIFR
         zzUZ93Gzt1DsGgsmiJO5sWtcXSjvGbPlxA3dkXDbdCcC6ctVmJhpGelXftHm9jGPSx
         NZ7ixSeKGTPsg==
Date:   Fri, 18 Jun 2021 12:33:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] ASoC: fsl_xcvr: disable all interrupts when suspend
 happens
Message-ID: <20210618113322.GA4920@sirena.org.uk>
References: <1624009876-3076-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5DYLZmz6f0yjrOpaL4B_wicq0ofrYpW6QqzNPEc0j407Q@mail.gmail.com>
 <CAA+D8AOiL2otCBRyP3q7EWd2C7RnUhWZjRtxcJWQyXXXydf_ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <CAA+D8AOiL2otCBRyP3q7EWd2C7RnUhWZjRtxcJWQyXXXydf_ZQ@mail.gmail.com>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 18, 2021 at 07:30:25PM +0800, Shengjiu Wang wrote:
> On Fri, Jun 18, 2021 at 7:21 PM Fabio Estevam <festevam@gmail.com> wrote:

> > The operations in _suspend() are usually balanced with the ones in _resume().

> > Shouldn't you enable the interrupts in resume() then?

> No,  as you said below, the interrupts are enabled in fsl_xcvr_prepare().
> so this change should not block anything.

Might be worth a comment explaining why there's the asymmetry.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDMhIIACgkQJNaLcl1U
h9APMQf/d/lJMjdPrNhdzJeuS3tVHQ268JZCwmabDferZbnDRbjuwaiq+4wAdnBC
EFksPtmaTNBBrrLUc1bTxLs0Hl0wBGNv+zf5r8FCfEm60zrQF3QKDTZ1t46ZelbX
9uQRMcFanYwBChVofttzEwDHWStsDCHoi7pfP4ZwGTR+SR6rERyzgAv43862ne/G
klbzzYKa+CyLGvojCzNTZBvkyNPQCkhuazh7wk6UolcFTf2oz+wjUPYyJ/Xbwqb5
t+Y4zwAqMls5GZtzFWIohvRgCULmADRq8FqCzFQIYm3teLhDgQGtbM8Xn2Tz3Vp0
MQveAgdluQ8hDsBYMq31CB4CgMOZag==
=a0cm
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
