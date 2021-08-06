Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625B83E290A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242500AbhHFLDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231768AbhHFLDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:03:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E59761184;
        Fri,  6 Aug 2021 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628247797;
        bh=20NfF3J9cl225zcEu0KJHGyDeyhbZp7+OrKXj20E938=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzmXTg6bqsJf90YQnaimWLVaXTfXj8zag1L7nAopdECFMW8Uv/qcv3hhm2wQxPcUs
         nrWNCvcP4u3VgEsLiu1Z6niaWPPutPz8fLrJI5ta0L3UdIIkGlaB+QygWSQG44ZS2r
         nwtZbSsqPz8D5CDP5MhwEmd1AFivWjAN0NtfaSHoAFQal7viQqtFkO9/E7Ecieffkr
         PdsuA+H9837AtRN7Xhqc7uScVjXxDuLKpsSm43aJsDaYMnta+WJQR7bjMOs9tx71WW
         h4lXxsGvWILQfN4MPQHxNCjKc0UbKCtjNGke2LYP12IRcLZFVWxK5azak7BmeCi7bl
         huG9TpaUaJaaQ==
Date:   Fri, 6 Aug 2021 12:03:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <steves.lee@maximintegrated.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, geert@linux-m68k.org,
        rf@opensource.wolfsonmicro.com, shumingf@realtek.com,
        srinivas.kandagatla@linaro.org, krzk@kernel.org, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        ryan.lee.maxim@gmail.com, steves.lee.maxim@gmail.com
Subject: Re: [PATCH] ASoC: max98390: Add support change dsm param name
Message-ID: <20210806110301.GW26252@sirena.org.uk>
References: <20210806080834.16705-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="js+/jT5SQQin5+Fm"
Content-Disposition: inline
In-Reply-To: <20210806080834.16705-1-steves.lee@maximintegrated.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--js+/jT5SQQin5+Fm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 06, 2021 at 05:08:34PM +0900, Steve Lee wrote:

>  	ret = request_firmware(&fw, filename, component->dev);
>  	if (ret) {
> -		ret = request_firmware(&fw, "dsm_param.bin", component->dev);
> +		ret = request_firmware(&fw, "dsmparam.bin", component->dev);

This will break anything using dsm_param.bin as the default - why make
the change?

--js+/jT5SQQin5+Fm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmENFuQACgkQJNaLcl1U
h9BXGwf/YRMSJCh7uD1Bjn/x2m3TeF4LisjMz7+rn7cYD3tdHoKsH8QpSkO69E/P
WSRXZMZqySN9e4FacYFYVlqEjOGoprB+gGpay3eL10Vj3Y8YUNfKA+x6a3WMnCDD
6KTLXtUABhKgYaeZvttmNjskXCfrDr0G6D+fS/qGXkjjfqiGnATUmetKf9hVMrdC
9Rb4JAdy8yvqWdo4c2zrx6To5Hy1CWtbISGDRDxy09Ik3YQuqN+tJ5C4j7lzQDP/
m8e2twJbchuvk39gcSYTGG7pBV+bOluinVhp1H20hzHC7cL0lSWqgNMpt8BItk+o
VmPRHBf/aJE4SvghbRHd/RoBbbqF7w==
=mdVv
-----END PGP SIGNATURE-----

--js+/jT5SQQin5+Fm--
