Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EA23F4995
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhHWLUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:20:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236422AbhHWLUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:20:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E1CA6138F;
        Mon, 23 Aug 2021 11:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629717604;
        bh=Wclgrw6m6BxICpicnUto8OUs+4WdnXkyrzgO5hXEq08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oekp8axDqIoeW5CHA/lnpv36WzCW/r9tpNUkqPHzTLF/4RkKXSBPHKypz90C1GJAq
         Y0jk36XHrmFMOIALTDpiRY4EwJWSZawxsOxCQcVmuqJ4qKcDXBpknPbyFBXxt+n2C8
         niInnEj6nL8gFNoItsmNvxaLJP/nVhVhOAVwp//Q25iFQ025NgBvbgqv6YQJflYu3H
         ET5thGUfqABm/ZuNuPznMUeXXM/1d2gi3DEcR56YleVsqtdc9HCvQ6RXGrR4L4aKRP
         GesMXaoltgiT4PnmU6MZWHpFX+Au89Y008wOJBFIGZ9Ht/21LU2XIwqBFAkpBF8m2z
         5zfPe32vgO79w==
Date:   Mon, 23 Aug 2021 12:19:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] ASoC: rockchip: add support for i2s-tdm controller
Message-ID: <20210823111938.GC4380@sirena.org.uk>
References: <20210820182731.29370-1-frattaroli.nicolas@gmail.com>
 <20210820182731.29370-2-frattaroli.nicolas@gmail.com>
 <66d6bd43-ee43-eff4-7a68-333fbb996787@linux.intel.com>
 <3469189.PC3msRC2N5@archbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <3469189.PC3msRC2N5@archbook>
X-Cookie: APL hackers do it in the quad.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 21, 2021 at 10:45:52PM +0200, Nicolas Frattaroli wrote:
> On Freitag, 20. August 2021 21:02:16 CEST Pierre-Louis Bossart wrote:
> > > +	regmap_read(i2s_tdm->regmap, I2S_CLR, &val);
> > > +	/* Wait on the clear operation to finish */
> > > +	while (val) {

> > delay needed here?

> The rockchip_i2s.c code doesn't have a delay here either, but I can
> add one of 1 usec for good measure, it seems weird to retry the
> read as fast as it can.

You should probably have a cpu_relax() in there at least.

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEjhEkACgkQJNaLcl1U
h9DRvwf/eYPzwI/HK4Jzi3lJiLh1vo6ezpgKS2ev6fNjoSB5emwL3rxmM/SHYkhd
vOoWprclRkygu+R5bIiLPc9Y2h6i34D/mc8aT6D2dqG+fDq5SaHx3FSX91PTLGU0
MIZLUdFQqJAINWBwgZmtZPj5ssgK6VsZ3Re9bUsaKi+R0q43eWAqSRiZ54fqFIwI
18takfFGAfqMRNfrzAXHcIqRG3viwccrBxcxIGSbxF+RrT0O++c6q8R4rB4c5nvm
/m23A2wdczve2z2hmaV6T/48gI4gVQReDFMb/S3T3hslTd4DzghMFSBIzQZx5OEY
jWofpFXTysAcWf6nQMM48fBkf/RAAQ==
=E6qU
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
