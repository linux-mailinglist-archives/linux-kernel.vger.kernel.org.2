Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD93B5091
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 01:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFZXku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 19:40:50 -0400
Received: from mout02.posteo.de ([185.67.36.66]:52653 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhFZXkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 19:40:49 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 9AEB12400FF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 01:38:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1624750705; bh=s6esWgU/Xlf7w6ZVBczhpdMCl7wS0e60yh65YUkUMHg=;
        h=Date:From:To:Cc:Subject:From;
        b=q2f+UyV2GZN1y9xf4Par16MlJVGpK4axnyczLWB9F1rxzQsPQ2Ije04U9zXMFPNi7
         aWelrLcwRckqP2+UaBq+K8Av7ZpJSwm5oEkI6R+QxTEoAvOUYBMgVbPSp9MCV116FZ
         5DfmWSyNcJhuHueblZLQyBoob52CvqPC/aEe/dcoMUnVhCioAmutwZsFNoIZqnVwYB
         QSO4OTdwTIC/vnv8lahkjce2UP2zb0dby6cKAnyo7gVUMAi49VU9+EhFHW8vHEh92k
         rY4OyfL5Gnm48o6Jany7vZAn1eErsCFzEOoA0xsxL0lopvY4M+F+RkfuF7Y3qSt8G1
         CGuxlOp2o6iGw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4GC9Kr45dPz6tm9;
        Sun, 27 Jun 2021 01:38:24 +0200 (CEST)
Date:   Sat, 26 Jun 2021 23:38:24 +0000
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Ash Logan <ash@heyquark.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] powerpc: wii_defconfig: Enable OTP by default
Message-ID: <YNe6cPIhtc1Yh6Lf@latitude>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210519095044.4109-5-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SVeRRa6GP7W+F48g"
Content-Disposition: inline
In-Reply-To: <20210519095044.4109-5-linkmauve@linkmauve.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SVeRRa6GP7W+F48g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 19, 2021 at 11:50:44AM +0200, Emmanuel Gil Peyrot wrote:
> This selects the nintendo-otp module when building for this platform, if
> CONFIG_NVMEM is also selected.

The 'if' is a bit confusing. CONFIG_NVRAM=3Dy has indeed been in
wii_defconfig since 2009.


Thanks,
Jonathan Neusch=C3=A4fer

--SVeRRa6GP7W+F48g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmDXum8ACgkQCDBEmo7z
X9uYFxAArusbDqw9HFJIducCUsMF4cBXIOa+foSnzOZNuBQx64g58pTVNi9MZyK0
ehLYLSwfsTMj/J10u/y55NkoVXPyOoLlbEgikH0VX5nixGIZP6XqxsKVp2eViTX8
UZnRwTTPkocRABRALNBqIy2Vr3Xu0sc5cLj7Wr9mnME3EOdtj0529kt30qNLxFNa
QgnEtfT9v2Xk8ZtcNcobYMbEqhAvACSB559cuVki4G1SsnHfVjBrJzYUFsPRSLty
hLVcYrCnkoAL9MTYcnrI+vzdivZiDRxtj7OjcKiX/z34xKe74qNs+ZEaS9oe8xXM
J/FF+Ur1BeDw0gGvXKr8zFgTAxPWy4F7TGjnqXRYVYWJuhHhSlJ4uH4YfTTplodG
FB6KME8ERasehlObLt67QTbuxNoqbyz6GMBtNZ/41nvwnY+c14+rIsT8zNVrX7g1
zTJ7x0lQO99aOMUD20MDKcwJy5tF9kILEKK5IE9ZdtSBZMctBNU8fjvPLswshHTV
5OWpFee08odl3X3ItG2wbBZuDnGgtU/McM2aeCYJ13nAU0k4SlBw3MBx/sDfehI0
tLnVgLWVnv612sV9haKgHbA4JdK1PeldbzDgZuf/xe2GEq6x6SZ56XLvw/1zA3po
dOGetYL9Kwsmo+LBa0ooUM+Gl9b9ERG9ZEd/WsalsyjgMH1zhGs=
=frcq
-----END PGP SIGNATURE-----

--SVeRRa6GP7W+F48g--
