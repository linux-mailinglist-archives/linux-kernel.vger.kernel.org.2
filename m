Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750F34113CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbhITLv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236839AbhITLvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:51:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAE1E6108C;
        Mon, 20 Sep 2021 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632138598;
        bh=V6kgYgogW976xpByhMqKFGsk3ORwS5VxWZ+29DRMxHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlaozWlWlARDWspL5oZTclqYkhokylGOFqWGYdLdB02cO47tSDd7L0tudUYAx3dFf
         txoMY4xg7OH8bq+ztj99ZgC8Kdaa4BeMHN2IR+8LKff3V/XnyRCOiX3nIr8n4WYsgO
         wPii8/jg2yFfALwoeAkHFdW2J1A3Z82epJbqEX5sJZFIhoddEzzQt1xlAkrU8N+6JV
         ALX+HYfiiIK9wg6jAUHh3l0F8m8maKsuO4amRpPX+xwq3B2TL58aWCkXlXsG0eYDQq
         m3wPWMWnrVgQPWVMX+2NRvsUwSf6peLFQBTpbbfn2715FyElDuxOSeuoHl2dFob08F
         Zz2N0RgiGWezg==
Date:   Mon, 20 Sep 2021 12:49:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Message-ID: <20210920114914.GC4192@sirena.org.uk>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
 <42974939.Tn3hggVSkZ@archbook>
 <20210916122549.GF5048@sirena.org.uk>
 <2435067.tOv7cHfTnj@archbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <2435067.tOv7cHfTnj@archbook>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2021 at 07:38:47PM +0200, Nicolas Frattaroli wrote:

> Going forward, what would be a solution that is acceptable for upstream? =
As=20
> far as I understand, the obvious route here is to drop the rockchip,fsync-
> half-frame property and just always set this mode when we're using a TDM =
bus=20
> format. Is this correct?

Yes.

> According to the TRM, the register bit this sets only affects TDM modes.=
=20
> Though since TDM is not standardised in any way from what I've read onlin=
e, it=20
> is possible that there is hardware out there which expects the non-fsync-=
half-
> frame mode, but I am completely fine with only thinking about this hardwa=
re=20
> when it actually surfaces.

Right, we can figure it out later.

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFIdToACgkQJNaLcl1U
h9BGIAgAgRW0++RxUFblbEgs7rujuZ+mmldKzxR18cC+Os/498LvNXyA+iEO49w8
uKcqHbz77yNSnVJj8aJhhLin6Xie6m755h+PFnlZ2IbjCRrfHT1QPP3sPmfJn3xW
RrZHrQX3kKPb3Tbm8s9tdz0E1HgjkqnrlETHnGbXYL5RUv2/SzDQlAD40i153a1T
vcaIhIvmIH5un/jbFoJSPlp11EQWsMN1dz1CvWaT4m+3AsU/oht57XdVeJHk53h1
HjXefXq9ZE6bjHSwudceZtHvM4aFf+3IVmRM4i9ZKHF046mOYWxw+49Z3dTtA7Bi
ipwsNPQOMZGPIfZTgZ8+ST/F4aJTlA==
=xhRq
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
