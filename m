Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490963FF01D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345807AbhIBPZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhIBPZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:25:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3187360F4B;
        Thu,  2 Sep 2021 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630596284;
        bh=5xHwpTyrJz/V1ecWOpG2oVcDhIQ65r7ovJhDHEp+hFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUqArlOmcFL226oWhkLx8xHTMVV1zWf5cDzsmYYuqROLrebShV/2ogjHbCLfVspMd
         pTzMmBb2rQMwx6StXCtSmKXbyixRiEl3izZ+FVeKV5p7cjGUDIgQIYD+lmFuXvuW8R
         p4XSGqm/ONRbDGtZ6gZZnwsg6Nqu+H8+ywij6bYUA00H+mThqKlHKoFysbB+AVZdVN
         2cb0/jKB3ZhvxffGmQOp6E1B4shOEfZUTJSLwhbi4ch7h+Ct/b/mB4Hwn0UvbFn6IH
         Vy0+yavTirOEweqG1Qkkb4aM/0r6W/O+u+X1nBMk1QE1WOXlc7NVcHwZLS22H39QNg
         edCe0fRUj0iXw==
Date:   Thu, 2 Sep 2021 16:24:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP
 select
Message-ID: <20210902152412.GF11164@sirena.org.uk>
References: <20210802190351.3201677-1-nathan@kernel.org>
 <20210802212409.3207648-1-nathan@kernel.org>
 <da246896-fbd3-be8d-355f-3c0a83e7d4eb@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
In-Reply-To: <da246896-fbd3-be8d-355f-3c0a83e7d4eb@linux.intel.com>
X-Cookie: Famous last words:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 02, 2021 at 10:02:18AM -0500, Pierre-Louis Bossart wrote:
> On 8/2/21 4:24 PM, Nathan Chancellor wrote:
> > When CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH is enabled without
> > CONFIG_EXPERT, there is a Kconfig warning about unmet dependencies:

> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>

> This patch was missed, maybe because I didn't provide a formal ack on my
> own suggestion, so here goes:

> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

It looks like this was sent in reply to an old thread so got deleted
along with the old thread.  In any case I don't have it any more...

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEw7JsACgkQJNaLcl1U
h9C2Kwf/VIq50TNTUN4NObepN1GojSmpDkg+Cd9qAYJ9R9hHuZ0m5S8MJQsnv0ws
Jct981brHL3nh6HjM2oG6/t7oLaRvuc5TQCrH5rQKQcIooXJJ8f86WmjZreJp3SR
ZLdchWIHuF1a5dwx+gKWXTpxVBAC7vaiBxGGQJwLjoOlhFBvkkCMi67SgWvnddk6
ouM+jUhfmNU+L1yL2KsgCUpa1yzRuMqoCEklFgtTGvLqtkwU/q+SckMR09X3PlvM
twzFq/8xEvsVnzzA9uhxlcXSdez1mP8HgmJwdhCpRkwsjr8Hgof0NAmRgt4uxfSi
D5NBEI/o+aB/HoyctOXVmPRSHBd4Cw==
=vJrj
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
