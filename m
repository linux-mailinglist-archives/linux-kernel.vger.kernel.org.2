Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE43D3C63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhGWOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235506AbhGWOnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:43:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1073E60EFD;
        Fri, 23 Jul 2021 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627053851;
        bh=SZPewBRQJZCojWC9vM1jkHzk7FV+fphq0zntMxmhJzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaIkDedAtDCZljuTL7JA30QSgh2NdLwwF6ylOSfdGVrSOAR2l2ogTktTgnB6ZA5k5
         TL01S4GvsUQRNDV9qVxHSuFXtXvA6CStDbP/xA3cT7S4nd4XvBmiNQoA7MSodobUDE
         VClN8jjuAVEpciJ8n0BUNaPmpBkdnTaJnGZBo1xu/2x5zKvWA0jXi9UlxDzHuqOOKq
         4OHk92aIe4wPIBSJreuY/vz8YAlWONNJOlkbyYgNp2dcrC/vYQYxdu5lSuII/NmoOc
         CEwNNPJMhi/eBswekTbT40+cYmoWq/PQ+kPDg3oLjvq+v+5NuyLN8U8Mt+MZY4mmiC
         4x5UrwbtQ/iOQ==
Date:   Fri, 23 Jul 2021 16:24:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        rander.wang@linux.intel.com, shumingf@realtek.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: dapm: Revert "use component prefix when checking
 widget names"
Message-ID: <20210723152403.GH5221@sirena.org.uk>
References: <20210703125034.24655-1-rf@opensource.cirrus.com>
 <20210705165041.GC4574@sirena.org.uk>
 <a882a9e0-db05-2f89-abb9-8b308ccb56c8@opensource.cirrus.com>
 <1952b7f0-3c0a-faa4-8a1b-1a8bc4fff473@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qVHblb/y9DPlgkHs"
Content-Disposition: inline
In-Reply-To: <1952b7f0-3c0a-faa4-8a1b-1a8bc4fff473@opensource.cirrus.com>
X-Cookie: Integrity has no need for rules.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qVHblb/y9DPlgkHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 23, 2021 at 04:17:26PM +0100, Richard Fitzgerald wrote:
> On 22/07/2021 10:55, Richard Fitzgerald wrote:
> > On 05/07/2021 17:50, Mark Brown wrote:

> > I don't mind if someone wants to change the core dapm functions if that
> > is generally useful, providing that it also updates all callers of those
> > functions to still work.

> > Changing the behaviour of core code to fix the Realtek driver without
> > updating other callers of those functions is a problem.

> Just to point out this is breaking stuff right now. It's not just
> theoretical.

You took several weeks to respond to my review comment, I'm sure you can
cope with waiting a day or two for a response to your followup (which
I'm having trouble understanding TBH).  It would probably help if you
could specifically identify the problem you are seeing and where you're
seeing it - as I said in my review comment there appears to be a
misconception about how the APIs are expected to work.

--qVHblb/y9DPlgkHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD63xMACgkQJNaLcl1U
h9C3Hwf+Mcep2J6MgGpHOIe7hbta2Wm+ZNc4j3NpK2rdi8GcR2+9+OMw6u2MlAug
CWVjXEZQE3JwjWAE5HXye+zYA60oC8I4PhzAJFRN/CIGbyzc8yJwgJe0KN6w66is
Op+sAyI8efowRSx4GdkLTZLrTVuNCwVz8pj0IWmgSXoGVA5sCviAnN5m+kii/jFP
xfCbdOdMuxImE5HEC8g+XlCovLmkqs6cqN1df/Pt4OWra0RbOeCbXmSfS7U0ZL3I
EeTCgDKYXNrvTg3tkGnsdD11jlauSnjHlfOtubX8MjXHGwBwowEBw/rQb0D01Cqn
X2u4h/iExKTaE1K60DNx/HUpW/ijGA==
=rpD2
-----END PGP SIGNATURE-----

--qVHblb/y9DPlgkHs--
