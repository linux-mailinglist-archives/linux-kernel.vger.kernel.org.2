Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF98356FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353421AbhDGPQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232221AbhDGPQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:16:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5764B61222;
        Wed,  7 Apr 2021 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617808551;
        bh=94PRIMWG4V3sgv4oARYxnmjhrvLu3NubLdmmO0Dgjuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BF4g7p0GvM/lL5494Bp3z0or+u55EH1ofQEvNHjxLj+3XFtOLnH2ISD6pmDUnUq+I
         gHc6wiOwVnWBBjROSmxmEaPuvwrp6DcXa5bIjh3wt5+fMj7OCH101qsGf9hQhIsV2Q
         QIfX4rbNgx2fI4DZ+ET4nYzsuXX8z1FLgecYf0yZpybvjzQFDrDKMM+uqKUOVUxQwP
         0gRQX1u5wM0ZV1ly4QlWEuzuD53BmxKwIJ5YiXHZSGafS5a8bI765b+sJddaXfL81F
         tnZB8N/hcv/RQrQNyzNfv89gpLntv/UML2/GLiJ3qGVRfolY0V/Y5VzJw2VsAUJ1L6
         y8MSVCCUIPiew==
Date:   Wed, 7 Apr 2021 16:15:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Perry Yuan <Perry.Yuan@dell.com>
Cc:     pobrn@protonmail.com, pierre-louis.bossart@linux.intel.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        Mario.Limonciello@dell.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mario.limonciello@outlook.com,
        Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v6 2/2] ASoC: rt715:add micmute led state control supports
Message-ID: <20210407151534.GE5510@sirena.org.uk>
References: <20210404083159.1620-1-Perry_Yuan@Dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline
In-Reply-To: <20210404083159.1620-1-Perry_Yuan@Dell.com>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 04, 2021 at 04:31:59PM +0800, Perry Yuan wrote:

> +static bool micmute_led_set;
> +static int  dmi_matched(const struct dmi_system_id *dmi)
> +{
> +	micmute_led_set = 1;
> +	return 1;
> +}

This isn't how we usually record DMI quirks, usually we'd query once on
probe and store the data in the driver data struct - see other users for
examples.

> @@ -358,6 +388,7 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
>  	unsigned int mask = (1 << fls(max)) - 1;

> +	dmi_check_system(micmute_led_dmi_table);
> +	if (invert && micmute_led_set) {

This check for invert is odd and could probably use a comment.

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBtzJUACgkQJNaLcl1U
h9Dpcwf9F6efsgl8SxB48L2h93SnAp+aXJZGvsihl3talmxVNg7zmoGcUoHsDMU8
Q48ZaYHXa2Zehw7UMpBlQ1Iww60W43c3yVSv5xS9C5FZdr7pvn0fjVhVX121uSTt
BeTI2r8BH0ndjb29prof+duUTHGBx+I81NjAC7aK26EIcnkHZqREM1dhVbJtSd+I
p+ofEZVpTswy5qECN1/JtYf6QvlRJ3x0QOCaq8E4Sj1URTRP3NCMSJH9h/WaItae
sJvELh1IcUMel0ElT1TEtf/fgDZVgiQh3PmRkA6qtrqturKrWSw61T99EE80Rn7j
ZsK6s1vQEXo5vslhtx5JoOGtK8wDTQ==
=w3kO
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
