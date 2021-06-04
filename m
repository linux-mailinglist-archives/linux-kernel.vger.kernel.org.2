Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7208D39BEA0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFDR1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhFDR1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:27:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E9F9613F8;
        Fri,  4 Jun 2021 17:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622827527;
        bh=Ge2xUBkqY1RmkZ+sBVqn1MFf14FqwyBIugyJ21jW0YY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNOpONJyOx9rKm+0Fd6iJwylBCekLtIePB+5aKBrUCVRWJlJMg5Wv8x40sTL2U3X8
         bacplF6WoZS70B9O/Uu6JO7afNQq+wiX0oHYusDaCuRU9wT4ObVXblq47EwkPPV73d
         XrgLiMLIMadgPla7OMiPolSTZqTq806bRqIjuXm1ZRuCjomNTCXCdIA6unqJ/B3Q+A
         fNT0LIXSb6eBCX8cW3yRwPG28QJxrvKr8T2wIDqyqW1jITezGO7s0/71DCZSepelSS
         k9vURd4h3rXUETk7zFtSkjo7IAIVqOtfPb7kk2nVIRNwjn0VjHwnFDK7L7WX2IZ2Jk
         Qw/ty5qucMz+Q==
Date:   Fri, 4 Jun 2021 18:25:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Clause-22/Clause-45 MDIO regmap support
Message-ID: <20210604172515.GG4045@sirena.org.uk>
References: <cover.1622743333.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <cover.1622743333.git.sander@svanheule.net>
X-Cookie: There is a fly on your nose.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 03, 2021 at 08:25:08PM +0200, Sander Vanheule wrote:

> 1. I've opted to just ignore any bits that lie beyond the allowed address
>    width. Would it be cleaner to raise an error instead?

It doesn't *really* matter, enforcement is probably a bit better as it
might catch bugs.

> 2. Packing of the clause-45 register addresses (16 bit) and adressed device
>    type (5 bit) is the same as in the mdio subsystem, resulting in a 21 bit
>    address. Is this an appropriate way to pack this information into one
>    address for the regmap interface?

Either that or pass the type in when instantiating the regmap (it sounds
like it should be the same for all registers on the device?).

> The reasoning behind (1) is to allow the regmap user to use extra bits
> as a way to virtually extend the address space. Note that this actually
> results in aliasing. This can be useful if the data read from to a
> register doesn't have the same meaning as the data written to it
> (e.g. GPIO pin input and output data). An alternative solution to this
> would be some concept of "aliased registers" in regmap -- like volatile or
> precious registers.

I think these registers are in practice going to either need to be
volatile (how most of them work at the minute) or otherwise handled in
regmap (eg, the page support we've got).  Having two different names for
the same register feels like it's asking for bugs if any of the higher
level functions of regmap get used.

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC6YfoACgkQJNaLcl1U
h9BM/gf/TAz/WHlHWY9nNa8nT1K/6WBUU8bmREMGRvZV6m4tNBSs+HJ4v5K7eTxj
PUtztJvTbZLktgDltlA3tzECyTWG4HAwxtv3LTcTLbgGoK5aHo8oneSQOViXP6Nq
lrY757bQaqfvLX3LlVRB/Y5Is0I8v6nKcJow027m5FEqIJaH20h1FC92dHpRHbGt
KbAF8YcAfh1xc1PDNq4dpLs7CtbU0Yqw81e4y31Urmfn7PYCWnSYYMZ8U3Zl194H
RbZigaAPbs2ZDt9itzxoNIGTpPfFfeMoZdi2Y5zXnQjkJVc6qJqpj2mAn07FUtHa
Hw17KSw2W+hSF2OGVrRGIpxO/Q0B0A==
=m3n3
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
