Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8499933B140
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCOLic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhCOLiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:38:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A999764E61;
        Mon, 15 Mar 2021 11:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615808294;
        bh=8gXgJowDrl+HwLckEpzI7NxazwDx7AH/kUL5bDJHzaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LvaKUSUZ7wgU+9vKyWh6C4gR6Lx25AnBt43qqiHvhp/6WCOld2p6OoM3u+E5291A8
         oknhEqnL2gFxHUHi7WUGwYTx4rNBQagBm/JkyWdDGnr63B/GbUMHeVheptFG6fhtY3
         tEhnXz/4KAvlEuxQoPiekyLcKI0gVPESczWslUh6FGvwoyxYuWU6jrABLHhhisxNHt
         60FKuPbuhsfY5/E/F6jd5vE/NEflwKzjm7h7REnCR3WTbOpTNBCMhFv7H1p7Ikjh1d
         AIHgIASX/5E4sltAxP8GURfXb4ouGAwosThhvh3dF29liwLpZmTTNy0x3YmLJnydBX
         HDsnFWiM0cwcA==
Date:   Mon, 15 Mar 2021 11:36:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: soc: codecs: Remove unnecessary THIS_MODULE
Message-ID: <20210315113658.GA4595@sirena.org.uk>
References: <1615623786-16302-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <1615623786-16302-1-git-send-email-wangqing@vivo.com>
X-Cookie: Close cover before striking.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 13, 2021 at 04:23:02PM +0800, Wang Qing wrote:
> As THIS_MODULE has been set in module_platform_driver(), so remove it.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBPRtoACgkQJNaLcl1U
h9BJSAf/eVvdpF1V9OpXSWXBOkL30BgGpsVL+gnWp1HqwDm2w2UTToMWSwAmAX2T
y98sKx2z4zjwKhL3WpA3TmCJkMe9b2zlwSYo34aFVBUoZjgBm8PnkWdnI1u+rCnd
+keSrOMkunuPSQSaxLg23n2riViyUcTZ7kJs15Lvlt93Y5jG1UooUSB+Pkb3h03A
LQp7YCNq76JmS9FtDrbb/S80P594qWpKWDWTKFZD1TN1CGRRLVO9XBkMRbj5cP+g
eRaSP3E8EjmU3JhZvVNDqDhcYM7DhBu/2iKT/h70sb6Um6GETXWViC2UlyNIjPO8
vS2M9KBz25eWZtWgIvP1NGysSHXjSw==
=zA9T
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
