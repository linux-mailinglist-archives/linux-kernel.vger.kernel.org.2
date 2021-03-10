Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDAB333EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhCJN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:28:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233272AbhCJNZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:25:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7886F64FF3;
        Wed, 10 Mar 2021 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615382716;
        bh=3YEROOanQFhwri64Wf39ydWpxMlU6FxhJmhx5ERcPxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PS8PlXwqn9tn4bLkN+PaIjd7KVPLlOCG0IC4NjGgEHDo0XXhnh6p26sOc4HfkTU4W
         hGemk5Ql/keQ/hMy251dQgRtHacmUvsWY08AYDmWq4MKcjEyllNTMQd86tpk+XsRqm
         NBArS2O79NvDKFbJVS9hVVhFhR4Oxe1E3TRXffunAcUyXJZNezV+nZj72/cfZB9p1c
         Am0MLIVH3iXRpwQPt9S0R+aB5UiWMOFf4ihAf2SY2Yr0YbEtJpj3LpwvFTj6wju0tG
         RgQduI//kqFx9ioCRTc0pZWg+v9z2icltjyaFSGVX9ZqWRCYQlYPFeH6yDCauB8CSF
         x0Yqo3QRSRWyQ==
Date:   Wed, 10 Mar 2021 13:24:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        gustavoars@kernel.org, pierre-louis.bossart@linux.intel.com,
        daniel.baluta@nxp.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] ASoC: wm8960: Remove bitclk relax condition in
 wm8960_configure_sysclk
Message-ID: <20210310132404.GB4746@sirena.org.uk>
References: <1615341642-3797-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <1615341642-3797-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: no maintenance:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 10, 2021 at 10:00:42AM +0800, Shengjiu Wang wrote:

> changes in resend v2
> - Add acked-by Charles

Please don't resend for acks, it just makes for more noise.

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBIyHMACgkQJNaLcl1U
h9Bw0Qf/Yh9VvCk6GMlhz0L0JzyvLqDcnIIJ38Zv/dUcvEMq416SGcrsZzgT+gHK
uKdC2H6qJqAqP9Ko86isNFhesN0Ep5th+ymYthtsDtf3rme/b3purNQepuR8E27r
Y7AkyOj+GLo69WTwlYmvVZzEzJYMIzcuL0DOh0VURQsSp0q2wOPrFk7dOcAxYx8X
2EmSKwKR21pwnkWo/BQUmVmY/rNirii/m6n/1Ytj6flqnQz6HOHkksrMEYcPv4/V
ERQ4f73bpkyo+9ofh/14DYQ+mVcd4sz4gov8kE9lKMkG5jeFLwqurBx+nVUrBT1r
peHrYo1wWVkIftvHScO2FV/JdBt/Og==
=XEXn
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
