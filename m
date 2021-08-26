Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00C33F8931
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbhHZNmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242241AbhHZNlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:41:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E5F060ED3;
        Thu, 26 Aug 2021 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629985268;
        bh=d6cWKlulQYuYbLxO50RwaiPqpKO52JhiP3U7TXUlBuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjXw4uS6+K3PFT5NV7+MocAxwQO3NA1gfwxtmz+SkfzyWhZcbX11TEwbyMEisRM90
         0GZte+c/egAUU7vifTlb9Qwio1AgFKouKAQSuTY10Iw618uvwuFthJFAyS/VwOxEy/
         klTkEEcbHuIDWnQ6al8BXF/HAhpQWo2AerGgvY0pQBhFJADjRFNy0N4sk6Ykq0WN9N
         oHx5jYjThslXfgHlrJJCqO8q6JkJzTFWjrMRjTLNZ3KMyrYKcR6V99pFfiQ1QxSzUI
         eLp53NPSnGTGhmEQw2PnCbHx5TX+ALDe26JVjlxVNLWsvYzwgwG35fUZhGpY86s4a5
         wJzNmBWLYIbUw==
Date:   Thu, 26 Aug 2021 14:40:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Esben Haabendal <esben@geanix.com>
Subject: Re: "BUG: Invalid wait context" in ls_extirq_set_type
Message-ID: <20210826134039.GG4148@sirena.org.uk>
References: <20210825135438.ubcuxm5vctt6ne2q@skbuf>
 <26de7b85-e466-e9af-077a-9d1dc087e061@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gKijDXBCEH69PxaN"
Content-Disposition: inline
In-Reply-To: <26de7b85-e466-e9af-077a-9d1dc087e061@rasmusvillemoes.dk>
X-Cookie: /earth: file system full.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKijDXBCEH69PxaN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 26, 2021 at 11:01:31AM +0200, Rasmus Villemoes wrote:

> I don't know what the right fix is. Am I right when a say that for !RT,
> spinlock==raw_spinlock? If so, switching regmap's spinlock to
> raw_spinlock would be nop for !RT and fix this issue, but would of
> course have quite far-reaching effects on RT kernels.

Note that regmap doesn't have a fixed kind of locking used for all
regmaps, the individual regmaps can select which (if any) kind of lock
they want to use on a per-regmap basis.  Adding raw_spinlock support
wouldn't affect any regmap that doesn't actively select raw spinlocks.

--gKijDXBCEH69PxaN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEnmdcACgkQJNaLcl1U
h9AU2Af/ekGEj8EBgJMNI7xxeCic0QVbCCGNrEEZ8sXZSI2YQtLNB4l4SGYB+Rk0
WUr8+toFR2kDw9GjaRKr0/Ny9Jrj8W+sWwJ270cvPkk+pU4txB/ZG+w5XEEi2jDG
9qDbJT7SN8WKrgt3JGYaeygOrlVxFjru7aSo8wwCrJ6GrTfgS58Ih+srtxBIK0ed
lzoBrGz1xYb60+iMFO20kJGlL2/bGhUWUbsPOHEoZqo6JQqNDCQEglJi4NxBiqKb
XO7aD16X0MZkYt8nDMjhcxBofQPGPRJRqh4KdAU5eD7JgEGeo+fzYnnpwSgcF4yM
C6B0qEzrxWmC/2U0BTWioAPvvBUwtw==
=DooY
-----END PGP SIGNATURE-----

--gKijDXBCEH69PxaN--
