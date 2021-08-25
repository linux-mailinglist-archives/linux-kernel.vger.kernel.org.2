Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5843F7845
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbhHYP2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240735AbhHYP2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:28:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1198C61027;
        Wed, 25 Aug 2021 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629905282;
        bh=UXG/9B0dxNUKG1o93UdkxmcN2LyXV1JOlgRgyr1YEus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3OZbx3a24jw9ulVpPwToBebd524Qs76xf3E4E+Tnnh1m+78nMKS3hn3dbgGPDRP1
         exO4HJgMdte3i5H1lPALpOY5AxzADwoe8mp98clb7SYwBrUn+N7UpC7KwFrPOocj6Z
         C8qCaszVBKICXTMHgI+TWTIMwbu59ogHndHspqH8+q4lp8XH36rZoTX8B6cKeT/63r
         FdQ6Lm+jRu47epsUCf7U8bBVH0/YRvUHQQUgIFDZ1Kx+Pm/TNqKAbdhz0Cw4LEN2P3
         +vDftAAvEnctrcfbAi5qyjrq0em0HL+SO1schocGvdFAqmoBQ+ynFH9XulrviQ+Ztd
         S4G6IPbX4541w==
Date:   Wed, 25 Aug 2021 16:27:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
Message-ID: <20210825152735.GJ5186@sirena.org.uk>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <cc65098e-b459-b20a-f6e2-ee521fc20ca7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Content-Disposition: inline
In-Reply-To: <cc65098e-b459-b20a-f6e2-ee521fc20ca7@redhat.com>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 25, 2021 at 04:48:15PM +0200, Hans de Goede wrote:

> Daniel, I believe that what Mark wants here is something similar to what
> we already do for the 5v boost converter regulator in the TI bq24190 charger
> chip used on some Cherry Trail devices.

Yeah, that or something like a generalized version of it which lets a
separate quirk file like they seem to have register the data to insert -
I'd be happy enough with the simple thing too given that it's not
visible to anything, or with DMI quirks in the regulator driver too for
that matter if it's just one or two platforms but there do seem to be
rather a lot of these platforms which need quirks.

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEmYWYACgkQJNaLcl1U
h9AN0Qf9GZXR6MRcgZLrLwXX9NdTHOuh35/SlGHOp95zERw3wce7RqgcszLL4olD
9lV3JpkwB78vwF819b9hxbGjIAqyoqK0kpTcwlctaVEpHylRPYhvHXkpekCVMFY6
A4uroOX1rYOrWvPwhcnUBKfUAa3o2SoW8wm40LIvfFoOB638MBGx4lvsB2PhqK0g
upRHkmceCgo/B/OBxvuzhiwcJdYxZ48UcBuyisiG6plQZY+JFtRPj/MTKcfiq+ip
OSVL+44MuUGws4rR6YPJXvAiHZJgmyfpnLyufbBQv7i7XievCgw8AaDyHikeNpjd
sS3FSvj/+l42fzIImV8TEAZwZeQODw==
=o1zp
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--
