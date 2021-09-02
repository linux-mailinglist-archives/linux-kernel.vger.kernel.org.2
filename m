Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB31B3FEFB2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbhIBOup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhIBOuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:50:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66B4560FDA;
        Thu,  2 Sep 2021 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630594185;
        bh=74B1g330j3XFo5x7ASCrKG7fXjCkSQ81tfsxRgQUxzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dk+1RcI9IZWuLycsGUAXMvaiX1zWc3TIBzrflsE1irzo5FSEjc40XYEvMmtUXD6ZD
         7KTVJg9+PDs3ITsCcVV77WYVQs79i+HN90MNIIG+KrN3s4uTWUXPG4UhWFyu7dcYBb
         b75dIHkCF7xuI5uoPp97CuegYyHmELwL4ewWOjrBch3v3b8A+00KXeIcG0vdBRuk+u
         gJmWwumQkBbvcdnFn6LJPGc9kswNQsxabbJAovvewCpl0PHe7/uPljqUSapqamWENv
         bgGedZ/GjkdjDRpBgoO806YJsMKGqVp5eZrWptPZE4ndL5aEbx0guOrEJ/s4YIy3oF
         9KMFJxlYTqonA==
Date:   Thu, 2 Sep 2021 15:49:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, peter.ujfalusi@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        s-anna@ti.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: imx: Add code to manage DSP related clocks
Message-ID: <20210902144913.GE11164@sirena.org.uk>
References: <20210902123216.787025-1-daniel.baluta@oss.nxp.com>
 <20210902123216.787025-2-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <20210902123216.787025-2-daniel.baluta@oss.nxp.com>
X-Cookie: Famous last words:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 02, 2021 at 03:32:15PM +0300, Daniel Baluta wrote:

> +	for (i = 0; i < clks->num_dsp_clks; i++) {
> +		clks->dsp_clks[i] = devm_clk_get(sdev->dev, clks->dsp_clks_names[i]);

Looks like this could benefit from the use of the clk_bulk_ APIs?

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEw5GkACgkQJNaLcl1U
h9D6dQf8CQ+j2eYy3OLz8n4W9uYfdEiX+7mQIfuhP8KESkfKUchq2YshYjNxgXdh
89mN6XH8LiikrIMYk+ID0VZ84f5fEKsKSLWlRTNfCU0VV9Gk9lBzGqX0wcfKHn1r
pNAXj7LZD2uJmqMQmXgLcRjBLVHtLgjnrc6XZPxZElzlEzewhMta37io4I/a/Yyz
wp1+BPUxv3wIWFZE4IblYZaX4lA3WnYf2gJDNx3EJCOnuR/xHIrnGrpValgiHUVG
PN6hkNaXcpvru8KVEb7jQR4OFDKQ/IKFdpnXPZeXN8QLw2K6Gi35RqPYwddtQog3
rMbgSPa9NNBVUO0PeY5xBq6AjAFdeA==
=PxVd
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
