Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4464465E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhKEPlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233576AbhKEPlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:41:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89AC261262;
        Fri,  5 Nov 2021 15:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636126736;
        bh=n+X3HnJrn5I94lNBI4oN/v0sCIelBvNfe55+cq90v10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9Ucd2v6QRgwynLsGWWjsZ9DrN41cZWBcOU3fmyszspj5juzbIaCUnMbf1VmMIF6N
         OXBBbWMH3izsCDC59sQJOPq2RS8zSwSzK68HNT0IBbJbb/WvBHajwwZprNjtSw+IxC
         JAhLQ+Vd+JZKdQPaG2yuM3b88Mzm9RcoUcmXndlzWT7j0Wbcvuuqhs0gpa3rnfL+yC
         usnFsjkkMEWgP0/fsohMi+zg9pr12EzyHT5R2ZTg8G7Xj86kBwRLDN62oJ00nXm0Qj
         XRuz5Nz9l67rfJqK8ypCHB9i9HKcJpwenJLCPNjFtcszgAcvs2I158u20QJm1vJ+2Q
         CfNcVtRNRxzrg==
Date:   Fri, 5 Nov 2021 15:38:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, yc.hung@mediatek.com,
        daniel.baluta@nxp.com
Subject: Re: [PATCH 3/4] ASoC: mediatek: mt8195: separate the common code
 from machine driver
Message-ID: <YYVQC7KLZx8oxdXT@sirena.org.uk>
References: <20211103100040.11933-1-trevor.wu@mediatek.com>
 <20211103100040.11933-4-trevor.wu@mediatek.com>
 <YYP+l7tMofYoB+aC@sirena.org.uk>
 <b4360ea17c3045759e85ee13fa9c001afe73c93c.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t/JfaRmZozyWm9hx"
Content-Disposition: inline
In-Reply-To: <b4360ea17c3045759e85ee13fa9c001afe73c93c.camel@mediatek.com>
X-Cookie: For recreational use only.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t/JfaRmZozyWm9hx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 05, 2021 at 12:11:55PM +0800, Trevor Wu wrote:
> On Thu, 2021-11-04 at 15:39 +0000, Mark Brown wrote:

> > I don't follow why the DSP support requires a new driver?  Shouldn't
> > all
> > systems with the DSP present be using it?

> We need to keep the solution without DSP, so we can replace DSP
> solution with non-DSP when it's required. But when we introduce SOF for
> DSP control, there will be more routes in machine driver and device
> tree usage is different from the original. So it's hard to share the
> same driver for these two solutions.

We shouldn't be requiring people to load completely different drivers
based on software configuration, what if a system wants to bypass the
DSP in some but not all configurations?  Can we not just have controls
allowing users to route round the DSP where appropriate?

--t/JfaRmZozyWm9hx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGFUAoACgkQJNaLcl1U
h9AcIQf/UzpTAAC3VR+zMJZTNX3wEOw/Bi2D9vxmvTBGIwB7G/FlETQmVwaUxECA
azgmnw3jnHqEQO1aNTlkf5su9mzgHkUuQTiNy0AHeQwBcxSmOk5xad6W2mTurLbf
GexsEap8koTYYrIGYaD4DkBef34y5WcEnMmm2DS9lHcpAge/XD9agMmB5QrH3PWR
dcLcfVzHVNGSZbGd6Woxi7xb8Y9wciaFuMyyEcl5YNbXpJO36x/rrxOOA5Okv2rD
McStZ5dJaOvw1juc+ndps1GwyfUSTKFre0NjTSFAVGOelVzIfL9vmIYIqo/pm2/7
weWT+28cmDv+DuB48D7CT5v1QGs11w==
=sW00
-----END PGP SIGNATURE-----

--t/JfaRmZozyWm9hx--
