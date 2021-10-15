Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2741142F544
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbhJOOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236879AbhJOOcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:32:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70DF8610E5;
        Fri, 15 Oct 2021 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634308211;
        bh=AEtWb/xpPvXYdf5GA4X8ida+83gqErYx/NpU8kM27To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueP0q1Ga0z7mOhcyKp/GuEGLiCZThinNlPsNosw9QnHZaOMvYTqeJ4lwBMzuP68vV
         GgEVup4n4FW2P7NGUwUyiygSyPT4lg5tl9tM4cljUmC9AYEyKRQhE2VIYqCM8315pB
         DzyyXz9yelcP9M5njE+39pYX7w8RSLgwalaSJbCqN29U54OJStSQU10lNR7Af/ERZQ
         W7sbJRdE1FRiULJJrxhDKIE50jsaR1IJbx533jER8wUbGTteia+vy8x1KmhZ5B1KPE
         y3UMpKckf4vipJ68+B/aAdlmt5Ht6NSJPuiFcvc7NNkLwVE8q9NQGKamq1RQQI2dTB
         fZYFB28Gf93aw==
Date:   Fri, 15 Oct 2021 15:30:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 06/16] ASoC: cs42l42: Reset GPIO is mandatory
Message-ID: <YWmQb8oudyZr8tsz@sirena.org.uk>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
 <20211015133619.4698-7-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jSS0e2uIyUoUwoHo"
Content-Disposition: inline
In-Reply-To: <20211015133619.4698-7-rf@opensource.cirrus.com>
X-Cookie: I'm having an emotional outburst!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jSS0e2uIyUoUwoHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 15, 2021 at 02:36:09PM +0100, Richard Fitzgerald wrote:

> The hard RESET must be used to correctly power-up the cs42l42, as
> described in the datasheet.

> The code was getting the GPIO with devm_gpiod_get_optional(). Change
> this to devm_gpiod_get().

Does that power sequencing have to be done by the CPU though?  Usually
if a GPIO is not supplied it's because the sequencing is done during the
general power up sequence (PMICs can be programmed to assert GPIOs as
part of the their sequencing for example).

--jSS0e2uIyUoUwoHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFpkG8ACgkQJNaLcl1U
h9Dyqgf+LJrZXj+uSKJIZ0JT5Qh4ifQCqaIfbbYyPJ4Bdnq2KyOv9i8KNczYj8sS
yfb2lRfd0I5iFDg9gKshaeER4HsgD/AetI9Ndz+AI4pYQHtyj7GEU0jj2rw4jQbO
EgjqNobNWM8BkIbwZf4de/e7oL44wlgq4REspzgFUDO7nfbsfc8y5F40VOSeLbat
B+tv99B7EKofPRlx6gFVdXdWn5LW//8SMyDcFpRqLWX/iKeYBcPGc/P9Q2NCIi1Z
+Xz9J4XOZ3VH5n2nXrA7E9GYYM7G0s1er2tJs7pXFW8k5RPAD+ONMJ/bPz9flX/f
7eKJLWkhyRLt5F8ekZmY7nNPNJBERQ==
=cfD/
-----END PGP SIGNATURE-----

--jSS0e2uIyUoUwoHo--
