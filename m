Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822DF3F8AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbhHZPMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:12:32 -0400
Received: from mx01.ayax.eu ([188.137.98.110]:37300 "EHLO mx01.ayax.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232291AbhHZPMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:12:31 -0400
X-Greylist: delayed 1542 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 11:12:30 EDT
Received: from [192.168.192.146] (port=53042 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1mJGdV-0007Jl-4T; Thu, 26 Aug 2021 16:45:45 +0200
Date:   Thu, 26 Aug 2021 16:45:43 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: set the DCMI pins on stm32mp157c-odyssey
Message-ID: <YSepFyt8o+5lAsrA@nx64de-df6d00>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Seeed Odyssey-STM32MP157C board has a 20-pin DVP camera output. The
DCMI pins used on this output are defined in the pin state definition
&pinctrl/dcmi-1, AKA &dcmi_pins_b (added in mainline commit
02814a41529a55dbfb9fbb2a3728e78e70646ea6). Set these pins as the default
pinctrl of the DCMI peripheral in the board device tree.

The pins are not used for any other purpose, so it seems safe to assume
most users will not need to override (delete) what this patch provides.
status defaults to "disabled", so the peripheral will not be
unnecessarily started. And the users who actually intend to make use of
a camera on the DVP port will have this little part of the configuration
ready.

Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
---
 arch/arm/boot/dts/stm32mp157c-odyssey.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
index be1dd5e9e744..554f5d3bcdc3 100644
--- a/arch/arm/boot/dts/stm32mp157c-odyssey.dts
+++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
@@ -22,6 +22,12 @@ chosen {
 	};
 };
 
+&dcmi {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&dcmi_pins_b>;
+	pinctrl-1 = <&dcmi_sleep_pins_b>;
+};
+
 &ethernet0 {
 	status = "okay";
 	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
-- 
2.30.2

