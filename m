Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2613C288E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhGIRnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhGIRnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:43:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E22D61355;
        Fri,  9 Jul 2021 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625852434;
        bh=zwHOp0GCjkbxw1hl9BNQfO2iS/TSp7p4Eiv2rkxuNGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zf44t+xjjcuIMoHEyohZEx3JMQjQPryCyYTDY7O7KGQdBumd6sXJhg4a9qN/w/Sun
         wJuNnev+IW0DJVoOO6Ck69HjIDKHGcA/oE5xRDlaUVfBksv60obneQ8BmraUH6j8dv
         mcyMEhsRblWcFl9NrbSs3HsPTuLltxNmsfiB/a16JAKtbnTnGm7YNFnB2iNRkkOuth
         4apw2yZrpDDNwCcamOmBNaX+Gu2ih8xW3kh9Y+G47Jxr5IBj1u/PhvEPuyiSDwiKba
         oBDGoZv/4SHCIXWueEYYmEe2tKQh4FKZ1f2lmTvzDWOuSHu5dNgpuv5ZXXU6uzrJB/
         76ZuBJ94vX2jw==
Date:   Fri, 9 Jul 2021 18:40:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hdegoede@redhat.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, lgirdwood@gmail.com,
        andy.shevchenko@gmail.com, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 2/2] platform/surface: Add Surface Go 2 board file
Message-ID: <20210709174000.GF4112@sirena.org.uk>
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210708224226.457224-3-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <20210708224226.457224-3-djrscally@gmail.com>
X-Cookie: This fortune intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 08, 2021 at 11:42:26PM +0100, Daniel Scally wrote:

> The DSDT tables on the Surface Go 2 contain no power control methods for
> the world facing camera, so the regulator, gpio and clk frameworks have no
> way to discover the appropriate connections and settings.

Does anything actually need these connections or settings?

> +static const struct property_entry core_properties[] = {
> +	PROPERTY_ENTRY_STRING("regulator-name", "CORE"),
> +	PROPERTY_ENTRY_U32("regulator-min-microvolt", 1200000),
> +	PROPERTY_ENTRY_U32("regulator-max-microvolt", 1200000),
> +	{ }
> +};

Does anything actually care about the voltages here - why specify them?
As far as I can tell from grepping all the supplies you're adding are
digital.

> +static const struct software_node regulator_nodes[] = {
> +	{"ANA", &tps68470_node, ana_properties},
> +	{"VSIO", &tps68470_node, vsio_properties},
> +	{"CORE", &tps68470_node, core_properties},
> +};

> +static const struct property_entry sensor_properties[] = {
> +	PROPERTY_ENTRY_REF("avdd-supply", &regulator_nodes[0]),
> +	PROPERTY_ENTRY_REF("dovdd-supply", &regulator_nodes[1]),
> +	PROPERTY_ENTRY_REF("dvdd-supply", &regulator_nodes[2]),
> +	{ }

I would strongly caution against this idiom of referencing elements in
other arrays using magic numbers, it is both hard to read and error
prone when someone goes in making changes.  If they need to be in arrays
then constants for the array indexes would help a lot.

> +static struct software_node sensor_node = {
> +	.name		= "INT347A",
> +	.properties	= sensor_properties,
> +};
> +
> +static struct gpiod_lookup_table surface_go_2_gpios = {
> +	.dev_id = "i2c-INT347A:00",
> +	.table = {
> +		GPIO_LOOKUP("tps68470-gpio", 9, "reset", GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("tps68470-gpio", 7, "powerdown", GPIO_ACTIVE_LOW)
> +	}
> +};

This appears to be using regular board file stuff for GPIOs, if this
swnode stuff is somehow needed for regulators why is it not also needed
for GPIOs?  I think this is going back to the thing I was saying earlier
about not really understanding the problem being solved here.

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDoifAACgkQJNaLcl1U
h9DxYwf/fdd57J6wmmNX7uW0RW9BIcLglfExzVG4PfYZ95VErxvXfV/O1vKKiEP2
dj6FIAvCCv5PNRk7L7PvxRfna/XaiEjzq+cgDpPrB36vsYVIZHXR7fpksDPAf+Su
2VDZ+qYvLCGREeIO/OxrwlST60ndXHzlMD3WvOX5wdNekQVJlaSMLBNb+efrRHaZ
PwzMQ/7lOSzvspYwdmqYiIh+dghsw1d56QgNReFQBBAVBcp/AivLwEWzUCaclHsE
RVqqq+mS55BphYHhF9gwVhn6VZg6PX1r3rpXWXGSL83v3ABjdlKezRrqJb1weKSs
I/1aVE5FfFDo5LzQhXRyAE9FGqEahQ==
=9c7a
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
