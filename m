Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4151393400
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhE0Qdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:33:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46222 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbhE0Qdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dvDMkkVrI/aL8/9zlFpGlf5BX/Y4vnasiRl8zBV01Rg=; b=ibgQzFbvurX4a3pmdFnasmxTUB
        zxznUDmF8AKBM0kNwoN0CvmocxlLrW3Zx6vZPTBznHOOVYISSHT4P4B6tAaCxNBvaDda0qAWDHsEO
        YxUI8NNACLRW5ksdQh304QKpX8liLZUKiXK+35wcQg4AZPPr7Yt/G/fuOR2pIgiI0Dks=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lmIvQ-006S0w-BQ; Thu, 27 May 2021 16:32:01 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id AC688D0EA1A; Thu, 27 May 2021 17:31:57 +0100 (BST)
Date:   Thu, 27 May 2021 17:31:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 55/69] ASoC: rt5645: add error checking to rt5645_probe
 function
Message-ID: <YK/JfeMt9j9z+40Q@sirena.org.uk>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
 <20210503115736.2104747-56-gregkh@linuxfoundation.org>
 <YK1uZdtgffiCnUVQ@sirena.org.uk>
 <YK1z6AlOAMxYCh75@equinox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oYNRd8n5UUXjY5O4"
Content-Disposition: inline
In-Reply-To: <YK1z6AlOAMxYCh75@equinox>
X-Cookie: A penny saved has not been spent.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oYNRd8n5UUXjY5O4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 11:02:16PM +0100, Phillip Potter wrote:
> On Tue, May 25, 2021 at 10:38:45PM +0100, Mark Brown wrote:

> > Phillip, please follow the standard patch submission process,
> > this is documented in submitting-paches.rst in the kernel tree.
> > In particular please make sure that you copy the relevant

> This patch was submitted to a closed mentoring group as part of the
> University of Minnesota reversion/checking process. I was not
> responsible for the final send out to the public mailing lists etc. as
> the patches were collated first and sent out together en masse.

OK, this is really unfortunate.

> > This comment is not accurate, rt5645_remove() just resets the
> > hardware - it's not going to clean up anything to do with any of
> > the branches to error you've got above.  The core *will* clean up

> My comment was adjusted after submission for brevity's sake. This was
> what I originally wrote:
>  /*
>   * All of the above is cleaned up when we return an error here, as
>   * the caller will notice the error and invoke rt5645_remove and
>   * other cleanup routines, as it does for the snd_soc_dapm_* calls
>   * above as well.
>   */
> Happy to resubmit/rewrite as needed? Based on what you've written
> though it may be better to drop the patch?

That is a lot better yes, it accurately reflects what was going
on - the review definitely wasn't helping here.

> > Also I'm guessing this was done purely through inspection rather
> > than the code having been tested?  If there was a problem seen at
> > runtime this isn't fixing it, TBH I'm more than a little dubious

> Yes, that's correct - I did not test this directly other than making
> sure it builds, as I don't have this hardware to test with.=20

OK, in that case it's going to be safer to just drop the change,
it's probably not going to cause any actual problems but it's
certainly not something that should go in as a hurried fix.

--oYNRd8n5UUXjY5O4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCvyXwACgkQJNaLcl1U
h9CaPQf/dZpP6aPFUNxUHEFxOiW9U3mdS8RvjA8WvGKT1fNPNRa34nMlO0gA6+gQ
4NTI7zOJS97EnAE7c2Ctsta9AFWuU3o8dV0/6P5mcQKd273BAxWnVMv1Wmzz7MFr
e2gjLTcCcAdhqCqE/EFV6LduRGgsxjf2YnhZnNKFkcYkDcbagKRMgNb3N6Tp5OeS
Lsk1rV5JGX4N+AaO7X9m3+YaC8wBpliKuZXl7sLzVCXqM5Oy83aNLGv3+27Uz6rP
lSc2xHLXrCTR+LW53W/Fu6sikUsxfvPdY/nE25ESDSKVq79rA4xYx1Z1seqqF1r1
jPnDHGaSDgp4uFbvP9ol92hkqhCSTQ==
=6JuK
-----END PGP SIGNATURE-----

--oYNRd8n5UUXjY5O4--
