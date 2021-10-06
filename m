Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302C9424292
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhJFQ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhJFQ1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:27:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2D61610E5;
        Wed,  6 Oct 2021 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633537546;
        bh=yMaIO/vd9u6EImrWxqcYNEJlDSKGJFG3owN7iCX+71A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFazALmVxw2rZ1+El/acDelSWVyVEpwrxEZeSIgfwQKuM7JseeOjQNchG09/jBLeI
         z7mTJ74NRPa+btJsFJgjsqow1fkKJuo4AjqMDm24FN5GFAbkuvHhBu9Went3/sDt9p
         MFUYP+WdInjYC51xT4BXNLmahT3yPpBcpZ9g/L0GB0TQfpSCqRsjDTRqABB7eRr3iO
         7tBYXX/M68BXbwB4bm9X/lVkvF/5yHyJUjYvuaXbRaLA5vXQi4EmqqwdP5RcU4YjpS
         KFUrboC5dYv7Xk5LeoFLeSS9wViYI4P4Bo59j/oFy0FUCZ1XyHhpA0BVPX1g6dWZN5
         tm6b4I4kQtLMQ==
Date:   Wed, 6 Oct 2021 17:25:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/4] ASoC: Intel: bytcht_es8316: Get platform data via
 dev_get_platdata()
Message-ID: <YV3OCDEgsy1NywTT@sirena.org.uk>
References: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
 <c8b85524-6b9f-8fd3-3978-1d26b92660fd@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cLozU3SCA/iEvNWJ"
Content-Disposition: inline
In-Reply-To: <c8b85524-6b9f-8fd3-3978-1d26b92660fd@linux.intel.com>
X-Cookie: A is for Apple.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cLozU3SCA/iEvNWJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 06, 2021 at 10:52:54AM -0500, Pierre-Louis Bossart wrote:
> On 10/6/21 10:04 AM, Andy Shevchenko wrote:
> > Access to platform data via dev_get_platdata() getter to make code cleaner.

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> For the series

> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.com>

> FWIW Marc likes a cover letter that's kept in the merge logs.

And for Mark it's more about the fact that it means that b4 can figure
out that any tags like Acked-by apply to all the patches in the series
instead of needing manual editing to add the tags.

--cLozU3SCA/iEvNWJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFdzgcACgkQJNaLcl1U
h9CUXgf+JIYwxgw/R8tGnzq26yu7CEbph09Q5/lfkYm0whq7yFISmL5sD3CPsCJE
1mQTpd36K2XUMv6bTN6AKyY8JCn/TilBde9vp1oCfX3Rb+be734HtY8m3EeLpAx3
+/epxCXM08ac2gf5dHbtzj6gjNL+uwtwTCCNOAwjwT+n2A2tlXl2Y0bNKfTYpPlD
tCcHbEkGhK84zSwymSOaSre3GC4QcGquf6Wl+aibNvOwqt2SONH+M9kXsObdesVo
swIHZsbywgaahkWXhrGUVRcE/uHUDUmZctSnQ/IlMXP21waUFLfA6ZkUdr1vX3rH
9iJbD+psO7AaVe4U+bmUzQCgbS+qtQ==
=4kTl
-----END PGP SIGNATURE-----

--cLozU3SCA/iEvNWJ--
