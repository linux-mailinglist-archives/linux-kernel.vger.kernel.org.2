Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754EA37B9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhELJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:56:41 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:24907 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhELJ4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:56:39 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id F3843A1B65;
        Wed, 12 May 2021 11:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1620813329;
        bh=ppuEtfUiNh6dPna9esARC/I573CvEjsGGl/2B/7p0bA=;
        h=From:To:Cc:Subject:Date:From;
        b=jMGnnZmNRDrqSJ2f9xNKGupyjRyNPvpNlbkDoUCudpzAW0RLKYaor5/a2bvxCuhPb
         gI0J2o4xigK2/URYPxJkfeF6zzunb6+ue5GGpc0m5SfV6rpL042H5aC0YWdAsG37rj
         l57vsA/OWZLSQDLK/2yybSVScppN5RJCpoiVZb/I=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH RESEND] ARM: dts: imx6dl-yapp4: Configure the OLED display segment offset
Date:   Wed, 12 May 2021 11:55:14 +0200
Message-Id: <1620813314-30803-1-git-send-email-michal.vokac@ysoft.com>
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

