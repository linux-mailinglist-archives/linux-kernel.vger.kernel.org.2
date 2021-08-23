Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EB93F49B6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhHWL1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234997AbhHWL1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:27:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B692D6120C;
        Mon, 23 Aug 2021 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629718001;
        bh=SNXPezX13mfcuVusqi9++jw0PbkmIdb33Xu6aIl7Cps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k52MX7bckBei8Fe5kTMVB2Guq+tsMgybPciSKFS/WOBJSWPdQSQrHefK1uwzWYhl9
         9MHzvxwm3QJ/h81UhyWihlSQxx0Opcwd54kc5LFohHqbwrfNAo7/Pjcv7rCwqFrczB
         BnfIDgjJItd6fL0AwMnRidpCgR8qrQy3pY/yUbFLr+Yom3DSo3ppOh8wBPBTVgdUlj
         1R6D/QwQP9KdRt31sdoj/pzvA+HBsi+mn4gmQaXFoEP2jrVND/1YTgNtKzxq3FeWGj
         unVZIblEwxr2bsw8iPpEXlPk7PBQ34MZkkAX0ZIFpIIthS+1K6VUIDXnr6E4juUisX
         VcGfexLSrwDsg==
Date:   Mon, 23 Aug 2021 12:26:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] dt-bindings: sound: rt1015p: correct indentation
Message-ID: <20210823112615.GD4380@sirena.org.uk>
References: <20210819101020.26368-1-krzysztof.kozlowski@canonical.com>
 <20210819101020.26368-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
In-Reply-To: <20210819101020.26368-2-krzysztof.kozlowski@canonical.com>
X-Cookie: APL hackers do it in the quad.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 19, 2021 at 12:10:20PM +0200, Krzysztof Kozlowski wrote:
> Use common enum instead of oneOf and correct indentation warning:
>   realtek,rt1015p.yaml:18:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

For stuff like this where there's no relationship between the things
being patched it's probably better to just send a bunch of individual
patches rather than a series, it works better with tooling and makes it
clear there's no interdependencies or anything.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEjhdYACgkQJNaLcl1U
h9Ah2wf/WfM7XjJE/ztslTnuMDDI4tC7FvozpC17wxbK3oNxPlzluBz+r0Bu664m
GEFc1PpVWxMEzRcVVa3axO+jTlNcRqWNpUHPxtINqUdZ1s1JSEsHdvyfdXKAytx3
N9T7OWRHi4LQagC+FRKlVsDY3UkyzL83pCC3gdZXxs3icKhr/zpFePWa9r04yAVl
l3qrndJpATla6IPu9OQuxyPpyyxkChYMkS0KDvAWNscIU1XCkDQgUXnBS0VRUOKP
heIksdtyfDK/93XpGyWRB8PqSba6QMljBLbvRBpGV3v4gQbON/Lvyde4MCmXnoLA
wXaLGSkpbItq31bZJcipEPb0dBZXNQ==
=65Xc
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
