Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CC941C5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245310AbhI2NpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243959AbhI2NpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:45:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B4296140F;
        Wed, 29 Sep 2021 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632923016;
        bh=R6yoV0khFy81tUH1THfIPp6FLThss8lF2bIHISDUfns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/qJsMvb6ZU3ZdOS1gYaSjrYedCwW5clkK/GRa6XdcAXEuQ5swT2JhrHGss2sz0kg
         Pg3T1zSKj5CBnS0m8gI3+y7J5Qnr0wvLZxKIDatJdZF/kxguCOaEVX4JwVD0KZr0Er
         dPUXORbYTtNo7tp23PuYRA+hOr2y+OQnGMwAHkRTygJxH/XYzbJrXzaVBo7FkTPjdB
         df6EUZ4aJoaRWvKP3Eqnw4JQ83WTKHp5PnMUx+GfsJLnVBnUaHcpDr7ahtX5gwrX4F
         W4x7zM/4EOkkTzr/V2C1g7cKMX0XVzp7BsWxFBIi3RF9Xyg2m8JL7xf/zDClxzVbkV
         WHtkj9iGSDXrQ==
Date:   Wed, 29 Sep 2021 14:42:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: dt-bindings: maxim,max77686: convert to
 dtschema
Message-ID: <20210929134247.GP4199@sirena.org.uk>
References: <20210928141353.112619-1-krzysztof.kozlowski@canonical.com>
 <20210928141353.112619-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ga5bsqHr1s/xcZEm"
Content-Disposition: inline
In-Reply-To: <20210928141353.112619-2-krzysztof.kozlowski@canonical.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ga5bsqHr1s/xcZEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 28, 2021 at 04:13:52PM +0200, Krzysztof Kozlowski wrote:
> Convert the regulators of Maxim MAX77686 PMIC to DT schema format.

Acked-by: Mark Brown <broonie@kernel.org>

--ga5bsqHr1s/xcZEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFUbVYACgkQJNaLcl1U
h9DloAf/XFL4fnS0kNxZrXMTIQh5zPSsMx3LQzMGl90gsHctETvhyqUMnHhoJ0jW
0RclV/+kabp0erM6VmYMuSDU7qz4b6Fx9vfBPStagxVjTxabY2Kqc9XSBxaC4v6b
0Jn4fv+/WMZSgRUz5mHcnAWI6NaOjuFROLAhQHULwUaW03ZbUKX7X3E0ZUFJj60f
NCtZSLJfzxtbBi4495DKnh33bynY0J6dY+aaLh3WiParPhpZBDBBHwIa1JCDP9N9
fLQ3fKIQnrfkI8DWVy+wPAoS14Qpa881JykDk0K1BoFZ9Cgrndzf4zmzO1F8EBWx
nfwsxR3pVWKoJOAA21mD4DfljTN/GQ==
=QwUs
-----END PGP SIGNATURE-----

--ga5bsqHr1s/xcZEm--
