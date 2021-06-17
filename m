Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A553AB3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhFQMuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231887AbhFQMuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E9B3610CA;
        Thu, 17 Jun 2021 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623934083;
        bh=GFVeKqW983HVBr2jewK0aWIWpdIf+9EG330tW3Fn3no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tX7F5Iz6WrbBLZurLErapJlX8kyh2Jn459o3ZcftS/4S2W+0seq0y7fQ8F9mO+Fsw
         8GRTQLe1LQcKLEAd20B78gaMc5ugkbTY5dCcsnuwaMN6LY/flS6ISpqCa19zehfvGv
         SHQZY6ayi+M2O3qCFJtNjQ+FZqYxks3YP4/NOot/AcEbciU7ZnF8P49UndWinA3QHn
         hb8hpQ0Nmi2zlaXqGHN2KaAnoiQIanU8yX2wvw3LaYrrkuBRl46g52JxdxPbEVk25I
         8W0gjR/nUnbTEMkGbKfu3d4mAT+8Movpg8bnfHBeEwhA9X9L1rWp2IDWGjCA6gX+Wo
         J2rqhGGz4NOHA==
Date:   Thu, 17 Jun 2021 13:47:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] regulator: sy7636a: Add terminate entry for
 platform_device_id tables
Message-ID: <20210617124741.GA14305@sirena.org.uk>
References: <20210617024838.1023794-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20210617024838.1023794-1-weiyongjun1@huawei.com>
X-Cookie: divorce, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 17, 2021 at 02:48:38AM +0000, Wei Yongjun wrote:
> Make sure platform_device_id tables are NULL terminated.

This doesn't apply against current code, please check and resend.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDLRGwACgkQJNaLcl1U
h9CXoQf/UXmn28hP+PMygnpofYpb+LaIaXOk/eh3+7g5vl5HcbYnOiruzA8gaagG
UFmWE1V7CFnzsNhNWr0UaaeLLf99Q714yB6JyoyZloyqUs/eIHM1bpZZv/wl3TZY
B+XyRRBOsg7+0Q5SOqGewt77sghKEXjLOuHLwIVAYquEIooYDeWDME0mxUGITA2k
wMdEBbi2p7upwrsj1sBJkGE1D3zBe7UE9ue0vaGf67Gk4yjSMJuDp5+cHVFXdG12
eX1Q4APq63PkgNAwMBW0Mv9w8XFP5hy9VtRB7bno8I+xilvtqz/UCI4mBhwwbGiT
uovCg/aoQVaVk7fzbgrg4LnVMefEzA==
=9Tbc
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
