Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9163FB645
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhH3Mnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:43:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54588 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbhH3Mnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fBt1X6EY1xX453QbgynAdMp9aI19EGl/lNvntyfgFrg=; b=CYKKhPkx+oFuoGrl+DJrDd+5dm
        h2bfuAM1DoS5f0V0dCmlIHXhoBU8MEo3aDCyFEXgCWUePcONzDRHW56K3rWlReX/WhZNYpxbivYGF
        l05s16eE83jZ1hBcUtjczykdoWNhNqmgL+uQ3SMxUo4Dh/XSbe1kqktAT53VueBdWYNk=;
Received: from jack.einval.com ([84.45.184.145] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1mKgcd-00H53W-I1; Mon, 30 Aug 2021 12:42:43 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 0BEABD1B485; Mon, 30 Aug 2021 13:42:43 +0100 (BST)
Date:   Mon, 30 Aug 2021 13:42:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: teach regmap to use raw spinlocks if
 requested in the config
Message-ID: <YSzSQzDuWcrzSPtR@sirena.org.uk>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-2-vladimir.oltean@nxp.com>
 <875yvr3j5c.ffs@tglx>
 <19a98ebe-507b-d60e-47a3-9ffabfb24ca3@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N7YRvco+FvfPPSot"
Content-Disposition: inline
In-Reply-To: <19a98ebe-507b-d60e-47a3-9ffabfb24ca3@rasmusvillemoes.dk>
X-Cookie: I can relate to that.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N7YRvco+FvfPPSot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 30, 2021 at 01:02:33PM +0200, Rasmus Villemoes wrote:

> i.e. the regmap code can actually do allocations under whatever internal
> lock it uses. So ISTM that any regmap that uses a raw_spinlock (whether
> unconditionally or via Vladimir's opt-in) cannot be used with
> regmap_bulk_write().

No, anything that's using a spinlock already needs to avoid any
allocations - ensuring that either there's no cache or that the
cache is fully initialized with defaults.  The only non-cache
allocations that might be done are only used by buses that sleep
anyway.

--N7YRvco+FvfPPSot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEs0j8ACgkQJNaLcl1U
h9CJjAf/RvusnH4vj0idv00Ctl/kgz2l3OVfBCL3DcYIMGa/VkOTdUtPYMXQhWWe
nfwW5x1pfMrCDX3WOTuKgWzc6RIsQEQwmpObTdkCBuGDOX8VOTQztC1if1xwGSfx
5QyXt5oIlGELkqHxpTjp8jpB5XL8UdcxgccUq4vKsWPMyZ8+82Tu8YsGqBtor8KN
+bIqSdPiHjrOTfZCpDhPiWMzaza0/rif/uAg8QkNODeAjt6gn25lKpn+DlBHFG+D
zdZrfuMUpDtAzPMx1dMcNav6sMJ2YFzRuWdqLzQzEBBJ498RtBqQCx6k9m6xd+cO
PLVLCTmyxMml+7RqNyXtOkKkMICl+w==
=9eZt
-----END PGP SIGNATURE-----

--N7YRvco+FvfPPSot--
