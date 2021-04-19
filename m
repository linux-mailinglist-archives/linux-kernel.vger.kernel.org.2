Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC4F3643CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbhDSNVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240484AbhDSNRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:17:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08B8A613DD;
        Mon, 19 Apr 2021 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618838059;
        bh=OosnQ5ZFutS/+bz82y+4HRJ1FsflS0HFY219LJA20Zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXCoDJObGt8mlc8RE/N7u6SAP1xQN9WKe8Z2EmIc1FAqzJ1DD9T/cVXDD/kev34w1
         ZAjCInQ7Wo2kbM1c8eS3sZAXWAlm1PJsMSBg/gjdBiTxF1rxtpwipoFLWM6E2BQmW5
         vW8/RmYlgttdpR3uMJP8tKTtTYgeODVV4qkB/Wn/SFRxh8RC/nkIPebhjNTmIYZ50n
         hn52nGU4ze7UJ3dqfIybKTmK6oT4UUACmCTw0XlvbeobEsoS8mtrH2HgIZaO6Y0PJw
         Rl8pgpa6jqBUnkJ5Yusz/CAa0QxLh+RPRRfbPaPgPRqqmfCiE3EmqwscCorOsJlfaS
         s01Uqo/BrhPPA==
Date:   Mon, 19 Apr 2021 14:13:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v5 3/5] regulator: sy7636a: Initial commit
Message-ID: <20210419131354.GA5645@sirena.org.uk>
References: <20210418210222.2945-1-alistair@alistair23.me>
 <20210418210222.2945-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20210418210222.2945-3-alistair@alistair23.me>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 19, 2021 at 07:02:20AM +1000, Alistair Francis wrote:

>  drivers/regulator/sy7636a-regulator.c | 127 ++++++++++++++++++++++++++
>  include/linux/mfd/sy7636a.h           |   1 +

It would make merging slightly easier if you could either put the MFD
change in the MFD patch or allocate separate driver data in the
regulator driver.

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB9ghEACgkQJNaLcl1U
h9An1Af+LUOyWNM47BJBtCSiI7ILggSSn/BW5zEMf1FdRXs5GJw+VScSox9IYqQ2
iAS05Gn//xmdUb2AdVE5YkBYpdypHrhicYEZWG+SdFEveuLGn7awvyEcvMFmJeO7
NwSSdllvzN8Wsc7aVsr/D0lf7rvR2oEiEYsh68PBcWLIoIVyE77l1OUP5eZpzyw7
4OXuF6vR9FxgimabfVukIC+o7vviPECBQdqvH+ZLsTMsMYpbm+aKgvAcfmD9PrmQ
7dYmwqQQWc+85kd/s4xm1cKr7T3iE3rv4bsq/tnSvgbFyIHu6PkpZg+mWTMFgprM
VWc8rlVO5e03r/YnPnTtOCuQ4IqrGQ==
=zVAZ
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
