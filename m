Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4730E45D98D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbhKYLwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238867AbhKYLu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:50:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63A2D60FBF;
        Thu, 25 Nov 2021 11:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637840837;
        bh=3No3aHhaKBIBbI6sfTp5IL0mJhrT1nQJUx5S4ytzxhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9FeHPomai+swTgZZk5vF1XaFl9raK+axoQM2ZQr14qBBqBFicD93VkFgVGzpHWQD
         NAAHTNW7AEdE+scl4FkXZeW685kZez0M/6iHkahTEDzwEgGrTKHWwhCTCtIJb2GNEl
         o9s60MTGzVwvIqRzwAV92Obejm20uqxa6hOztfLsUlLNkDNSMgi+0kTaH3d3oaPDVv
         +jck6L670WadupE9i7yx4868ewYEGGeO+Qgzbqmyg60LSdGXz5/ELM0pWTUDcBJkNf
         p4OEOKL85ToLgAifseHWYbSnrBZ0j777hwct35j31qj6nZGOSpv/THWLtOpq1Zw9K4
         R8Q3hZYC3UaPA==
Date:   Thu, 25 Nov 2021 11:47:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     Rob Herring <robh@kernel.org>, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, kishon@ti.com
Subject: Re: [PATCH] ASoC: dt-bindings: davinci-mcasp: convert McASP bindings
 to yaml schema
Message-ID: <YZ93wOWfHdLUC6bG@sirena.org.uk>
References: <20211122091525.2290-1-j-choudhary@ti.com>
 <1637685269.740254.3442929.nullmailer@robh.at.kernel.org>
 <d72bac88-8f56-35cd-a953-270a1ed4d34b@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dh/qz3bmpLmon4Sl"
Content-Disposition: inline
In-Reply-To: <d72bac88-8f56-35cd-a953-270a1ed4d34b@ti.com>
X-Cookie: This bag is recyclable.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dh/qz3bmpLmon4Sl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 25, 2021 at 03:37:36PM +0530, Jayesh Choudhary wrote:
>=20
>=20
> On 23/11/21 10:04 pm, Rob Herring wrote:
> > On Mon, 22 Nov 2021 14:45:25 +0530, Jayesh Choudhary wrote:
> > > Convert the bindings for McASP controllers for TI SOCs
> > > from txt to YAML schema.
> > >=20
> > > Adds additional properties 'clocks', 'clock-names', 'power-domains'

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--Dh/qz3bmpLmon4Sl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGfd78ACgkQJNaLcl1U
h9CAdQf/Zccr8jpu9GYJ1s1e6SIPLaOTHQ7T/GvnYZZWTgn++xolnkLc/bEPn1Q2
afzCXD85nhCGUqT1mqoF+FMq1LKR/SBzBebIPpHPh5D2Qj1IeNcyhBf+e5sEaLa1
H/8tN5igeAPxp/QOtoWhJMrcSLVk7M3kXbza1tfUvZOWud2/gE4IczPzphdhIv7M
Upu/x6p9wibHL5Qi12J5uRZyVgyaE+3KB7vWMlhHlTW+BTxYx+a9+xJMF49Dja75
RK9avILPAvpkKfOGXYuB/43AJNVuZswPM5Xf5W28DHk4NkbiwT7NysGI59v7I3pr
b+VSayQk/BMdqGFX2S317GBUtwBGlA==
=1ZPR
-----END PGP SIGNATURE-----

--Dh/qz3bmpLmon4Sl--
