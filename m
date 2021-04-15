Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5E7361115
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhDOR0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233395AbhDOR0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:26:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA067610F7;
        Thu, 15 Apr 2021 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618507578;
        bh=7ft7XWhcl8j51azotCTdt9feNmJzjvydryFigI2I6+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pWTvHfzUTUJYubbnG/ta4Lbv0YUF5evDnjUD71U7a4kLtl6NXu75oiJNiOMo4ZECJ
         Mh6O8PycQMLofh4xP6oq9NT0ax2ob/80HMjxtLUAzVvY+oFGYf1yvdxPILW9p3jXoz
         eNwcnXYlwIWoGTGEDlJRqdMuLdVLawYLH5KxI184fvp4mIJx+gxpOsQZCMUutyYes4
         rr1GPHRDso2E+KyO9ZZJPcLXxuuAYRpCVhalb8wDcDLnGfTWWNF/wIUqSToA2tNxgY
         MAUOCvzGnzYmSpgsAWakpEo2pp2mN3TvmneDsmpwDF1gpLXR3IJRznkNTvKisVjRqj
         x51WVS7eCuIqQ==
Date:   Thu, 15 Apr 2021 18:25:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, gustavoars@kernel.org,
        mirq-linux@rere.qmqm.pl, tiwai@suse.com, lgirdwood@gmail.com
Subject: Re: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
Message-ID: <20210415172554.GI5514@sirena.org.uk>
References: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
 <a0c862ec-44ba-52e0-551c-0347166ac4e9@perex.cz>
 <5e1fb981-48c1-7d5a-79a6-ba54bac26165@microchip.com>
 <4f401536-5a66-0d65-30cb-7ecf6b235539@microchip.com>
 <20210415161743.GH5514@sirena.org.uk>
 <1aff49d4-5691-67cb-3fe7-979d476f1edb@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Content-Disposition: inline
In-Reply-To: <1aff49d4-5691-67cb-3fe7-979d476f1edb@microchip.com>
X-Cookie: VMS must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 15, 2021 at 04:56:00PM +0000, Codrin.Ciubotariu@microchip.com w=
rote:

> Are there any plans for refactoring DPCM? any ideas ongoing? I also have=
=20
> some changes for PCM dmaengine, in the same 'style', similar to what I=20
> sent some time ago...
> I can adjust to different ideas, if there are any, but, for a start, can=
=20
> anyone confirm that the problem I am trying to fix is real?

Lars-Peter's presentation from ELC in 2016 (!) is probably the clearest
summary of the ideas:

   https://elinux.org/images/e/e7/Audio_on_Linux.pdf
   https://youtu.be/6oQF2TzCYtQ

Essentially the idea is to represent everything, including the DSPs, as
ASoC components and be able to represent the digital links between
components in the DAPM graph in the same way we currently represent
analogue links.  This means we need a way to propagate digital
configuration along the DAPM graph (or a parallel, cross linked digital
one).  Sadly I'm not really aware of anyone actively working on the
actual conversion at the minute, Morimoto-san has done a lot of great
preparatory work to make everything a component which makes the whole
thing more tractable.

--gJNQRAHI5jiYqw2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB4dyEACgkQJNaLcl1U
h9DSfQf+JkppA2jscPzzjdd9boS9MvB4K13ujfyH4R0ulhxBTuJgb5iVHE1G0aHM
NG4GVpP9IexvwP9c0AK8jcMy+4iz/ZphMvC2ha14jHPMrPI3887OBshaI11RXSf+
7LvmQ3AIubqZhuC2rVjmatelfl3QCkfNFeR7m1SKmvfb8OFMeyksluYPVRUEZnHF
0IWCeL7GElwgOk+xgDM79QvtCZurdG7GOmzGfqWMbY7nd0tVA4Vv26NGjKsvYlmt
li6SA9vaXO3Z7D3jKSXTk6m7TY+p6wCTPy2D1J+ICjMFyWuG0eLYwKW2+uH1OTAk
q+77EZoayqpTnS5rgA01jqbIY+dK9w==
=0V65
-----END PGP SIGNATURE-----

--gJNQRAHI5jiYqw2y--
