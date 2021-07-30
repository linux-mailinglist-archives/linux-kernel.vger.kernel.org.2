Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02D43DB7A5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 13:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbhG3LN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 07:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238552AbhG3LN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:13:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A03560FE7;
        Fri, 30 Jul 2021 11:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627643632;
        bh=/KqZ04QBL6v2hnznT99rAqLNoGRggWAJw9cekzyiWc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OetvCozpPEm5G7NkPeSwK7YJfkkjMarYxO8kf7jAM5pQ8sjBMk1kqXX84C913rJus
         IT6XROxWLAldHO9DD5qN143vLwaSdV9FqP+L8rIN9nzco0wzxRo9piOyy+dWf4yeSG
         QFQKxyLzR02egW0S+/pHAaWn2tjrmhZkagV4tkElgD6maKTyVdY5UHmc1kvjBnYCAF
         EMzjYuVnuvpmVnLZ2FTolkf9iz4qaR0Vz296O+WN3ShZG1ZyWSKaugBA7gKVJ39CDD
         FobxoLGQvZPGCwiY7jQPcaZ55l/+K0Ut+pAa4MnNHBkpJdKTDzsKwicXvcy1CJE37m
         KUAgzFClCCgcw==
Date:   Fri, 30 Jul 2021 12:13:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] mfd: sy7636a: Initial commit
Message-ID: <20210730111341.GX4670@sirena.org.uk>
References: <20210708115804.212-1-alistair@alistair23.me>
 <YPbjZdu7T9wFcvNz@google.com>
 <20210720152351.GC5042@sirena.org.uk>
 <YPb1Hs0EoZ1MikuX@google.com>
 <20210720202639.GE5042@sirena.org.uk>
 <CAKmqyKNUBzWuLSvLTqaCNhDpuficctvCgpk3ZEBVFuKeCrx86w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XbyeA6tlA6gsyQxQ"
Content-Disposition: inline
In-Reply-To: <CAKmqyKNUBzWuLSvLTqaCNhDpuficctvCgpk3ZEBVFuKeCrx86w@mail.gmail.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XbyeA6tlA6gsyQxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 30, 2021 at 04:21:18PM +1000, Alistair Francis wrote:

> Are you saying that I shouldn't add the regulator to the device tree?
> Should I leave it as part of `sy7636a_cells` then?

Yes, that'd be better.

--XbyeA6tlA6gsyQxQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmED3uQACgkQJNaLcl1U
h9CcVQf+InH1Nw+eXIoyA55xciCUKGvunG2l1LNZRDhtvtUocgxoM76Ri4X5tgn6
OHchcDn5Sg+DhGll1PyqYHZtc7cFooyvsHWNVdaXXGJnZTL0ky1V1qFA7NdsV5RL
AQUwi41kmMGFuz4Aj6xLJswzK/6BUIrR4/yvrJYaCTJqDrO0NAUBEZhe7vopgITc
njGCAt8ZXJLk8n+WC84tzdRd5YdtyFZzPF4BbNPEARf58srdma3hndlhXwXbSrYT
/3lwTmFmW+8ksqCJ91uP6nj8UcLFokF1GAwzvucdEPfCH4koinbgwXTXwRooST78
KtRrrjIv1/efVg19J9kv/VaDcyGurw==
=fm8W
-----END PGP SIGNATURE-----

--XbyeA6tlA6gsyQxQ--
