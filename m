Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D4D3C2844
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhGIRaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGIRaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:30:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5CA9613BD;
        Fri,  9 Jul 2021 17:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625851641;
        bh=hunFLVyp1kxN8ZqWSRfrDVs7gY3ARFHi3Rol7iZHrco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wf1XfEtMdv9XkXqtMNKUuDOw4edZpH7GIsgFaNVhsmvtyHeSQuOJHBQRI39IM8SMC
         yPt4nCUaHxngzGfc0B6B2T73Aqjyiuenivhlq11yXQuQ9rkHErqxJxTOiBAJIhBPMd
         mkz8LA3Ui4BFpmW+qSspe79/SPtBo5FKGnO7w9d9BF9f8VDaklotsL4zVM3s2d/cLx
         G7EL694eFvYJb/c8FrqHsk5wG451XNCh9aMMZbkV8Y7OQFCzJvW/Ywmq7Jws7/gfI+
         Um4ZpFNFXl2AC94i9/zsElLG9eAPRLUvRgq1iL66p7JBuPnaPQE4sZDUxBiiPH5F57
         b6WY8b5AYItSw==
Date:   Fri, 9 Jul 2021 18:26:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hdegoede@redhat.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, lgirdwood@gmail.com,
        andy.shevchenko@gmail.com, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 1/2] regulator: Add support for software node
 connections
Message-ID: <20210709172647.GE4112@sirena.org.uk>
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210708224226.457224-2-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <20210708224226.457224-2-djrscally@gmail.com>
X-Cookie: This fortune intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 08, 2021 at 11:42:25PM +0100, Daniel Scally wrote:

> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_OF) += of_regulator.o
>  obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
>  obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
>  obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
> +obj-$(CONFIG_REGULATOR_SWNODE) += swnode_regulator.o

This appears to be sorted with regulator drivers but as far as I
understand it this is not a driver?  I'd put it next to the OF file.

> @@ -1785,6 +1788,22 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,

The line numbers here look off...

> +++ b/drivers/regulator/swnode_regulator.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Author: Dan Scally <djrscally@gmail.com> */
> +

Please make the entire comment a C++ one so things look more
intentional.

> +static struct fwnode_handle *
> +regulator_swnode_get_init_node(struct fwnode_handle *fwnode,
> +			       const struct regulator_desc *desc)
> +{
> +	const struct software_node *parent, *child;
> +
> +	parent = to_software_node(fwnode->secondary);
> +
> +	if (desc->regulators_node)
> +		child = software_node_find_by_name(parent,
> +						   desc->regulators_node);
> +	else
> +		child = software_node_find_by_name(parent, desc->name);
> +
> +	return software_node_fwnode(child);
> +}

Nothing is documenting what the binding for these swnodes is supposed to
be so it's hard to tell if any of this is correct and makes sense, nor
how someone is supposed to take this stuff and integrate it into a
system.  I think this needs some more explicit documentation of what's
going on adding to the tree, this will help with review and help anyone
who needs to use this stuff figure out how to do so.

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDohtYACgkQJNaLcl1U
h9CaHQf9Edt3jgRyz64Jm4Y5r8Skn4xhgKSAiteLjulAe+KgRAPsBgrRwAd3sqbf
5PWZ7hkFBUC7w3XEyuZgDrf38n7cS8G2bREIriH+yjxsvTQY3HhgmUEDokKooVei
LP1xvCIefyjnraWftsrUvXu61WgqgkuSEJZukhR8e71XbmSIpLNfZ5o2mMZkgfpJ
+F66ARC2BoWZCsEfG4xbeJz21X8odvNIcDmgxegLuYeaTVx4gusike8N8tE1rp/T
WQ064w0XnZVrcYs+u8eCHzXJOBbiLV7aDO8hs9xnsMHYWUIDFRyWYFZzUY8eJzUG
g5fKXBObe504GP1a6iS+RndCQzULyQ==
=agHe
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
