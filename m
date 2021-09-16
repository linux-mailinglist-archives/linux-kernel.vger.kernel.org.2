Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DAD40D87A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbhIPLZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235650AbhIPLZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:25:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB22C61209;
        Thu, 16 Sep 2021 11:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631791448;
        bh=NMgNoIq6hJP/OBlSS3MAr+6o3KajWt99OdGKIwdT+34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=flZVHBUkb84eZY2YTJwMjBb1P0hQ7pdNuafibxNm8iWR5LZqHMIihA4bYLoeMia/s
         SUIFvZevPTxYNOO7hVq1J+RgTp6xjcvcHqI6XOfQbIxqb80HNOfA9C6nmOG/l3FEKu
         zJ3w7w2FSiFOQwSKjhkf7yOyqmzYD23IzCh20lWlxwaUh9Nqt8YLZeh+tJNmSF4ZU2
         odPdga05b/CzQBY4H3hX8jBUphFCN7xnB1lUojutI9aUlcJ8mYPj6W1pxYZ7b+fLZs
         l5l7AO3WC3NuJfLH2bM929NrCBqx9Yjc8js5H/KkVPl/wdVxJlqevpaF6k/TCsRzob
         wdJpFjx9T8tMg==
Date:   Thu, 16 Sep 2021 12:23:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/24] MAINTAINERS: update silergy,sy8106a.yaml reference
Message-ID: <20210916112327.GC5048@sirena.org.uk>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
 <eed037d15b9b919d6401898cd5cdeea0542a41d5.1631783482.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
In-Reply-To: <eed037d15b9b919d6401898cd5cdeea0542a41d5.1631783482.git.mchehab+huawei@kernel.org>
X-Cookie: We've upped our standards, so up yours!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 16, 2021 at 11:14:17AM +0200, Mauro Carvalho Chehab wrote:
> Changeset b1c36aae51c9 ("regulator: Convert SY8106A binding to a schema")
> renamed: Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
> to: Documentation/devicetree/bindings/regulator/silergy,sy8106a.yaml.

What's the story with dependencies here?  You've just sent a single
patch with no cover letter or anything.  I can't see any reason why
there would be any?

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFDKS4ACgkQJNaLcl1U
h9DwbAf/QW/5nmCsGZ25qSz42lrNLKtYY+VAdQupk1EdCJB62CnwWTWWQ7XhhRln
T/Ldj7ebSiXJje0QEos53RrumNu1rQyIV72OmeBKHUe81Lb3xizOLmZD1uFMkJzO
8FeO6f/9aCLCDRvcWA9ijY1O4Ew9NejZVA+C54xWFxwH1gulYHds1U7Nzd0eQ/i1
XKbDDregcvJw+Q3Kd+8cOIsQpSSKBpUW/4f0CT53tVZJXgx+u6JCeiKQHBa32FfD
e6AgvOId7q9oJYFCdhST00wPxM4jnr1SjeeWPI5b1ziILMb1dBlgwzAPsF9sQZ0M
KqXQKdaWLuBphA++ZGGB9e8LotPmOQ==
=2KFO
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
