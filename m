Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D935533A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbhDFMKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:10:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:42079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343761AbhDFMKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617711022;
        bh=OfN24IwxxARsGfWQJbdfi7ZRHscsB6YDPNa6NgX+9x0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QftaEuF7KNEQLsVUaivUvRS+S2J5KL4GBIklNKHRKS0yK761zlIqccAMMtjijAST9
         x1MnoNF+7B7Pz62HX0/x9Zi7tuJESdVxvGfZYOWqgZEpaYEVQYeiI9GsAskj1JyskQ
         PAmo7DGy6fOrXtbb68Qd47yFaZJixOE3qjTrxSKQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBlxW-1lHfhi21Pg-00CA7T; Tue, 06
 Apr 2021 14:10:22 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     Tomer Maimon <tmaimon77@gmail.com>, Joel Stanley <joel@jms.id.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 02/10] dt-bindings: arm: npcm: Add nuvoton,wpcm450 compatible string
Date:   Tue,  6 Apr 2021 14:09:13 +0200
Message-Id: <20210406120921.2484986-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
References: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3i3tqHvtVBg3rg5Rc8lXpQLYNYHJptTlPSoxI6UjwlejQdqEtYJ
 4umszCzzU6McbbYFuhSR8XlUa1e6jyEAO8wJhcerP+pLklSMXcpZYCfC7JIqcIpZHZh01Ku
 Vbb/GYyrymKQ9rJ4W8v887vT0X7FC31pL0pIij1mI6EiY5Z5G0FZeUwJKrP1Ffzk92F0udB
 rUQWgppEEzYgdSdNWs/zg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XCort7w0/+M=:aJ/nnbDPyvhnGdcYpgh+Ld
 rjHdHavsR6ss15tj8D5BsQQypx9hO+BNLHRFIeUsrF3Gj+07C3wpoqjrvMzTBZMQW7kT3abw2
 IrgeHVQlnFgClABitxjk4HgLr6WZML8pzA+RgNor15ddPXfmbaC2dVg9601F7cqYNtDblMewW
 1jKQlaRvJXKBq1OTu9sIZWw38PZZHXMlVwLJ3xRjpjXkppGPNuATf+PDJycArRZP7k35GTaMc
 fYuQFsrYC8suUw+GU21Iuzk6svNLH/HrHaM1ZeK07gJcYlcc+be2qNncRZr9J2RTfUpsDvcro
 HmGwMDMrhGkQvYYMeMwdj/Fx0AChP+QCRXBKaPlgkx4C+AoGf3+iNDD4kmp4g/+zh+w6XihBP
 CR6Ku9+nJzj+cZw4soctAIDf7e2OgxU2k5trfUTLlJp1ZTfc9/Ez0MeerWdzBlIN+zsCAempS
 gu2Y3Y180W2GZR5S7Gjz2tqvlsTdg9geMhSIoIxepUwQBsTYbqA2R8RpGX9LHaMAFhvCpXvYd
 ths63bC/4kC0PiyFbfewDa56Lpr2niVResH7Dpxmf4PeUBVnocyUyUpS/l0BZoijOUVzPsAXi
 q7Ko6rG4JBQaFLbZpxcVGG419FKqfnGQpMSObj1PgKCgHzTgW4b+5t/HxiiD6W1gsaS0HG6YP
 Cx7BWjoyTkHWAef69+wHHhRhZCMm4IozNYLy0dAqkVC8QPJoSFbvUcdgpQp6vQjBBNJl/iZ9R
 FxCbWyF0C9dgs735TE1rP8HYYHQcTS5wRXdSFyIKXJqCsOcmvKUJfBLdgIJi+D8K47USDVxtl
 4nMzQ50giGdvjogjlIowNgQO4T+gO1OWRb2EE9KuLgyC3tqUe+jdJ4XBF8ER3VB1xpi4rSbD4
 N8YGLd+C844ACH5o0wEFp2B3Xk0lWgprCUg+RbLVztfxMm/ltzilZsmtiP+lNewOJaUv6JGc3
 Bqj89L2MH9c+XydYOtbuSgYawX+Nbn9rdQ4PkEC6OwS6FoDrVw5oKvLZ1l05PuokDvBkraVZ+
 0EdKytydRP5rg0KRRCz6Rih65ReaaXUQ8RjoJmbfOy109ClJlGz/9cmCMZxKVvd15EOXb5Zd/
 Zv0xLFDaBuu1Jj2ZcegjohGvhGUYH7mWtHq6iFUpf5ihHbTmDOCXN8wE+vas6tVBLFAc1P468
 ytbsTrbzfyiVYXu7RT0tqRmlIUdimqxLp76zwP6bXkqfQduGHZTEkFDho8qc52kTZ+bpeGUii
 nLAAhzXBfTUJNaJmf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WPCM450 is an older BMC SoC in the Nuvoton NPCM family, originally
marketed as Winbond WPCM450.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Rob Herring <robh@kernel.org>
=2D--

This patch requires "dt-bindings: arm: Convert nuvoton,npcm750 binding to =
YAML"
(https://lore.kernel.org/lkml/20210320164023.614059-1-j.neuschaefer@gmx.ne=
t/)

v2:
- Added Rob's ACK
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

