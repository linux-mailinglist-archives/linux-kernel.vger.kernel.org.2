Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E087310F07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhBEQEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:04:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231493AbhBEP4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:56:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80C5C64DF6;
        Fri,  5 Feb 2021 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612533822;
        bh=KSxIMlDA6ShJiaWSByB90Lc7u1RAy7m+dFD6RcfG6m0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lkoEcfJnt0fU9Iij7bTJMAndSCEiVurjdE9VNRGNHVT0iEDMcEINYzsKoOZL6cfM9
         GfOJuAE3Zt4Q0+xz4xEsiG0KtPOIpRIzGy2HQoc4w+IpY7+X+3IrjQ+5OZK2Oz2Uvs
         OKws/+OMqB072shE4zH+l3F/L/tjZqYciYT+BBv76qE+apLwel9okio39bY0H+AtX4
         1iLboaZ4fpMs3123JkGSuyFzsSUAkWKQi+T+Ujkfm5McF7oYhX87xXjjsu6yofnNw2
         JUs8822XtMP7hLe2CJ6fkhs+KnX7ZdVtUE6pvlcg6g9x4GXeMCQygAr80Q0MTJPXPc
         kOaNCClvv1m8Q==
Date:   Fri, 5 Feb 2021 14:02:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, linuxppc-dev@lists.ozlabs.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio base
 on rpmsg
Message-ID: <20210205140251.GB4720@sirena.org.uk>
References: <1612508250-10586-1-git-send-email-shengjiu.wang@nxp.com>
 <1612508250-10586-3-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <1612508250-10586-3-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2021 at 02:57:25PM +0800, Shengjiu Wang wrote:
> This is a dummy cpu dai driver for rpmsg audio use case,
> which is mainly used for getting the user's configuration

This is actually doing stuff, it's not a dummy driver.

> +static int fsl_rpmsg_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

If this isn't needed just remove it.

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAdUAoACgkQJNaLcl1U
h9CaXQf5ATE//mi5uJVW049xtEPBycAxvAbD6dNUWYwuolWDZojNk7ks+PbhTKnA
0gUKScEIt0hL34j7/4NiKG+VZ66VHWlGKf+GOAhnku/bVm9Iu6PmTRoG72cNRiyt
/hfXxeapZaUppPdd6/QADyoGWNnc4W3+JwC+tcSbRrIFpgrZK+fp+nLkBbmvdTtm
rjguO81Wbie1P9vtAlWfiZhjh47ZACa6OhbNXXu4P7ndcwBUrOU9J0CMtLOWPMMU
E9dYnRBCJVSWIHbTz51qUzzpF7DCsb8TJYDlLmMSyzCf+OsosvVQ5gCLMTE/Wsfw
J4QgeKlJPaSNbAGIo78mYd3NJttKTw==
=oQQq
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
