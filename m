Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D8352D4F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhDBPXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235634AbhDBPXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:23:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B25EA61155;
        Fri,  2 Apr 2021 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617377020;
        bh=DBl2fwgcPxtK+wafl3e+AoDL7rHOuEM2EySnkBrXa18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPHheqi7hj3Ky8QYaqiooCBeHfhVgOjQY8lrW17v6d/dx8LvnHkXrGNy79Wk23aXo
         ZbF9qnFOiimlWJiraE/MBhv/zSETlFdwGFkTYo//bBlpqRyK0IkhCtw9GlsXvlUh9k
         G9tBnGR1v4ZYMboX8Vg2HtA3O7rJ6Sr9/sd3YnWMynN9Chu+WjkVZJFubFydCk19tm
         0M0MUxD1sZmWYJHqzgOgCNrlxMcrCgkEqe4eQf+yW2hBk1G28ukNKp399u3uw9OpB6
         8xWVRnT+ezrfSVWRl8L+FQBdQd1liiWA0Z8s5iqtC6AA4qF63K60Saz6JukrcpFfhb
         MaWv53xYkTkIg==
Date:   Fri, 2 Apr 2021 16:23:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <steves.lee@maximintegrated.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, geert@linux-m68k.org,
        rf@opensource.wolfsonmicro.com, shumingf@realtek.com,
        srinivas.kandagatla@linaro.org, krzk@kernel.org, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        ryan.lee.maxim@gmail.com, steves.lee.maxim@gmail.com
Subject: Re: [PATCH] ASoC: max98390: Add controls for tx path
Message-ID: <20210402152326.GA5402@sirena.org.uk>
References: <20210402033643.12259-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20210402033643.12259-1-steves.lee@maximintegrated.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 02, 2021 at 12:36:43PM +0900, Steve Lee wrote:

> +	SOC_SINGLE("Tx Enable Selection", MAX98390_PCM_TX_EN_A,
> +		0, 255, 0),

I'm not clear what this is (especially given the source selection below)
but it looks like it should be a mute control?

> +	SOC_SINGLE("Tx Hiz Selection", MAX98390_PCM_TX_HIZ_CTRL_A,
> +		0, 255, 0),

This I'd expect to be tied into machine driver configuration, either DT
properties or TDM slot configuration - it's not something that looks
like it's something you'd want to control at runtime.

> +	SOC_SINGLE("Tx Source Selection", MAX98390_PCM_CH_SRC_2,
> +		0, 255, 0),

This looks like it should be a DAPM control or possibly a TDM slot
configuration - look at how the Arizona devices handle routing from
multiple TDM slots for the DAPM version.

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBnNu4ACgkQJNaLcl1U
h9AcQAf9HFJYiEd0KVxqnDJ5nyLgUXBD7W2RjBQ7MMluKeti3cwsaSiFHs90efQt
7wTHZWUbEl1V3FdBv1u/xe8yyCkrEBFUt5IRKh2HUcvvM7izZrfzl+Pfe3uz3G5j
+V7545xbUvIUsgMTDAGTdCjTZrjVvATyXYLNiZZKzFqrEUrT5fEWrKfoSnfO3EQG
EHC5FDmzGz8jUWOjdUo6FkFXegsLJC2pm66jmSrT4pyVGQe71cePh2O03/Ok9uU5
U5TTpQgqekU80WyOVAuJPoPiJAi1Xr/vV9H9LSlwxazeINQZDHYJhyqOhLzBtjYg
K1XFzhEKIAHt6p61no1KcnWVk9ECEw==
=k78j
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
