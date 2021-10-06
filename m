Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADEA4241CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbhJFPuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhJFPuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:50:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0876561058;
        Wed,  6 Oct 2021 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633535339;
        bh=47gQvTqBUwVekDVQzpGg9z1YxiQhRhuibQ0ZZS8DDms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GROolJw06y0WPU8RbKw/7NqgAV4KoLfBV8lLaFc2FmLRCleim5MTMGzrKWQZg1AEi
         SGri5CduGoeqDIboZo6Nj2+jYGQBQ0cu8GyZktrgzSPI9ShBDDzdXoKYOK7j5ZUGta
         mDo3x7hZjst4piPdrrZFrs0QYmnrKe8MkfQHHmbMCHj+MmT3qnAFZPGAvho2smR87S
         AZ1wtSI5j27Oj8y/xLh6a5VeD7D+pnqUwT76guGybO4bAmcO4hL9gbJBEsDZhoNegh
         7Z9SKrmP3oDzBjACsjGrIFvNECLgfVQgAUPYg6vODyxs9F25tSS3Mj0jIsrR0gnpMd
         mDJeRcfhSPXng==
Date:   Wed, 6 Oct 2021 16:48:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joe Perches <joe@perches.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 2/4] ASoC: Intel: bytcr_rt5640: Use temporary variable
 for struct device
Message-ID: <YV3FaZ+afuZZSIth@sirena.org.uk>
References: <20211006150442.16503-1-andriy.shevchenko@linux.intel.com>
 <20211006150442.16503-2-andriy.shevchenko@linux.intel.com>
 <4b81a10dca78e286a9f806464b97111b5a15a91e.camel@perches.com>
 <YV3ER4uIL4aRWBjz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kyawfiakXrTSOOdd"
Content-Disposition: inline
In-Reply-To: <YV3ER4uIL4aRWBjz@smile.fi.intel.com>
X-Cookie: A is for Apple.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kyawfiakXrTSOOdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 06, 2021 at 06:44:07PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 06, 2021 at 08:21:01AM -0700, Joe Perches wrote:

> > Some will complain about a lack of commit message.

> Yeah, sorry for that, it wasn't deliberate. I forgot to run `git msg-filter`
> on these three patches to add it.

> Mark, do you want me resend entire bunch(es) or just starting from these
> patches? Or...?

If you're adding a commit message with automation it's probably not
adding any value.

--kyawfiakXrTSOOdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFdxWgACgkQJNaLcl1U
h9Dj6Qf/d4hZFf/MYBhKCyGf2BxUJWrfHkBWX9kcLxCJmVG5Yz2jw9oBQKgq7pZM
pYF4EntfZ2RDTGY7/aV7ZmrG8Wk3gYHgaZSzjTYR2KcldtFHTo0VikUbSvArp5HB
gPpP2BpyO4k8+O8aNjeGAjKcQ1jBd+Buezd9jELU/IAdoeuJVMkfeI9Fkd/7IzzM
4gJw6b++c9IuaZ1m1Gz33cB6qkSqfiinWcd6sO6wOzJ9gcnYrZBHtKQwsvkf5iZe
vP7YN9Yl9yR9ngyPUGegbrk9OX9mUOWUkM0t1Z9SoWrZgq9VoUJ+QWYENo0gkt19
qqIuupXs2MN80/oJeD21JGRJlOIZNA==
=MIjN
-----END PGP SIGNATURE-----

--kyawfiakXrTSOOdd--
