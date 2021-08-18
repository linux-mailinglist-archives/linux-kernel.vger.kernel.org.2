Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B2D3F040C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhHRM5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233634AbhHRM5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:57:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F33B661053;
        Wed, 18 Aug 2021 12:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629291416;
        bh=oUNMZ3N3BnzZiuVDegJM0Y3OIg2AOXjLtpwnoWnPOcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGPmsKA0z6tyfzG8q5As0YJjUf/y6AFPeJtlhlXeg8477075l4+6AP/DThInqBqyl
         20JGpTLPBW34foVHKMvkf0IqeD0o0GCBlFKkkITtddJlw/AVTSuvqJrLjaZ2KPSN8E
         32iEXxalcAGPGIB7ecFGB39Fu+cj8NmBz9B0b8EGYmeENi/+fxkzmkW9RbmGjcUdBs
         WbeFslXQodgSA2kNzST2Oo/8+/YK6ETq3SCjRlIRDZckW0g5VEXHnbLcT1W257Vnru
         H1iyCe6ReS+xtSQwHyEhQ3+jgbVP6wgNYD854MWZ1VFo5/FeycTkMsWU0+3+IJ3vbv
         p8N30s61nLvSA==
Date:   Wed, 18 Aug 2021 13:56:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     lgirdwood@gmail.com, ulf.hansson@linaro.org, lee.jones@linaro.org,
        zhangchangzhong@huawei.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] regulator: add PRE_ENABLE event define
Message-ID: <20210818125631.GA17664@sirena.org.uk>
References: <20210817033848.1396749-1-jay.xu@rock-chips.com>
 <20210817033848.1396749-2-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20210817033848.1396749-2-jay.xu@rock-chips.com>
X-Cookie: Save the Whales -- Harpoon a Honda.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 17, 2021 at 11:38:46AM +0800, Jianqun Xu wrote:
> Add REGULATOR_EVENT_PRE_ENABLE to allow to notify driver that the
> regulator is about to enabled.

This doesn't apply against current code, please check and resend.

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEdA34ACgkQJNaLcl1U
h9AnWAf/U/DuYbgl0iPGbSpeyY8l4hRw+vanENiMTm2Q1gbrFsFWVh6ldSMuDHT4
0NB0J/k+zBhMthcnjR3C38hBMXZZY3ruYzeTtAK33RJDBQv5gF7x1RWGmDwxnMQI
mEo8pOimdDhCSqpcomIuv05W+Fplq0zowOXbhjmQRHwZOyTgyLUX89b0cOeDV+Cb
6UQC2R/C8LSrURUtLyFFqvb37Q7MfIT4MTD+8BaO+fGOrvPJXKICsbpjZ4ow7UPV
C6S+4fAoMZGimeXxWLHsvtE7ErDdyPUR4aTBJL9vNwwWERswEOntlL0e0+YpYUCt
C+cuyIbh0V6AfIypW7Gv8uFXnWrwmw==
=5oQy
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
