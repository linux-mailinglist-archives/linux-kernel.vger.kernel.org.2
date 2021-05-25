Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83815390B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 23:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhEYVju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 17:39:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49804 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhEYVjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 17:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Irs8dmLAQFDYVM6psOb2IEgVAF0RO4s4qx9pqPEGE0k=; b=rQKfUdbkKDL2pZ6RkTn/mRy5k2
        WWjQsBAq8Xe0f/HkuC1IHFFdAihGSM/McNrr1R9wW1AId2/onrci+HzfjeRHwnPS36QnYzOUbrVUs
        8CWeQLCTu3xq6ZJ3CFGAvjNnQRxjXAibglzIcj/r5Vt/CXURFDz1azo+SyBqVjbutRcc=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1llekd-005qMz-0U; Tue, 25 May 2021 21:38:11 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5A542D0DECA; Tue, 25 May 2021 22:38:45 +0100 (BST)
Date:   Tue, 25 May 2021 22:38:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 55/69] ASoC: rt5645: add error checking to rt5645_probe
 function
Message-ID: <YK1uZdtgffiCnUVQ@sirena.org.uk>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
 <20210503115736.2104747-56-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ub/BhbFoJ/f/pqD1"
Content-Disposition: inline
In-Reply-To: <20210503115736.2104747-56-gregkh@linuxfoundation.org>
X-Cookie: You are always busy.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ub/BhbFoJ/f/pqD1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 03, 2021 at 01:57:22PM +0200, Greg Kroah-Hartman wrote:
> From: Phillip Potter <phil@philpotter.co.uk>
>=20
> Check for return value from various snd_soc_dapm_* calls, as many of
> them can return errors and this should be handled. Also, reintroduce
> the allocation failure check for rt5645->eq_param as well. Make all

Phillip, please follow the standard patch submission process,
this is documented in submitting-paches.rst in the kernel tree.
In particular please make sure that you copy the relevant
maintainers and mailing lists for the subsystem and any driver
specific maintainers on any patches that you are submitting to
the kernel so that they can be reviewed.

> +exit:
> +	/*
> +	 * If there was an error above, everything will be cleaned up by the
> +	 * caller if we return an error here.  This will be done with a later
> +	 * call to rt5645_remove().
> +	 */
> +	return ret;

This comment is not accurate, rt5645_remove() just resets the
hardware - it's not going to clean up anything to do with any of
the branches to error you've got above.  The core *will* clean up
any routes and widgets that are added, but it doesn't do it by
calling remove() and people shouldn't add code in their remove
functions which does so.

Also I'm guessing this was done purely through inspection rather
than the code having been tested?  If there was a problem seen at
runtime this isn't fixing it, TBH I'm more than a little dubious
about applying this untested - it's really random if things check
these errors since they're basically static checks that we're not
smart enough to do at compile time and the core is pretty loud
when they hit.  I occasionally wonder about just removing the
return codes, I think more callers don't have the checks than do
(certainly in the case of _force_enable() where I was surprised
to find any callers that do), but never got round to it.

--ub/BhbFoJ/f/pqD1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCtbl4ACgkQJNaLcl1U
h9DQWwf/TT6ek/EkuiVj1ZSYmXqZLo3Fb+SkoAfG/H/BZjtZdcAJNjY5nIxfVOrQ
h5Od36YMlk1JKsLIppyOjVPndqJPhijEAxSAc4PGpijOr6Dk7kj2pNMdNxd7fOYt
PeoD8F9126zalNOwAGA9ar2eZgjf2aKID3xHq2Xu3QHne3/wNdzRFuFJdHk5Ss8q
5DAZ8jkprER+kUhKPhIUvmznADnuShcoqAUVCDqp2QZ52kRctQSlQbvoAjppYfs1
DIyra0vSP3LK7jWPjlnlhymI8X8KGiXUKBx4Dmy7BX5iWF4nRLq3KB776iup6S9Z
9P5ClPa59xTOq12WfmgRF9FlrQkcoA==
=9ZiU
-----END PGP SIGNATURE-----

--ub/BhbFoJ/f/pqD1--
