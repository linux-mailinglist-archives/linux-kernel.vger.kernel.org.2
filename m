Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB7E369757
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhDWQrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 12:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhDWQrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 12:47:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1783960FE6;
        Fri, 23 Apr 2021 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619196406;
        bh=hrqrADAEzMFpkpMJhB8rj4N/o1LglX/44krbouGR8yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+sdGTYK4aj9yDFncbICtCZWbqNeYXUw5nC+SdTJCCCyoZqQqXwfDB8l2K7bRr8UY
         N9rPkMalrUus9Y9lNssS0lW+IZVFqANoT+wr7iCqbGRjpQTsvhjSEfUUYH2T8Dk+q/
         Vc9DaR4qdj27qevhjdNdeuEUfyut+yz+SvHrfEp2ga+yla2IpizWu1S9lqpABvVYDw
         rtvS06aBSxaVeqOsQI9W4SvsqhycdtxdsdWs8Jr03n7PAs/kQ5pPfKlS4pmJasKZW/
         UVeXB9zBT81Rwoy/ANVYkarIIqSRRkjyrsORkgVSXFusR4QUf18npK86dcLJHMs+21
         UoG0KPu8vhFDA==
Date:   Fri, 23 Apr 2021 17:46:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, amistry@google.com,
        nartemiev@google.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dwc: add a quirk DW_I2S_QUIRK_STOP_ON_SHUTDOWN
 to dwc driver
Message-ID: <20210423164617.GG5507@sirena.org.uk>
References: <1619195089-29710-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PpAOPzA3dXsRhoo+"
Content-Disposition: inline
In-Reply-To: <1619195089-29710-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Cookie: This is now.  Later is later.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PpAOPzA3dXsRhoo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 23, 2021 at 09:54:38PM +0530, Vijendar Mukunda wrote:

> For CZ/StoneyRidge platforms, ACP DMA between ACP SRAM and
> I2S FIFO should be stopped before stopping I2S Controller DMA.

> When DMA is progressing and stop request received, while DMA transfer
> ongoing between ACP SRAM and I2S FIFO, Stopping I2S DMA prior to ACP DMA
> stop resulting DMA Channel stop failure.

This again...  copying in Peter for the sequencing discussion.  If we
need to do this I'm not convinced that bodging it in the driver is a
good idea, and especially not deferring it outside of the trigger
operation - for example on a suspend or pause we won't actually do a
shutdown() so the trigger will end up not happening which seems like it
may cause problems.  We'd probably be better off with the core knowing
what's going on and being able to reorder the callbacks although
designing an interface for that seems a bit annoying.

> This issue can't be fixed in ACP DMA driver due to design constraint.

What is the design constraint here - can't we fix the design?  Or is it
a hardware design constraint (presumably broken signalling between the
I2S and DMA blocks)?

--PpAOPzA3dXsRhoo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCC+dkACgkQJNaLcl1U
h9BDTgf/e98lodiz8JAhBWlgb4e/N5kUc+JkS6Q8iz5kFGIG96PawL0jUcldx5Wx
dml7h0vBjDgBrkgFQ09HQ3nzoyJdVHRa6zqdvCt3af4u2YcpkUb8u7ljoSJJLdDK
yXQ4ROt1rC0MKrsVKzHqitiIMo8oSEl2F0Vs4aHLUUof6I3w7qhSSD1VVkGuh36U
yJ8JTwaCeKtkXDbth333kbaW7a8biVgUFFprtMzrpoeVH9A9p4CCjH0i+uPwB6cl
BX4HoHkoCdzHaisZsNob8MjjykSvoBGVtuKsquEpT+R5PkPRMuGcOYDW1FMJ5FrQ
GKwU1bfjUALew8t7yMnnhDZA9SASKg==
=025N
-----END PGP SIGNATURE-----

--PpAOPzA3dXsRhoo+--
