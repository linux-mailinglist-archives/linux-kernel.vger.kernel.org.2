Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A67443A23
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhKBX5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:57:41 -0400
Received: from smtpcmd13146.aruba.it ([62.149.156.146]:37381 "EHLO
        smtpcmd13146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhKBX5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:57:36 -0400
Received: from ubuntu.localdomain ([146.241.216.221])
        by Aruba Outgoing Smtp  with ESMTPSA
        id i3cHmA3UmueW5i3cImi7n5; Wed, 03 Nov 2021 00:54:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1635897299; bh=EKouxjESLduVmOfCsLluFku3U4dwAjwdu1pApB1O3O4=;
        h=From:To:Subject:Date:MIME-Version;
        b=FiuNyz7UcSUGvuhJ01mgWMLh5aU6yGMNW5ubO2konbVIxL+sksNYfTjeM9Pi7p9dI
         A6frq0cD1Sb7elyV5R8671sXAn/+LQ5YncWyq38QD+5ZHgccx7pddXRtdfDR0e9JvW
         GlXNu6RNLjI0et7TitDEp0dQZ8Iv8goErb3H1oQJSLLTVV7oqYL2CASECaa3RB5Ao6
         i+LPWF2gAciGAgOI/MAqVnEJJxhpL98nCMtUzZ632njONhb2D3z/fk+hhq59/eluDw
         ySq4Fxm4STNjC9wJGnx5M6ezsFZSJ74exdevu80bM12d4MmskuQ5ushC+VVOSp8WRQ
         3tnqb35ythP3Q==
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
Subject: [PATCH 1/7] ARM: dts: mmp2-brownstone: fix wrong static ip autoconf
Date:   Wed,  3 Nov 2021 00:54:50 +0100
Message-Id: <20211102235456.710617-2-giulio.benetti@benettiengineering.com>
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
 arch/arm/boot/dts/mmp2-brownstone.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index 04f1ae1382e7..05ccb567e516 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -12,7 +12,7 @@ / {
 	compatible = "mrvl,mmp2-brownstone", "mrvl,mmp2";
 
 	chosen {
-		bootargs = "console=ttyS2,38400 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on";
+		bootargs = "console=ttyS2,38400 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:off";
 	};
 
 	memory {
-- 
2.25.1

