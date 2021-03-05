Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C2432F11E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhCER0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:26:10 -0500
Received: from mout02.posteo.de ([185.67.36.66]:58095 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhCERZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:25:57 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id DA9AD240101
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 18:25:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1614965155; bh=bp0lExzC9gAGX7U2Qv4+paZ/iwj3xqJTTZriT9pNdQ0=;
        h=Date:From:To:Cc:Subject:From;
        b=at0PY/y354xZZjXkXb3OiZX6lfAs8xZc2yFc8xzAry48lT5WxLyWMmwP2ZSOc4/qb
         e049cN1SzKqpvsh8rSv97cOGL0eiMVZQlD2bBUPDjGnpbPUJwWSOnQZbjUi3Pkct7E
         VMTyJgivimJDrHmwjDzrVcTRVXAu2Js43JOHhyh1ugI8tWPcTbJJPSTdXwQtL0/EKg
         L83ISdx0t8x+Px3KZ1lmfiBRvxHz2C24LBqwpSwpIeQ+cVYS82XosKWsOiu/CUY+ln
         3XxzMJj3kMKtn4Rm1fZ8SUYRAgAeC/B8E6g0ikJCCwntE0ctdnDa+5JcgRBToxXu+D
         HWRtGG+j5IyCw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DsZQC0r8Gz9rxh;
        Fri,  5 Mar 2021 18:25:55 +0100 (CET)
Date:   Fri, 5 Mar 2021 18:25:54 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: Add Hycon Technology vendor prefix
Message-ID: <YEJpogUgOHHPFUQ+@latitude>
References: <20210305163834.70924-1-giulio.benetti@benettiengineering.com>
 <20210305163834.70924-2-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pFSGEDoxZL2aB1le"
Content-Disposition: inline
In-Reply-To: <20210305163834.70924-2-giulio.benetti@benettiengineering.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pFSGEDoxZL2aB1le
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 05, 2021 at 05:38:32PM +0100, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
>=20
> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
> include "hycon" as a vendor prefix for "Hycon Technology".
> Company website: http://www.hycontek.com/

As far as I can see, https would be possible here.

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index a1312637d6ff..51b00aa96dff 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -488,6 +488,8 @@ patternProperties:
>    "^hugsun,.*":
>      description: Shenzhen Hugsun Technology Co. Ltd.
>    "^hwacom,.*":
> +    description: Hycon Technology Corp.
> +  "^hycon,.*":
>      description: HwaCom Systems Inc.

This is the wrong way around. You declared "hwacom," to mean "Hycon
Technology Corp.", and "hycon," to mean "HwaCom Systems Inc.".


Best regards,
Jonathan Neusch=C3=A4fer

--pFSGEDoxZL2aB1le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmBCaZoACgkQCDBEmo7z
X9sk/xAAr4DklsD9bubyXF25nYOwqumfPXg9MQon7FMeyPO+JVW6rCwDOFKGHhU/
ARMfkYvwQkKhQTsINQzpZokctscgsUfy+WgFqMApGN4mLV0tyLhgq6x/uEA7Y1fw
WhMm7wFSybbO4yLBpNnGNPembmocrT3DmNoe1YrlhkiwA0ipccrJO2WetB55Oz17
OPKTy0LSE2El0KFYjzWIalj/cDRRKncoakx21Z5HR/fKRaTrvhUsh5Bqg8oWm0DP
u/PDebsDv1uUZ8hfJM3MNGkMcy53r+3g/iEUY/LqzZAYaf654//27p1Gl2SpPsIw
irusfyYBHYJdBGJgS8CeQbsuVnY9NQCSoizD0d8XE3QjTF07CDpg6nUpzUrhVdTd
91yBrXglvVDJzWhGQM4hiElT1RsnvpaJhwv0J1IKGZv60xwarRfgYU/fa0z0rTyp
aun8Gr31hT2GqRJhqGLYSopklxmlaBRzzO4r130DeQnJudUiFm1tIsujkv3kDBXl
LeGgRCyvinIB95XscE4VxvOvtlhYFRHK3P3rhlONit4OQV05VUy808TAe6Q97oiY
x1M7EoAcnN25oaP7IG2OWv/XxKxch89zjS8cKZ9LNwGse25H+b2I/m7nZ/yRzri3
elv2lJ67H8elegF+va1Mv1beNMAUn6mxFwW96QE5pjvllu1ifvw=
=hj7T
-----END PGP SIGNATURE-----

--pFSGEDoxZL2aB1le--
