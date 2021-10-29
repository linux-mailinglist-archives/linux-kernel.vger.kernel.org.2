Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4A4400E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJ2RGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhJ2RF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:05:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA8AB60C4D;
        Fri, 29 Oct 2021 17:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635527010;
        bh=+aEPyNOmqtbPjDTbpU+vjv4p0Wjy/OBh9cRtgzsckiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cvOMzC+WvvRbbBbN3bcKsocHcYUYD296bxbwkfDAqgipXFA8t0/0Rud1wqyxZRZlD
         YwXLkt3Jqv4dgpHfWxT6MWiTn9C4YuZalm5PFBiFuEjmOF7z0ILCXahlvjdCB9n3a+
         NJpZ+5K+IE4iQNqLLnwG4yobUavshW3i7I6KMF7WSA/Rb66sv7+W1w+PzVDvblUefO
         dvuF6+qwlHCQVWRzPv1Pg72a1LomqpUw2qTLNiYttY7fHG8dfTGDEN47zRtqYCEb/S
         SbAOZwgsnAHIjPfWhsj3Z+ISEoU2lEfk7/pG7yTVHQQ8cdNjC0Pd0aBpSpmOAuhF4t
         GHdfAsVEYeXgQ==
Date:   Fri, 29 Oct 2021 18:03:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs42l42: Add control for audio slow-start switch
Message-ID: <YXwpXedltzt1ykfc@sirena.org.uk>
References: <20211029161305.12714-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hL5c6N7Mka1PL2FS"
Content-Disposition: inline
In-Reply-To: <20211029161305.12714-1-rf@opensource.cirrus.com>
X-Cookie: Dr. Jekyll had something to Hyde.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hL5c6N7Mka1PL2FS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 29, 2021 at 05:13:05PM +0100, Richard Fitzgerald wrote:
> +static int cs42l42_slow_start_put(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	u8 val;
> +
> +	/* all bits of SLOW_START_EN much change together */
> +	switch (ucontrol->value.integer.value[0]) {
> +	case 0:
> +		val = 0;
> +		break;
> +	case 1:
> +		val = CS42L42_SLOW_START_EN_MASK;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	snd_soc_component_update_bits(component, CS42L42_SLOW_START_ENABLE,
> +				      CS42L42_SLOW_START_EN_MASK, val);
> +
> +	return 0;

This should return 1 if the value changed.

--hL5c6N7Mka1PL2FS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF8KVwACgkQJNaLcl1U
h9BpCwf/QA87MrTLPKUg4QokHNEUHtqN8OkGgKlM2g2Tk77vRbYrRuVkpcVx679G
cY/zSKPSgPpU7p+PDv/FNHmZSg4g5NKpql2/qsXEW2EmUR4CTBK4NOmB8mwKekmE
3in6/AaUFQeWFroY7KT2c/GeFB2MSaBpV+h7qMZcMxqOR7tbgX/tPgnzwJU+NK0i
ZUFii+COSLgIwSUzRUIeKSeCYBoexY81Ry60B0R16R2uZtPHh99zw0NfBsT+55Jn
T/nlnZsQBhr66FJm/pSMVuip+7dFrcoS/Bc4cfiWtWUvNodnJaYxNRufwlKD4UBm
ZG2IExXYAEIzJsQ7m3xanTIyIudmPQ==
=xpuZ
-----END PGP SIGNATURE-----

--hL5c6N7Mka1PL2FS--
