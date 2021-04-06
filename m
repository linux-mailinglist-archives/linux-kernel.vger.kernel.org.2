Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8A2355335
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbhDFMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:10:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:46353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343744AbhDFMKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617710991;
        bh=KpTYS8atLjrE/4GNwFDukd12JiHZ0ZOeahsrryBdGeY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VOWC7DerThJgvFhCt8RxD7pp5S6I4aIKd0D002IqRdT4/YJnWBLx/OS0DIILJwhJ1
         /RqgxYfGx9bB8VS8MVIsagBTqc7ImG22nlpy0RH76dsFjBaTEwsOqyS1NxpV6c3M08
         Vd4pQ/hrt7XOQGcchoCcv1CDZpwRJZLsIk5AIB4c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysRu-1lqNif2hHO-00vvIO; Tue, 06
 Apr 2021 14:09:51 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     Tomer Maimon <tmaimon77@gmail.com>, Joel Stanley <joel@jms.id.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        allen <allen.chen@ite.com.tw>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 01/10] dt-bindings: vendor-prefixes: Add Supermicro
Date:   Tue,  6 Apr 2021 14:09:12 +0200
Message-Id: <20210406120921.2484986-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
References: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xocqc0oP8O7AxwukI4bLefxqkCMRGb4FL/sgNQpEhAp+uph5fYI
 D6omEO3rn00+UPuneJf+sgpzGp8ZJSiwKPQrw3DuXxVwuv81/GMazUlxn+xeKenXBN2UdXH
 l5PRwyQthYBA9eNRv2W0rp94r3Mim23DUvkwlnlmRdy7B7kLtwsCytIFJGDOTPIrHqxv9gp
 Nj6ojZVbcAqVxU2v1FL5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JBmt0AXMpgA=:YRX6SCRLEUtZR2eUPydmdp
 SGn+s9gkZtj3wuJaNR5weqUqEMO7Ku5FHoXdqaPbBFK4pwN6rl9ZjtUQMfmM/qK/U9mY42+F7
 89SNFwsDpPjzLSpfoAAySB/kQONKChL6enlzTqzidrXUvB5iLbG/wo6FP4QrHkTMWb97HeVbx
 eovEzVlGhwc9ID9s0lrfwXHLNlYPFdekcIcGOnxC79GE8DFrek0Z9NfGUipXm8jWcDxmQm+3i
 RbTpC7LkRdYQ2WHRd8Zqh9sTjWYqvnNY7t0n97ud68gcpyj5kIOifDRB7m2uvdBg1+XaVV3p2
 l/5KXg7IMpEKB5I5CyY7YaOMHe8ir+6FkvMl/Ezh8dDLcywwdkb+LluoGfvs/wfXS7hdJrgrn
 bh36JOspR3wt2B8x1clKNWJ273Q+3dP0+JodNXhdJw0diml7OpYj+Dur1Jmq8gX17Hl8tBjii
 NvhpthVU2wN+37XSTsOo7snIixLfPRZN+jkGR/ekRScftq9v7N5D5AfWrAWOwyKZcak0vrzU+
 ZRw6K0SBm7zdedYGyNSu9SmXtsnNuGFPCIf+swfG1Uf2XEmBa8PFdGiEEPYe8HUM4z4avDxMm
 IqxMReaBi1aRxaAORAtyx+Z7boHHxAB8YSc+mv6J9fJAHO8diVkuj8StkNRRQqkrgTvzlPNYQ
 mysV0kyEIKGgNG+Vr6xIu+syc/RPTpIXkkVLbP73rkShjtwfcw2aVJ2ynJTYz97x67B1INp5E
 m99kt0D2NC0+5ujAFwCp33410qBUZV65fVzZJU4VGxZU/ebnUtzRXnkMjI3CfEKjx6RYyczqk
 KTnajlMjeHaLl+MEGIsgR97eVh+bvTkOqpH79srqe6PaYSWoLGq8dcfgLxp6IaKFrzc4n+b2m
 3zPqHT4/rqNPqXmQVIL/YXFUzYs1DUbKtqnmVpXlIw7HMebH+HuHwtU4qrPSklLwBZeMWSWkY
 qfQhwfFrNtNcIWbjanVpyp2Dnof/FJq2KIw6Aef9yeIXIzVjA4TQKtNg4vn6CeZBMfLYm6QbJ
 NaB6ZjCbnMrpr+yPjurh4ivOaotgza5Q1zmN5D8lcXns/XRk1lNkQrcQGPc+pjgU7qV75kHcu
 F1pcjdaFgHeS44XItSUmnjbK6seIz1MAXIGhWXt6Q40pJUSZR4ASAtrRxRh/FbS2bSohQqtwh
 cTAfdSh1B7pwt+z6bZhJZ5jm23bBD3F2mDd58N/F3/tiSEA5JSX8fErZCKri0yUdSYjQ67ji+
 er17GmZHybhb5Zbgu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Super Micro Computer, Inc. (https://www.supermicro.com/en/), commonly
known as Supermicro, is a manufacturer of server hardware.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Rob Herring <robh@kernel.org>
=2D--

v2:
- Added Rob's ACK
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

