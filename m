Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EA4342ED4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCTSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:19:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:59999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhCTSSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616264324;
        bh=GVx8/K7yYDVoo050qqGQmQL+SjUfoXirB6WTv2qDFWM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VS7rz+qxpxxaaGFSkeWRkJ60QM5waU71v8JjMor5favGhDUMH2i1WFlmuXuqNSu1r
         L+wjkJiPpiYIOHLQEEpSB0STDpGWQaRE6ZwmHebf8Hu00ou5XRhAdv3aDZ07IAFymQ
         bvvNUpc/BKe6SVvvLrBC2Vp4z22lhix5kLUHRRH8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bk4-1lkN7C2PNO-01850Q; Sat, 20
 Mar 2021 19:18:44 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 02/14] dt-bindings: arm: npcm: Add nuvoton,wpcm450 compatible string
Date:   Sat, 20 Mar 2021 19:15:58 +0100
Message-Id: <20210320181610.680870-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320181610.680870-1-j.neuschaefer@gmx.net>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yedfqajxlN1FAoHANCYVteSz4SlckZkDE9Linr7spqQF8RAwH5s
 rX+UJz/8u4AJjdE0MENaEhWaseqSix065XTmHg+lCKnz7CfXmhU1cdyKDgweZjGjyLiEB3a
 UJ5wk1lfGHMFd/DLbPlHvlCHr8QhJ81UlOmOPNuH5LfQzrXOVAon663FgwidHsphdZ4DCBq
 Xm9Bfpu3aNh9yLA1Hh7AA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Bc6xy5JL9I=:6+4OIJfEgVHpodEDyIa5T8
 pvD4QBDUe13P963KH2nWuR2rOd0IpQjxKTthDnilQ1XB//3Jn9oqfJsYRkwMoWWAliuK2Sp9N
 twhvMlfz0EndyiojTP5Mx86Jtu4ju2wO+0Y06sPTR83/jcNSOJsDMJf7D6abwtN76fngbeVH+
 IAxtE4M/wRbDaq+bdr/sVeFQP/Qi6MpDGYUju3xm752dPNQXgKrrEOmGzhrEIyEL51YCwjaQl
 BMyfZNW52PjPSx+2HcUwvyYfPGozLrIc3JPSOoceiSoW6wNOKWSXBVQisvURbADWorfsV+jl3
 t9/cpbzNN0pUar5LgNXQLRSJXaGW/gDFsqci7z4rw0OJ5pp8bcCppRyx+4fr6IfLVSHSqbV0Y
 cLx6nzVQbMz2H/U1m2kMR3SkbWcQ3Fdv7uKFdGD2unGhaOHXIXz9KoQunQ11HP+/1U/pJ+6Ni
 DodRlGjhNNUGMfti3VlASrxI2Dmz8gcq+mBlsJ7WEFKH81rLhywTvYbQPXvYlg81xd23aaK/m
 m3Wq1WV/Yr7HvId9VM2WtMyoVHLhMewTS4dzjMFR0hExsETRmW/JwSfnBv5wpym61ZB+1mmQM
 VLFov/82kXbcFaSX3EydQZa8dsnksqHcPWxf/FBB127K/9ObcXNYGzQuhECWgq21Psr/es1h7
 588aJ4dUkK4tnC8wABMJDjobIlny4Y9Mr5LYgBSJ+GBHGHkvK9PYEa5HLE/c3uQf+tByVAGID
 sk6GdYkZkmDCqOsEsrQxuKUl8U05ismncr67HyNSsATeGlW90+pVpR8obJAR2lFrjfs9/t79J
 FBPOoIn4OG8mJTtvL2mfq8km6OlEtz6Hvb9fToWiWNBn76e+7fvQKiaNAtfUUC/ccCJXRNtEr
 IIKHn2wOmA5griHXg3VfPlhObp4/Bth8BOis9odyqdw46cB2VaMvE2L9CM3VRvV3O5Zn+OlyV
 hz6gEX4xpq+XYezm+BAOGi8X4RCiBBMjJvFVqO/D1wIm79A0OEKxltC5jw6ofeacSnhhv/pLy
 k88Uiq358KhfEXIYwtafWexNFlm2ODXyrbXIaJj3/egtBaFK2ZtUzrI5IqvgWQzjxNep4xr4H
 YtJgjAnJxyu+c0c4WdoJl4tas1uzu78RhndvYC23Yz7eTlek6ZHc03uOprEKoduwhHAcpRLD9
 VEXE3NCQk7trf1KtrNMMj3uQz8bejdLEAdolp9C2A6eJ/iCj+4ouynVFf+QRWaqaKnl1boIa1
 1v/5DDNEKcCV3f+sp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WPCM450 is an older BMC SoC in the Nuvoton NPCM family, originally
marketed as Winbond WPCM450.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

This patch requires "dt-bindings: arm: Convert nuvoton,npcm750 binding to =
YAML"
(https://lore.kernel.org/lkml/20210320164023.614059-1-j.neuschaefer@gmx.ne=
t/)
=2D--
 Documentation/devicetree/bindings/arm/npcm/npcm.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/npcm/npcm.yaml b/Docume=
ntation/devicetree/bindings/arm/npcm/npcm.yaml
index 894aefb70652a..95e51378089c9 100644
=2D-- a/Documentation/devicetree/bindings/arm/npcm/npcm.yaml
+++ b/Documentation/devicetree/bindings/arm/npcm/npcm.yaml
@@ -14,6 +14,12 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - description: WPCM450 based boards
+        items:
+          - enum:
+              - supermicro,x9sci-ln4f-bmc   # Supermicro X9SCI-LN4F serve=
r's BMC
+          - const: nuvoton,wpcm450
+
       - description: NPCM750 based boards
         items:
           - enum:
=2D-
2.30.2

