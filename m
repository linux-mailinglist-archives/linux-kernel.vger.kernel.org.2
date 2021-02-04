Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D144F30F5ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhBDPOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:14:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237056AbhBDPNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:13:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 584E964DF2;
        Thu,  4 Feb 2021 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612451548;
        bh=G4jmW1klxSDhuyqLVoj50N0KykhbrDTq8TJm7ElTHpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1EODtEGbjMAIDkq072psv/urRdZPDKRVv6TZJAOxW+XAnE6Vb5Uwjt0aMx7AnstA
         j7n0VVxrsfX2rFgn0P1Sd/nf/wEvgGKKuTkXvEueJkjKh4fzyKlgzSH0n69EG1P04w
         KVO0UNXhRj6FebbVfYiUg69guvDqpmZ30p2Lq51rF7gu3rPePkdkqF7+b6C9zYST5C
         9wZsrVy08GhsDx0yLQGhmlB/N5p7clax1eIu41pfFnxZQldhFgD7wkCl2SQpblZdh4
         tDvRmUtzKwcHYSmqMmTlxHv8sGh+mhPkW6G8OoV0AP5GdwBxe4lmETKSS1tYj0tE3o
         BxGljiI5oxnYw==
Date:   Thu, 4 Feb 2021 15:11:40 +0000
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
Message-ID: <20210204151139.GE4288@sirena.org.uk>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
 <20210204140515.GC4288@sirena.org.uk>
 <20210204150456.GN2789116@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline
In-Reply-To: <20210204150456.GN2789116@dell>
X-Cookie: Truth can wait
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 04, 2021 at 03:04:56PM +0000, Lee Jones wrote:
> On Thu, 04 Feb 2021, Mark Brown wrote:
> > On Thu, Feb 04, 2021 at 01:56:16PM +0000, Lee Jones wrote:

> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>

> > > Applied, thanks.

> > While we we were just having a discussion about what to do about this
> > stuff...

> We were?

> This set has all the Acks we need to proceed.  What's blocking?

There's the subsystem maintainer...

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAcDqsACgkQJNaLcl1U
h9AqDgf/XzyTNV0AwXM8ECOYYqs8avg1zJ118ZJf4W3sf0LRQzsUidYaLfh7btT6
ax+t2Pm1s145XuvGeFEJFAx9UDaqWQRa7/WPGTveZmnPYgSHryMK8pmtWyc1STcY
iQKV0b/kLwUTn9V9Hu/jejpRl+a3N87j2hYIKK5Y3o+3wVjvFPj9FHSpdKFNvy0k
HKrV9GhZzMOHM30JfgBvAjNOoutBAhHe8agmQOcvK526XY3JBw6DctrG5vSXaj9q
w8yLcOmdv56laLX76e4dzXPCjGTqxlDop2MeyaNg3fmZ99kxLGumgMmNdggRU/xa
QPHYEKBU4bfMkXhTYk1yqct/Y4O5rA==
=1Vn6
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
