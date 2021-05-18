Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A038740B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347463AbhERIa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347447AbhERIaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:30:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085C0C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 01:29:00 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1liv5x-00074f-4D; Tue, 18 May 2021 10:28:53 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1liv5v-0006nv-Lc; Tue, 18 May 2021 10:28:51 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v1 5/9] ARM: dts: imx6dl: enable touchscreen debounce filter on PLYM2M and PRTVT7 boards
Date:   Tue, 18 May 2021 10:28:46 +0200
Message-Id: <20210518082850.26048-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210518082850.26048-1-o.rempel@pengutronix.de>
References: <20210518082850.26048-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activate low-pass/debounce filter on the touchscreen.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-plym2m.dts | 4 +++-
 arch/arm/boot/dts/imx6dl-prtvt7.dts | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-plym2m.dts b/arch/arm/boot/dts/imx6dl-plym2m.dts
index c97274f0df07..60fe5f14666e 100644
--- a/arch/arm/boot/dts/imx6dl-plym2m.dts
+++ b/arch/arm/boot/dts/imx6dl-plym2m.dts
@@ -145,7 +145,9 @@ touchscreen@0 {
 		ti,vref-delay-usecs = /bits/ 16 <100>;
 		ti,x-plate-ohms = /bits/ 16 <800>;
 		ti,y-plate-ohms = /bits/ 16 <300>;
-
+		ti,debounce-max = /bits/ 16 <3>;
+		ti,debounce-tol = /bits/ 16 <70>;
+		ti,debounce-rep = /bits/ 16 <3>;
 		wakeup-source;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
index d22ded6fc48b..1626f3704f1b 100644
--- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
@@ -233,6 +233,9 @@ touchscreen@0 {
 		ti,vref-delay-usecs = /bits/ 16 <100>;
 		ti,x-plate-ohms = /bits/ 16 <800>;
 		ti,y-plate-ohms = /bits/ 16 <300>;
+		ti,debounce-max = /bits/ 16 <3>;
+		ti,debounce-tol = /bits/ 16 <70>;
+		ti,debounce-rep = /bits/ 16 <3>;
 		wakeup-source;
 	};
 };
-- 
2.29.2

