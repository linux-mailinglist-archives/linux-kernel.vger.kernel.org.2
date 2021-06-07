Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A96D39DA94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFGLGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbhFGLGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:06:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BED4460FE4;
        Mon,  7 Jun 2021 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623063850;
        bh=DcdZ+bLa9AlzIt6Lv4vJF/t0KaAmbvdt8tWW0NS/CEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOqBkkOqDbUPmVMWBSKWqRDGa5PCPymPcgzPbJiDxCZT2cKXx3drE3ZLbms3sVc+/
         jQYB0P/TM+oAa+y491Ff6EZdnED+jm3f/OBHE4vFkHLEVMWh++hj+zGfoekAiVQvjd
         b791d50JiEbAF+L/z13QZJ6hypUN1z3ZVpFFqOE9lOD4D6WYEbR87U+ZQDNi0VgjH6
         u6IhLSuBDlU3egUVVP7jALJd5pfU0De9ZQUPv3X/13OoWcbjMlckZw/fJEj1xERk1S
         UlQSIDKW+0hNqp1UYGKg6VqGGGNinzQNO2IV/Rjn+bDNE6F3hHJxzlGWLAG0QqGBOY
         AuOIvXHxFFS/Q==
Date:   Mon, 7 Jun 2021 12:03:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] regmap: mdio: Reject invalid clause-22 addresses
Message-ID: <20210607110355.GA5705@sirena.org.uk>
References: <cover.1622743333.git.sander@svanheule.net>
 <20210605083116.12786-1-sander@svanheule.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20210605083116.12786-1-sander@svanheule.net>
X-Cookie: While supplies last.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 05, 2021 at 10:31:18AM +0200, Sander Vanheule wrote:
> Currently a regmap configuration for regmap-mdio must have a register
> address width of 5 bits (cf. clause-22 register access). This is not
> enforced on the provided register addresses, which would enable
> clause-45 MDIO bus access, if the right bit packing is used.

Please don't send new patches in reply to old patch serieses, it makes
it hard to follow what's going on and what the current state of things
is and makes it easy for things to get missed when threads get cleaned
out.

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC9/RoACgkQJNaLcl1U
h9B3iwf/R/z3ysBnJOfzFqOix8UG3rlCuvsx+J5lvjvwy0uV2WkuIgKbN74uWb68
kBKQhol9NmoAbJ/Qp98+nfB39uPvPFRdxEButQS4hUPaUA8N/esiWoY7jH0hJjLh
ovJTiX5PWPEA3KxyCJZfVRp94wSVb/Rm6DKYa1ySzY3af9YHYxyHItaNQJDYRr8l
cY82bGCv5Vz/tJuRjQdnzCmK0N5UymrkLWYDdEBgO4OaRaCLujmaZ4P5UIV5GFKS
tg03tpkTv0+smcPojfr/ggRo1sc++X9BD4iK6lMtQbGA9J1SBI1WkmjN5M+8pnRT
fGfEqLNRD9wAh2sR07LyaKjN0IS5iA==
=YnRq
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
