Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FAB40C81B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhIOPUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234215AbhIOPUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0EFB60F6D;
        Wed, 15 Sep 2021 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631719123;
        bh=KPyEcgeISqHY914J6y2I8MCbJ1P5dbDTRXQCf8XOvQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1JSIS/Qw8IL1Tb86DduCCaivBYtTDwdpiM+9vP2gOOoPzqxhWCezJbPo370S7MJF
         YuyMQHWss42rhvfjJ7T3jxlL4YlqYN/Tx9kToifrvk8qpMliebHmbIp2nr01M1CYQP
         mvJpdGs3Cl6N9W/yxyK9aO0gBO4hlIRHDq0lbPEtR7TJSjws25GoMb2R3nrFiTFbUy
         voPYY4ZkTcnxPMoMq1fauCoFnMKCLAViMvXDe5eUfsDVylMf1hC5z7713o/eOzBztC
         zOW8TJW8M1f69uhmJyZ4AE9/3Wf+j3HeLA9CcD+huwGYubpybSUjUoF3KwXcs8qg+m
         XFZKKxfOb0WbQ==
Date:   Wed, 15 Sep 2021 16:18:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2] regmap: spi: Set regmap max raw r/w from
 max_transfer_size
Message-ID: <20210915151802.GA50080@sirena.org.uk>
References: <20210913130101.1577964-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20210913130101.1577964-1-tanureal@opensource.cirrus.com>
X-Cookie: For external use only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 13, 2021 at 02:01:01PM +0100, Lucas Tanure wrote:
> Set regmap raw read/write from spi max_transfer_size
> so regmap_raw_read/write can split the access into chunks

This breaks the build:

/mnt/kernel/drivers/base/regmap/regmap-spi.c: In function 'regmap_get_spi_bus':
/mnt/kernel/drivers/base/regmap/regmap-spi.c:115:21: error: unused variable 'master' [-Werror=unused-variable]
  struct spi_master *master = spi->master;
                     ^~~~~~
cc1: all warnings being treated as errors

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFCDqkACgkQJNaLcl1U
h9A7/gf8C72+XmGQhT0u5th8JOmWMDFiludy8d2CaxDjZjX9+9RAlSw63n8udPWf
bgIXMPhPtZXzbtK4yLb2scG5ua0Af8iZP39Jn2SMD2kRiqnhD2cubR45vD5tLul0
+CuG0gjA4Dzo/Dkg2VQpkhtz1psLKWuxhjZoTIj+1J3UQF7QgiJzMi7XeYyHeJ0R
/ae5/kQMyHZAeXPATBHFYIqCWJdYTnLmkEm01IQDXvMWsNky/xgdfzD/C00YcB2K
PnWi7xE9p7OZ3py4PCDo+0REtMv6H8G1wUSmkwRNF/66n4ClInB8zy4vr8PucLuG
pXHt8V6nFA1sp9SmC9vASDfjbHVY7g==
=A30b
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
