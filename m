Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF26348226
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbhCXTtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237892AbhCXTst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:48:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C10CA61963;
        Wed, 24 Mar 2021 19:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616615329;
        bh=gqnmGYhk3udJPxquG6cxpNbi49QbqQbwiJwSS2qaF6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=elzRZvqyeFbdcp5+wIe9XWN9MiOzp9jabGyh/TDOkGAJggPB42fjFD2l30+Bbkh06
         5GE6e7ahe3yjh8mMiiKS0Zi9AEOORTOMxEFYILzcdt3AkLsS3vNaogieTqEpl0KshG
         4p8iOf3KnLfhBSaWCLFqt0yzXsvsV7kcCOasHhtZJbnCmnMiXqg5cT7C3151HQu6Pn
         wJONMHDTd9eIxA27D2EKDiB3UqnZF1mATMiXS1e6k5W/24Rho5MBBkUfxely7PMVbC
         HfVBXFDgY9WAJ0EndgTYwQF3NOHEfLYEYd1ypcWIJaelaJXCodX9P7rNyzrNyhP10p
         bpEhJs7B4hCYg==
Date:   Wed, 24 Mar 2021 19:48:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com, gustavoars@kernel.org,
        Takashi Iwai <tiwai@suse.com>, daniel.baluta@nxp.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] ASoC: wm8960: Remove bitclk relax condition in
 wm8960_configure_sysclk
Message-ID: <20210324194841.GB4596@sirena.org.uk>
References: <1615341642-3797-1-git-send-email-shengjiu.wang@nxp.com>
 <20210310132404.GB4746@sirena.org.uk>
 <CAA+D8ANXcyJ+GrEqTNuoNJ4wGCQfqjRkhcevt-eXSrNj_V128w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <CAA+D8ANXcyJ+GrEqTNuoNJ4wGCQfqjRkhcevt-eXSrNj_V128w@mail.gmail.com>
X-Cookie: The eyes of taxes are upon you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 24, 2021 at 09:44:26AM +0800, Shengjiu Wang wrote:
> On Wed, Mar 10, 2021 at 9:26 PM Mark Brown <broonie@kernel.org> wrote:

> > Please don't resend for acks, it just makes for more noise.

> ok, but could you please review this patch?

I already had it queued when you resent your patch, that's part of why I
was complaining about the resend.  It's in git now.

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBbl5gACgkQJNaLcl1U
h9Dongf+L99ppnpwQMqPG7xyAvuIy6Yns6XMnbQxoLtLTqs+UrR+mf188mKR6zCI
4f8M6NPIA/S3q8F1/2lO1HIcPKKEk8Rl9Y4MB7PV6wZQfo8Rd5DAkDoHLIX1uqr8
+MTw04/T6ym/h+jeF8MMtaItVDGeCYIcVcBGPvC8zGbsRp6SWYF+5nuPkWqE0OAA
z3vysGMcsA4SprtRLZYWAPLHHPQfzHMKJzymk6IKfbiuHcO7Gci5r94IHJGVggx7
eszVHVmUG9cwWB4Q2JNw3qKFnyvosexq9Dfpokl8+6+e8R3COL1t7jqOzL2uoAUB
1Q3k/8I8anj5SwHjqsDcu2pHHVRAng==
=ltSw
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
