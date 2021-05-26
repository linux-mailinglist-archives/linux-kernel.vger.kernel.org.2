Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0C391EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhEZSX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 14:23:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60954 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhEZSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 14:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+qaik4LTkMCA5O6w9UEiz/Pui3c6ELwDabBUnwJA9AY=; b=U/sxmDMGfNb3vsRjIqxjxs4UJs
        HaSJ2B6/JWKszpBgyUfqdirJmPBvzxE8/IuAMHPzA/u1H+nZ/eot07ppOF7l7nWNEbKbxduQbK25R
        fsA9OqQxVI0A5tnpH1QycAZvGPOwhvCXO95aqguRSbT8cIKzJXpm260mO8QI1+orioTw=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1llyAB-0065ak-A1; Wed, 26 May 2021 18:21:51 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8D52FD0E9DE; Wed, 26 May 2021 19:21:48 +0100 (BST)
Date:   Wed, 26 May 2021 19:21:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] regulator: rt6245: Add support for Richtek RT6245
Message-ID: <YK6RvBD3c38BhJZa@sirena.org.uk>
References: <1622009578-15577-1-git-send-email-u0084500@gmail.com>
 <1622009578-15577-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lTwzbj1zgyOksQ3T"
Content-Disposition: inline
In-Reply-To: <1622009578-15577-2-git-send-email-u0084500@gmail.com>
X-Cookie: Take an astronaut to launch.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lTwzbj1zgyOksQ3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 26, 2021 at 02:12:58PM +0800, cy_huang wrote:

> +	/* xor checksum for bit 6 to 0 */
> +	bit_count = __sw_hweight8(code & RT6245_CODE_MASK);

This doesn't compile with an x86 allmodconfig:

ERROR: modpost: "__sw_hweight8" [drivers/regulator/rt6245-regulator.ko] undefined!

--lTwzbj1zgyOksQ3T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCukbkACgkQJNaLcl1U
h9ChYwf+KzmHlyb4wot9VOf5H/NKXJ/Q7MrjB7TQO3ElHQe4FrfHh28gWC0CN5OV
o+BlFDX+tgoJUXAd9kc4dpU8wygnAgO0gcyevlx+yfDvYrU8aucLtO8rRVF4Gzd5
RHH0HSncUGY0zexEMLSSGr2E8CwzpNhpTuierbBv4uvfjvpaVlMbMsTY7jldxL8d
1UMGWQZSMX+r3NWVlGQ7JXdsuDYVoz0sdtpnQp8rPe5EYU5uzJ0lYsP2EJ70z+KV
CTjaEPEqQTkVIiiPnDJx8lmnyC0N4xL4oFwbKJT90vu+kwkq3m4i9Fezwximg/AM
CXn5zGW5jlGwf2NywYVTCOZhbuQNGA==
=SV4H
-----END PGP SIGNATURE-----

--lTwzbj1zgyOksQ3T--
