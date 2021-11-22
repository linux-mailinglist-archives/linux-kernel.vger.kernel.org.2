Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DC6459318
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhKVQfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230099AbhKVQfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:35:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 654BC60D42;
        Mon, 22 Nov 2021 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637598744;
        bh=nTBnFInXi0cK0wN3zrpD0mCF7F5ZiDbfkskhLXtZqCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/QULSRXW/Qs3ujS0VqZqID2djQo0mJPQKR28kZ4Bwvc5XQNCs3iRJBb/U3Z1v8fB
         Wu4VKi2PPeqs6YmNEoIylYCkp5qW5mZEWITHIs1c2bako7OfciEGOGRkkSKHMmROog
         ReLyU+4xKdCgSnG0spKxGCs/cQHB3UoFD9XzW1BstgzLwAGEfM7V9YY6iunGcnyO7Y
         DsztSYB7TCAWr+3fFYblNV0B9Ssk29iLuhl3CCGRSjdXcxRN/Do4tK7Y2rMG3QKir5
         8Lt2XXIEeEiqU3JMeEmw54ckIALAWRsB2hrhVUFuvBh/eE5+53d0Gn8mR3lwjU2Fyv
         0AbvWUIoc2koQ==
Date:   Mon, 22 Nov 2021 16:32:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: lp873x: Use bitfield helpers
Message-ID: <YZvGFHLWf3GM1jVl@sirena.org.uk>
References: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
 <44d60384b640c8586b4ca7edbc9287a34ce21c5b.1637593297.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qq4+Q4VlCZHFklyh"
Content-Disposition: inline
In-Reply-To: <44d60384b640c8586b4ca7edbc9287a34ce21c5b.1637593297.git.geert+renesas@glider.be>
X-Cookie: Lake Erie died for your sins.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qq4+Q4VlCZHFklyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 22, 2021 at 04:54:08PM +0100, Geert Uytterhoeven wrote:
> Use the FIELD_PREP() helper, instead open-coding the same operation.

Acked-by: Mark Brown <broonie@kernel.org>

--Qq4+Q4VlCZHFklyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGbxhMACgkQJNaLcl1U
h9DHeQgAhELKCMdpGAswyTNH53dysYFxMrLPT8H8VrySXj1/3PlBlj6EvPbIUIjk
o4vVaFP16QStm7KKxQex/AabOVsdQ54GtpotessfZuD2VZjfAoegyXAU+ybPEzTv
HIILxCU0qb3LyNlIyY0jMzYrUFwC6vu8WzIJByShWg2Ikbv3RLsAUmSh2r5enIG9
rXcQszC1L1bVBYHnZ06p/f6MpuqBoQknuDic50YHO2d7X7xMO5Nnre4UpSQ/l9eT
UipG9UKZBNkDR+ETpz/BAH2EUtZBQEYoLDpjCSZHYCVomha3Yj5FbXUI98LSRcD9
rxFyawoBPjfq+xgB/IKKOYrqD8zGhA==
=l6F2
-----END PGP SIGNATURE-----

--Qq4+Q4VlCZHFklyh--
