Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B71F44D903
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhKKPTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:19:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhKKPTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:19:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DE87610D0;
        Thu, 11 Nov 2021 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636643816;
        bh=tEn6Tu4Ha4rwwg9KtM/MZwE3jquXcKhBNhUYxUSODmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0aVvzNgoFdP7m+3O0qapT5eekLyJZ5S2D4nSLiKKb+RDbjl06HcaqpG5P3qiKOMT
         c5syGnVn/TjaJweFWHPl0zellk1JbHVz2pCBfpEyXoirXUokvMr1qHYAPmUF4TxYt3
         DWUMOeZfMdt+uJqWZ8JvT5O+tI0JUEH4rVBFWosaMre3xiWzDYyAtsSJl2r7gVqiS5
         2rqwrbJwMLUw1A4uTtTJaRA3VJR3fXFvfVxrdjLLtx5IWXCG+rDDcCF/TVPVE1qcsV
         KIz4tYQMylCOolUmh7aNRboy66IQuf3zZk7EBXCCijdoEhufKAvvAOReVRaO9z7ctq
         mqYiPUvcRuRuA==
Date:   Thu, 11 Nov 2021 15:16:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] regmap: allow to define reg_update_bits for no
 bus configuration
Message-ID: <YY0z44ZaLumgNtF7@sirena.org.uk>
References: <20211111014138.15645-1-ansuelsmth@gmail.com>
 <YY0O+yHo9ZSYgj83@sirena.org.uk>
 <YY0tfZze+kltD9gb@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZD9oCnPfcxg2Vs4e"
Content-Disposition: inline
In-Reply-To: <YY0tfZze+kltD9gb@Ansuel-xps.localdomain>
X-Cookie: Teutonic:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZD9oCnPfcxg2Vs4e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 11, 2021 at 03:49:33PM +0100, Ansuel Smith wrote:
> On Thu, Nov 11, 2021 at 12:39:23PM +0000, Mark Brown wrote:

> > Please allow a reasonable time for review and remember that it's the
> > merge window right now so no new patches are being applied.

> I'm so sorry. I had some problem last time with sending v2 that got
> rejected automatically by patchwork and I thought it was the same for
> this. Again sorry.

The patchwork instance for LKML is now read only (at some point it might
even get converted to just point at the threads in lore automatically
IIRC) - nothing new is being added.

--ZD9oCnPfcxg2Vs4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGNM+MACgkQJNaLcl1U
h9C1fAf+PKdBQfPHSiyaiFWPam+O5fwITjP3uu/frbt16JLK4mib9ZyxfCHFCu4w
RxFicCMj6U9oQHocQhG0QmXerBQdcxpqg9h048c+Kb6wyVx2dVsseF90VIBwkgkc
xA2yngf/imSEGB7J3Xy5PevN8uNS8aDC2wKA74YMKlvPgN0h/G0ma0FXckEVOpk+
kUl98hrkHlSWRMdRA7NJuis28zxNNztalz93+Kodh0FXV2HCwMH/nNdkc8ZTRljL
CFXwDT+XQ5UQB6+v9KYQagu1WvtJEEy6a2nfirxTZ8sQUJmTdBKkKVUJ8wH1q9p+
sec7wVaKIxeFqLbcKmeFu6INSorOsQ==
=pXxX
-----END PGP SIGNATURE-----

--ZD9oCnPfcxg2Vs4e--
