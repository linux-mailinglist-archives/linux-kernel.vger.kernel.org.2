Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79455313BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 18:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbhBHR4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 12:56:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232043AbhBHPdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:33:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9205664E88;
        Mon,  8 Feb 2021 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612797947;
        bh=+WGRxfTf3SmVnOnMu2BEXZkFM4poWL99zz9p04NYNew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkFn+etQECgOBWC7AHCUONlfgYrTpB7REwo3Dx2gyTEr07MvWLVOyQAaUw1GhJttP
         HmHUw+dOhngtE2AZYgxtxvfrYsds8ed+AYuPkEdlRKR9xr/bCcCPjbJsfBju5wUDld
         tGwAwq5MHfLU5Xc+bxeZMg/pRCQjbjOzDhKNwMgW5/fjtzJsXrTUtPToVhCRM2NNIF
         IrQdFmGmpyABU57iCM/x35usc5QNuJj6+zjnUPY/HWyQ74nGYk0VLv5nZGBX2H3mdr
         ytCPq53Q3K9EwpfRdPNLfNZ7JEqO4v8kLomU2eUi0DUieIpYIUj2EvI3IdiNcDGrf8
         IePqUKcO6AjEA==
Date:   Mon, 8 Feb 2021 15:24:55 +0000
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
Message-ID: <20210208152455.GH8645@sirena.org.uk>
References: <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
 <20210204140515.GC4288@sirena.org.uk>
 <20210204150456.GN2789116@dell>
 <20210204151139.GE4288@sirena.org.uk>
 <20210204154058.GP2789116@dell>
 <20210204194213.GG4288@sirena.org.uk>
 <20210205083416.GR2789116@dell>
 <20210205211101.GL4720@sirena.org.uk>
 <20210208083350.GA4766@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Content-Disposition: inline
In-Reply-To: <20210208083350.GA4766@dell>
X-Cookie: You will triumph over your enemy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 08, 2021 at 08:33:50AM +0000, Lee Jones wrote:
> On Fri, 05 Feb 2021, Mark Brown wrote:

> > No, it's that there's plenty of drivers like this that are listed in
> > MAINTAINERS but still generally go through subsystem trees - this is
> > also true of for quite a few MFD drivers, you tend to get a bit annoyed
> > (quite reasonably) whenever I mistakenly pull MFD changes for them into
> > one of my trees without syncing with you.

> Driver Maintainers in MFD don't sent Acks.

Ah, that's not the case elsewhere (and there's the case where the driver
maintainer is sending patches for their own driver which causes a bit of
confusion).

> > I guess, or at least a pull request so it's in my tree and I'll notice
> > any coverage issues.

> Okay, I'll process it.

Thanks, pulled it in now.

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAhV8YACgkQJNaLcl1U
h9BUlgf/U+gi/WKLvvsMpVe1g3YNDDGoBm2fcVXM446X3TG4lLtzw1bbeLtOXagm
m+s6zM8Hcw3mD9gZzINHbnMyv/DVmJ/4a/oc1PFlX7y/nVNjxbNQzolruFwDoCaW
mVG72RJ5XWdOASUuvwRi1V7BesNLhGjHzvfR1Wp+l/eSl8+L6jbqf58i5kzeFOOA
TSYfowD80iu2dRTxcN5Rg8gpafuM5zbjqWo6oz6zC7BZ8X2C9OENi0imPJj/YjLS
5j3Lc1gfumC8wts7vBjuYMU0g6oVfflvJvAT6BGUVaFO3w73yehcyx0ZyTtULyEN
zaJEesqjbat/0sDdNFnjsp8Jx2w6Cw==
=EzRc
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
