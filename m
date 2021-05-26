Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278EB391525
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhEZKlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:41:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhEZKlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TMe0IyJS6cQ+Lq2HcNsTfT78sP/9ZGYPAk05niLZNeM=; b=ueVfX9lZTHGcN+dDDycF9mQOdz
        iTPADjKo7qvHBeqyQkPRQjiKTc6yInxBCdzMcVMZ5IPGCSL7M/Bu5GCY0y7NBhPOcReo4cuyktI+a
        Lr+1b3l5uwbjLFKWwUZjAVSdl+pRuKIKUO7DDHwl1NDxUoBwdo4cda5SMSnbQtSf11mw=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1llqw2-005xmf-VR; Wed, 26 May 2021 10:38:47 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 49705D05864; Wed, 26 May 2021 11:39:21 +0100 (BST)
Date:   Wed, 26 May 2021 11:39:21 +0100
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
Subject: Re: [PATCH v2 05/12] ASoC: hdmi-codec: Add a prepare hook
Message-ID: <YK4lWaB6Lx+SPjpF@sirena.org.uk>
References: <20210525132354.297468-1-maxime@cerno.tech>
 <20210525132354.297468-6-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wI7EtUudqJM9+3Oj"
Content-Disposition: inline
In-Reply-To: <20210525132354.297468-6-maxime@cerno.tech>
X-Cookie: Ahead warp factor one, Mr. Sulu.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wI7EtUudqJM9+3Oj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 25, 2021 at 03:23:47PM +0200, Maxime Ripard wrote:
> The IEC958 status bit is usually set by the userspace after hw_params
> has been called, so in order to use whatever is set by the userspace, we
> need to implement the prepare hook. Let's add it to the hdmi_codec_ops,
> and mandate that either prepare or hw_params is implemented.

Acked-by: Mark Brown <broonie@kernel.org>

--wI7EtUudqJM9+3Oj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCuJVgACgkQJNaLcl1U
h9CRRggAhsstIqtcqC4EquItefHkzTS9v8kbwvJytct/Q8VBhXpc7T0EkxWdaCxn
s+7PulshfFDvB24KxgJcIs+bHVkn+e0dvfDLkjSd7RO+nGcIwnccOUzCJ2CX7/qS
++Q7uUsY8Ne55NUPIfMpubv32SIHaYeCHglZjHKaHNpsM58ANdTAN2Sl2PMJs3u6
phAyak9G80MvU5cjMto9WmV9zyGZ6uobiGH4qjx8wzO+71RuSMwCKVF6EZ/mdg26
8XLOMvwo44jmHGWCduFH3mdVtsPi89Tblv3wNBrLlwMjZhJ2AiEqssq67lKCbKF5
tvl87wk9yeLVRB/BD43Vpa3DajNrrg==
=7TgH
-----END PGP SIGNATURE-----

--wI7EtUudqJM9+3Oj--
