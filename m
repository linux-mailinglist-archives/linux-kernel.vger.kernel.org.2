Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28914391527
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhEZKlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:41:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56932 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbhEZKlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZZ29t9rWQM4OHKScJo66H518G9wk4b5EkUEydCzI4Y8=; b=P1lTnzGRnD6xJwViIxs2la/hmZ
        aLW8qo6s0YSEySGWYLrL9g/N7VCscyCT9z2V8VztvKYpidgHTEP9P7AA1hG2wBJZkbalafJod5ino
        R5WUr/PCJdJHYLWghQcE7V6KxGS5EUjbOc1/X1oVS9wSR4TvP1JwrxcbwLEAEDqcMDOM=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1llqvh-005xmI-5B; Wed, 26 May 2021 10:38:25 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id F01C7D05865; Wed, 26 May 2021 11:38:59 +0100 (BST)
Date:   Wed, 26 May 2021 11:38:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jaroslav Kysela <perex@perex.cz>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-doc@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 04/12] ASoC: hdmi-codec: Add iec958 controls
Message-ID: <YK4lQ1WJ+bBAwnDz@sirena.org.uk>
References: <20210525132354.297468-1-maxime@cerno.tech>
 <20210525132354.297468-5-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VHjauBDPfRurBChP"
Content-Disposition: inline
In-Reply-To: <20210525132354.297468-5-maxime@cerno.tech>
X-Cookie: Ahead warp factor one, Mr. Sulu.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VHjauBDPfRurBChP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 25, 2021 at 03:23:46PM +0200, Maxime Ripard wrote:
> The IEC958 status bits can be exposed and modified by the userspace
> through dedicated ALSA controls.

Acked-by: Mark Brown <broonie@kernel.org>

--VHjauBDPfRurBChP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCuJUMACgkQJNaLcl1U
h9BbiAf9FlorXmTGbHpwvZBlli/cOILFyMcqSLtmFjeQQEQ/Hw/zi+ovr1CDHxx7
GGjEpFOC3ThNwPXOMCPBcJ9KI7dkJL5rk+Hb4nChrNno8iZLrEy9O73H5iATxn5o
HTnqWXd2c9DDAFeNnYPkXrqH4jntmdlprTBBwHaCfX216S7uK1+3y+wGGN2ssCoq
Icvel1+KQ/o9MdMhs9cuDRw6e3GYNVqEK82wOLfKL6AstDOmVt6IJ+PvOG/h4NSD
mRSQ/XDsW/iXataTHhEjyihRhDEjSQ9MXd7gCtKitVBetbKUhO6EDY/hY7aV3J1i
OpnoP0ODzC13oVmNXUGkksNvsjhFgw==
=vtry
-----END PGP SIGNATURE-----

--VHjauBDPfRurBChP--
