Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D805455CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 14:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhKRNiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 08:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhKRNiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:38:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 506ED61548;
        Thu, 18 Nov 2021 13:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637242507;
        bh=BGoyxc/tZD31AxPnY8XqHiqawb2bCXDgubQl3ZHzSdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6CID7OY3hEZaGyOA0FF5D1ZC6IGTPwGhrSXjt8h4A60HtZRGAJu2Yq3HuPeSaA3K
         O0TaWzgfIGz+7xR2TDCzt79QTopQRTLwjf8BdLYZ/DVDeHMm1ODLVdie51k7E0HRaV
         ReRAQiv8J9FhJsuO3jiQQlwg8MOOosncwJulXlpysRUKVUfAqLNJNkLgpu8saRpYbZ
         xPYdG6rtk1e65HLWFORF/TD5guv5r0GcagGhysNIwuABs8itgC7GucwaC+r+uDGOAB
         29oDGXA/kbfqqdE1Y3KKmarxdUopUnDNgOPp2zU3ZNmti61Icq3jEICEK1JxTZJU5J
         wga0mrjL04+jw==
Date:   Thu, 18 Nov 2021 13:35:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] regulator: irq_helpers: Allow omitting map_event for
 simple IRQs
Message-ID: <YZZWh1aIg7TAdOUX@sirena.org.uk>
References: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
 <2a5d9589c1c76ce537f795ee0aa6d3a7a6093283.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wLz+JDLbZ87D+8ZL"
Content-Disposition: inline
In-Reply-To: <2a5d9589c1c76ce537f795ee0aa6d3a7a6093283.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: People respond to people who respond.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wLz+JDLbZ87D+8ZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 18, 2021 at 01:48:26PM +0200, Matti Vaittinen wrote:

> +static bool single_bit_set(int val, int bits_to_check)
> +{
> +	int bit;
> +	const unsigned long bits = val;
> +
> +	bit = find_first_bit(&bits, bits_to_check);
> +	if (bit == bits_to_check)
> +		return false;
> +
> +	bit = find_next_bit(&bits, bits_to_check, bit + 1);
> +
> +	return (bit == bits_to_check);
> +}

The namespacing here feels like it should be with the other _bit()
helpers rather than private to the regulator code, I can certainly see
other things wanting to use it.

> +	if (!h->desc.map_event) {
> +		if (rdev_amount != 1 ||
> +		    !single_bit_set(common_errs, sizeof(common_errs) * 8) ||
> +		    per_rdev_errs)
> +			return ERR_PTR(-EINVAL);
> +
> +		h->desc.map_event = map_event_simple;
> +	}

This isn't the usual pattern, normally we would have the driver assign
the helper operation.  We can always still do the check based on finding
the expected map_event set up.

--wLz+JDLbZ87D+8ZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGWVoYACgkQJNaLcl1U
h9DhKQf/fT7waIN1qWfGm3XCrDp+8aEKyhKhPnbBOrGHxvoHVrp7j/rxw9jLvt3M
0sLvIhQ8hO2i8V/AqOR1j9zKydpvF5gJT44sMGFL9VsDTfB2xy1uVJdkl4h9IKrA
HBbPBFi77adYFyu+g/sIDyxcICH82CH733sFuN823g6fX/76kS+bUCg/yazckAfu
FQ+2gr4WQtVz/zAkKuJ/D2zRxurC25B53q2Ey2YUvgv73V9g8e83ZFrHERf/jheS
WPuaESVxbs1b+rESnNGpXJZga9Q+hYPnc13fNpVQ3ezzzGZCQ2O///HTDiuUQvz9
4R/y3WmqwEIQvE//xjZNJBkuQwt4/g==
=dM83
-----END PGP SIGNATURE-----

--wLz+JDLbZ87D+8ZL--
