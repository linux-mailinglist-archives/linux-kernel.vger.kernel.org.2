Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242B430F881
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhBDQux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:50:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237225AbhBDQtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:49:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 963CA64F53;
        Thu,  4 Feb 2021 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612457355;
        bh=LcO1yRAm1OdJ+WPUOMGfAM2m+dXYl1VDF5Xw46wAgVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLzL3KAkeej7gVd10qAfK53pezuGCo/rU9dLvtXRZpifg1dCqllx3oxiEnpUD+3Zg
         3qeh4GcdCGioP7Y/zVBzfxNHT/pVZAzlE0wsT4/U2ND2gdHNCDdu20+4hb6lj4B8Yn
         wnAYeD5MhIw8fwwgv6uKUFJMhXwGmUJsgAVmUeLRpm16MVzMd9odJKzH9ZtK7s6nqo
         MW74l2TjgUyZYsiLll4q0r467iWKPyZQb+9tL1YDJauxL65eGayfRBUST8eqUdGZ9z
         UZptAbd7HOVM9xehsvu/pbopfBwVWFf5+/SEcVwajg076oaXJt815HfAoWNrNG1d8r
         BpdRJokrg7pTg==
Date:   Thu, 4 Feb 2021 16:48:26 +0000
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
Subject: Re: [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards
 with WM5102 codec
Message-ID: <20210204164826.GF4288@sirena.org.uk>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
 <20210204105748.GD2789116@dell>
 <7f53dede-946e-c38e-e871-3df1119f1faf@redhat.com>
 <20210204124335.GA4288@sirena.org.uk>
 <20210204134606.GH2789116@dell>
 <20210204150904.GD4288@sirena.org.uk>
 <20210204152124.GO2789116@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
In-Reply-To: <20210204152124.GO2789116@dell>
X-Cookie: Truth can wait
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2021 at 03:21:24PM +0000, Lee Jones wrote:

> The default point-of-view is; if a patch was submitted as part of a
> set, it's likely that it makes the most sense to merge it as a set.

Blocking the whole series is itself not ideal since it means the whole
large series keeps on getting resent for minor changes in individual
patches where it's only a small number of leaf patches that have issues,=20
with a lot of these serieses the reason they're bundled together is that
there's some constants being added in one of the early patches that gets
used everywhere else, not that there's a really a particularly strong
relationship.

> Very often sets will have inter-dependencies (usually headers) which
> would otherwise require the base patches to be applied (perhaps the
> MFD core and the headers) in one release, followed by the accompanying
> child device changes during a subsequent release.  This doesn't scale
> well and puts the contributor in an unfair position.

You had been sharing pull requests for the common bits in the past which
had resolved the dependency issues?

> This is how we usually work together.  Why is ASoC so different?

Like I say we've got active work that ends up doing subsystem wide
interface changes on a fairly frequent basis which then creates issues
if a new user pops up that's still trying to use the old API.  Often
it's fine but coordinating near the time is safer than just acking with
a potentially long lead time on things actually going through.

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAcJVkACgkQJNaLcl1U
h9C2wgf/bIo0O0+WD5J5xb7GrHcSGFUfdnb8rQTTzJHB8vrCoQTjOj7fqtDOf3J6
SNgaTs3ohgNjhAb3mmSLzBqGsDkNKabCX0oT1xnpQjwDNeS/pUUOkZYMDafGSxHS
Gixal3inUvH7TUpzd1SODfaAtqIa2Vd0ZfAubh+gDbHn2C2vbqqc/cdTse8Zjssv
ivAVJQ3CMuLQRB+gx/ND+l1UMfw1Y/ilwg/wKItyPjt9ZpwjwzxAAK3l1c3CFTy3
7ONkxp/E968pDvxe6DaFFfFji2SpG7YURisZMMjB8Fj0NFZ9hlGznGOh0Uy3Brxk
wbXXazfS+8UaRH33SJcdpnufLnnOMQ==
=J/Kw
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
