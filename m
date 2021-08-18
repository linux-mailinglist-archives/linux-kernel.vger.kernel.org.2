Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4951E3F0344
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhHRMIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233061AbhHRMH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:07:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 539A160F58;
        Wed, 18 Aug 2021 12:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629288443;
        bh=6PiupebDXSJROvJfhgJanrhOdurpeH4omGhk2uoLVmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnjVsNFB/vyNS5JJ2Vxi7yBLVPp730FtDqtNUCEZwQf3V3is0+w5TIZDcxwnD6wU8
         MQcdDtCKuzvByhw5W9nrnrRXYPGIYxQQEt3xAlNF8UXQsD3kyR3W02v1psSHef3TFP
         NY8gHSDa3Dj2N9QOBo5J8e8DuYSaWPQy+YO5M5DChB8LvQ2Eib+UW8oRp7OnRdjHyW
         3mGpG4mqCvtHdTvlTwJFSn/gvauS9Qqbtxmq+kbqh1SJQWeN5NNWGQa7RiVOIKCPrj
         Ohe61T+omTzdomT6WbKNRYU1C4cM8SWxupJzo2FcMLBjoXWvnX9yOo01su20wazPBk
         yBIQY5tsf5uUg==
Date:   Wed, 18 Aug 2021 13:07:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
Subject: Re: [RFC PATCH 2/2] ASoC: SOF: trigger re-probing of deferred
 devices from workqueue
Message-ID: <20210818120700.GB4177@sirena.org.uk>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20210817190057.255264-3-pierre-louis.bossart@linux.intel.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 17, 2021 at 02:00:57PM -0500, Pierre-Louis Bossart wrote:

> +++ b/sound/soc/sof/core.c
> @@ -251,6 +251,9 @@ static int sof_probe_continue(struct snd_sof_dev *sde=
v)
> =20
>  	sdev->probe_completed =3D true;
> =20
> +	/* kick-off re-probing of deferred devices */
> +	driver_deferred_probe_trigger();
> +

I think we should move this into snd_soc_register_component() - the same
issue could occur with any other component, the only other thing I can
see kicking in here is the machine driver registration but that ought to
kick probe itself anyway.  Or is there some other case here?

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEc9+MACgkQJNaLcl1U
h9Cr2wf/S8qlM4N0JWIvZi7CnLhjjIa1inDcejhDhF6aDSXP6gDFHmGDK4OhxQlK
DEUOhSBihTPTAXLvenYyDTli/yFrIgBTOo/t+w0to519OkfZG6/81SAkYhABSUau
y7J4dhO4eek/QqkG5vBywhtHBIRwV3SfVludEZGjxp8TZ+jqXgsZffAt7Wv3TOF1
L4g+Ska/mS6uRNZBiK/Vhdrh16i1QHMF3RGITcV7tkNao2apxdmy6kfqgoOZjYqy
QvkfkRJVrsDAgz+MkqPCr5L1LzkdDvfd1eprBtJ34Qdz/++Cp98XdC6xkBo7d7yh
XAuqs55hifZNeYfaKq7a0X1ZSjaeQQ==
=1j3q
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
