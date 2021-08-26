Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE13F87C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbhHZMle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240767AbhHZMld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:41:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C1B9610A3;
        Thu, 26 Aug 2021 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629981646;
        bh=v+hSZmfYSqJ7n+9tWtedIrVU3oif2Q/4V8DUmYCErMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clGUbmIDDT7YriArGRVJDBvYA6ERBKtrFmf48wGvm3OSFwTQ863ey8IoWaad5gtrJ
         8HHoScPUbuKCEykeCPV/UyhEA9/5La5SHtC7bUqj+dkRSuna/iqh6lZLraenWdntLx
         0zI+Nj+2Btv5vxvSulVzflcBqyrbcM3VPw90FwsCgRfdzidiMfMtIfyVeSkoHum44F
         85AvLLmjo2fdteSppLXvA2LKIiWxQABRyxvNO6/SL57MCJHMpuuSVNmZFraipHGmAv
         uA+RmubPbEIQk7B/QRkAo2WenmYdIK05db5YeeeeOgEiaBPvHA4aq2JbJss5KoTd8f
         iAQaEfbtbNp4A==
Date:   Thu, 26 Aug 2021 13:40:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
Message-ID: <20210826124017.GC4148@sirena.org.uk>
References: <20210825103301.GC5186@sirena.org.uk>
 <CAHp75VdHpjbjz4biTP11TKT6J+7WQi-a1Ru3VLuSxM5tSLCB3Q@mail.gmail.com>
 <20210825113013.GD5186@sirena.org.uk>
 <CAHp75VfKJgux8k_mPauYB3MHcEOcnnzhSpoUDi4mVFDgtmNXeg@mail.gmail.com>
 <20210825131139.GG5186@sirena.org.uk>
 <YSZMxxJ76vF316Pi@pendragon.ideasonboard.com>
 <4ac0acb9-83ea-7fcd-cde3-669ba3b699c6@gmail.com>
 <YSZSOZXxSac307/A@pendragon.ideasonboard.com>
 <20210825145232.GI5186@sirena.org.uk>
 <bce63128-3dde-f4c6-b0cd-00818293ebc3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <bce63128-3dde-f4c6-b0cd-00818293ebc3@gmail.com>
X-Cookie: /earth: file system full.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 25, 2021 at 11:09:09PM +0100, Daniel Scally wrote:

> Alright; and what about parsing the platform data into a struct
> regulator_init_data then...at the moment that's left up to the
> individual regulator drivers. In my mind that's something better left to
> core, so rather than finding the right instance of struct
> regulator_init_data from the regulator_lookup_list the
> regulator_lookup_init_data() function would be finding the right
> instance of the struct from cfg->dev->platform_data instead...what are
> your thoughts on that?

That sounds like a useful helper to have - we need to let drivers have
custom platform data (especially for MFDs) but even there they could
use such a helper if they can point it at an array stored elsewhere.

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEni7EACgkQJNaLcl1U
h9BKfwf9FLJI4ZYrEANl+eLgmFTIqFp7IzuyvY9j5DNO7O/CJnO6MNKoVK123Twg
nD+LUu4cAH3SysojkoLUwrCpk6QrhLYuzTGsadrdCzxg/Mw+XP3ap1EnKWJGlFfI
wJ04PfxjO82h9Pk3JOZLjUF8Tz6n7+6zraAd+GcpvN49DC0n5XoapkvuwJlAsk5h
ddq2xA+rD+KNWrs1AUV3v0pUKyFYfuR7pHqgtWeCiYEHTquW6CRHONyl7/BhwkKo
KdeLuyre42k2XYFjQednKoy9zhcgFAwqjdR+Do/LbDhfvdvK8P3FIx3/dU6+JHPi
/gUlEYhDHZwO5wDMfnGdFnZ5+IgpPg==
=4/H/
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
