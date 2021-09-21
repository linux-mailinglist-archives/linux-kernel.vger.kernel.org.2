Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEFD413314
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhIUMD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232089AbhIUMD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:03:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AEDC60F56;
        Tue, 21 Sep 2021 12:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632225717;
        bh=okJ5Wv071gm/kqPX80JwwLPKBFkmOu1Wfy85JkuFJxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KiHMVTOb17nzr8fZcDhOLmICRm3Ht+Fg4Pt0UNJ+Qg2jcUREcDV1HVSwWlaQatRPT
         yzPgyjZ3nE3t9avSqUysWS61wLkk6jOcHWPjDFsFH+4g17aF0ObV/l7sKF5TWfuTqt
         v8Q3Ufk6LmZLmZDE0SeMTyJGoroYaWrtlPS+sVhUmBYz/lSmLw5DsL9jHqg3A2z8T/
         oOjJzctrYT071xId9PLdaKsuKrnusLLDP8ZQCd1K/zUi+H8/CtHjXjZV9lui0otPyP
         5cmjTLEDr1bRWZgzoj+vh8p0GXmHtohmtR0RE8yvhCSRsLVwBzOsoq6ArNXg9Z2Ccf
         93wgIUImozJTQ==
Date:   Tue, 21 Sep 2021 13:01:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kirill Marinushkin <kmarinushkin@birdec.com>
Subject: Re: [PATCH] ASoC: pcm512x: Mend accesses to the I2S_1 and I2S_2
 registers
Message-ID: <20210921120113.GA9990@sirena.org.uk>
References: <2d221984-7a2e-7006-0f8a-ffb5f64ee885@axentia.se>
 <ae4b25f1-2b2c-d937-e23d-0f7d23bdf0c4@gmail.com>
 <815cbba4-60d6-8d97-c483-146c2f7c3912@axentia.se>
 <7537b141-0ef1-fb44-7e02-27b4dd1e772b@gmail.com>
 <d9850534-df41-a6b3-48e2-34823f5866e9@axentia.se>
 <27f903d9-a74e-182e-b715-4124cf666f45@axentia.se>
 <8b96eb7b-8829-443f-481c-ab1772ece098@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <8b96eb7b-8829-443f-481c-ab1772ece098@axentia.se>
X-Cookie: Will it improve my CASH FLOW?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 21, 2021 at 10:48:01AM +0200, Peter Rosin wrote:
> On 2021-09-21 10:10, Peter Rosin wrote:

> Ok, so the attached works for me as well. But I don't know if it's
> appropriate to resume/suspend like that?

> is:
>=20
> pcm512x 0-004c: Failed to set data format: -16
>=20
> The root cause is that the chip is in Powerdown mode when
> pcm512x_set_fmt runs. So, bring the chip out of suspend for
> the update of the format.

How would this work if the device looses power while in suspend (eg, due
to the regulators being software controllable)?  If the data isn't being
stored in the cache then it'll need to be stored somewhere else and
restored on resume.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFJyYkACgkQJNaLcl1U
h9AcOwf5AbVSBdEhOQkB4TQMM2DFgVXIoGbmpI2PtDL+he2gx06CBr8GyNLXelfF
Kq3B/YaaA0YEX0xOlJwbZqYJBtjqCj2K0RqsTvZE/H7hQrNcpwSX5EHb4lv3E8W7
mmJRUKqVGK4mn/fhOe9+XQJkqyyt/xz8tkfu1hm8QdzBOQqtNa3bNsOOBHoR3VUK
35zbG0qaxVoTZmOqRDh8bOfv/7RroMkkEb/TEwe41DsoB8RaTgPFcXmiSayPdJrO
EHMUQ78SgY/VeWrDmXIVkbAClbNb2uUlhswfd6h0WN5utTl1WheCS2iUrtZQqiM/
Ip7mX9Rb9eu6dj/7WtnVE69TOvm9Bw==
=EZ2J
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
