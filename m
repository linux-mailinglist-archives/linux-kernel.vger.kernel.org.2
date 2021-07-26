Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD83D5938
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhGZLbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233546AbhGZLbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:31:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB258600D1;
        Mon, 26 Jul 2021 12:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627301509;
        bh=/QofLHUu0Emm2H+ZcKFx3EDNEVMlwCtoBJQm1TtySOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WmkskUkICpmrjbz2hFjNzve3EeJqYZVnQiMxgLHd89172pwA61x7ukFRQMsqFxOnA
         vd7GxeGIW6+B5LiTxsWDpBe9juJx2PwzmPP33jYtPKeoHpRMoqIadydAJb/7YhmFsM
         8rny1LKHMdy2D46fu6RaqCanLO/xIOYQLkGKz90Dq6jU1J86lkIDDjkgAqmYz9cOai
         GyaJdBf3PhSf5+Q11sjoh++YTxUMSo9F0T4NgCoUdtHW0wJS0H0FxIcb1Hb+iEPMQP
         5zKB9mUw8L1qrViWb+yDBPvLK5w2NIKs7cP2Gw2AJVKABCShEe8lHreb3RcuQ+IBoy
         7ufQO2RGYl5qg==
Date:   Mon, 26 Jul 2021 13:11:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: do not call regmap_debugfs_init() from
 regmap_attach_dev()
Message-ID: <20210726121140.GH4670@sirena.org.uk>
References: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
 <20210726114751.GE4670@sirena.org.uk>
 <7b54590fddf167744fa2574d8815130608f8e063.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline
In-Reply-To: <7b54590fddf167744fa2574d8815130608f8e063.camel@ew.tq-group.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 26, 2021 at 02:01:51PM +0200, Matthias Schiffer wrote:
> On Mon, 2021-07-26 at 12:47 +0100, Mark Brown wrote:

> > The use case for regmap_attach_dev() is that there was no device when
> > the regmap was initially instantiated due to it running very early, we
> > want to attach the device when we figure out what it is which includes
> > setting up the debugfs stuff.  Whatever is managing to call this with
> > the same device as has already been set is clearly not that use case.

> I'm not talking about a case where regmap_attach_dev() is called when
> there is already a device attached; as far as I can tell such a thing
> does not happen in current kernel code.

So in that case how are we managing to create a debugfs file with the
same name given (which was the problem you were reporting) that the
device name is embedded in the name of the debugfs file?

> Please have a look at the commit in the Fixes: tag. The duplicate
> regmap_debugfs_init() happens even when no device was passed in
> __regmap_init(), so the regmap_attach_dev() is the first time a device
> it attached.

That's not what your patch says it's fixing, your patch says it's
fixing an attempt to recreate the same directory as we had originally
(we should probably clean up the one with no device but that's not what
your commit does).  I think what you need to look at here is that we
store map->debugfs_name and don't overwrite it when the device is
supplied.

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD+pnsACgkQJNaLcl1U
h9AuLAf/bz56u91f+8X4FVTHSRY/jPtHrZ1O0onHtCXFxjRdNMQQMepd5egYhm9/
jrwLMN8YL1B6jbpkXqfsQyi6Dv5VslqnphcimDtglAY64xYYsz4Lj0KzaLoT0qXO
KPbcloeSnG9X2t/Wpl2tuqIahkpuCEwUzyGQg6h3P7KWyAOQOzFpw1t48Onnwawy
Q2MPvyeEmnUjW4AG+bGiARI9+Qvm8Mzwio2b2imWJ2y0RmqRWVquvZHca2xXzl7w
tutOOucn7g2lP10ZQH58HMGD+yh+F3OH/yldHmIRI3uEnXYmELpgfI+jR/gL1+tP
76v1WZd7BUVvOqY+VfZlSl1+EUxijA==
=US12
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--
