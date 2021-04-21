Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456E53669AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 13:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhDULGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 07:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235131AbhDULGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 07:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD1566144D;
        Wed, 21 Apr 2021 11:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619003167;
        bh=ibymGhoC6SIgzayCKlW3avb2cLYOlJYug+lPz4rPiIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fbeRSnW6FX6RJVQNfQKsjsOMwyuShGFCbO7OVX/nber6M7zM1IqyQDAijSuwzME8Z
         2AJKir8gl0oltCnl2wxeaLRkl1SP9DPJgUdSG8s4/4QGolJYKDZZ0/JwVIzao07nTs
         gVG/6ulYen67+mOb74yODWu8nm8aCl6+/bxrHu3BWPO66ZikXTN54iXk647oVvFlJn
         QyMTGhoUWlyWFEGE88G+LZBc8fTCtj+jzHGYfNCB/4mbdUdO/6CYvATFwPFpsOAfHB
         Qch1zm1VS35xNf3AbmO09EATwJLXcs0dkE433pxLeFwEjSIn2nM5yscUTQkEWA2fiQ
         0HSl+5BfkjU7g==
Date:   Wed, 21 Apr 2021 12:05:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: Enabling pmbus power control
Message-ID: <20210421110540.GA4617@sirena.org.uk>
References: <20210420033648.GA227111@roeck-us.net>
 <YH5rky8nA4nKAVdg@hatter.bewilderbeest.net>
 <9639fa33-01ca-9802-e745-5e3edb81e305@roeck-us.net>
 <YH59WOg0iKbz1d0l@hatter.bewilderbeest.net>
 <fe111c8a-9588-dbfb-624a-29bb3a5efe13@roeck-us.net>
 <YH7w6HUtBSCZRWq4@hatter.bewilderbeest.net>
 <20210420161317.GE6073@sirena.org.uk>
 <YH8D+LWxWPqnFd2h@hatter.bewilderbeest.net>
 <20210420171540.GG6073@sirena.org.uk>
 <YH8jUuOEJKDDDoMb@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <YH8jUuOEJKDDDoMb@hatter.bewilderbeest.net>
X-Cookie: RELATIVES!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 20, 2021 at 01:54:10PM -0500, Zev Weiss wrote:

> Consider the power shelf I mentioned earlier -- it's a rackmount power
> supply and that's about it.  It provides DC power to arbitrary devices that
> it has no other connection to, just ground and +12V.  Those devices might be
> servers, or cooling fans, or vacuum cleaners or floodlights -- the power
> shelf doesn't know, or care.  It's a lot like a switchable network PDU in

If your chassis is particularly simple then it will be particularly
simple to fit into a generic framework so that should make your life a
lot easier here.  Generally the simpler your system is the easier it
will be to use in something generic, it's not going to be stretching
ideas about how things should look and is more likely to have good
helpers available already.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCABwMACgkQJNaLcl1U
h9ADpwf/VbjMaN7n+jZDxshUvMWZB1BdyohTc3svzJBpwgEZ64SKrE1c+kHOAoO/
7tZNItEYVN+0hugBvbWoC7zBG+X+NPue5Spl8H+vnNFUYxVigAa2bEpNSWInZnXc
TXdumtwjtmOMAGYBCh5Q+l+1KpzZbNADLEWQcei7+DXl0XqhvHzsJTslt07/hyIw
vEBXZTEMP7U5DWYszH7NIMyBN+qbBDVDXHVmeg+JHq8YHh2oF4GwLrx3wC2EQakF
KEQnQ2p/1xrKkzfcSkU0fCvgvf+pN9EvxS94rBkA2xDuer4vlx0ReA9Pll63GPAK
EJ5KQnnPxUbSziNlhuIY83TVxIPyIw==
=xLFC
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
