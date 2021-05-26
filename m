Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9657539151D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhEZKkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:40:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56774 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbhEZKkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ApStfRDU0a2Bcxs0DU/lRdHOKyM7PDXIMldhjFKUC1g=; b=JzBt+Vx/khdrcQKa/bcrJCd6Zx
        fy2Ur+KbJUCQu1V1LvcbfXGMIpq0u2XGgTsHwqL30rHarLjr6Xz6zVL1S9wsQnQ6PHVGSK2FIujAL
        TKSE7rn7w5l1aH2jN1YNF5v2xXXSAyKpOYiIC3Jx24xd/ETeQhNWS7t3T/uOUNTrTawc=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1llqvN-005xlj-Gk; Wed, 26 May 2021 10:38:05 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 93E77D05836; Wed, 26 May 2021 11:38:40 +0100 (BST)
Date:   Wed, 26 May 2021 11:38:40 +0100
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
Subject: Re: [PATCH v2 03/12] ASoC: hdmi-codec: Rework to support more
 controls
Message-ID: <YK4lMLG6PlxzDJhs@sirena.org.uk>
References: <20210525132354.297468-1-maxime@cerno.tech>
 <20210525132354.297468-4-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eIFZBnIxpSROlH5X"
Content-Disposition: inline
In-Reply-To: <20210525132354.297468-4-maxime@cerno.tech>
X-Cookie: Ahead warp factor one, Mr. Sulu.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eIFZBnIxpSROlH5X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 25, 2021 at 03:23:45PM +0200, Maxime Ripard wrote:
> We're going to add more controls to support the IEC958 output, so let's
> rework the control registration a bit to support more of them.

Acked-by: Mark Brown <broonie@kernel.org>

--eIFZBnIxpSROlH5X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCuJS8ACgkQJNaLcl1U
h9ABYQf/acYuDAkB3WhiZ1hCCQpVdonll1Aj3jSnr5WtK5yitGmh8cYms3T5uWUE
XmT9B52fCJh6IAHjAm9XZbBWm49ShM/pgA00Q6otZDb8zVSS6v39HIFvnRDDsRNx
ASGbUOdr4Z/1kPc4n8UDKlq45Dz8985Rtfoh5QknQEeD5P0zvNViwWcfjmVZ2UQ+
qJk9oC/WJIxhR6PyY8x0XbI4plfCO4WvEG9dEdKE4navagTtBVa5e9RxF1wyXK9r
dDaL9bRcRigdba+/DRBjrDrJEDQM5GUe9yT+znvJzcqmkPYt9q2qe6Wen6UxjKrf
seBlUHvVi2p9QEVe3haqTNcmB5vqzQ==
=RH7S
-----END PGP SIGNATURE-----

--eIFZBnIxpSROlH5X--
