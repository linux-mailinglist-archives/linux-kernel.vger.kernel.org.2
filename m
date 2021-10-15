Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388EE42F684
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbhJOPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 11:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240764AbhJOPGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:06:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DFA1600D4;
        Fri, 15 Oct 2021 15:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634310271;
        bh=SswMb9wzOxq0M9rtsUWefGhnQeZ9QlqXp3SndHLCDfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWgRNNZMwOCyuTCHLO5nFRrwGacGn1A6q2dl6GcaoHCPTgBfw89/o4nDKzghlrFUh
         ajRTJ3CyqR/sjkr8sVI+pwDLrMY0ObwiM34zndB1U2/8THkLuClBmrKy9WoQoTR3Kl
         /oSYnx6ir6Ur4+4tuE0G05PncEIjSNFxrKUH9ZCPCVBh3kSkWIix9VT2SUU0prrLUX
         SXUUXZApPytQZC71Ux+/aARqWvZM7iLNm31w13jWE4/Q6Yc/zg8Ze2lTcwDUAZGkja
         bYWg53wSMoYzG6BVKqYRuN7bcY8uZScZ82PBi5Uun02/cqzyz0XKhQqVDK2+qCSVQn
         rTYG0s8s/u44A==
Date:   Fri, 15 Oct 2021 16:04:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 08/16] ASoC: cs42l42: Reset and power-down on driver
 remove()
Message-ID: <YWmYfYRNqyruBltq@sirena.org.uk>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
 <20211015133619.4698-9-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YEwHEeG4QLJiJTRL"
Content-Disposition: inline
In-Reply-To: <20211015133619.4698-9-rf@opensource.cirrus.com>
X-Cookie: I'm having an emotional outburst!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YEwHEeG4QLJiJTRL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 15, 2021 at 02:36:11PM +0100, Richard Fitzgerald wrote:
> Driver remove() should assert RESET and disable the supplies.
> Previously this assumed that calling pm_runtime_suspend() would result
> in a call to cs42l42_runtime_suspend() to power-down. This isn't
> guaranteed - pm_runtime can be disabled.

>  	pm_runtime_suspend(&i2c_client->dev);
>  	pm_runtime_disable(&i2c_client->dev);
> =20
> +	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
> +	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies=
);

Won't this end up with an extra disable of the regulators if they're
already disabled?

--YEwHEeG4QLJiJTRL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFpmHwACgkQJNaLcl1U
h9AoPQf/VsuvOQOkub0xVouyjOI+TAb9UWlot4YRDNwT+tQavmkRxviZg2CAd3+8
Nb6tPe49xRCMEUhN5QuKa5By58FtHXNQxTJRJu5E5FkWVgiK+HQW05pTv3rGafEF
JybSqUBpfMqKta3RQ67dGqAANPl5falAqHhyn6nlX7QNIS0hVtAGgEKuge2FbAG9
vyQpbEZ7C+L1fRGt4TssRiuQUJHTkOhAmHD/meT7qWeh8gHlKlM7xblbT4Pv13mc
woUSNc0c6RP+XyleS1MGQ/+VU7042LP0uC6m/SQah4c9mXTdojEihWp4Mzve+OLQ
T4L780EV7YYfz6D0+Kq3eKQ35rDbXw==
=1u+2
-----END PGP SIGNATURE-----

--YEwHEeG4QLJiJTRL--
