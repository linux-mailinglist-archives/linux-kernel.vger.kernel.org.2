Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C060233917A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhCLPgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231679AbhCLPf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:35:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E1E464F4D;
        Fri, 12 Mar 2021 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615563357;
        bh=eEKFK3OThEMIo+ZId/9KGlssHgbryRe18XUiNaBF2R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOuteIOL+nMhXruJzsVz5ttEqS4PASeXqgxlCS/YiPDV1m0y7FDOy1ccVYnuxsaCo
         JLM9RxNbLkT+5R7FJ5SPUoNK3j2+H4ZxHZpcGotcu+SqBReVshez0HaRTPbYaRIheC
         Mla9LwjsK9uL94ITTSzWRTXRB6Fv1Gf7xvKximTcc6yIQlIqjCUKmbjKRkHagTkmg2
         9tsVHVAiPHQ6uNhyLWMZOSzzw3v7tSvtSJhQ2fAgQt/V1+kVAi+n+A6l7ImDvNoRdI
         tv3Ec7Cz1npmA6x25QZFtEYSUy+E2rWZNHr0k0aEsSHLwd+QjVmZ5OryEqsfLzR/y2
         2XnMhmCwOidnA==
Date:   Fri, 12 Mar 2021 15:34:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH 3/7] ASoC: codecs: wcd938x: add basic driver
Message-ID: <20210312153443.GI5348@sirena.org.uk>
References: <20210311173416.25219-1-srinivas.kandagatla@linaro.org>
 <20210311173416.25219-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Content-Disposition: inline
In-Reply-To: <20210311173416.25219-4-srinivas.kandagatla@linaro.org>
X-Cookie: Lake Erie died for your sins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 11, 2021 at 05:34:12PM +0000, Srinivas Kandagatla wrote:

> +static int wcd9380_update_status(struct sdw_slave *slave,
> +				 enum sdw_slave_status status)
> +{
> +	return 0;
> +}
> +
> +static int wcd9380_port_prep(struct sdw_slave *slave,
> +			     struct sdw_prepare_ch *prepare_ch,
> +			     enum sdw_port_prep_ops state)
> +{
> +	return 0;
> +}

If these can legitimately be empty I'd expect the framework to support
them being omitted.

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBLihIACgkQJNaLcl1U
h9Ci5Af+PqSg4yirqEFMszFh/ZclR61rSGqEGOzB8LWC3qEET8W5UpRKUKtDdRHb
wXhbQkw5H6mbRHy/oqQVUaLXQm8U2Xt4CwyZSTCS3CHmYasfkk63kbhaccT1xxAf
UdPxODkq/8ykC7eM9aGWG1D5sqdGZg+hRlIVtMKAev5K9i5AOxWQAx5qSKwukA+9
taUkuvFN3xxxw2Lkiv1NTncSn+B/TXwfXcYAOF3GLkeJyRjvd/tfzX+gImSoL+kT
D/EPmg8APp36rkq7JAH1GGjrisac/FuEyecDFhFY1KyWrzyuD6yx0uJRkn5oYWK7
istKWxTEaCQjxtaj3iBkxKkFF23W7w==
=PrKP
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
