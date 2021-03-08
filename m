Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6844A3314C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhCHRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:25:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhCHRZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:25:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 705F5652A8;
        Mon,  8 Mar 2021 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615224320;
        bh=b6BRR50HzmVWmrotn7iSHieZh+VlfjdpIW3Os6BAFLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q05+R6QvIbOWHvQnLt40wPncFyjcTkw1RsV89WPmkcT+m7Kz8NSFneI0M3KzgGXBM
         TM6lXkvvvyWn8d9Oy+yGow9kvhLaSuCKraoZLV+BDk0swrxlSjM7ZpI4w6U7w/KZHe
         DMad0seUgaPb70hP9nd0ENcVas5MwnP04IkzTI734mwQMgVxMZmZeQe50c4w2iw90Y
         L56gml9uTuEPmW1CEy3FkpzqBQmFnNRqP6kEJTWrKkrDPT6E7Xs9pFfakyPUr6/9zp
         WMVlo6GzihqDePkx1SY+28OcS0bFMzwJLVlUYLl2hlfV8nMMYt4ktBm5xSJzq6BYb+
         kFgrfHGLje64w==
Date:   Mon, 8 Mar 2021 17:24:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Perry Yuan <Perry.Yuan@dell.com>
Cc:     pobrn@protonmail.com, pierre-louis.bossart@linux.intel.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        Mario.Limonciello@dell.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control supports
Message-ID: <20210308172409.GF4656@sirena.org.uk>
References: <20210301093834.19524-1-Perry_Yuan@Dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline
In-Reply-To: <20210301093834.19524-1-Perry_Yuan@Dell.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 01, 2021 at 05:38:34PM +0800, Perry Yuan wrote:

> +	/* Micmute LED state changed by muted/unmute switch */
> +	if (mc->invert) {
> +		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) {
> +			micmute_led = LED_OFF;
> +		} else {
> +			micmute_led = LED_ON;
> +		}
> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
> +	}

These conditionals on inversion seem weird and counterintuitive.  If
we're going with this approach it would probably be clearer to define a
custom operation for the affected controls that wraps the standard one
and adds the LED setting rather than keying off invert like this.

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBGXbgACgkQJNaLcl1U
h9AXRgf/e2ciVQlrAlmLa8m9QF1UsyV9296wawACwZFQLD7Wt16EsjqSW/c0tHDT
U3IeVN5wCG+DIO5MpG+BefiEH/tfqZXeokAwcK4kVm1WsNgDRK9yF1qJNmGdhEvg
iCTKDjBru0W/Xy06ETNZkDhnOm/YwTaZ/K8qn6XmVJaNaPioK9eWT+H09K4bnjdb
Kns45ThVDbzr2pBbO7LbMcE07oIGlZwbnoy4E0LTKYkZeVeM8RGAYCoYj17Npekc
Oe1SyE/KtHeZOeUMTEzxmj5NVBcvfsA/L0dD+OwlBrrsxZuxCe+t2qOV+WX2GmyV
FvF4wwH5rWLCAiJU6as/F2FLQBhnAA==
=JdN1
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
