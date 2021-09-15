Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282DA40C5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhIOM7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233060AbhIOM7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:59:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D6C961251;
        Wed, 15 Sep 2021 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631710692;
        bh=N6rr3JXgaVvNIcoc45Ek8+E7jTIQE589BC7YgY3vN9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwd4fkxB4Lc9RmsbUEyA8m3ZLd+ExIiADhJ3Q0WclLbnekgb4bDxl5da0ojRhoYh9
         n+6Lz6UtNeav+P/womHVhdSFMkXtfsjOYR0xUAgkUbEIXDpHvtS3clY2t81/CWty/0
         3Xb+UOXIpMKSYc86W2jsWWCQtNHrU+6vaY23Yf+h4UgP81VaKVmwxvSlBLTVjAgvCe
         fA8aLmEcZ95MI8sQtZ5LZuSZI90CiNWk/tStTKHPnKp03DnuZ6bF2e1YSP3NK3fj3B
         H3E1wgjTGZdXYy44webgrowJ4Bl0Dlejyu9oxD3bbRBJXModxKaKpjY6BXOS925mij
         GdGGgznzLaEpA==
Date:   Wed, 15 Sep 2021 13:57:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v3 1/2] regmap: spi: Set regmap max raw r/w from
 max_transfer_size
Message-ID: <20210915125731.GF5389@sirena.org.uk>
References: <20210915120951.29907-1-tanureal@opensource.cirrus.com>
 <20210915123453.GD5389@sirena.org.uk>
 <ef63110f-a579-aaca-9bde-549392a0628c@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
In-Reply-To: <ef63110f-a579-aaca-9bde-549392a0628c@opensource.cirrus.com>
X-Cookie: Absence makes the heart grow frantic.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 15, 2021 at 01:37:03PM +0100, Lucas tanure wrote:
> On 9/15/21 13:34, Mark Brown wrote:

> Yes, its exactly the same, I forgot to add the second patch the previous
> one.
> I will resend with Charles review-by.

Please allow a bit more time in case people are reviewing your whole
series.

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFB7bsACgkQJNaLcl1U
h9BmEQf9HpUDItBVEjQiyt4rhpSvs2CndVIlEMIMihUdGm4vWokncQUeU0GvtLQH
+Um2tUyaOdmQH9pppU4KWs4reiRbkr209qiMcVSRe9fGWTwZ8RwDhw246H/rAEyu
qdELO7h0GL2JTtJfkW+E+rjURYuwBhZlKeF0UrrsE9b3grzfEDW5SFmO61Z6ghGs
LlMP+blM2hU7CCB1FnfBQXF76oQ7WMYOevs/B6j7ui1ZicaQztgATG8OFI2Lguht
1NIvx9FqAuzwq/IePtpGU5mtq/QSF+3VDPe+1pnVH+x/XTMXzq3PPJZbrOl11ywe
0q09g7zMoWPTYLEFSF8T79klUucgLA==
=vk86
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
