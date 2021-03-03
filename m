Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AB832BE29
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385129AbhCCRIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:08:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhCCMte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:49:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32F5064ECF;
        Wed,  3 Mar 2021 12:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614775439;
        bh=cXZDI8w+v+WsjZlp81DKHcLF6pulRicjjsRUnzCRmzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwuZhP+NbazvgI8HRHDMXUaI0QWNlG0IGLBE+NJ92vnfhjJwb59ZaH1je7cggKEJG
         oSD02pMdQ/YSh/NLM0kSbUmxsNsSVRlzzLfnX9HOkYWSzr1OcdKw71vvx7SJDdB/f4
         fLao4mZ8b95oc2KHaJ3WqTQhIh9El+6YhoBcrJI4q/X5U2OJQ35dOiqKzyvqZNd/Ye
         zbt9Dx4HfDxCErCI4UgXn9idNkeEvNTYLiiavfTzAEUvP8FPqwFNeDuIa/T9F0pKNI
         LjggfGb/YuMhcwpPvrUPrxxl29eoP8v5W+DQJeS0ADGMIVkR2TW6WUOGfepQPq23cX
         81oIInBV37oLA==
Date:   Wed, 3 Mar 2021 12:42:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SoC: codecs: fix platform_no_drv_owner.cocci warnings
Message-ID: <20210303124252.GA5027@sirena.org.uk>
References: <1614762481-102466-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <1614762481-102466-1-git-send-email-yang.lee@linux.alibaba.com>
X-Cookie: Results are not typical.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2021 at 05:08:01PM +0800, Yang Li wrote:
> ./sound/soc/codecs/lpass-rx-macro.c:3588:3-8: No need to set .owner here.=
=20
> The core will do it.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA/hEsACgkQJNaLcl1U
h9A03gf/XgwMVVLCnTTglb+pJaMtLyI+eaitGf+Ngq2SU3HGg8VqLUvSRK3THzT5
H+ZF1X/v8oz2HmFttwpX4GsqSnpwgnIcxMc65KQGC6dZg9gzVioIQxx9Asj16tRM
QSoL9iDIMMpzlTQJJrsuPOttCazstPdZxtVU7qAm6sRd82taTzuzjAaLsc9EdjWV
Oi3MZMKCuUwkNUbGc7aiBo9A5VzWeGhNGmXTgW+qBxKYk4qy0P+oe65gYc61KE9A
KktG3oTdu8yPILzPDtHyTO/RXyveemKWHTEY9ZAnjGROjeCDfRNjrHxMBB9xOF7f
sZB5TuTmbQFusi74x3bCjdWZhguARA==
=2PxD
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
