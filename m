Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456F539735F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhFAMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233823AbhFAMiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EAF960FE5;
        Tue,  1 Jun 2021 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622550994;
        bh=2+ivin/diukkvPRUMoKU7rL59DqrYfnBewenIeEPcR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VShp+p8WU+C5SXju/x1RnursJXYFwXVm7kesfGEsdonSYFoSZH9jyRF7NbXcLShI3
         JM41GwjxJ0leXNp6dr43QUoXpTwvsbUyZU/0gLMBIyiUDy1dwQjeMcdkJdY/wcEMZ1
         VjMzvekTSawV8DgJ/wfyLitvuN8mFMwYoNTQIxuw79ewrg4CLv3V+0UbcW+Ci5gOFf
         Kf2HGNtM6nkTg719e4HTUrDNsJyothhZnet7rxLLIsfWYqmondn5rGL+jiWRrf7Ef6
         HT1J3pwFZhAvUEPl63R8VNfe9DIGjsquK+MiuHamS3YmRviqEgldIi8QVPwsLh9v/m
         5kSQ7uJyIK49w==
Date:   Tue, 1 Jun 2021 13:36:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Jaroslav Kysela <perex@perex.cz>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-doc@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 05/12] ASoC: hdmi-codec: Add a prepare hook
Message-ID: <20210601123600.GA4089@sirena.org.uk>
References: <20210525132354.297468-1-maxime@cerno.tech>
 <20210525132354.297468-6-maxime@cerno.tech>
 <YK4lWaB6Lx+SPjpF@sirena.org.uk>
 <20210531094213.kuuunk7ytu3q6sq6@gilmour>
 <s5hzgwb17ji.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <s5hzgwb17ji.wl-tiwai@suse.de>
X-Cookie: Sic Transit Gloria Thursdi.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 31, 2021 at 01:12:17PM +0200, Takashi Iwai wrote:
> Maxime Ripard wrote:

> > There's a build dependency between the DRM bits and the new hook
> > introduced in hdmi-codec, would you be ok with merging it through the
> > drm tree?

> Speaking of ALSA core changes, I'm fine with that.

Yeah, a pull request for the shared bits would be handy in case there's
some collision with other work.

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC2KccACgkQJNaLcl1U
h9BKcAf+O81ROM96RMUTZYJIimTQF0+J/oQkn+ESJXI+SHZBaclCwMSDyDON/sKl
JWt3ZmmxhZcLbu0e+i0IKllvpqlENXAAn3WxWdlC7/uFvY0fe1YLRTLVPUneRD0G
PY6UdYKkSfSbfQj/9CJR2svgHPHwrjtb2zrrFK+SnD57cAbuOsrKJPVNGQNl7YKl
p0KBajw4X98C2vToZhWraDaKNlq0PJ0IiPCqo17/UHi8M0dhr1VQ6lTcBGa3Wn6y
JkS69Xdqm+M7Nwz2LNekJ8yRBbjnpSA8d/ENLPUWiuRifvMYQlNCbJ0evCFQYhmn
szkAj4KiQQhziNgUPgsCjN+8N/HlLQ==
=/Jte
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
