Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E43D66E7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhGZSHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 14:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhGZSHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 14:07:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FCB460F5D;
        Mon, 26 Jul 2021 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627325295;
        bh=nS4s2XZmkBJQiEwuzXSDm0iidZKN3C8FuLA1QgfkRHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfU6Wk4PH8dV8tqGarhjjoK9+Q5rpvjadtNHSey5AR592CZZKMY23C7oxekeQ12yS
         vWAaA6DhmR7Tgir1lUyz5E8jBhQtqD0mecFbQXzKEQ8nl9jBRbhqmFGrsBgjVOt9rL
         CgJ04fzAFmmg0SpV3wEUTB+A7sw2Q/5mjNHPoKbVeM9YRoNl3q19fw8KdLHy6JR4fc
         kRN86/dkdL2gV+qhqxoarq5zE638LV04p9mQMMu+hs3YSStriwovf4sr4ZkVUUusv3
         95GI4FI6sNjXSn9x4fuaq9xASlFE2zs2PJ3Gjc44T5Xmmz1w1Oxk08dxmfFt1vorIz
         lCAM2gi5SOewQ==
Date:   Mon, 26 Jul 2021 19:48:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: do not call regmap_debugfs_init() from
 regmap_attach_dev()
Message-ID: <20210726184805.GK4670@sirena.org.uk>
References: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
 <20210726114751.GE4670@sirena.org.uk>
 <7b54590fddf167744fa2574d8815130608f8e063.camel@ew.tq-group.com>
 <20210726121140.GH4670@sirena.org.uk>
 <45bb83c5ba33d479e1634e3a9efafcca5691fd9e.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Content-Disposition: inline
In-Reply-To: <45bb83c5ba33d479e1634e3a9efafcca5691fd9e.camel@ew.tq-group.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 26, 2021 at 02:18:42PM +0200, Matthias Schiffer wrote:
> On Mon, 2021-07-26 at 13:11 +0100, Mark Brown wrote:

> > That's not what your patch says it's fixing, your patch says it's
> > fixing an attempt to recreate the same directory as we had originally
> > (we should probably clean up the one with no device but that's not what
> > your commit does).  I think what you need to look at here is that we
> > store map->debugfs_name and don't overwrite it when the device is
> > supplied.

> That would be fine if regmap_debugfs_init() didn't do a lot more than
> just create the debugfs directory. I'm more concerned about the mutex

The whole point here is to move the debugfs directory so if any fix
stops that happening it's not really viable.  If we knew that devices
were definitely going to have a device bound we could just defer till
the device is bound but it's not clear to me that that will always
happen.

> and list head initialization that is happening on an already
> initialized structure. I haven't looked in detail what the mutex and
> list head are used for, but I assume bad things=E2=84=A2 are going to hap=
pen
> when someone is already holding the mutex or using the list.

They're used to cache information on where registers are located in the
debugfs files so seeks work much faster on large register maps, they
won't be doing anything if userspace isn't up yet which should really be
the case for anything that's initializing early enough that it needed to
have a regmap prior to the driver model being up.  You're right that
there is a potential issue there though, but that can be handled
separately.

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD/A2QACgkQJNaLcl1U
h9BGngf8DVTuWskooXwF1utc2D5e1a+5TKMcIJVKafCizPG3KJSW/VHUrAEIOQfz
BOKxc7Zg2Y9yWOm8Mu0ysx1BO59QbAK5oC00KRI+BNHD7rdyg1i8kMFFtIRSl6Cb
M8/Lbv3L3Odl7ajQU57Eko72qFiEm6od6rxKTkl38g7Kq4HnSaw/GiyPXIlMXuv5
XVp+qniN/sd7FCQuo0zDfHZB8g9DV8CIrYDK3AFtxSn9nlOHCQTZIejVf5CsQSNN
eUTrUZGCkmNPJaT5CKxauss5xcZDFQ5L6YxaiOPnHz83cSmn2fx1zj7M1CrCPMyy
H+7kdVbSTEWhyNJ7lhw2nEDNkDceSg==
=LS3/
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--
