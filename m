Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6F93FB5ED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhH3MWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:22:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50284 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbhH3MUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2oe3rQNKRsH+sZx1COtJ0b5SxHv/VuiVP6lcNnZDmbU=; b=pqre4ADfLQ/tmzhj4a+EM/fB+E
        k1wbbi30/NfGL5YrLDp3r5uUuIO+A+Ds5pNaTwIAVjC+sULEJirteSvLHk6nphywNk2AyEEFK6Zf3
        lcFNV/KtQzwxVslpah02SLtDpjKrKqmq/ZD9rOeEstN9R/58E9aKIT1bGQ5/QeT0wTvo=;
Received: from jack.einval.com ([84.45.184.145] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1mKgGU-00H4U4-Ho; Mon, 30 Aug 2021 12:19:50 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 4DC10D1B484; Mon, 30 Aug 2021 13:19:49 +0100 (BST)
Date:   Mon, 30 Aug 2021 13:19:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: teach regmap to use raw spinlocks if
 requested in the config
Message-ID: <YSzM5S3VKOBXniRu@sirena.org.uk>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-2-vladimir.oltean@nxp.com>
 <875yvr3j5c.ffs@tglx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UG0QBevihfrK1GlS"
Content-Disposition: inline
In-Reply-To: <875yvr3j5c.ffs@tglx>
X-Cookie: I can relate to that.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UG0QBevihfrK1GlS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 27, 2021 at 01:01:35AM +0200, Thomas Gleixner wrote:
> On Wed, Aug 25 2021 at 23:50, Vladimir Oltean wrote:

> > It seems reasonable for regmap to have an option use a raw spinlock too,
> > so add that in the config such that drivers can request it.

> What's reasonable about that?

> What exactly prevents the regmap locking to use a raw spinlock
> unconditionally?

We definitely can't use a raw spinlock unconditionally since we
support register maps on devices connected via buses which can't
be accessed atomically so we need the option of doing mutexes.

> Even for the case where the regmap is not dealing with irq chips it does
> not make any sense to protect low level operations on shared register
> with a regular spinlock. I might be missing something though...

That probably does make sense, I think we're just using regular
spinlocks for spinlocks mainly because they're the default rather
than because anyone put huge amounts of thought into it.  IIRC
the first users were using spinlocks for their locking when they
were converted.

--UG0QBevihfrK1GlS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEszOQACgkQJNaLcl1U
h9Dn9Qf/ebqXC0dbiH/yOjtNHGY17MMPRL+1UDXL1Cl+hANqVEEGzogokDM2Pr6h
M1XoLFdrR0fWFLlrU+O52AFsdK2VOh7M1nT27RHYttSZ9jmYki9cu3QF8RK88Oxd
ozEX6Z6GdfBe4tlfVfLObQwEpqkRSw4IyESzybY7YKoGtogRPav69FgCL8UeT5gT
YcWVSRjWwkMpeSlr06oqWBKzO3LGW0Q73756rMjiRbaw1H7OksQIfgMCp7CM4RvJ
kHEPu8Me9Gkklv2Jhouow2GBiqwcFvz+52ldHiowQI7SBZPe/09IbzagCMVPc+Hl
qwmZRxx1iXCE4cJQXEkk7ND+ADCIBg==
=+enQ
-----END PGP SIGNATURE-----

--UG0QBevihfrK1GlS--
