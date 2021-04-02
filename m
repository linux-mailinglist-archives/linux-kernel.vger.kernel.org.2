Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2636352E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhDBRcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236138AbhDBRbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:31:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 082B261163;
        Fri,  2 Apr 2021 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617384674;
        bh=iqRDoNodRQB7OWPbPJyHieAWF1j4D+sJWzYZvN4W8kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jfdhuz+kjBnI7TtaHPc7rd/5hockdNuJ1I+aB78nGXQZSxEPjPxuWYEnR7WPMUlHF
         xZpRR+uujs+V1v6FOXTvQssutkfs4egkuV8HVqpywTigjUdBD8BeKt/2SwLgaKH41l
         50ColL8MBHpyF7T66FoBw1Lj4ExF/Yy0YvHPxhoJ0g6MxctN+4In/BhfqeWUH5Amaj
         h7wcNmFhF6fdSudkxDR0qjaw5AvYsuZtZdCE5DmTyBslhmQ6pVg1bgObLMEMcUvXEj
         mcxXxWa8vz3rbOgnxy6EH+hKmfLmxTH4NhI975xbvaEMOC/I4q/GjxnuqClZAj3cgm
         H/TavBmxEG3tg==
Date:   Fri, 2 Apr 2021 18:31:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/19] regulator: rohm-regulator: linear voltage
 support
Message-ID: <20210402173100.GF5402@sirena.org.uk>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
 <de0516571f78ceded6ca18873a96b7d95008ede1.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline
In-Reply-To: <de0516571f78ceded6ca18873a96b7d95008ede1.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2021 at 03:58:03PM +0300, Matti Vaittinen wrote:
> The helper for obtaining HW-state based DVS voltage levels currently only
> works for regulators using linear-ranges. Extend support to regulators with
> simple linear mappings and add also proper error path if pickable-ranges
> regulators call this.

Acked-by: Mark Brown <broonie@kernel.org>

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBnVNMACgkQJNaLcl1U
h9DYSQf/TQwMujZg1KX/1Vru7BrGiWwESwGDSwi9wVm8+z7HmX++J4gjKA76UYxa
Gn4DsTbs90rqmuK2ezeBfjZ4ebxvf+LIkeYNNNW20A4NPb1dZ3SZXSMMOFfV/I+/
kEQ8neU0I9v5zhuYXdJG7tfjvEqR3TsnOpioZaUjeeAqczNz38FROXgA5jU2T9EW
OYjmr4LQBqOBLgLiLMNcb4fhTqPhp/Cn77jm6EvfkFXf8DlhOGk0H4ibfWtveXrd
0jY9Aed/+MbdF6m6lI+oOU/nBrOZbEDMGyI9tM3FMyXq8z+P68Fdfu47xF200IhV
ZTT6sp1FoEb0DY12MBjBDzMwfL8qvQ==
=M+2X
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--
