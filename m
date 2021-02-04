Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6474130F49E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhBDOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:09:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236618AbhBDOGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:06:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECE1B64F53;
        Thu,  4 Feb 2021 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612447564;
        bh=WTpwmaKEsOmopPWlV5aFCRgW07zNI0+llSoe3KrdjNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+52rSFlPrnt3pGAvXLfrIbKUDVaWXqEOiuZe6BU24JGEjVozqFRgcyuCuCXfBY9d
         Kh1DRlYizwCufebQleqDSfodBkX5WYZmYw0T/5poz7mfDI3wkduPE13YpZ5/PVGMTd
         TeEZrGOqjZfm+mLhryIEVAVtPzFEb/R5TLp3yY3JP9fWMFCvZTADV38eRJNfpAR7Kt
         7qiM3L4GVIPF8tUHGU1HbsiW8JCQjxAO7mm5aiqNEnx5UfQPgNpLlD+LeXWSakK9ky
         aOAAqkbbK6Icoirek6meFxZtmvXfmA2TocE/NaclCw0FAQX9eyDuy4ohTyhjAOWuMZ
         gQrBjSZAcAmkQ==
Date:   Thu, 4 Feb 2021 14:05:15 +0000
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
Message-ID: <20210204140515.GC4288@sirena.org.uk>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20210204135616.GL2789116@dell>
X-Cookie: Truth can wait
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 04, 2021 at 01:56:16PM +0000, Lee Jones wrote:

> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>

> Applied, thanks.

While we we were just having a discussion about what to do about this
stuff...

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAb/xoACgkQJNaLcl1U
h9C3yAf9GvUSrNJ8yyv9kq8xIU5ckUwLeA4UL1g+1mugCDM1+SgPzSN6dZAl39kn
qWBsGN3BdkVWPaXZySyXkNsTQGEHte6PHH1Losn4w6p3AhTioLlODamNzDQs/aws
lTCwVMCY9cpZQIgBRlL/OGwsJU+wFKHNS4vHKKk/roLHElduYoDKXfyElKHBCv/G
rltkUuNYI/JbZM3ise5Gq9571O0filPGDe+LE97LIRlHWH3acn+3JFqrLRN8o4Tm
WOrjgdKppQyuXX8IzKyzgqaZVD6Gm0qVLRFruNtIcuCsoIXB9OkUnaa57YbeDs7s
PgzTpMX50XN/tIcK/4YBNxPsWL9h6Q==
=Rlvb
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
