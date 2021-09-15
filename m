Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2940C719
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhIOOMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234504AbhIOOMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:12:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D688611C1;
        Wed, 15 Sep 2021 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631715053;
        bh=YbvuYcfAW5Fjwy98n/gQJCW044gac9hZzpuoydBe/dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhHMNxjD3PIagYWukAJT16WejQu1Dbiq44S2cQuGmDemU2s0PzXskS0Mb6Irn2nY0
         BvejqDNI6tgKrU1ojfMAGWva+cvxOeL1smppWSvCJUDTI7NVGjiBan1X2KNSHfm7Cv
         SSpy5IqfbXrxWkAx/ybCRQtL/d6EL853pp8VMM72yCXx3IQT/T5e6tI417NVsb0NcG
         apEMwbvZhpq0W4c93pt3BoeiITIqoc9OSZs4wJcnpAcw2hMTEjTT57GRqIozJsev+y
         lxg8x+/sbjcNbn/yBiGmplD1n/bTKDfkkMtprEac4uc6TZbXNEVB2zY8NoV8SVuzGK
         BaTvvFkw5hLng==
Date:   Wed, 15 Sep 2021 15:10:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Message-ID: <20210915141012.GC12513@sirena.org.uk>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
 <20210903231536.225540-3-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <20210903231536.225540-3-frattaroli.nicolas@gmail.com>
X-Cookie: The more the merrier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 04, 2021 at 01:15:34AM +0200, Nicolas Frattaroli wrote:

> +  rockchip,frame-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 64
> +    minimum: 32
> +    maximum: 512
> +    description:
> +      Width of a frame, usually slot width multiplied by number of slots.
> +      Must be even.

Why is this in the binding?  This is normally configured by the machine
driver setting the TDM slots, not through DT.

> +  rockchip,mclk-calibrate:
> +    description:
> +      Switch between two root clocks depending on the audio sample rate.
> +      For integer multiples of 8000 (e.g. 48000 Hz), mclk_root0 is used.
> +      For integer multiples of 11025 (e.g. 44100 Hz), mclk_root1 is used.
> +    type: boolean

Why would we not want to do this, and assuming it's to do with
availability can't we detect it simply through seeing if both MCLKs are
available?

> +  rockchip,tdm-fsync-half-frame:
> +    description: Whether to use half frame fsync.
> +    type: boolean
> +

Why is this not part of the normal bus format configuration?  I don't
know what this is but it sounds a lot like I2S mode...

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFB/sMACgkQJNaLcl1U
h9AyVgf/R1hx+9U5odYrV/J4RA9uPRmhSRnrn3d9jvqBMcYWbZUVHv4dTKqn4SqK
QUkjtLocXUuai3S1P/4XuaoN0HvXjNaPsGxo7967IUUgfxrWbRiBIsG+DQJiAMWS
95KX7lNSNmjf8ZGDY5LTp78M8fhzUpB0zedTNQw5D9r8aCHTBAmIUw+fKOJFlucS
ndk/eJHrgcxpcvaVZX8nuRdgAfJpv/i4v4+K6I/dAHsiGOkbFwiJiOIZ+psy7wpr
lp5ioBhSuQQEH/sA62y0nSDVXggOJEPp+APhIqeiGDTmiZ9gabhBClhDHQ3aylpJ
9vmhvE2NT59s90BGBWMnFEQfyqdk4A==
=s91p
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
