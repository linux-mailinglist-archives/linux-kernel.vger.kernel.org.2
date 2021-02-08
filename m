Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD53132C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBHMwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:52:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:52026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhBHMwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:52:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E12A064E75;
        Mon,  8 Feb 2021 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612788684;
        bh=9IjLVP5T0wUUCJwwqwgMjD3RIpZbFWCwOIuAE4nRasg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8K+ouHPGUQOgK/g4tivJy/BBRC6Sv9PuuYidu3jIhAre2qW1Y2NoXAbOz9O5K1ED
         OZyrW+hL/FYm7j8DJb51+0w7hm6G+CPkO8d7jIzCKII9cI0yvuesP4G7wcmJTxzEYA
         BDfumCYMaSq0e6ck9CtFw/5jh7cVKE3+Lk02iStv7P5A5KwgmXrNadLjeBHIfKwJ1D
         TMcPMkG0Or6S5tYFWC4oyihVZGLScMG+jwqfYtrlquaoEWI4Hxe4MPY5HN0Bfh7jAB
         HUS/ATt2rzlMxNhU127Lc8bFeXehepYdDChharTda7zf1FzT921PzTBohwMIoBwm7i
         EpSM1Xaa+MBQw==
Date:   Mon, 8 Feb 2021 12:50:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [RESEND PATCH v2 0/9] soundwire/regmap: use _no_pm routines
Message-ID: <20210208125032.GF8645@sirena.org.uk>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
 <20210206102644.GN2656@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline
In-Reply-To: <20210206102644.GN2656@vkoul-mobl.Dlink>
X-Cookie: You will triumph over your enemy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 06, 2021 at 03:56:44PM +0530, Vinod Koul wrote:

> Applied all sdw patches, thanks

Is there a tag I can pull the new APIs from?

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAhM5gACgkQJNaLcl1U
h9Cn5Af/QPKks2pyEPXbJqMyKyRplL9nrj8AmVJjIcza+PjXIXsc95fjt9WJw1w5
QU5WrskcCm35zqvOOXyjW9Isn2LYK41MblnPE+XAEofNsNSAWwCqnGMR42frS/nm
SF4l02Q0nuQEz6Lf7042mvYV2qS8QecMNnDlLHfo5yJCp0irtBBF0WWqi0GRPJ+0
doyhiUzpnSaR90cf5UgQe8CoNJdD9zbU+xmN3lKxP/7dgl18RdAiLs3nxdiRGPX0
e/M113XNYKBB8CxeP+/cEkWK7c7+0exz5dHfaus2VfLXMMjSD+Fym+9P26rI5iZ4
CY3U6idFm8VnrEhRGm6JrIBVlztFOQ==
=ueCe
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
