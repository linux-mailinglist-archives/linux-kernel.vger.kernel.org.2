Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9A3A7E44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFOMhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhFOMhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:37:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8483261439;
        Tue, 15 Jun 2021 12:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623760530;
        bh=3Wq2+8NVL2BkUnnxNcF/n58X+TgoV/vpvH/oU15vV7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVV1K/cbGczQ8QwJv9mbThJVKX9OaXYWRSR8PYi+0/gCIM+rOPoyA1Cu3LXcJho39
         m3xHypjuHeWpIJQ8xjLo5HDnaBCQLXMl8MwWNU+UwhQCEyfZSud0dh81t4oOC82S6c
         xSTNFdYf35WNAVeo+L6ZEv8qWM7+kWGLOWbOducN+uOUaBPy+GTypudmXIp4VepOKv
         0a/Bs5+0R1OZd7iMWnNaAq5lTa/nQQMrqMo6NWtX7JY5k7FdNjL2tJiuOH9Hu14GWm
         lmaApRAvGq+Ph5A201h97LmvDs2VXxVEJZ7KPH+7HKCsGA4I9dPdP2bHZPW7LTWzNd
         3wrn8sk0jqfUQ==
Date:   Tue, 15 Jun 2021 13:35:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ASoC: codecs: wcd938x: remove incorrect module
 interdependency
Message-ID: <20210615123206.GA50640@sirena.org.uk>
References: <20210615094839.27237-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20210615094839.27237-1-srinivas.kandagatla@linaro.org>
X-Cookie: Simulated picture.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 15, 2021 at 10:48:39AM +0100, Srinivas Kandagatla wrote:
> For some reason we ended up with cyclic dependency between snd_soc_wcd938x
> and snd_soc_wcd938x_sdw modules.
>=20
> Remove this cyclic dependency by handling them in respective modules.
> Without this below error is reported during make modules_install

This breaks an x86 allmodconfig build:

/mnt/kernel/sound/soc/codecs/wcd938x-sdw.c: In function 'wcd9380_interrupt_=
callback':
/mnt/kernel/sound/soc/codecs/wcd938x-sdw.c:184:3: error: implicit declarati=
on of function 'handle_nested_irq' [-Werror=3Dimplicit-function-declaration]
   handle_nested_irq(irq_find_mapping(slave_irq, 0));
   ^~~~~~~~~~~~~~~~~


--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDInn4ACgkQJNaLcl1U
h9Dicgf/cDl99zA5mgDwaxaR3yr03dF4EsFzPUGjF9mrNYmBCckOJEU0Wg6cA8mZ
lhYYhyCzxE1aGHrom2kcY+c4h3T5KNzKzqprikedSz5oNldntR2Ld/I4vhkxkIiH
O6pUUTjRQEZLTN1F0JJnLhy7GeleTSG0hDGKEwPBAX820B1agC5vBYDl0SKB3shQ
8VG6r8PjNjBC8IccvXAna/yBGA+bF0+ll9wdD9aTzeyGB2wXsbv0vSIYxKl5CetC
Pcve/AZx5a3nwIqdR6QVqowB/Rj/aIo29L12RJUThDbt9yVCboQW6nPrwtEpb0zM
oOIHCadWaUu3UxQlje6jPjT0xDWvkg==
=17D0
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
