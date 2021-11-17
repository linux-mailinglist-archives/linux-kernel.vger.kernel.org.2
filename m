Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D97454BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbhKQRcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:32:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237770AbhKQRcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:32:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE6BF6138B;
        Wed, 17 Nov 2021 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637170155;
        bh=/OY3TTIbV3uqWHM/tEbq0g7zfM/Ce2n1Er3jv+U3qDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=riEW7iAQGlfz/01XujlKXW58hpsfRK2MX8Vib0ljC9yKWVFlvlq3qyx/nf0HCUc+a
         5AbHTlE66rT1wD34hxtikfQRt4ud9m637U1/octfKduJNIjD2CMbbP43LKiMgFNRWW
         i5WFd1cMfci2wDKywf7cx4CbFcxLeQYBDmkqL7E2udw7WZZb/FvZItvt022qlnMONZ
         dk3PVaz22gcjJ+nNDFPc49SJdWvJvRenasLC512ZHRbgXFCcvqD2ffPq4RL+EwtvNA
         bZeOnOyhCY/qd+Bs5WILvGYDCD8vA9TMYu9rQ3CneU1PUCvZXLeby4QfKAakiGtoeh
         FKWxlDvSP10AQ==
Date:   Wed, 17 Nov 2021 17:29:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, daniel.baluta@nxp.com,
        daniel.baluta@gmail.com, AjitKumar.Pandey@amd.com,
        Balakishore.pati@amd.com, vsreddy@amd.com,
        Julian.Schroeder@amd.com, vishnuvardhanrao.ravulapati@amd.com,
        linux-kernel@vger.kernel.org, yc.hung@mediatek.com,
        linux-mediatek@lists.infradead.org,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH 16/21] ASoC: SOF: topology: Add support for Mediatek AFE
 DAI
Message-ID: <YZU75B2JHbYHy40l@sirena.org.uk>
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
 <20211117093734.17407-17-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y1aGE2SznRaFViUz"
Content-Disposition: inline
In-Reply-To: <20211117093734.17407-17-daniel.baluta@oss.nxp.com>
X-Cookie: Leave no stone unturned.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y1aGE2SznRaFViUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 11:37:29AM +0200, Daniel Baluta wrote:
> From: YC Hung <yc.hung@mediatek.com>
>=20
> Add new sof dai and config to pass topology file configuration
> to SOF firmware running on Mediatek platform DSP core.
> Add mediatek audio front end(AFE) to the list of supported sof_dais

This breaks an x86 allmodconfig build:

/mnt/kernel/sound/soc/sof/mediatek/mt8195/mt8195.c: In function 'mt8195_run=
':
/mnt/kernel/sound/soc/sof/mediatek/mt8195/mt8195.c:207:2: error: implicit d=
eclaration of function 'sof_hifixdsp_boot_sequence' [-Werror=3Dimplicit-fun=
ction-declaration]
  207 |  sof_hifixdsp_boot_sequence(sdev, adsp_bootup_addr);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
At top level:
/mnt/kernel/sound/soc/sof/mediatek/mt8195/mt8195.c:201:12: error: 'mt8195_r=
un' defined but not used [-Werror=3Dunused-function]
  201 | static int mt8195_run(struct snd_sof_dev *sdev)
      |            ^~~~~~~~~~
cc1: all warnings being treated as errors

_boot_sequence is added in "ASoC: SOF: mediatek: Add fw loader and
mt8195 dsp ops to load firmware" which is later in the series.

mt8195_run should be either global, a static inline or not declared in
the header at all.

--y1aGE2SznRaFViUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGVO+MACgkQJNaLcl1U
h9BHUAf/WPdQ1sU34pc7wXKT7HjpQzqXz6Y92JQZagFk6v6n4c5zaV8lGeMp4RJe
b7qYWE1l7b+95S89NCV2cZOTqRX/e0aikOjZp4COv6NUSx9wwq6niGVbf7Vp7514
eRbtxcUNrzrjW6ccMgjuV9J5X+QMXY6+hShIqxVFFDWuzQl0TzXFpXaZ1mb7C1gC
KQIkWxluoO20C4TSQi/TvoxSGnxIfq4dvrb6i1oVMFnMOBvbQrqPRkVs1+r+cv8K
s43s9ZjcIQkDOzVX76tMmLSb64yEP+7FJzlwIhaIaPOoMmebYpzzf8JNHE4rjti1
necJgXEnDl0sH2hhC7ZS5gv1m6qkGQ==
=WcZw
-----END PGP SIGNATURE-----

--y1aGE2SznRaFViUz--
