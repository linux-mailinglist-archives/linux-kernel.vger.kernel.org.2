Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECC5342EC9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCTSRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:17:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:59385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhCTSQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616264191;
        bh=dwWjNrSn2iknh3uCrtCouI9eamjWocbr/PwFK6GJxAU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BxJ7G5YAaP9mUfbB9Adur8HaSaZvH2YL4WB+tCK49vS/yvR3hR/LD0Npp3GgtMT75
         XfpDmfSSu1SUMzLx3xXrSLbxKKlIOKkjKThwab/fgcZLRYC57tCUDfZ8w5wLcnQpBd
         k53gUOgmV1uSpwntAg09e95RWUgda1vRXRG8NzY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zBb-1ljYL61vL1-0153w8; Sat, 20
 Mar 2021 19:16:31 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>
Subject: [PATCH 01/14] dt-bindings: vendor-prefixes: Add Supermicro
Date:   Sat, 20 Mar 2021 19:15:57 +0100
Message-Id: <20210320181610.680870-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320181610.680870-1-j.neuschaefer@gmx.net>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g4q4NUCgwIJUrBM/v93UtTqSQSAKvdpuwseu0fMuzzEL2MxSRWq
 5L/cwr6EC4T09vK8oSCUd1jjaYGt0MqUDK3/xB1wjgsGR+71q8x5Mb7TTnunbJ7TpfSrt1L
 ma6EPL1NzjfX7sVyIfzZWttEFifrehag4H6i7y1rbaJ4pRsbP0QJeghjTMR7r+u71i4zrIH
 82lf5Fg7S0An9XrMlgfUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m6xcw6g5Vhc=:f/uQnLwPuyUr/FZJRu53UM
 yar3xpHibLNDJach1OIfFzvPcNMKKYg8gMB8DyXbWsyppBFStFIf06YiLwRbYkwPBOuaU+vcb
 7p3Bb4/+Gp2Hfpx7uuGYoEVslFUoVbXg3LNMddWc67JkEF1UPP+2Mz8spsM6Q138SCuUmzFW3
 0fnXaln6vj9jSWFjsR4nvGmBCu5jEBQ25CNelJgi7bBDShtD0rAumbAI5CqZcxOR082Oxofmf
 NYF0rgdZsly2n1H10isNcCNW49ALf5Xewn9XFLCNkbK91p0K13gLzto3nZOW36Ke6xnKJfma7
 tfK8RUqPtLaJgIwGzBMXHD8W4fQJX/pTDutsHbE8iKJsVmKfA733z6BKd+akbInDVBaqlfYW+
 1Qxs920Pb7cLo2EYmRbcDaSTnPXnvwn4EAgDh+F3qLY2yD3cnRnxSKSFuv+TfW9k6zA1mP46Q
 FkOEuzc1hRJqUSE6SP9d5WMaamZQsVHuZBMnGX2RWWvDiLPviVOkpGTkM362Vqpg2MNqpVWNA
 DpYcWCvmE9EOma0mTmuS3IinJVJhpHCNQhIk37PghpHJdX3FWtZUCbvYw7HC6JXANXzxRdGUc
 M1rtFZOwaOOUNZSVoDaY/mBOZHZ5uH8mkA/Dr1AvQB/I3i+Zet8J+JPIC1D0IqvGUJd9PyvTo
 kpsixmlJ83+UKR+OYfn/qQ7GXqDYDFGMjO/ivcMQuChfOu9KKIRgVopq9K68wfNgzmKXK45++
 ezk0BOe0t4jRHeeAN0Ah4L6IgdqWe5lT1XSZY3PlSxWMMFUQDvzk+yBQL3BYUMdVIfg2qzdiN
 fZi2PhdEmdC7WKufkKAijKfqPvvbltNRc3eOIFAnY7FljMfF/2CanEZrfoWRf7q4PsUIqlDG0
 dF4UMQWoxVo04RfsQX8uitT3i0LYID0RhWTANQDoH0xE/sAfE8ufKRpiO9rtdQ5eashcS7QMZ
 6jS6IXRALRUVzmwY6hjGCAoTP/+CQlVIfEonOPdSKe2lnPdAfejgFTjgJXBGfn0mG7CYkQPJF
 yHa3vGmkXI5gIixVPnxwh3dXeZvwRhKGeYWxyYXTCxyQEvl5rhW3HlnzqsFZ2ktlv+2S/vgMX
 O+ha3j7IWc7kfqDOk6iQzhzW1AhF4udXGvPgR0uXqBTTAYRBceHUcLFHc77UHFAIIxEnTfa94
 PSd3QPMzolj+4xt4E+lduPrXzd7hxnzvALW/PKBzh15ueF95qISG1Gg0hVoGaUpwx0BxyIWcf
 6F0qDtMt+ZlXzzJDU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Super Micro Computer, Inc. (https://www.supermicro.com/en/), commonly
known as Supermicro, is a manufacturer of server hardware.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docu=
mentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424d..ec6d6ccfbbb3b 100644
=2D-- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1085,6 +1085,8 @@ patternProperties:
     description: Shenzhen Sunchip Technology Co., Ltd
   "^SUNW,.*":
     description: Sun Microsystems, Inc
+  "^supermicro,.*":
+    description: Super Micro Computer, Inc.
   "^silvaco,.*":
     description: Silvaco, Inc.
   "^swir,.*":
=2D-
2.30.2

