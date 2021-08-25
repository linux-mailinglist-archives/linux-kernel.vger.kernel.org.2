Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006CB3F79F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhHYQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235063AbhHYQOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:14:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A451861151;
        Wed, 25 Aug 2021 16:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629908008;
        bh=cuhbORo+vK72jskU92DnQpjj6jmqRv72esQDD/kdcWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTjYXHamOsBAE+Rt++XP570MzJjAVn2JfZIBYqKeenTjzmoVniSk7GFAdgJYBIvVo
         MdcdWTHIYVPeySUDPWzEXpPgMVVjsuMzOCvQWlKslGRNWzfNSX417lVNzatiEQRt9c
         MUsa9G3oPSuAPCyt0G8t9oBa/S/iQI/BLooK/Pu1d5owHrtauUe2/fg0lFO5g9w1Ql
         /HB2VlqlV9/PubmbzSD8TgeaSCOA9G/nf5ejLHj56a2uRoP1fG4QEguUxzwzUVvRau
         GOqfx6Qu7abk79YG0hfc7tT0j43uJzMzZNw9cv0kBj8cnT4JnfGy2A5xEc1msnRThk
         J42oiN+AHNzew==
Date:   Wed, 25 Aug 2021 17:13:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
Message-ID: <20210825161300.GL5186@sirena.org.uk>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <cc65098e-b459-b20a-f6e2-ee521fc20ca7@redhat.com>
 <20210825152735.GJ5186@sirena.org.uk>
 <YSZk5tyAxZoosXS3@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IuJpT0rwbUevm2bB"
Content-Disposition: inline
In-Reply-To: <YSZk5tyAxZoosXS3@pendragon.ideasonboard.com>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IuJpT0rwbUevm2bB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 25, 2021 at 06:42:30PM +0300, Laurent Pinchart wrote:
> On Wed, Aug 25, 2021 at 04:27:35PM +0100, Mark Brown wrote:

> > Yeah, that or something like a generalized version of it which lets a
> > separate quirk file like they seem to have register the data to insert -

> Let's also remember that we have to handle not just regulators, but also
> GPIOs and clocks. And I'm pretty sure there will be more. We could have
> a mechanism specific to the tps68470 driver to pass platform data from
> the board file to the driver, and replicate that mechanism in different
> drivers (for other regulators, clocks and GPIOs), but I really would
> like to avoid splitting the DMI-conditioned platform data in those
> drivers directly. I'd like to store all the init data for a given
> platform in a single "board" file.

Right, that's the more general bit I'm suggesting.

--IuJpT0rwbUevm2bB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEmbAsACgkQJNaLcl1U
h9BerQf/WuUAv3FHwUK4Y6sdfXg7P6fUoU41asYQRl/RONNF8MnduFGx70c5vqfs
RAj6nnbeIdHjMXpgOncLBqeNzWFjrxk1VuVrmEIeeb0B5LfZ3s2/Tc3aSQ8Cop0n
MPhBT9EhrWVQ/IM0O95xfa1u/zZIoZQovmLtSsQZ9D1QPA2gvoZhoAAO93ggRlps
HmjiiWv06oiMFpODG14vqSpWcfNFbRsAhWXQqAuSFXPn+rrQkTKyPXODetiGnoT/
gP/OdIseBdiSdIPgqSIdoDdwvK/+V+GTWkkVmaUelK+e1J2ixSQFNjWhIxKVPup4
3YxfV/vow0/gm6HE8PTI67D0SYyv5A==
=WWWK
-----END PGP SIGNATURE-----

--IuJpT0rwbUevm2bB--
