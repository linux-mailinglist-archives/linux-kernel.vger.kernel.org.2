Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441FF32AAF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580012AbhCBUBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:01:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343585AbhCBRce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:32:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4922464F39;
        Tue,  2 Mar 2021 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614706283;
        bh=hoZukWnMn5P2+DYts201SNfUf0kubqe2JwQjXk7SHNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUir//FcGSs39Nv3Rp4LUGdCTv89+9h8FfKp8fC4+Ljn0VUwQaN60XIlOPhVBcIF4
         s5bAiXdplkfzg1er9edBe7nx3IVnv2HhbgIbZX4qVD6Ja1BCQKo/X+oBwPhbA3XFkJ
         xv/u2A2rZLB2oN9SJ+Ln85XRnCY+iDpBiZrDwnVokFLElZB8PSI0AB763E7XtJnyp6
         z7UOOAln4KwWjPRYLkcoK6mu0/BdwqcK7nKAT5gb6GwpsQEwOYRpAPPRPFdU6vgRiB
         Jxr4QPMs2QRhAXnGTFDBOZ1lQmRrLQ1+GTjjAk7TK6skaWrMab1n9+j/Rm61R9+yDX
         uqnbS+6OKLxBA==
Date:   Tue, 2 Mar 2021 17:30:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] ASoC: cs42l42: Wait at least 150us after writing
 SCLK_PRESENT
Message-ID: <20210302173016.GS4522@sirena.org.uk>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
 <20210302170454.39679-13-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wxIXENaY2CYUgF8u"
Content-Disposition: inline
In-Reply-To: <20210302170454.39679-13-tanureal@opensource.cirrus.com>
X-Cookie: Friction is a drag.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wxIXENaY2CYUgF8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 02, 2021 at 05:04:51PM +0000, Lucas Tanure wrote:

> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--wxIXENaY2CYUgF8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA+digACgkQJNaLcl1U
h9DIbAf7BzToJ3kMO/GE8IhugTbrm92iabuHBXSvcba6ri2+NLWKAx6lzxVid1c7
DueM+3myvUwP7Ps01gziJv6ZWt+xFHFgBL1R9risA00w1oxeN/pnU2X6NKVQIcc7
CNKvkDLSyw/8uWTFh3dXae82l1WXuOkUdYAjTXvPwu+GsB3maCXjmv6GVMc6XNwt
lCCtjcUds4wMlgameb/n4fi9KwtBGOcHCZhy9MXdgZdE2dnPTNhyQ5jlQHAPRdX0
6PeBgmWifkXJ2u939VLQ2QoYHASmvHMyJwj8YKTVTe8n+P5nmqloA4QP+ZByOdRC
cSMi41OQ2ZhVXWb4AJAb5NHblHKZnA==
=WxeY
-----END PGP SIGNATURE-----

--wxIXENaY2CYUgF8u--
