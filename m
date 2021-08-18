Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8347E3F0318
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhHRL6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231476AbhHRL6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:58:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A4FD60F35;
        Wed, 18 Aug 2021 11:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629287879;
        bh=zDdIEBXge4nz0nnU4dADmgnRlRa8EXpkrmPjAb2TLGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=is+3SKOxJmzcnOtFScFhV4MIyK5peo6X99sk7V3/q/hLKtn8cUmsLsMrJWv7SxYKg
         r6EDlZJ4nS4G1LhKOUFE+pgOX9q1ufy1RmDiTAC9if3j9rcRCd4LnYlbfIbcPd/VXe
         eLui6X9ld6D7TCrAwPti41uXTSzpnlltAO8ZVEVbxeJGs/++FR95FgMV6BUjHBewP7
         1p53QfnanSr2jdQrlEYF/qZ8vYqyD+w+Q47L9NNtOz+FI4ehvEuieDdex1dm0EgQiC
         7ATJ8obp9FxX/R2dMLDE+7l9kkt/MijPqxQB4WB99dbAHg2OB4Z7v7+DDXarnB/sMy
         HW2JxkJOwXecg==
Date:   Wed, 18 Aug 2021 12:57:36 +0100
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
Message-ID: <20210818115736.GA4177@sirena.org.uk>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <YRyeR6imvSwOOasQ@kroah.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 18, 2021 at 07:44:39AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 17, 2021 at 02:00:56PM -0500, Pierre-Louis Bossart wrote:

> > In these cases, there is no way to notify the deferred probe
> > infrastructure of the enablement of resources after the driver
> > binding.

> Then just wait for it to happen naturally?

Through what mechanism will it happen naturally?  Deferred probe
currently only does things if things are being registered or if probes
complete.

> > The driver_deferred_probe_trigger() function is currently used
> > 'anytime a driver is successfully bound to a device', this patch
> > suggest exporing by exporting it so that drivers can kick-off
> > re-probing of deferred devices at the end of a deferred processing.

> I really do not want to export this as it will get really messy very
> quickly with different drivers/busses attempting to call this.

I'm not sure I see the mess here - it's just queueing some work, one of
the things that the workqueue stuff does well is handle things getting
scheduled while they're already queued.  Honestly having understood
their problem I think we need to be adding these calls into all the
resource provider APIs.

> Either handle it in your driver (why do you have to defer probe at all,
> just succeed and move on to register the needed stuff after you are
> initialized) or rely on the driver core here.

That's exactly what they're doing currently and the driver core isn't
delivering.

Driver A is slow to start up and providing a resource to driver B, this
gets handled in driver A by succeeding immediately and then registering
the resource once the startup has completed.  Unfortunately while that
was happening not only has driver B registered and deferred but the rest
of the probes/defers in the system have completed so the deferred probe
mechanism is idle.  Nothing currently tells the deferred probe mechanism
that a new resource is now available so it never retries the probe of
driver B.  The only way I can see to fix this without modifying the
driver core is to make driver A block during probe but that would at
best slow down boot.

The issue is that the driver core is using drivers completing probe as a
proxy for resources becoming available.  That works most of the time
because most probes are fully synchronous but it breaks down if a
resource provider registers resources outside of probe, we might still
be fine if system boot is still happening and something else probes but
only through luck.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEc9a8ACgkQJNaLcl1U
h9BeUgf/bxaKOZOoIjNrTdjgfaEekt/IY0d7bcnHylKh/CMn3PK4hhYyUa2i3cIr
SMe2P9NrdsU/EpaqvHGE1QL6v09OsT5n0TzHJ75cHzcC6qkjasu7ble9AubIQKcy
Fw1VYQa7GzzvR7WPZtyEKN/XHCluIc9/LBQ5Wuze5cwONg2EQRMsY9f0rMOD3h+9
2VFtykn+/BK/42dDs9Oese4TRAifzF2P8/jN3oFIk1/oSBldu6+eod38HDIK5HNc
IY1MKq26TIdUjtnK1aa8X0dMPE4+p6scHbqilxi2ILutzuRpW5D4OPouptCghSkq
YJgZEEba8o28TT8sJCorZorZf34EwQ==
=FeUe
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
