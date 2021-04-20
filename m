Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C153C365E53
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhDTRQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233245AbhDTRQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:16:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3EEF613B2;
        Tue, 20 Apr 2021 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618938967;
        bh=H+j6/O+vzwBdqDqne8S74Rsssnj/Bb/OXT6d4SHJfxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSEe+Z3Tqfsd5sKd7I8a4Y0cw2sNwm+1DuV05zXPlZqQwIayT0RYAL8G388R4CRUO
         6oBuEts/VwUcNy8nxgEWOCCGm+pwZdm/x1xF/B4r9t9JUGCZdmnSoL/0ibyNlOeuz9
         qo+ZzzUr8MPc+rBFP4A7itVhb0T2FLGZCKto+mYyqHIABamanvkjr+UoS1h0ik6NWQ
         ESZHhsehKyDIbTzrBKvRyvF8Fx9BNAHiffHvtb4fallSj1u+bHUCwD3o+skPpNijfa
         GZBjk8Ge75n3jLcYd6rIzO2jtGnbo5+nt4BnSZi9EgvG+6NQ5nidHgXZboGQU3vfDs
         uuf/k8BRVtZlg==
Date:   Tue, 20 Apr 2021 18:15:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: Enabling pmbus power control
Message-ID: <20210420171540.GG6073@sirena.org.uk>
References: <20210330193810.GA235990@roeck-us.net>
 <YH4ukR5egB2eG0Vo@hatter.bewilderbeest.net>
 <20210420033648.GA227111@roeck-us.net>
 <YH5rky8nA4nKAVdg@hatter.bewilderbeest.net>
 <9639fa33-01ca-9802-e745-5e3edb81e305@roeck-us.net>
 <YH59WOg0iKbz1d0l@hatter.bewilderbeest.net>
 <fe111c8a-9588-dbfb-624a-29bb3a5efe13@roeck-us.net>
 <YH7w6HUtBSCZRWq4@hatter.bewilderbeest.net>
 <20210420161317.GE6073@sirena.org.uk>
 <YH8D+LWxWPqnFd2h@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OFj+1YLvsEfSXdCH"
Content-Disposition: inline
In-Reply-To: <YH8D+LWxWPqnFd2h@hatter.bewilderbeest.net>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 20, 2021 at 11:40:24AM -0500, Zev Weiss wrote:
> On Tue, Apr 20, 2021 at 11:13:18AM CDT, Mark Brown wrote:

> > I already suggested writing a driver or drivers that represent the
> > hardware you have, that advice remains.  It's hard to follow what you
> > were trying to say with your long mail earlier today but it seems like

> That email was an attempt to explain why writing a driver for the specific
> hardware devices we're powering seems like a poor fit to me.  To summarize:

>  - There's a wide variety of different devices potentially behind an
> LM25066.

This is true for lots of hardware, we still integrate things into
frameworks.

>  - A hypothetical driver for any one of them would be completely
> non-specific to that device and functionally identical to a driver    for
> any other, because the only hardware it would actually be    touching is the
> LM25066, and in ways that are again completely    non-specific to anything
> but the LM25066 itself.

I don't see why that would be the case at all.  Even within the indended
application as a power controller for a hotpluggable bus there's plenty
of potential for integration into a wider representation of the socket
things get inserted into - for example I've worked with buses that had
support for operator signalling of hotplug (buttons to press to initiate
hot removal, with lights to signal when a clean shutdown of the card had
been completed), you might also want to have additional environment
monitoring and of course the labelling that I mentioned in an earlier
post.  I can imagine you probably have some other connection of some
kind to the host too (eg, network ports) to join up and perhaps sync
hotplug for.

> I'm not at all opposed to using a abstractions or frameworks (I'd very much
> like to do so in fact).  The problem is that I've thus far been unable to
> determine exactly what the appropriate one is.

Perhaps you need to write some kind of generic system for hotplugging
modules if you can't find one.

--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB/DDwACgkQJNaLcl1U
h9DSeAf/ZEL/+2Z4UbqEH68jcytAmNORaqjie1w4JK/FywH4S1K3/sdrOyEY3Xyi
geHnrQsV1pTKl0BErVGLGOz6goAC17RkUaE+8eiy88vOFXmLgTdXH2hyacfB6Jop
SMeaj8TOb/ZvTkKzAkq6WuPlfg2NnYQkA4UlKKHRT8azfIXX3DE3oTmOTksumqRp
AwzSppNS/Ke1EVhr68wsEw1Xw9eO3KXsbP80aCb7x3OnMiDeAodW14fEy3vG2p3G
4h7rdJjKpwZGiBq3bM7M6l4t8FkhLlFpitgFVR6Jja7Tutt5lpgQE34PY3cp7S6N
bvvJ1Kp4xkafHcenyTro6j2/VW37mQ==
=+YvT
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--
