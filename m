Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931CF4400A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJ2Q5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 12:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhJ2Q5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 12:57:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D77961184;
        Fri, 29 Oct 2021 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635526472;
        bh=xJMcJlZ5X3eXJxE7o9KfSrs2+XgcENRmMvxeR2ZxKWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAO4KmRxyDHZ80ape2mgFBfMKBMDY9HiW5DkEzIfu+pJzSRyPvGUTKJvLM+dlT0hi
         /VPxuibsdC7VHMWFUM66ox+HzN1Xn3vNdOvWa4cGfQ08u4eu7bTlywBD9iys9FGYlv
         wvm03JRh2HUx2PAmdA+i/ZOy3ezyZ5DP+8VIFs2bvRqFhyyd6/nc1K8oGs62Pz9Ru9
         CfDQ+TuNXg86HDR0C3oiHHWHIYVbM4Q+xhl+Tjxji3qkIfF1dVD5fZyWwyC7+z9Xkx
         98o64YNmrF2JldeKam8EIqH1SpgR8nzdyYnqgGQRWaRvfNFNGg06b7lslb6wNDb3Ej
         2OR9kJV60KKlA==
Date:   Fri, 29 Oct 2021 17:54:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brent Lu <brent.lu@intel.com>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Huajun Li <huajun.li@intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 3/6] ASoC: Intel: sof_rt5682: use comp_ids to
 enumerate rt5682s
Message-ID: <YXwnPd5ZRn024HOK@sirena.org.uk>
References: <20211020155715.2045947-1-brent.lu@intel.com>
 <20211020155715.2045947-4-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRC+e69iwlw8jUnU"
Content-Disposition: inline
In-Reply-To: <20211020155715.2045947-4-brent.lu@intel.com>
X-Cookie: Please go away.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRC+e69iwlw8jUnU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 20, 2021 at 11:57:12PM +0800, Brent Lu wrote:
> Use comp_ids field to enumerate rt5682/rt5682s headphone codec for
> JSL/TGL/ADL devices and remove redundant entries in tables.
>=20
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---

This doesn't apply against current code, please check and resend.

--wRC+e69iwlw8jUnU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF8JzwACgkQJNaLcl1U
h9CJ+wf+KM8JpratXROtpko1giAoVs0fSdbEHkH/arWfVgCh+d3CojV7Y9YUezid
MWqb4+nhpEJVelVVxvdREThE1BTHPPa9F9eDh57qJFneClpWOA9OG4dkhT02AK6K
47CNsHGZWWCTUFqpxPcQ4HsytIrUGtlxTqXQ9hlBiNEuaacc6BHLAa2K6EHBgfnb
mmFxdOPlEJ4x+qwtkPbWc45V6WpbIOEN8xmKa/C2KaDT3rev7Eu7g0I06XLAqKzi
+davyAcReu3MxkqKQUMM6y1KILmppdeAhB9+oQ/2v4ITz/fSfbgA5J3Z+rykT4fv
88iVxIqwC24DK+0RkoAhi5o4O1MrZQ==
=VgIZ
-----END PGP SIGNATURE-----

--wRC+e69iwlw8jUnU--
