Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208B04170C3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 13:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245351AbhIXLWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 07:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245092AbhIXLWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 07:22:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44A7D600D4;
        Fri, 24 Sep 2021 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632482446;
        bh=t8L2IVDl99/kDqCoaO6fJS4u+P0lrqCcTLXv8CeeRJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOcSzmO4XYFajFL015M7WW9tbo0kVDYSuOrKRieZj5QMho0OwOMHAmzQ823EGSP7z
         DdjuS0FzYiUx43KmjJ1KS/sLhfJx5Yes/wsQgaihkpYydAKg2GJ/r5S9+8rFu406wf
         djotY5xJLeijjhhHk8E4o/JgXXHJI+M98HSEGsk67znC4RhxWkcu+PXdTUYUQbPppk
         xPruIYBGTgKWUo1WfZatUp0ZMSizTVpCVqyzluRT84t5QhXwcb81cVOOx7t2lLNcMs
         +52xKYkOV2UmrysSNdRDUntbdXHN2IqgKV2NBzk0i1c87+DhWO7ag1q2UyPuGKGz8Q
         301tqRLvG3ccA==
Date:   Fri, 24 Sep 2021 12:20:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v1 2/4] mfd: arizona: Add missing entries SPI to device
 ID table
Message-ID: <20210924112000.GB4840@sirena.org.uk>
References: <20210923194645.53046-1-broonie@kernel.org>
 <20210923194645.53046-3-broonie@kernel.org>
 <538c0c79-d568-be03-e524-01f5c6429554@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <538c0c79-d568-be03-e524-01f5c6429554@opensource.cirrus.com>
X-Cookie: Are we live or on tape?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 24, 2021 at 10:24:17AM +0100, Richard Fitzgerald wrote:
> On 23/09/2021 20:46, Mark Brown wrote:

> > Currently autoloading for SPI devices does not use the DT ID table, it uses
> > SPI modalises. Supporting OF modalises is going to be difficult if not
> > impractical, an attempt was made but has been reverted, so ensure that
> > module autoloading works for this driver by adding SPI IDs for parts that
> > only have a compatible listed.

> >   static const struct spi_device_id arizona_spi_ids[] = {
> > +	{ "wm1814", WM1814 },
> >   	{ "wm5102", WM5102 },
> >   	{ "wm5110", WM5110 },
> >   	{ "wm8280", WM8280 },
> > +	{ "wm8997", WM8997 },
> > +	{ "wm8998", WM8998 },

> WM1814, WM8997 and WM8998 do not have a SPI interface, which is why they
> aren't in the table of SPI IDs.

They're listed as valid DT compatibles for SPI so will now generate
warnings on boot, the driver should not list those compatibles if
they're not valid.

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFNtGAACgkQJNaLcl1U
h9D2WQf/eTTq2Hocs/KfMqObp+AeluMMwH+MICNpX08gwVxATkmWLlvKc94QFsHM
13sUYgtR6z79/iBRnkUni/UAwly7+GbEX6oxkL6icY06XB/wxXH/k2lDWODrS3tm
ga9s7OTXzarzcq+UTH4UH1EOrgXk+UNKQj0TnrFL1pal8ncVBfdtHX4eZajIa0SS
+dOHE+2BdORdbakvhAxmK7LR5AEu9HrTMJHKKI+QqBMnJCrYlBx0IesM9k+PR/q7
AREOCim9TZCm8THMQHaP8WbuxBVuWTHwnfdll0N6yuctwrlBA9P75yA2qKF93tT/
1mThFAGQcdSYPFQmhVaOlNDfQmtKbA==
=tPuv
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
