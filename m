Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DF7315BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhBJBMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:12:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234407AbhBIWZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:25:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64C7764E56;
        Tue,  9 Feb 2021 22:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612909463;
        bh=7kfxLK78PvfigA3R4+VMbeoeBXl7l9q8dV+Npd79hmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bytmFa9s0GNPrj/vhul83Yqfc3J2cbXfknvlwBAwsnb9RN3uOX0U7HT98gqG6CwvO
         v/MzX/xnG504FWaN6fs4kkZPHH7xYxyhfTrwmqsN01qzlR5OiLBihoJXk/cuNL1vl3
         BRqfW8oTcoQHRV7MlKZOETUvNHsRyXEMuR0NXtNj3DbPjXvzGgYGFwPcOEdqC4i3zU
         GyGkZglpS+dtRTRlKy0xv3HpibI0MX10PwNGuX+ThaeG6cIMdO/L1VvhzY30L4sw1n
         8G8oq5BU+KTGQ6wdqAYpcScn+OM4Jq50T0zHrpDpUUJ+ILUc/5DEaTZR+zUjfEvTxa
         W81VBLUwB4T0Q==
Date:   Tue, 9 Feb 2021 22:23:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-pcm: change error message to debug message
Message-ID: <20210209222331.GD4916@sirena.org.uk>
References: <1612771965-5776-1-git-send-email-shengjiu.wang@nxp.com>
 <b7f5442d-ad21-eb8a-7d90-7a8207320541@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <b7f5442d-ad21-eb8a-7d90-7a8207320541@linux.intel.com>
X-Cookie: Put your trust in those who are worthy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 08, 2021 at 09:06:44AM -0600, Pierre-Louis Bossart wrote:

> If you demote this to dev_dbg, we'll have to ask every single user who
> reports 'sound is broken' to enable dynamic debug traces. I really don't see
> the benefit, this is a clear case of 'fail big and fail early', partly
> concealing the problem doesn't make it go away but harder to diagnose.

Don't you also get the same information out of the DAPM debugfs or did
I misread where the error is generated from?

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAjC2IACgkQJNaLcl1U
h9DwFAf8DLNKdQrHOYHHu+fNRUcqtMVhFvVVF0+cfmG9XU5BbkLm99NYsC1DZXFR
gesRhVjscehAl32rdW26yebEpK25sZ/yivEnPTmgmk/Y+jRzGRHQhAu2wowQtBlO
bJrqcsb72F4oYduMlICmRI9cya3AnWDwlQh5tX6iaYoQT28jM/KqtN0SYWQl9b0Z
ASTnP0KDq9M8nb5PftaVzKa7QGw+owjzxg5aZoEdqs1GuBFJOXJFQKk22b3vUl9S
OUb9tqhjJckUoKWm7mMs5lF3TI6nZHXxRuvBKPxlgLmfyYUkf87ld6oqGzKF7Av5
wLxjnJveFW0YK1Pmj4Es65nSBVdTOg==
=8ykL
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
