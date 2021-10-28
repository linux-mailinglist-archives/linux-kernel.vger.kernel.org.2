Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DDC43E0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJ1MbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ1MbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A28E610CA;
        Thu, 28 Oct 2021 12:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635424122;
        bh=0IyHeV0L08KxqGj2Yi4V76DmhaAi20BHj3eWpXmjuSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPtm2gf6ueNW4PwQim7p7pYHbw1vohTXjCquTE2CXOEdA7saNvRjaRHPiYer91bzW
         GKazsdh1TA8kb9OhaSQbzFZXIp0RLzdrR2D1oeibRXMWmU4LfHQZ4B/7m1/nRa7/7N
         fs4NjX2fMDRIj/oxke/iNXJfm9Jv4XEV6jeVt4YRaG3wThFWzisY2gRbwmEUO/NdxU
         YLbhLRQR0I1Fipgx/4GQd2nRcdRAixMkWgGukGIZft1pdCzsG2QXLGtqZoPO+hIEQQ
         wCZQuX3gYFqG+P7spK25lmGMHP04ZeiE/mToZxo6/+y+iBmJXB88oacFZM4po+W79n
         jzWTQlaNv1qlw==
Date:   Thu, 28 Oct 2021 13:28:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Vijendar.Mukunda@amd.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, fazilyildiran@gmail.com
Subject: Re: [PATCH RESEND] ASoC: fix unmet dependencies on GPIOLIB for
 SND_SOC_DMIC
Message-ID: <YXqXdV0YC5BhEARB@sirena.org.uk>
References: <20211027184835.112916-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DdE/G2GeDUUSa88j"
Content-Disposition: inline
In-Reply-To: <20211027184835.112916-1-julianbraha@gmail.com>
X-Cookie: try again
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DdE/G2GeDUUSa88j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 27, 2021 at 02:48:35PM -0400, Julian Braha wrote:
> When SND_SOC_AMD_RENOIR_MACH or SND_SOC_AMD_RV_RT5682_MACH
> are selected, and GPIOLIB is not selected, Kbuild gives
> the following warnings, respectively:

I can't seem to find any indication that this has been sent before...

--DdE/G2GeDUUSa88j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF6l3QACgkQJNaLcl1U
h9DjMgf+NZ1xB5WHfg/qE5AWTWl3sQk/3x1QHEWf9GvEbnabN53Q4mI2Gl8BruND
Bo2jUu7e6Gk8QCBqRbPG4QBtq3E6Kp8iU5COhvwfII/YtUI48hF673+VWe5zUN/V
bGzv/5PCMHq9z4ExbSV/fRYjgWpGBundZfnkj8+NzgrzRh4LOLJz4tksc4I3oNzk
HucsQHqL/nJ4D4UG+b+mR/jHWf0BOarTY+/yY/VLUGRNV+ndAkTecPXEUucDxn5A
Zc04LducScKdd4oOBzXhF5jhdhdJNGiIMXu+byUbxbTBwwjwz7W3vYFflbPufIWF
lxLueOIx0+F4BIGUeUCVguCPfpF6Sg==
=zRlM
-----END PGP SIGNATURE-----

--DdE/G2GeDUUSa88j--
