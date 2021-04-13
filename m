Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1664035E22F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbhDMPCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:02:00 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:46691 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239975AbhDMPB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:01:57 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id E7894A2B15;
        Tue, 13 Apr 2021 17:01:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1618326092;
        bh=ppuEtfUiNh6dPna9esARC/I573CvEjsGGl/2B/7p0bA=;
        h=From:To:Cc:Subject:Date:From;
        b=i3peWw2tiwVc/c43nN3u+uH0kMWmLgRDcBHllTzW8fUmTDRGr9kUY+F3iGP7c22Dz
         wGxa99AmKvBy5LrfU9YzISO+GPOSbOP0j1FPkWftwiChuSTY0gQkQ3hG1bEEAaSqXy
         zFxo7r8x9RH8VIEwYx3RXers/rTqS5LW0qqvZ4yg=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH] ARM: dts: imx6dl-yapp4: Configure the OLED display segment offset
Date:   Tue, 13 Apr 2021 17:01:16 +0200
Message-Id: <1618326076-6869-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx6dl-yapp4 platform uses a GE-LX012864FWPP3N0000 OLED display.
The display consist of a 128x64 OLED panel and a SSD1305 controller.

The OLED panel resolution is 128x64 but the built-in controller default
resolution is 132x64. To display properly a segment offset needs to be
configured.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 51972c85e207..111d4d331f98 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -373,6 +373,7 @@
 		solomon,height = <64>;
 		solomon,width = <128>;
 		solomon,page-offset = <0>;
+		solomon,col-offset = <4>;
 		solomon,prechargep2 = <15>;
 		reset-gpios = <&gpio_oled 1 GPIO_ACTIVE_LOW>;
 		vbat-supply = <&sw2_reg>;
-- 
2.1.4

