Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0DB39A15B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFCMqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhFCMqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:46:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA11B61359;
        Thu,  3 Jun 2021 12:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622724307;
        bh=/0PErPiivKve18T5PWrNZSDblM4Yr8THdIMojDFkKIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfNLIlaHMkXy6z2Nwq1e62IgDvqFsiO17qMHNj+BAuK2eBbID038FOpOVRQg+VmnD
         gmLsesbPwihI4Y/q1165NFrTqwMWmXUeK56e/fiyQXTNL7RiuoG0YJjJiFyNgKqjnt
         ZsZYJZGbapXCve5ek6JvhtPxuHy4kZqQA6z5NAK9ou5R+n6M+aqxW17tR4VD2Azc9m
         4MRRnNhNo/pEngG66YpM4ar12j3QrXpHPNzabijjh2g66ra2vas1ZIFTxdQR41m1a6
         7RFq/PLwuk6oL+9eLZXZpBnbllg0qzBx+7yLE11RrgkubbjjFVf30Lp2cGf+ZQmUXs
         fT278QpB+0Rog==
Date:   Thu, 3 Jun 2021 13:44:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v2 2/4] ASoC: codecs: wcd: add multi button Headset
 detection support
Message-ID: <20210603124455.GE4257@sirena.org.uk>
References: <20210524110700.27077-1-srinivas.kandagatla@linaro.org>
 <20210524110700.27077-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <20210524110700.27077-3-srinivas.kandagatla@linaro.org>
X-Cookie: Where am I?  Who am I?  Am I?  I
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 24, 2021 at 12:06:58PM +0100, Srinivas Kandagatla wrote:

> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(wcd_mbhc_event_notify);

Why is this not EXPORT_SYMBOL_GPL?  Same for the other symbols that are
exported, between ASoC and regmap I'm not clear that there's anything
useful that is usable from non-GPL code...

> +	/* Report insertion */
> +	if (jack_type == SND_JACK_HEADPHONE)
> +		mbhc->current_plug = MBHC_PLUG_TYPE_HEADPHONE;
> +	else if (jack_type == SND_JACK_HEADSET) {
> +		mbhc->current_plug = MBHC_PLUG_TYPE_HEADSET;
> +		mbhc->jiffies_atreport = jiffies;
> +	} else if (jack_type == SND_JACK_LINEOUT)
> +		mbhc->current_plug = MBHC_PLUG_TYPE_HIGH_HPH;

This would be more idiomatically written as a switch statement.

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC4zsYACgkQJNaLcl1U
h9AHcAf+MAkcShDyOY9iT0Adnp0ijXBX3S6aae7O09/0QaNOvBIWj8b14Iokai81
8r5zFAdH/G8zkVmTIsqEZBZL/3qOWFKUy9mmOIuNkiAAUvoDUZr+Bsk/qcca+SNu
kdlOcue5k8z2We9SBIvF6kxV9LXH4eSw5Le0mJCqEP+/Bj9gViF/EWiOBaJZNJPl
f41hiDlJuG1PyKpDw6OFsulvOtOdgVrBPC+eJThbgi0Ox+gL8BPil5iznwVOuMd1
ca31v0Us5t8lF/GoFCmUgM+7J8k5JKk/LPvSph2oIPXWucW2xsyPLN0va5BPM7/7
y8OCKNeIUnX5pIRwldewtdbEaKa4YA==
=46e+
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
