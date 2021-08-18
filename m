Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15473EFD74
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbhHRHMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:12:03 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:13059 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238094AbhHRHMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:12:02 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Aug 2021 03:12:01 EDT
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.1.22.96])
        by uho.ysoft.cz (Postfix) with ESMTP id DF667A09E6;
        Wed, 18 Aug 2021 09:02:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1629270156;
        bh=9R2smNe0TvY7IhMVEAeWoQKZlOff3LSIpHUkF/LRuV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlxJ1lzQvemq5nspoKZcSQjg23DEm+uQxYoiciKLvWXY07ed9ZOnzjVvNvl8YElaU
         yfcVEFL0AgCP7yyuq8dp0Qx9yCFx7HA6WcMu3PEyH4w5Vcgkh7OkFvzPPorPVEiDsG
         ADojrWHEWnZgQ+ltcCXl3HqsLsSaXS7h+z1KsBBg=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 2/2] ARM: dts: imx6dl-yapp4: Remove the unused white LED channel
Date:   Wed, 18 Aug 2021 09:02:09 +0200
Message-Id: <20210818070209.1540451-2-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818070209.1540451-1-michal.vokac@ysoft.com>
References: <20210818070209.1540451-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the reg property was added to each channel node in commit
b86d3d21cd4c ("ARM: dts: imx6dl-yapp4: Add reg property to the lp5562
channel node") it is possible to skip unused channels.

Remove the actually unused white LED channel.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 8c796551352b..3107bf7fbce5 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -290,14 +290,6 @@ chan@2 {
 			reg = <2>;
 			color = <LED_COLOR_ID_BLUE>;
 		};
-
-		chan@3 {
-			chan-name = "W";
-			led-cur = /bits/ 8 <0x0>;
-			max-cur = /bits/ 8 <0x0>;
-			reg = <3>;
-			color = <LED_COLOR_ID_WHITE>;
-		};
 	};
 
 	eeprom@57 {
-- 
2.25.1

