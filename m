Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21913A14B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhFIMpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhFIMpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:45:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4B1761183;
        Wed,  9 Jun 2021 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623242599;
        bh=3LmDIUZ1wKlG81I+AFVUAzlVq2kCXIgwekcGWmo3BKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTrySzzH01xRqI6y+qazicvHLm3iUahU9lnsc49IiCQ3YhpFE1MGZmItjImUulTSl
         MTRFsckWs8M5r1tfrx9B1xss2tIBYo7mP9xDz9QvZyyHwxfPhKHCu0uD0+Vm2N03KG
         efqwhhxFl9HaT+aduguKYCqVi7iEE9OxgKF6gM0OROhOMWh178CnByE4KEur/yTy9L
         z/yAapPpoQtCE+lxO14rkrnEpAPHzKFYWUwtlKyoLCarKsKopozI0ezGJdI92mgpV9
         fhAVh/cqpu7lxRpBJ3Y97QebzByy2Ff9nk+bjy8MuaBdEX6s5RC5QZRUtpeoBFkcRi
         DlTmnMxs4axQQ==
Date:   Wed, 9 Jun 2021 13:43:04 +0100
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
Message-ID: <20210609124304.GB5052@sirena.org.uk>
References: <20210525132354.297468-1-maxime@cerno.tech>
 <20210525132354.297468-5-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20210525132354.297468-5-maxime@cerno.tech>
X-Cookie: Alex Haley was adopted!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 03:23:46PM +0200, Maxime Ripard wrote:
> The IEC958 status bits can be exposed and modified by the userspace
> through dedicated ALSA controls.
>=20
> This patch implements those controls for the hdmi-codec driver. It
> relies on a default value being setup at probe time that can later be
> overridden by the control put.

This breaks bisection:

/mnt/kernel/sound/soc/codecs/hdmi-codec.c: In function 'hdmi_codec_hw_param=
s':
/mnt/kernel/sound/soc/codecs/hdmi-codec.c:504:50: error: invalid type argum=
ent of '->' (have 'struct hdmi_codec_params')
  memcpy(hp.iec.status, hcp->iec_status, sizeof(hp->iec_status));
                                                  ^~

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDAt1cACgkQJNaLcl1U
h9AuAwf6A2ho54/TuWajEspKMKa3Y8mJqdCmq/szJ3u4iWTqPzBREw/Xyol8SXcW
adYBtoSaS/Q6yh0OoY9A33TJwzQKwX4ZYow8t0KEmz7s/snT7Jgz8TUZPDE4ZEZb
hHB/oXRVboMFrY62HeW+SnN/4A3D0ooOalNMNrV3/Abzjm9isJqafRKkj2dr8ymG
7iplj1Rip+CLrhpSUi1ZF8aFTzqO7mckdD2pt/UN6k+aZ2oac65WgHhxOWt2m0q7
Zl0ZPA2J9rTqse01tGxJ2GfVommjEFXKkcZStuzvWN2vfM4En0fdyUsU0hlghy+o
15yz8IgChSQ1PGgdfwwc5YpcBvx2pw==
=Ztwb
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
