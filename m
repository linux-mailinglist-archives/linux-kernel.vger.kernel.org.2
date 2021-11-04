Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACC2445677
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhKDPls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231341AbhKDPlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:41:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2109610FD;
        Thu,  4 Nov 2021 15:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636040349;
        bh=33691hjBX9cadGoNuJzUiBoacTbjKNGx8fgHdxnQIQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBp55FzKYxropmUNncWTfpvAEjPc/Yu8oqJK2u3YOsk5m/En/j7Bpm+EP3D7MKN3t
         yQR8Hq7NEYxbZdyB0vj0BxYacEjwI1oT8GCQ0apH3XudV1TIhYef54Dd4q6E6MZVaW
         gvylekx8Cts46ms8jezMX80mEeJhXX34EMUO6PNBMMiPbKlyWtjyzPq3aqDPmf4EP1
         ityBueCMVcwFsPI0/xsXzuiTu3Lvrm2zLX5syOP/bWZ6/BbZZys0M/9Jw4U1Yt285W
         5JqfDrYERFsWks5bOSxaXR1own0RBt5X4JfQ5gRlmqKxhSoVaVICXnUzIbNUOzpoAw
         vvslMfivQEspg==
Date:   Thu, 4 Nov 2021 15:39:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, yc.hung@mediatek.com,
        daniel.baluta@nxp.com
Subject: Re: [PATCH 3/4] ASoC: mediatek: mt8195: separate the common code
 from machine driver
Message-ID: <YYP+l7tMofYoB+aC@sirena.org.uk>
References: <20211103100040.11933-1-trevor.wu@mediatek.com>
 <20211103100040.11933-4-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c/fvPxmf2qWNcw9j"
Content-Disposition: inline
In-Reply-To: <20211103100040.11933-4-trevor.wu@mediatek.com>
X-Cookie: Motorized vehicles only.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c/fvPxmf2qWNcw9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 03, 2021 at 06:00:39PM +0800, Trevor Wu wrote:
> Because we will add DSP support, an new machine driver for the same
> board is required. BE and codec configuration will use the same code
> when machine driver is designed for the same board.

I don't follow why the DSP support requires a new driver?  Shouldn't all
systems with the DSP present be using it?

--c/fvPxmf2qWNcw9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGD/pYACgkQJNaLcl1U
h9BAqgf/Us8BcF+vWFc8NQqr1anc/z5wXrFIw7io61z4wr+ALcAiqTXbLnt7KKse
vtZMFvaxL3V/QbElufEk96G8jEXIrjYRuLAubtVQDl0a3LAtlQ8Se2ynhzu2Ib12
Rf8pihv2OkEOM8Cj11mnLnokKBRQPj/CeloGdaE0xvVqlrO+ymOTdXZ8luP69uI5
kCIYGzh3zlGA8G/aT88Doxmc9T5mgCoj9eu35oxN3h05bf4/h5kN77JHL6eiK5op
h3Xb2ql5Kaok5XZ1R4ZSbc6DhTY8xtsmfBkR7wZwPkmpXyXU9H4FTQXqib55VyXA
q5NZy4f9SyI9MoQnUgLHSiijyH5mQA==
=N3h7
-----END PGP SIGNATURE-----

--c/fvPxmf2qWNcw9j--
