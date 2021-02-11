Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D066318C07
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhBKN1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:27:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbhBKNFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:05:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B02E164E8A;
        Thu, 11 Feb 2021 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613048700;
        bh=mrE9SlUJANlUfo8RPvWo4Kd4/R2o5qyD4QYsEA8kue8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZzCI+4QsA3xIj74ZjcZ+jdEqQ15iGVFvm1tjeTizDSHiiuftySUfYuSltF3htik8
         9cOK1Q8eAzvJDuflYvywcuCjV7QPrMm9iftpWljLKEKQXGgD3zz3KZXAVlkMcC9ESv
         /QzmHPqu76lX8n12uX3cBg91S3Zbcs9/EmuNBMY8ddRbyn2vt/GN9KBxwVbHrmvGqJ
         fE4GBA3PUN1ALmHk7vJ8np6DtYVIAKclJ9scUYX+Q/gENn5BAg5jO0AhK3OCLF/a35
         FW61k6DZsnw1gxP1lzL7GLVgYaV5SLDhutScbMRkud2CUhAekiqiS+sd4R5ui/w8uz
         +3bMabE3GnsyA==
Date:   Thu, 11 Feb 2021 13:04:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Axel Lin <axel.lin@ingics.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] regulator: pca9450: Add SD_VSEL GPIO for LDO5
Message-ID: <20210211130406.GC5217@sirena.org.uk>
References: <20210211105534.38972-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <20210211105534.38972-1-frieder.schrempf@kontron.de>
X-Cookie: Do not pick the flowers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 11, 2021 at 11:55:28AM +0100, Schrempf Frieder wrote:

> +	if (IS_ERR(pca9450->sd_vsel_gpio)) {
> +		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");

Not critical but it's generally better to display the error code when
logging an error to aid in diagnostics.

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAlK0YACgkQJNaLcl1U
h9DpQwf/Z2CPKmv3SMhuul4qzXFxawSDqqpG9aySvlVMNj0eAaPTB/F75rl9o2A6
X9pUGSyudo76Y7giEmNh2QxZFQedxVinKt9ZzBSYyS6UK+53oztc3h1R3EDl3Omd
OtDDhJsGBlpK6QAvDCexB88C711QUZSPXRtSHfFkiCLc1zh3cx6oRJrpBGduEmER
cIWLGyvE2eFpl0oD+C5CJPd7NQS5Z3YzYzYb/JWndtvwc+CPNnyga+M71Xzmye8r
We8Nqsc41YGIgAJZP1rgJmxfm17VdLU+tTol49FfbhgQBk+/4+GddnxAtIWKLiia
NWDbySyrNNS5v0DCqB5KNXUywSxw1A==
=/oxK
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
