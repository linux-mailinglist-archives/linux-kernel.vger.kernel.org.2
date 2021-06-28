Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494E23B65AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbhF1Pd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233000AbhF1PHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:07:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0D0D61459;
        Mon, 28 Jun 2021 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624892015;
        bh=cO5kHhatIh9piqyE5gPyYNyoexdl3Z8SQfMo/3BHGJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=heDebRQEjFwCVumQPeQUnzfUQtQGjXt4csXcvrh9ZJWz3QhC7xrnyAbA6EHJXqauN
         lAuh2S0IC2boNiPkGf/DmxPhigmN41Ly1v5f3lB9iMMikJjsSY91c+mR3Uo/6bOrFh
         8WHt3ycUzBHy1ccnJYdP1r6aOXK2LOgUAFcExMhpSHx4XHmrAnBNFmlm5xyYhKULXy
         oxirNewCZ36buCXu1RmmnZCNi5Dr0k82OwuUjQ8O1jj45YTNeqowjYoXAbxh3zOuZ9
         EYc+r0M+LxMOPq2t/Og56vtm/YAKbXpEU2ZoJgXsYdiHOcYPz8FrjXVvjZC9Vp0If6
         7UEfHPRo3D3FA==
Date:   Mon, 28 Jun 2021 15:53:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH] regulator: devres: disable regulator on release if
 refcount is 1
Message-ID: <20210628145307.GC4492@sirena.org.uk>
References: <20210625125307.330831-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <20210625125307.330831-1-aardelean@deviqon.com>
X-Cookie: Someone is speaking well of you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 25, 2021 at 03:53:07PM +0300, Alexandru Ardelean wrote:

> This means that the last 'regulator_disable()' (on driver remove) becomes
> optional.
> If there are any unbalanced regulator_enable()/regulator_disable() calls,
> the 'enable_count' won't be touched and 'regulator_put()' will print a
> warning.

This doesn't seem like it's going to make reviewing and debugging
reference counting issues any easier, it seems even more of a concern
than a devm version TBH.  It's also not clear why if we were doing this
we'd restrict it to a single reference.

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDZ4lMACgkQJNaLcl1U
h9DNogf9E6uz6xiKwtF8yxAaAPWRSB7n/C7UjIAn3qIoGXRZi9mFFGAh2qdea2an
WBVkoi0PYtuiqlhSP2b1WYY/jWsS1ElG/HKnWaXpv3E3Nt5NdMQT85QuyWSpvir+
WbyMsiUSt4ACurCG+AOzRWKB/Hz1sEQHBg2UjVcK7SzoHhsKR4/YZ05XW91jHwYY
U1vyGsnmyuILGz1WlW0VVCyo3ansk40atNrWskDyGsXKQMhv2hhUOWY6LKt+f+mV
u9CzCZ4K0eQTTFFvx6QO7oIXUaqwed+Z9L/XwknphyLUIpK1bzAjpNt+tnWHEJsO
FjGHS0eBSOEzTMWE7GWf8USHiOA7jg==
=9qzN
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
