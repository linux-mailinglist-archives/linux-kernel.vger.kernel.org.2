Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5341AFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240669AbhI1NP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240536AbhI1NPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:15:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10B3861139;
        Tue, 28 Sep 2021 13:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632834855;
        bh=q8zsXDb8jefHli+qDKUzmSjk7zAuU+saUYu7K6QdqE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0U7/zXODYsKJDxLjahmdZ954zrv9PA3YEZQeoXhvt/SzU6GQvP0aefkogDLP2sDs
         hsgklLbVKazetYod/gsmxFkzL7tlr1vGJK9GH5H6vAYLCxWzVbTbi5LCo1DwfkopP8
         9L4Wj/JCV27mquH6aGVqCereex319oSSY9PX0mUsd1W8yRg6JTurBzBOuGZWn8BWEg
         8q7vv3EdLs3Y95uv9gfS0Oj90rKIu1ZMQ20PfBmKCa6zHQoPS9ZDWkeOvhppOZhZnv
         WhIe7tXLXXAqjRSngZSvz3x5HWDL4/iskdepUkyZIJWVFwELV2sHWMi7hoi06rzj7U
         DjHV20Tysu5zg==
Date:   Tue, 28 Sep 2021 14:13:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] mfd: arizona: Split of_match table into I2C and SPI
 versions
Message-ID: <20210928131326.GL4199@sirena.org.uk>
References: <20210928131145.17159-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yQDbd2FCF2Yhw41T"
Content-Disposition: inline
In-Reply-To: <20210928131145.17159-1-ckeepax@opensource.cirrus.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yQDbd2FCF2Yhw41T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 28, 2021 at 02:11:45PM +0100, Charles Keepax wrote:

> rather untidy, after recent changes this will also cause a warning
> on boot for the SPI subsystem. Tidy this up by creating a table
> for each interface listing only the appropriate compatibles.

> Fixes: 96c8395e2166 ("spi: Revert modalias changes")

This has been an issue for a long time regardless of what the SPI core
does, and if you're trying to identify the patch that introduced the
warning that's not it.

--yQDbd2FCF2Yhw41T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFTFPUACgkQJNaLcl1U
h9A2SQf9FZE292TyTQb37BkmDlCJ7OAAtuILmSpw07tppLHhtR7Es+ZE07QLejWG
Kv8NKRQsN5JbKBY5LAST2MqzFAmUrgKreaKqN5zbrMKW8fXajNMJF1iDtfHdGz+F
NkLtSawX8tlz+IDnZFkbqOxPHGeE8wDL/Om4U2/Lr8bIoTfFn0AsczA5LuML9e8g
XLlBFqzrWl0f8O4fdo7qnhgJS2iJmRId3vPD7+Dg9G/pwBdnnQ6vfQEW88F5CL1P
h4UT2wb0AFPurhCWwdR9P11ECegqUkoNRFOcBeUL71xesPssKamcpR53aFedDeD7
+RaRsNjOlls1nPy5DnjKBPK2qu4vJA==
=gd3C
-----END PGP SIGNATURE-----

--yQDbd2FCF2Yhw41T--
