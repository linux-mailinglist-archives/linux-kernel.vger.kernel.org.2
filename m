Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A12E352E70
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbhDBRcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236346AbhDBRbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:31:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80DA461154;
        Fri,  2 Apr 2021 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617384701;
        bh=my8naPIjnayNf0m2U0MZVlEyxJdZX5e19/+M/ali9Yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBaWxsQ/QuvcQb6FLouqCbQrZS/vrmNK7eAlI3KrdC12BDvCI+kw+9eLlut1W7Phx
         5PvyWTteERLffBhfEj7xp6LdNoLpe2Ryb6mEsbWO+UnbCvyWP/qfcgGs/tH43EN68s
         0Z1ZqJz5YKJ099jTVvZPDtiwc1Yrb1r9TBTuzOQHMjjSC9qYhj4/QPyUDXJXnybrSX
         dLqSqs7Ra8DNcJwGpePc9Hcw2MnuZwJ9nQJpkbzCvZImThXERqQxgDYcDky34+1nkC
         HuCtRgh/ghBDGG972MCDEu5zhwGlNw3NLiaWgyiwjsqpcq3xn1dy7FDK23vD5/d7jh
         HGOKJ/MQgjO2A==
Date:   Fri, 2 Apr 2021 18:31:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: Re: [PATCH v5 12/19] regulator: rohm-regulator: Support SNVS HW
 state.
Message-ID: <20210402173127.GG5402@sirena.org.uk>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
 <7a8323c92bcc039436b142e91bb86bbb9112aaf7.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Content-Disposition: inline
In-Reply-To: <7a8323c92bcc039436b142e91bb86bbb9112aaf7.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NPukt5Otb9an/u20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2021 at 03:58:33PM +0300, Matti Vaittinen wrote:
> The ROHM BD71815 supports setting voltage levels/regulator status
> for HW-states "RUN", "SUSPEND", "LPSR" and "SNVS". Add DT parsing
> helper also for SNVS state.

Acked-by: Mark Brown <broonie@kernel.org>

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBnVO4ACgkQJNaLcl1U
h9A1mAf+KAkiHTxqX2rr2nMzRwzkqvnenP1QPYlun24xWArSTTAfbEU6DPtSSpm4
0h9A15UFuEEVhJMtxVXeUF91wv2pbb9Qv6h5mdebrI6OyNsx4RMa6+Dd5Dm99rWj
nwjIzlLTNDy9XtMqC9Tt2m5f58UXGveTwnFS2LgLpOVbRAxbRSXbAYPaAvBtnojH
cwjLevF+GmbKa/mMimYRjDpqdQvzdVRlM+SlIZfa2Iu7497jahfkQ+0H1atLnxhM
JjD9wy6+Nk4Rl7f0bEZ5/fM0FRmf6ihkwoB+Fnhn7aabY3m39UzGImh9FO2M1vb8
G39lFfnlc2qVnKxxAp8TrHdh2xNw8w==
=IGnm
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--
