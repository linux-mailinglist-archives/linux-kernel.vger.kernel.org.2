Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213D1311332
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhBEVOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:14:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233189AbhBEVMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:12:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1338B64E51;
        Fri,  5 Feb 2021 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612559511;
        bh=EaTd+Wuy21AekfWgx1/4UsqU6p4ILwGM/82jequDut4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTIR9BVMqMvtDjmAa4NSUrz8yO6EQHRLuCy8juHBLzTJRQe1XRCRusgZN4R/jzKRy
         x3Z7aGS54KqCbVJxWAqui662+a+Tl/Y10+9HAnGzNxXwxg25FZ+mzmfCOGYfJyhfgp
         FLTkPLJwUFGoHXt/BHZ9hxzRX+Lpvg2eOeyJedis3Byt/PFchEvQdYs+f6snUyYbA9
         TqhYeq9WkB6gfR5i19RwsguOqVT97h9rhb8LR6cO1HztgrZwaQGTJhi2oOnkcIyu8U
         bETrP/cQB2oWNm1d9X07MkuI7LAo1fBT6KeFIgIFebGEB5NuYc+6KViWGg6oDhT52r
         e4hf+UAlf1kxA==
Date:   Fri, 5 Feb 2021 21:11:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 4/5] ASoC: Intel: Add DMI quirk table to
 soc_intel_is_byt_cr()
Message-ID: <20210205211101.GL4720@sirena.org.uk>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
 <20210204140515.GC4288@sirena.org.uk>
 <20210204150456.GN2789116@dell>
 <20210204151139.GE4288@sirena.org.uk>
 <20210204154058.GP2789116@dell>
 <20210204194213.GG4288@sirena.org.uk>
 <20210205083416.GR2789116@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZrCu0B0FMx3UnjE2"
Content-Disposition: inline
In-Reply-To: <20210205083416.GR2789116@dell>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZrCu0B0FMx3UnjE2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2021 at 08:34:16AM +0000, Lee Jones wrote:
> On Thu, 04 Feb 2021, Mark Brown wrote:
>=20
> > On Thu, Feb 04, 2021 at 03:40:58PM +0000, Lee Jones wrote:
> > > On Thu, 04 Feb 2021, Mark Brown wrote:
> > > > On Thu, Feb 04, 2021 at 03:04:56PM +0000, Lee Jones wrote:

> > > > > This set has all the Acks we need to proceed.  What's blocking?

> > > > There's the subsystem maintainer...

> > > I assume that was a question and you meant "where's"?

> > > Pierre is listed as the Maintainer.

> > I'm fairly sure you can see what I meant here and why there might be a
> > concern.

> So that should be a Reviewed-by and not an Acked-by then.  That's fine.

No, it's that there's plenty of drivers like this that are listed in
MAINTAINERS but still generally go through subsystem trees - this is
also true of for quite a few MFD drivers, you tend to get a bit annoyed
(quite reasonably) whenever I mistakenly pull MFD changes for them into
one of my trees without syncing with you.

> What do you want to happen with this set then?

> You want it broken up?

I guess, or at least a pull request so it's in my tree and I'll notice
any coverage issues.

--ZrCu0B0FMx3UnjE2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAdtGQACgkQJNaLcl1U
h9BWRwf/ZZn/bM6T8HI5iWDV7jZlHE6LElBXKls2FzlnvKemebzh6PZngZAoL2Ya
pPvJqzu2NzZjQdYQ4jwz4TO6KzMqClml0uX+GCKiklkobgapvDFvNJWcZO/Kp7Sk
40EJ/4FbGPTdGZ1XYAjSlQTBoZ3KF67AfiXWiOK+YzSrUxBtmEq77b9ebpTGssNS
XJtEU5AjWcwDj8QZRzadrnLV7vbQOIZZJVX+Ab5q6qssmuiHaeImEk9t6yAZuB6P
ETCaJKjjSCZJHTFvfP6/b5G0Hb64L8d5MQVxhAKn5aU+xt384pYGA4bCz4Qc93xJ
DbJknEWAKznp4kgImKWNB/39R4YH6Q==
=PeN+
-----END PGP SIGNATURE-----

--ZrCu0B0FMx3UnjE2--
