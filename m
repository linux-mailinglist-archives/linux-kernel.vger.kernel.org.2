Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C974F413249
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhIULNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232192AbhIULNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:13:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06D6F60EC0;
        Tue, 21 Sep 2021 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632222732;
        bh=yyXhUn58lpN8Nc0YGD1K+xedQdRickg/qG3CoTgTXjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBLlbnASKOEDfs+fPWH1yuBYrswejvtWMO/OWVRyY+UubhdPyN6vh0rYJJDYjxPeP
         UmE91P2HcZM3n1Lzw4W4YlgjuRN1v0osSiSpP1MBqDjnR/X1y96/b8J2V8CrsIRJen
         bJYYFDkI4rkv1yTkV4bwDk2nHOCLOBCclcAXOgH6GAuXyIQCZc1NDfCddZ2dEwDo8C
         bGzz5ejsuwpAeHYqowsr2UHJ4VxNFf6r/hcHXi6GwWUoy4eTFyxBHcGbe6Lc34/5fu
         lmnftTtUc51J2xA7qlp3uL33Lg8d32dFqmc+XsdlWr4cBrr94ogeiVubcI1PuPmLke
         PDgHXOzmAhIWQ==
Date:   Tue, 21 Sep 2021 12:11:28 +0100
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
Message-ID: <20210921111128.GA4203@sirena.org.uk>
References: <2d221984-7a2e-7006-0f8a-ffb5f64ee885@axentia.se>
 <ae4b25f1-2b2c-d937-e23d-0f7d23bdf0c4@gmail.com>
 <815cbba4-60d6-8d97-c483-146c2f7c3912@axentia.se>
 <YUj9LqNTH6A4CQcj@sirena.org.uk>
 <8ee31fd2-3fbe-f5da-a030-c6b677c7f398@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <8ee31fd2-3fbe-f5da-a030-c6b677c7f398@axentia.se>
X-Cookie: Quack!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 21, 2021 at 08:37:28AM +0200, Peter Rosin wrote:

> I expected it to just work to mark the register as readable and do
> without the default value (i.e. the way it was before my patch). What
> I don't understand is why regmap returns -EBUSY in that case. That
> doesn't make sense to me. Perhaps that -EBUSY is propagated from the
> I2C layer, but in that case, why is it then ok to do a write to
> another register at the same spot in the code? So, why -EBUSY?

Actually one thing that can trigger this now I think about it is
attempting to access a volatile register when the device is in cache
only mode for power management reasons - if the device is in cache only
mode then you can't do a hardware read so volatile registers become
inaccessible.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFJvd8ACgkQJNaLcl1U
h9CJKQf+OegzluneiRTJmiVh6LiL5bpcPOvlcoNyjQ9V7XuKD3L0HAt3Us2w4Uz1
zf61Wc7v3L50DjZ/bcEvPceanzWn2NjRwQCxHX9PTskwEAMGig5ydmm4rMBfWk6F
hZFCefunu2I5armlczsLCuvPPmvIeE0fOk1/t4Ha92c4ifxyFWoB2uoe/bxLNxzH
KhhHYssXI1D142G5khsfTMkzWNOIOIecjUuaQsTCO/AgdxO5K120c81ZzFJlVcKu
GG2UcJSi3Qt4XAmfDqRgpO3r2E4DiI/8ZwPW/LZkZHkBwXvBYaOqM0ueYDTSF+Ny
sam8UqO9TDsZC674q0fTaBS5mj+xoQ==
=ztW7
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
