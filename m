Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D1C39A4E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhFCPmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:42:49 -0400
Received: from mx01.ayax.eu ([188.137.98.110]:41858 "EHLO mx01.ayax.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhFCPmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:42:47 -0400
Received: from [192.168.192.146] (port=48290 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1lopSj-00063B-Pd; Thu, 03 Jun 2021 17:40:49 +0200
Date:   Thu, 3 Jun 2021 17:40:48 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: fix the Odyssey SoM eMMC VQMMC supply
Message-ID: <YLj4AMTCi84yO9GO@nx64de-df6d00>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Seeed SoM-STM32MP157C device tree had the eMMC’s (SDMMC2) VQMMC
supply set to v3v3 (buck4), the same as the VMMC supply. That was
incorrect, as on the SoM, the VQMMC supply is provided from vdd (buck3)
instead.

Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
---
 arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
index 6cf49a0a9e69..b5601d270c8f 100644
--- a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
@@ -269,7 +269,7 @@ &sdmmc2 {
 	st,neg-edge;
 	bus-width = <8>;
 	vmmc-supply = <&v3v3>;
-	vqmmc-supply = <&v3v3>;
+	vqmmc-supply = <&vdd>;
 	mmc-ddr-3_3v;
 	status = "okay";
 };
-- 
2.30.2

