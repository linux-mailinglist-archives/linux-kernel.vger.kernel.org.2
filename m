Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C75236F92F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 13:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhD3LYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 07:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhD3LYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 07:24:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ECE261458;
        Fri, 30 Apr 2021 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619781831;
        bh=X+CDJhE8KfboV+3/jr0bHess9R7lNxucFQ1ERm6TnLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XG6EX9X7TZi4D5vnQLpE7gW4B0aJD7CxwgzqwLdHGo+ahuEHLDNddejZb6UQhx5YF
         VdxLJewb6a9DvT2h8n3ctq6pBTR2wghrUDZ9kbsIAyX1rqHI0m6pyk1umsb5/NtBhx
         3d3LmQNfio1O1OCVamZI57hpa0kX3C8b6TZ0waHurlbnaC8/pzR77x35CwPVVor1Vh
         b2cBeX/Z6Ejocrgnohm1lyz0HJyFzTzDA/BQ4E6VZbhYGR9nhbIjTFToFJyRjbkMtC
         spXCXIwue2Fq0naix4mawTqgzEvrI3TPPxWz+04bmlvtepuYdkMFGhPpB80ky3y0G+
         IwfjLB/PvI1fQ==
Date:   Fri, 30 Apr 2021 12:23:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     trix@redhat.com
Cc:     srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: lpass-wsa-macro: make sure array index is
 set
Message-ID: <20210430112319.GB5981@sirena.org.uk>
References: <20210429173642.3230615-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <20210429173642.3230615-1-trix@redhat.com>
X-Cookie: QOTD:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 29, 2021 at 10:36:42AM -0700, trix@redhat.com wrote:

> The happens because 'ec_tx' is never initialized and there is
> no default in the switch statement that sets ec_tx.  Because there
> are only two cases for the switch, convert it to an if-else.

Add a default case that errors, that way if someone adds a new option
things are less painful.

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCL6KcACgkQJNaLcl1U
h9CHXQf/cWdl/E0EgzkmkslN9kdNSVSNk0J8PaNu6KP5kS0/hGhz2SxN0xkAxKQB
9gC0od5C5pSH3EnOu6YVt69YsNaZg0M3bZQYPA0UU4ePNI7zeCu1kgzudggcymvQ
QFaG6zyxP856E+Mak2llLI1WbuB/AGv54CPOwUHCy2WSsJMYs5WyoTruNEwVpmsl
S4O//D9Vz6+EqPhPCEaRJlCeZunhUAcCSuDgEv1Kob85SAsfz/G9r2GLylIME2pH
kYy9iQ2sYkEyVnGss+vb2nxW47s2x6d0BuATY7cS8/oI7xDa0GFKDqV4rhTuFRLc
6nEN0mBEPz139jjDvDLmJVaWUN04TA==
=9LpP
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
