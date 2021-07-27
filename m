Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D0F3D7BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhG0RJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbhG0RJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4391D60F90;
        Tue, 27 Jul 2021 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627405746;
        bh=8DWOP8N5f4fA/FNCyC1hfr3NFCCBNTTFtO7SeqnaWBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdLP/hvzbV4xfO6bNunyLrgyGq0a7yT7uzNLaIYEyYok9I+IXC4EQwvtHhDdTinxm
         gFhusaG5VSEcc10MaP0TAcUVvIq1qs9tKPM0D/6gD1ZvcfQg9T5OurtH6DXrNe6WfA
         p2VivfyFeumLrE5xhMInIkUhRmZfchJ11dMOJo03v6hFTZCFtuRt1eUk1XxyNRtNP8
         0yWEcaaoX6aUL0NetCEMqC6PUx3i2YdquII8acok2Xvb6x4J05KQZPqxL3hCFE6QBY
         K3g5TxhTUhgD5fjMz1tm901I4OxZIT+70TugUFAF03HDl4CfFT1IEJ46M2Zbfq2+S0
         w7cK2MxDRW2Cg==
Date:   Tue, 27 Jul 2021 18:08:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-kernel@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH] regmap: do not call regmap_debugfs_init() from
 regmap_attach_dev()
Message-ID: <20210727170856.GA4670@sirena.org.uk>
References: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
 <20210726114751.GE4670@sirena.org.uk>
 <7b54590fddf167744fa2574d8815130608f8e063.camel@ew.tq-group.com>
 <20210726121140.GH4670@sirena.org.uk>
 <45bb83c5ba33d479e1634e3a9efafcca5691fd9e.camel@ew.tq-group.com>
 <20210726184805.GK4670@sirena.org.uk>
 <b42ce068884cf6bcf471425a30bc4e17711037b3.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HSVPcR81XVhxeM7P"
Content-Disposition: inline
In-Reply-To: <b42ce068884cf6bcf471425a30bc4e17711037b3.camel@ew.tq-group.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HSVPcR81XVhxeM7P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 27, 2021 at 02:24:17PM +0200, Matthias Schiffer wrote:
> On Mon, 2021-07-26 at 19:48 +0100, Mark Brown wrote:

> > The whole point here is to move the debugfs directory so if any fix
> > stops that happening it's not really viable.

> Looking at the history, I assume this already broke with cffa4b2122f5
> ("regmap: debugfs: Fix a memory leak when calling regmap_attach_dev").
> This is why the kernel is trying to recreate the "dummy" debugfs
> directory on my system when regmap_attach_dev() is called by imx-
> pinctrl.

Right, before that we'd just overwrite the existing name.

> I'm not convinced that the behaviour before that commit was strictly
> better - when regmap_debugfs_init() was called for the second time, the
> new debugfs paths would be created, but the old ones were never
> removed, they just leaked.

There's definitely a memory leak, although unless you're instantiating a
lot of these devices it's going to be hard to notice.

> The thing on which I need clarification is whether it is okay to bind a
> device to these shared regmaps at all:

> There is nothing preventing two different drivers from calling
> regmap_attach_dev() on the same regmap (AFAICT, this is actually
> happening when both imx_rproc and reset-imx7 are enabled, as both use
> the same syscon "SRC").

It's OK for one device to do it, but it should probably be the core
syscon code not some random driver that happens to talk to the syscon.
All the current users look at least somewhat suspicious unless they
somehow coordinate with each other in ways that I can't determine.

> What I'm trying to find out here is if there are any legitimate users
> of regmap_attach_dev(). If there aren't any, we can remove the API and
> don't need to fix it.

There's a definite use case for it.  What's probably more interesting
is if we have any users that create regmaps without a device, currently
I can't seem to find any though it's possible my greps weren't good
enough to spot them. =20

--HSVPcR81XVhxeM7P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEAPacACgkQJNaLcl1U
h9C5Igf/djPA7O2OP47Ka7YfPlz8YdnBpUYIWB8MZ1HWbbA1VmJaScnQ3OsSMdQT
MAUcfUgtt2EQsBk8UOpimBMyxpv3OSSsnKj8+Mb7YneEQydYYalHA4JBWnerYRVL
cKIpDt3S9BBIk2PrFaQeRsydcdw5+jgz4aN+eZYY3NXtSvxp/9F7/eAsJDcKik6I
4uSH3kR/jWMRjrbwSzqmRkhPLTYjfat2gQbti9efeu7J0Q87mHQ/tyUIgkuS66O6
AtMcMVpUDbpD+1IPCfOPcHpjyYvxFe5trqxw9lUxjlEipCY6kLQx9+/8iahWWtr6
nK6shoLTzTbX14H+tOY0gQEp8eRqzw==
=fKF5
-----END PGP SIGNATURE-----

--HSVPcR81XVhxeM7P--
