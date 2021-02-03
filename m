Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA8E30DF8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhBCQT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232630AbhBCQTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:19:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A950064F74;
        Wed,  3 Feb 2021 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612369151;
        bh=K6U4CHFRSskkHz3ojBSXooC5+ftYU+xqIVYffsb/J7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IU5XKFkj/iqkEqoTsfqYNVRfsDWZGJsNQfECfvbfUyrFmbNbEAERjV7i3iTFl83se
         5xpPixgtzlLJoa90NZ73qeMpzoffYJCj8kBhIGqVOwNksTKg6k2ARHvejlulyi2lw3
         qWGrNHkItntZNV88TNjLIH1BG2vL7Tr6j0GMEdgqb5N1McIUDcYfDCcGo7ImueSEO6
         NbFRogi58P0LATTq3uJ5cvtCRWk6SREF0HJmwMeTv7vsm5kQewUwb20ydliRVcbuXR
         Yn0cmTcdD2eSKbyQ0MPA+JAr33R8nVyjbBFfRhPIs3Co1WiB2S3Qy0jNC8WSAdZqJb
         jjpwAO83O7YeQ==
Date:   Wed, 3 Feb 2021 16:18:22 +0000
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
Message-ID: <20210203161822.GF4880@sirena.org.uk>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-30-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline
In-Reply-To: <20210202221555.41167-30-cristian.marussi@arm.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 02, 2021 at 10:15:47PM +0000, Cristian Marussi wrote:
> Port driver to the new SCMI Voltage interface based on protocol handles
> and common devm_get_ops().

Acked-by: Mark Brown <broonie@kernel.org>

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAazM0ACgkQJNaLcl1U
h9ChAwf/cxgDKr121Q/m1iRu5q9YDrCu7Jcisy3H6oadOX0rjeXSapqJpZApRFfN
cquj6jpO6WDB3nPwlQ3Lgn43IOdYTN81/2oqUD42Y5m8PoD3ysFEwH1/oL+bdXsr
4hFujXc3qsd5QUxt2SY1QVMyvZgXy43Yx3FVqGwn9wa8cKrhvfjwhJ2e6ROFNn6y
E+BPhA0mpkWK9eAl2bh6qCiutJjLtYru07Ryxpc+U9jYsEdmakloIFqNnG6Wbd4L
nTQr5ghP5oCn8kP3Hs8zz4J5mXdO5/D3bqvJ3g52qwFNEl7bHvZKK5nRecPMYE85
FsJlgFw6zCCgZM1yVLOWuNOAiW+uig==
=s9fz
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--
