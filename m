Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A0E44AFE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhKIPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:02:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhKIPCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:02:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69F5560F6E;
        Tue,  9 Nov 2021 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636469992;
        bh=dWKdK73IMyUlKNgSZ++V+JORAEH3nUi3kyZlKRW+Qnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJ+coPXCLbzyS8S7CZVjaRZs6fcKILsvBJ0wqUzxgy60v12Hrc3E1dnSl8oxZHohk
         iD1XpPzGN1EIdSaY3iPLrqrGECSW2+9dAMVUoo5USrwktGOVMwYsaOow20fMboIwKG
         0eFL/kabqGVwZvmpbQg0Y4QD16TG15IQDAlJmHKYO8O7Rb33ppSRON0UKPD8cfIL0n
         Jk11jlG9L22JN5yHKKFk3YvZcWL7lI7bjDGWsfS5FrNOYsXT64yIjwZXFyXGfqsOi/
         vebhJsWm/BCA5/+VsWi5nCUcfoh04t+Wsq77LCaEz0XjuhclP4cQs97ngGCeFRbQ/N
         PSHSf5000HTFA==
Date:   Tue, 9 Nov 2021 14:59:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        - <patches@opensource.cirrus.com>, ~okias/devicetree@lists.sr.ht,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: sound: wlf,wm8903: Convert txt bindings
 to yaml
Message-ID: <YYqM48HTtoz0XeR9@sirena.org.uk>
References: <20211028124639.38420-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xGLz+eQnaXl9JzSJ"
Content-Disposition: inline
In-Reply-To: <20211028124639.38420-1-david@ixit.cz>
X-Cookie: Elevators smell different to midgets.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xGLz+eQnaXl9JzSJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 28, 2021 at 02:46:38PM +0200, David Heidelberg wrote:
> Convert the Wolfson WM8903 Ultra-Low Power Stereo CODEC Device Tree
> binding documentation to json-schema.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--xGLz+eQnaXl9JzSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGKjOIACgkQJNaLcl1U
h9A9/gf9GFEmiu9kGC1QseVVmf0pGCj+z4nAP/giOgiIeD3dlFfdJjOu68/djoRO
pr8bKXnnEk1Dni8yYOk/E44HS8oINhAyxyH4/o2QktLeydfkXZHrFQH8H8Xen2ry
doYd1Y8GBaWd92niZTkkB3srdBXW7ASvaalP35UfMdwclQAsiwRp1wrN/8nyEXLe
g1XTkPeV6YLvopI97p0kgMepcwaMBv1kyn4O6ZTZZER3tgQwBz8VBm5/s5Gxvd96
f8jOKdh00qYyLANI1mNp/2WRNnw/AgHLom2flRap6+y37zp7N+cFAFQtpn/V40C1
UtDArKO5n+/iw9HMFNejXZ0X9+9PiQ==
=ll7b
-----END PGP SIGNATURE-----

--xGLz+eQnaXl9JzSJ--
