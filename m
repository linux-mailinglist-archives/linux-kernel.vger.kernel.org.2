Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73044349371
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhCYN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhCYN4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:56:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C5A861A21;
        Thu, 25 Mar 2021 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616680581;
        bh=YYZNRoPN/jmxzdTbDEQN0oeF8/NrSLnA/0A2tLeOUW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naRuhFDKxzimba8c3HCpZSwtzpmAe+2NZ8NbE1OZZE25TquPpWWDq/iSeLW+/EcUc
         CkjOvkOdgkUSkjn6bOr6k5U5k2NG2Zm/XFFR0TWjU6bAB+cYgHYhVEkH9cwWO2yxjS
         Kl03g6SueMbTPA6Td6Es7nB0Tn90BKvsj46iQsJO2H5AkITjnSisYOWavYe0u8BX+Z
         YtvLFxLFxL9G3/KPpY64WJB1FRHFZ4wjXqdvHyV6OSv22EldNf1zQn2spqJe1bVtyU
         wZd8lVy5AQWy0ylwn7tYwd02uWl9Q9Ro2Zx0Kw+TnzoURTFUXrAJ4PeC/NXXNgUlrb
         qbyFJ7ZAQvylg==
Date:   Thu, 25 Mar 2021 13:56:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Lee <ryans.lee@maximintegrated.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
        yung-chuan.liao@linux.intel.com, rander.wang@linux.intel.com,
        guennadi.liakhovetski@linux.intel.com, vkoul@kernel.org,
        yong.zhi@intel.com, judyhsiao@google.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ryan.lee.maxim@gmail.com
Subject: Re: [PATCH 1/3] ASoC:codec:max98373: Changed amp shutdown register
 as volatile
Message-ID: <20210325135613.GA7767@sirena.org.uk>
References: <20210325033555.29377-1-ryans.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20210325033555.29377-1-ryans.lee@maximintegrated.com>
X-Cookie: Where does it go when you flush?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 24, 2021 at 08:35:53PM -0700, Ryan Lee wrote:
> 0x20FF(amp global enable) register was defined as non-volatile,
> but it is not. Overheating, overcurrent can cause amp shutdown
> in hardware.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBcln0ACgkQJNaLcl1U
h9Bh/wf/RG83rstR6bo+AlX4NLRZ8HuB7MxCJnyIXLn/hpEb7bqWlZZ8ElY87dvr
XJaKM1r66iGNIrJvSH1ZV+1sgO8qsE/epXksXuLfaw5S4VDFQpRMksdNOfYgop75
oYGULg/nw5rMZkAezpe4iOVtEwGXMBT1m7J29BaBzKY05YHxTnb/7/KkHnnBq5LF
nXf7VdRnYL14QhT2KcnBZh2XLYVxoKykWe1JV4orM4XiXO5iaJOBELgJuatpI4a0
fi6HSiROoHcXS/1rVZpB9nDdC5CY4/FJUcTdNRJsI+oYwxpkzLVMkoPjTrZp3jdR
0Z1e+64uqE1ONQkJqywOVR8C5VB5cg==
=c2+i
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
