Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C03F0532
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhHRNtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238217AbhHRNtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:49:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5669B6109F;
        Wed, 18 Aug 2021 13:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629294517;
        bh=0JN4PN4tbkcM834D1zmXbpBdVxfX6OE1teF1op5KPZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RzB8jq+KqDoZy4T1vdam1qn0CBnITBxKoejFRpEPJaJc+3VNSl3vOvdEFWzCdWr+5
         VHy9Els32tdBjtFktRZv6Kf39PbdOzN2ysJaLyL+nYBjjCdAv4nByek+c7Je1J+MQz
         R9SXcJa/uv9SXFUGdBTwcfO1b/9/sifB7ruw0pzXOvdph6vsXNz+SH53MqTthbAday
         V8iSY//Dvc4tsfnF/lgVsqvOCvQoCaalxma0z3GsrzWIGp+FBFDT84W0PkDXK5PgT8
         AwpqfdQ2Ae9BkAi3ajSGwm3/8ZRvrN86rHjOnXpt3YNqrYrWyBwHvE/NhBRI7cphVB
         oEWh3d75Feqsw==
Date:   Wed, 18 Aug 2021 14:48:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
Message-ID: <20210818134814.GF4177@sirena.org.uk>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com>
 <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <YR0Ji7DQXoo0z4vP@kroah.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 18, 2021 at 03:22:19PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 18, 2021 at 12:57:36PM +0100, Mark Brown wrote:

> > The issue is that the driver core is using drivers completing probe as a
> > proxy for resources becoming available.  That works most of the time
> > because most probes are fully synchronous but it breaks down if a
> > resource provider registers resources outside of probe, we might still
> > be fine if system boot is still happening and something else probes but
> > only through luck.

> The driver core is not using that as a proxy, that is up to the driver
> itself or not.  All probe means is "yes, this driver binds to this
> device, thank you!" for that specific bus/class type.  That's all, if
> the driver needs to go off and do real work before it can properly
> control the device, wonderful, have it go and do that async.

Right, which is what is happening here - but the deferred probe
machinery in the core is reading more into the probe succeeding than it
should.

> So if you know you should be binding to the device, great, kick off some
> other work and return success from probe.  There's no reason you have to
> delay or defer for no good reason, right?

The driver that's deferring isn't the one that takes a long time to
probe - the driver that's deferring depends on the driver that takes a
long time to probe, it defers because the resource it needs isn't
available when it tries to probe as the slow device is still doing it's
thing asynchronously.  The problem is that the driver core isn't going
back and attempting to probe the deferred device again once the driver
that took a long time has provided resources.

> But yes, if you do get new resources, the probe should be called again,
> that's what the deferred logic is for (or is that the link logic, I
> can't recall)  This shouldn't be a new thing, no needing to call the
> driver core directly like this at all, it should "just happen", right?

How specifically does new resources becoming available directly cause
a new probe deferral run at the moment?  I can't see anything that
resource provider APIs are doing to say that a new resource has become
available, this patch is trying to provide something they can do.

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEdD50ACgkQJNaLcl1U
h9DvcQf7ByAlmoXWhkLU3DIqWbUI/qYSjhgG6r9B0oaU0bZjJvbxEDCAt7n66jdJ
XtuJ7GQ6iG2EnYiYkFwu8tiVLH8jbiIjSiWmKalz3e7FHawVg7fwTdGxw13Fh9Z0
YpJjFbLf1OKO2OmYjtcDOAx0LXDvAIYDg+fd6dYf3tqH8gheT3hfMpvqJ0DANOAG
LwLiexLkX8ZIpZo2Utksj5XAnSBaoSmDTbVwWJPz7EKOKj9UA93n1wB+voxJxMmZ
Z4wlTQgpcJ/a28ZxhfS5auZ5bouxlnER2dfdEGUCFTl3MqgfYrh1068SKpFZexUV
9JFTsoDZ8OoP8vjCwqA4AmJmi198fw==
=NcUi
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
