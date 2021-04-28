Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC236DE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbhD1Rlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242378AbhD1Rlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:41:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C513761446;
        Wed, 28 Apr 2021 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619631641;
        bh=Il5tb9B4/yJVnn+I749OEcDsob5dIs8bK4SoPVj4oLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2IX/RK89FpMhNMgmvKfk7GdGnPSsv1gmKMsmPe+tZgibli+eVm54a4Mkx2w4AtaJ
         SD9c6yFU0h/SRhPJYy87aQPyXr0QMapxuJgzngK+Xe2Czu6GccWyQpQ9TCOh/R8Szu
         RjIsvwk3D9EeAwnRgdHjmebckV1QKCcrMXalEuq8SYkrvv5uw1dHL5m7dpZedh5dnL
         xycuAafw9i5VW/N+K7s5GueJfhqZhxHVgqlG+vurBgfRiufOuR3414SdrOQMvlEOwv
         Rde+kZpM1ThzZPbr8rqmR3u4Z9KZMkcFPviltHogeUgwafwfc6l4s9hXkyeoone/iZ
         dW8sSfXqiUpHA==
Date:   Wed, 28 Apr 2021 18:40:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Bill Wendling <morbo@google.com>, Kees Cook <keescook@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Daniel Kiss <Daniel.Kiss@arm.com>
Subject: Re: [PATCH] arm64/vdso: Discard .note.gnu.property sections in vDSO
Message-ID: <20210428174010.GA4593@sirena.org.uk>
References: <20210423205159.830854-1-morbo@google.com>
 <20210428172847.GC4022@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20210428172847.GC4022@arm.com>
X-Cookie: System checkpoint complete.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 28, 2021 at 06:28:47PM +0100, Catalin Marinas wrote:
> On Fri, Apr 23, 2021 at 01:51:59PM -0700, Bill Wendling wrote:

> > Since the note.gnu.property section in the vDSO is not checked by the
> > dynamic linker, discard the .note.gnu.property sections in the vDSO.

> Can we not instead fix the linker script to preserve the
> .note.gnu.property, correctly aligned? It doesn't take much space and
> while we don't use it now, it has the BTI information about the binary.

> Cc'ing a few others who were involved in the BTI support.

Not just BTI, we also flag PAC usage in there too and could add other
extensions going forwards.  While the note isn't actively used by
anything right now due to the kernel mapping the vDSO prior to userspace
starting it is part of the ABI and something could end up wanting to use
it and getting confused if it's not there.  It would be much better to
fix the alignment issue.

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCJnfkACgkQJNaLcl1U
h9AMeQf+JjCPE1mknCrwwNnvPnXcUenU0DeOnChJJgTGhQGIe4ovug+jvSsiDRvp
GKEOeeNYh3E2iABmqi46Ysc2bcVnzsivqsjXnlMGQP857+jnMgwh3lktKmQueL8P
XgEHWN4fT2k6+tPbREAUVkYqBHWz3VhKXNt44qEw0Byn3WchMMBfuX7HkN6H6CzR
60nUXcfnyX4u51TMrefOlakdvAOV21g2Qy37DuLjSGS9A2M/ojsEKQzDbWqG88t7
ZU/FGiybkObxq0DPXJtzVXU5JxYVeRprwdHuyx6jHLGd5v9M/x6TAzMRx6i6KrhS
kpuM+XkFWP1W7DlH2ECcQ9UY6E/qTg==
=1KEY
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
