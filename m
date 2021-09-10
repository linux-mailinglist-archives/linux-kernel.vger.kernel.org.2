Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6BC406A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 12:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhIJKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 06:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232157AbhIJKZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 06:25:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD07C6103D;
        Fri, 10 Sep 2021 10:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631269475;
        bh=cpBCtKfoFJsBnQ3CVScmpNOH6jE9CCJ9RCK8UwFQj/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZrHss3lnb7kui0uBEWe5AxyvJ9GtTIXPYGNfC3rgexbyODBYOxrhrUVomdUyMh60
         s52WJj7MWKMY9ugTC8fet9t4XARhrKRIRn6ONglqnwMgYnRNSJ18B7bpIj3G4+OmVC
         0IkwWolEAMWoZd5PsGlXlFuvbB0YgLaQH9Sni3d4sGpB7wAd29t913C0/XBT/mO4RU
         mqS7JewfNHRalNUbxaBZ+KPc9zJ+hh5+He6mAnqzjUpmToMqLJC421KDMuDAAwjBme
         fdNeVCZdvdWe6f0fElUlr+f+dytlBDompPp3UJsv/Ch6AXBvO50dLHvwDALBy0j+Kt
         Cp9J2iwZQ6BIQ==
Date:   Fri, 10 Sep 2021 11:23:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v2] ASoC: mediatek: common: handle NULL case in
 suspend/resume function
Message-ID: <20210910102358.GC4474@sirena.org.uk>
References: <20210910092613.30188-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <20210910092613.30188-1-trevor.wu@mediatek.com>
X-Cookie: You are standing on my toes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 10, 2021 at 05:26:13PM +0800, Trevor Wu wrote:

> When memory allocation for afe->reg_back_up fails, reg_back_up can't
> be used.
> Keep the suspend/resume flow but skip register backup when
> afe->reg_back_up is NULL, in case illegal memory access happens.

It seems like it'd be better to just allocate the buffer at probe time
and fail in case we can't get it, I'd be surprised if there's many
platforms using this hardware that don't also end up suspending and
resuming.

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE7Mj0ACgkQJNaLcl1U
h9CgyQf/ZnO68AsLS2olrmP3aE2kiE4Ya+tAlitO9OKbhT1L/n+iJbKrZ4LRbXEQ
ZfHKa0ObhYErjjmvlqb4C/bpkXixnPVFl+sMv8WOMenad2nwt+ObdT59iQzEVqA6
L/mePf/Fgdda0FuauBlcVcQT0Phb275wyvLRqTDmpTiWjDLNZTzuID9rU3b5ZSWW
had8BZqHsE6PtwSFpLw2/GOhn0aqyO/4SiTiEi5qowd1abY+HhjLfVUPuhGBU8sP
Yiy/MH030ps8jfXnX6FRF+fEp+T70yy3EZWm45c3vl2hLGDSH2iCHh4IDqZb8ynv
LPoGRv5X0L7ebfy2BqkWOahDI7GTNg==
=EfnS
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
