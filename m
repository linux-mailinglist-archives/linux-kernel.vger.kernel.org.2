Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7F3FFE30
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349093AbhICK3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349004AbhICK3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:29:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0A9F60F42;
        Fri,  3 Sep 2021 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630664891;
        bh=ALG3HBZ9tMQQ6qp3LSaDocNel4wVrD8EJq5572zXA88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5uCWSMTuLZKnKr3JueXqz5npeRN/+ZOf3V533ybH4gOlXF1Y0jVY8wwL//GJ8PGZ
         ngu5lPk7yfnl7JPeIji789+vVpbLNweKtHrzJdvHpe5aFdxgwVy9Z392lUjiN3JTY+
         /zE8YTn08AkW0YgKvPHeCI5igSRlsoxv7Padu+5pTdQRdzaJ7+f3ZK8PFfNpla43TQ
         3K6yO3zPfxX8fNQ186yYGmBvFsW1YwlmfPurwH3hsp9KyjR8GMtp7DLAaT/aq7XrBK
         jVc+PL4ehUksCkuhNrI3icy0TGfATyMXcmGz62ZCtqnjM9NgBfajjWk0sdY3wPjli5
         Hy6zeHzLFWgeQ==
Date:   Fri, 3 Sep 2021 11:27:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: Re: [PATCH for-5.15 v3] ASoC: Intel: boards: Fix
 CONFIG_SND_SOC_SDW_MOCKUP select
Message-ID: <20210903102738.GB4932@sirena.org.uk>
References: <20210802212409.3207648-1-nathan@kernel.org>
 <20210902181217.2958966-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20210902181217.2958966-1-nathan@kernel.org>
X-Cookie: Darth Vader sleeps with a Teddywookie.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 02, 2021 at 11:12:18AM -0700, Nathan Chancellor wrote:
> When CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH is enabled without
> CONFIG_EXPERT, there is a Kconfig warning about unmet dependencies:

To repeat what I already said in this thread: the reason this will have
got buried last time is that you sent the prior version in reply to an
old thread.  This new version has also been sent in reply to an old
thread which almost had the same effect.  Please stop doing that, and
also please pay attention to feedback.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEx+JkACgkQJNaLcl1U
h9Darwf/dMsP3sJkQI3zmuNnqYAH3Su2md52c3Q8zXiu6wWBT0JpJknJxExFVYFU
mpeCrDO3SsDPVkp+96ou9pIsEEtFY+cFb3bjI/jw3OLfM58bhuJHa9RmK6ysgGDy
3MM5VbZ0qKNMVEHJxSZvvPTFIWTg8ka07H77y7wzhAmByKEnRxMcRHoz/rGkp9dA
3Bv2o9gXcNTeIV+pi/f7rPvqPOhFmcgEtDfwVfG+xroYbVA6Qc9kmuOiq0tOgr1q
2a0g4/zmlo+iGdA/O0+vXZpvH3a+pPKBW34td9d/J5BDZjn7SFevEcJiDGfinlOb
4KJpG9My+1VJxwp/YXclvV8JER8sAQ==
=KVUM
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
