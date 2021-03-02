Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9834332AC1A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 22:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449493AbhCBVI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:08:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1580684AbhCBSMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:12:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6620C64EED;
        Tue,  2 Mar 2021 17:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614705394;
        bh=SNTgpDB+ecERim5nF4TTFA/XHzpSIpiD84MoUyGNFSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nv+7DP1Iog97Ie5lxh67SmX0GTBZVQc7Lw4Sq8pZu4qANsPr/DxZXcif+i5uHQcSL
         t+/sPfxjHz99TmzBxR5rmVy/1GBN76dZYdwRlwoHPmQUAPxcc5CEeTVZjA6oBuyO9X
         MIOSQ7IcrBVj638fOQgF3u6/L8PCSJjNzExajVNoDGGt4bZKvf4j532foSI/dgSxEz
         WzRra/oxJdNv0hmsNPDNz8086Bcx08IMGsGmMTMwmbv3PsTrJAoC57rRysG5uZqW6I
         8uI1gr0u5KMFm3bXYoBk+2vWDxdrK6G9I9f9uUZ0A2r16D+2LX3Qznz7Wg3HbMwF/4
         x4GGVaW5HLIKg==
Date:   Tue, 2 Mar 2021 17:15:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] ASoC: cs42l42: Fix Bitclock polarity inversion
Message-ID: <20210302171527.GP4522@sirena.org.uk>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
 <20210302170454.39679-6-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Content-Disposition: inline
In-Reply-To: <20210302170454.39679-6-tanureal@opensource.cirrus.com>
X-Cookie: Friction is a drag.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 02, 2021 at 05:04:44PM +0000, Lucas Tanure wrote:
> The driver was setting bit clock polarity opposite to intended polarity.

This is a bug fix which should be a separate patch and at the start of
the series so it should be sent separately before any non-fix stuff.

> Also simplify the code by grouping ADC and DAC clock configurations into
> a single field.

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA+cq8ACgkQJNaLcl1U
h9DxWAf9H+zQC6ubW9zf3dXH3HHb8UC3Uru8hrNUoc6T6dAhCEZnBzU0A2vfA+VS
YTpvvBWnFQ737bkHNjVw/1I7+f1AM0+RFOtcyGYHXw2XwgEOVxYrekw2dcfhpFdR
Zx5WiiGkMxzCNv6E2Jd0pGXDcL3cZ13N/E/Di6AcKWgpPL/r31rNGpK9Qg7kpsLP
1zZSIab8vf9d5gRZDuWCxDamlAZBU9X4HowguMzAOOY1hNuOJw5RNewsk4TViKQT
Q4xPc+F6KuwpGIHVQzWlfJ5GLLHXGq/Y4gx8e2fYQSJhC9Ou3e/ptkMzuk83YCDD
lBNDcSj6IrGy1gmUEWg0zRd4OmZH4Q==
=8Yc8
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--
