Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE8443A20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhKBX5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:57:39 -0400
Received: from smtpcmd13146.aruba.it ([62.149.156.146]:46771 "EHLO
        smtpcmd13146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhKBX5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:57:36 -0400
Received: from ubuntu.localdomain ([146.241.216.221])
        by Aruba Outgoing Smtp  with ESMTPSA
        id i3cHmA3UmueW5i3cJmi7ne; Wed, 03 Nov 2021 00:54:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1635897299; bh=injCjrST3vI53Ax5VupyKt6Fw+4MXa4L026VD0NF4Lg=;
        h=From:To:Subject:Date:MIME-Version;
        b=UHQymmKJS9J7yO/aU5amTmKaJZbRJ/4B8bQfLGoMS+N1Z5U4gxhNS8RYCf2AKpBL4
         kz2xSSIh1Aa5VixDBrWdh8kwE0PE0Tt2iAaYHR4Dp+wMvCNlzxO7IB3fRe2OzAEYTZ
         KldeOjSmp7ac85/bMLetZA515zeXyjj3ixsD2deL5ZFWlpkqkajGnin1yMaLv4K6wU
         WSVucnUbJLiUFksytWxJDSXCSZaxaVZyn0PsIAXdn3ZPABK+3MsnrLTMlFezCj/Lnk
         N32tL+jBx0kFJmdlHREar1MevrxdUwdLeF+5mlu31bKpQhLioD21OyhrePP4WhRN2g
         dQTzCMI3Tlt9A==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] ARM: dts: pxa168-aspenite: fix wrong static ip autoconf
Date:   Wed,  3 Nov 2021 00:54:51 +0100
Message-Id: <20211102235456.710617-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211102235456.710617-1-giulio.benetti@benettiengineering.com>
References: <20211102235456.710617-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGpcu/r5eG+py2luhJEriB/6aDLbc+j1VFN7E59ZzTmOdLGJUSPBGQHId+NyA6guTYUmns0JRHD4ToYu4InSzA7ncZd878e2NBenGHYVa2L+WivbIxCx
 1nLvioNNI9gN9cYO/glWHHItfS3Fcx/Dw2Huhf6V1Uy3nHnxZEBvJjVqQVXnd3KPOleGD5Sv6A6Gtol9p+aGW8u/QlHXaX8mEuWFzY06gSoSkXJ84rDtTwWl
 kPxhdTtbzwXRZHFzs9GuhRmP1dSoLm3WPna1xH/7uxF/5Vn69wKKWQEcAyC85vDiG805QbhQw6TFub1nIc7HY1fv7QOHDl3cG3LGQz/fcDZno+0LIZQfLfo4
 pDkKkNiIBnmf+vcSW2E2Ji334yVtIkYGX7Yi3Rge+QiLjpnfN4oR+sfzmbIbBVgRK9NY02TrQSMPZQ89c+wEGRBe5XIwwlr2Mf/syJE2Tyw/GAsWuNjOVb4l
 TCJNsMVvKLsrQfWv9TDbUeqR7ui48mKjxfQOlfNeXaKNogosm2/tELPxRxwXl6YQaeRGjFmCH3EwaZu07gCBxKqOb5TcpUcR2etv2Xj7em25O7i2s5Z38zIt
 Kq1TYkJ2GlSoYlkAxfs9NgWEqaIGn1cF66lCI69/f2vKP702ccgikyj6OEWvpM5SC1McDDG06LWM8vwshxEdAXkshXX8ta7fYFqXwh9cYy1KPA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment <autoconf> field is set to 'on' but judging from the static
ip setting it should be set to 'off', since in [1] states:
```
<autoconf>
off or none: don't use autoconfiguration (do static IP assignment instead)
on or any: use any protocol available in the kernel (default)
```

So let's substitute <autoconf> 'on' with 'off'.

[1]: https://www.kernel.org/doc/Documentation/filesystems/nfs/nfsroot.txt

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/pxa168-aspenite.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa168-aspenite.dts b/arch/arm/boot/dts/pxa168-aspenite.dts
index 8bade6bf395b..68076f1c5cd3 100644
--- a/arch/arm/boot/dts/pxa168-aspenite.dts
+++ b/arch/arm/boot/dts/pxa168-aspenite.dts
@@ -12,7 +12,7 @@ / {
 	compatible = "mrvl,pxa168-aspenite", "mrvl,pxa168";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on";
+		bootargs = "console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:off";
 	};
 
 	memory {
-- 
2.25.1

