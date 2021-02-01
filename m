Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318BC30B035
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhBATRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhBATRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:17:10 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828FFC0613D6;
        Mon,  1 Feb 2021 11:16:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s3so6481987edi.7;
        Mon, 01 Feb 2021 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2oJ/oS9W6B6NjUjWeyWWEJnoptgHKF+k6enHUja9os=;
        b=e2ZSe5L4DqRkHowO7yuhyPs3CMkfnLue4kyX/ln/Ia7m3ahZG//k55NGvjuHnUkxel
         iwTd8xIyzHn9aMLxJvRbjy9zk+Nyha3uq6Uw99qr0+nr5r+hTj4iDhmS825oSh5ix0Ys
         iLqa4kUp5I+PNPLCmtXO8XTu33h2XuIdJvr7FEiC51d5kQE6jx88JUGu3hF+cWiY5kHV
         sLqTnerAh2sU/LJXuAp4ysnFOD7k2si575b/RZ6ezCHjVj2PNk03qMOJ9ZoBYNMv2d2j
         Fw5P9Aj4iL2SC99cjaRxbs3UfGoSZa/RVXNsOUyUW6Wey50aIfFR5u+az3FS5ydrN1WO
         Yicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2oJ/oS9W6B6NjUjWeyWWEJnoptgHKF+k6enHUja9os=;
        b=WA1HRS3icn0EaWCasr/ARGIxsh0WvF0k6ZnWa6tmKiOhdYkLDk5KtGaTNcuyxqocW3
         IZc/vm0HmC4zqszeFYWafS+rbU/OeusUy+x0FSWk3YLgdIiBfOxsq902CtWc/RR01M52
         7pgXa2soavwKvtECQy3G6CnPh5Gwu3yul3MBvyfI+bt3KHltJ6PH72CPqLgIzjuAOHE6
         tGQINWN1Ysk/H7itG6151xuNw68Gl0AGpUIrU+SGOe+emYgfLoftNK9hmhLZirdOxDzh
         X3VO92zsxsV2Mk71ZV5hoZeuE/Ykfo2HHiTNwrX8bJ0pKkT2sAJZXcZ/E70gYM4DxQG3
         ahpg==
X-Gm-Message-State: AOAM53062jULvCWeiRuMR3BYrk/hE2z4XCUzMbXe5G9CzSEXOZch6RhG
        aOGaxorsrOo6wg0Fz+9rOQZWkaOxuVY=
X-Google-Smtp-Source: ABdhPJxhYrtE/Fe8Ro1UgIM2UBNTJv8wyaDn1S4w3Rujmub+U6t7MbTvxNQS9bY+5gv4bSHBFtXm9w==
X-Received: by 2002:aa7:dace:: with SMTP id x14mr20615282eds.300.1612206989336;
        Mon, 01 Feb 2021 11:16:29 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a11sm8243630ejc.64.2021.02.01.11.16.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:16:29 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] arm64: dts: rockchip: add rk3328 dwc3 usb controller node
Date:   Mon,  1 Feb 2021 20:16:18 +0100
Message-Id: <20210201191619.32353-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210201191619.32353-1-jbx6244@gmail.com>
References: <20210201191619.32353-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

RK3328 SoCs have one USB 3.0 OTG controller which uses DWC_USB3
core's general architecture. It can act as static xHCI host
controller, static device controller, USB 3.0/2.0 OTG basing
on ID of USB3.0 PHY.

Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 17709faf6..2bb666d35 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -987,6 +987,33 @@
 		status = "disabled";
 	};
 
+	usbdrd3: usb@ff600000 {
+		compatible = "rockchip,rk3328-dwc3";
+		clocks = <&cru SCLK_USB3OTG_REF>, <&cru SCLK_USB3OTG_SUSPEND>,
+			 <&cru ACLK_USB3OTG>;
+		clock-names = "ref_clk", "suspend_clk",
+			      "bus_clk";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		usbdrd_dwc3: usb@ff600000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xff600000 0x0 0x100000>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "otg";
+			phy_type = "utmi_wide";
+			snps,dis_enblslpm_quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,dis_u2_susphy_quirk;
+			snps,dis_u3_susphy_quirk;
+			snps,dis-del-phy-power-chg-quirk;
+			snps,dis-tx-ipgap-linecheck-quirk;
+			status = "disabled";
+		};
+	};
+
 	gic: interrupt-controller@ff811000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
2.11.0

