Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7BE352E77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhDBRdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234652AbhDBRdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:33:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17472610FC;
        Fri,  2 Apr 2021 17:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617384819;
        bh=8IASa5tOevrm7zrvU20QKNH/BDtSZcYWjppA/Xkc/4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tom7wZLx95KXsadqFUaHFR9S5Pmr4CZ6yJrzSWATPreZqFeyZMkA9YYad859z8ZUE
         DRGtERA8hZGVq0oh91YSdjqdMOfKw+nWisg9lrTMgtUtknvrEkwthc4HybNlPGaW7g
         zKDGc9gVNQ2xZDZ2ozhaPX8gOjxfrt9MHKEWc2Fd6pKVAPPSLT7h1T+UcTyEBuiqLD
         PPiw6xpERKozI3MoR4wg58gJsiIXkEuiw28PWA4cBS3UOnRiPrW0vImDGMZ0bo7VDp
         g3OZApsjoZUNXg/UcAysFuYiBS446BonzCwzyV0MB/s5E/8f5mtSyI05RQFdxEII/l
         Tnlnx8ovpZz9g==
Date:   Fri, 2 Apr 2021 18:33:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: Re: [PATCH v5 14/19] regulator: bd718x7, bd71828: Use ramp-delay
 helper
Message-ID: <20210402173326.GH5402@sirena.org.uk>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
 <42adb3a4055e6c661d01cf1dd6a9763d15b7e689.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNpeiK4tTqhYOExY"
Content-Disposition: inline
In-Reply-To: <42adb3a4055e6c661d01cf1dd6a9763d15b7e689.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNpeiK4tTqhYOExY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 03:59:28PM +0300, Matti Vaittinen wrote:
> Use generic regamp ramp-delay helper function instead of implementing own.
>=20

Acked-by: Mark Brown <broonie@kernel.org>

--PNpeiK4tTqhYOExY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBnVWUACgkQJNaLcl1U
h9A+Ugf/a3HG43GZgAtdE5eo1fA87VxQOCj8MUjZtqz+wiTe0UC5KbyG/I3dGjMP
CkE8FRmKLMrFfR59OVRW4mmzc17FEKGJ/tUICLaLoNxcWwnNbr+zjr8uuCfW8rsy
Caz1wbZxy5B3bZfN9dHAFttToV2nuLUG5iL7SD7CIBPeGjLIIL29D8HuVZ7Zrnhn
cRCNgKBjms4scoLfM7N0CytYlXosPZd/CGw6PJWhQyGgpvuzwskdWPfWGcJGKhNY
36cK2FN2iMGZzrM91CWCy60Xfqk31dKFnR4PHBJSnYpQhehnBqxmmoNLqhFGGy1U
H8iFeEiwUcMHwjiUwTrIEOESCcdPpA==
=gvbP
-----END PGP SIGNATURE-----

--PNpeiK4tTqhYOExY--
