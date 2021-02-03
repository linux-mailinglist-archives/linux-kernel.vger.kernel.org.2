Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855E630DB15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhBCN0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:26:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231571AbhBCN0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:26:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 801E264F55;
        Wed,  3 Feb 2021 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612358721;
        bh=rCv/sBNegsapp6VGbKAX0lRAu04/hGG1X1P02KCkvwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8k7bUG4aQoh9qxjGoBp+hGKfpMzknvEzS6IAC9GJdUwj6ZRck91WBYa9UnuOvEOt
         39IX2+T+8ZDyH6OR9nHxU14jqehURPfpsTkwP8UjUoD5mF7xOAH6F4V+Mhx6QmMru2
         kqzP5G2Nvl5VT5PLwexOX63IGl6xIIV1X8TGrsLE1+JP54O0UtP9LMu3PccU5D8E9G
         m0VLL/IkKvfPufM7IeBBui1PIm0IqfIWKt2BGc2PZSXhClopsIfwgqFgk9AdKHt297
         nA84NgAvuOg75gloLz81Yz07x19wSE/qYNaHuVDk1EXAc8lA9xN2Thc3OmzYBGwh4U
         ifQNcAuCueOfw==
Date:   Wed, 3 Feb 2021 13:24:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 29/37] regulator: scmi: port driver to the new
 scmi_voltage_proto_ops interface
Message-ID: <20210203132432.GD4880@sirena.org.uk>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-30-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <20210202221555.41167-30-cristian.marussi@arm.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 02, 2021 at 10:15:47PM +0000, Cristian Marussi wrote:
> Port driver to the new SCMI Voltage interface based on protocol handles
> and common devm_get_ops().

I have no cover letter or other context for this, what's the story here?

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAapA8ACgkQJNaLcl1U
h9C9Jgf9EkCrHP/1MrCrBSWfe0ccYEshKTmSKzd8OQVi7I7lNHCBmv6Q4h3gwPiw
w7hhD1WbPUFSstjwz7iyQXCdB0I52ldj4ryrdj/8I18k2BCPOWDa0wpcJ/yjF4CR
TJT9U2rojpRbgFW84PnmaXX5+T31WUgZt1sRg5V4kenTuSkZ57RDKaX2mROWoDoY
NnMoYQXtIiq4L8GxYK1kkVJPjbLaz+2VHA1aK+ZK3jWDx+KbhJJXxGPmtAPItxBa
e21F62pyVqsC8irTNiKZn+Oq1CEdgjUYH5wuqg4ON0n98wwPfvLa0MljqMJENpwg
DdZSMbmEqET+O34PBIvZEukkGrNArg==
=fstK
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
