Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6F30B08D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhBATmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhBATmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:42:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26662C0613D6;
        Mon,  1 Feb 2021 11:41:21 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g10so2002776eds.2;
        Mon, 01 Feb 2021 11:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2oJ/oS9W6B6NjUjWeyWWEJnoptgHKF+k6enHUja9os=;
        b=U/v8lwUONcQVdPmXvuzDftJuNNKgu/kZIz9dZstTYnJVBjMLk//Jn9D8cQh0YhZjW9
         QniU2yKt7T6i+fXOik+J34btYypV3PLqYArdrta1pvoF0vh0XzC2yX0+eukut0IS/ZSC
         TlAXhCWmoJei5Wa6wKZ2oeUgVXZ774eFQUlUdjjhcRwrcvnTaoZDiJnW8QOn1qQ0+hjA
         fuP8375zh0z0DiLvPTRpOwFFToLepqUJHXbr27apOBCjUMbkXemrB0dORU+Bo5hCWfYy
         j8ixwlMOUyO7segg/AE5AlCmepc/dT040V0Gi9zqz0jNjVRrokOU4OaHGgHVOPZZ8ZbT
         PrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2oJ/oS9W6B6NjUjWeyWWEJnoptgHKF+k6enHUja9os=;
        b=lrHHUDqwqDToqpF5NfIgQNIaFkHSiuCIKWzdEFJvoxvFsQdhchDn8mW2ip/VIJmANs
         5qDABo35NRt6wVCfJDr7zkTXXUF9snvPO67CQClQn+0NDxRG5Ex24K2JLLhd7r0dvub5
         wt5+xtQhHC3vcyOf+Lkh/1kokLQb82XT6iedOxUdqkfZkuikWkv3BRDy6NgQy/2BJ+d7
         lbspEVsIl/kR8Hgbe6tDNWOzUUjEIxwU3tu/2qgKJ1tClEoKy7Z8+RyKxkViQVOqoASv
         mhJy5OjO0G4X0hbkhTZN/xRDWNXHvU/j+EFmkgSXjo7RJBrMZApz3H53vukE6FnpHR5R
         fMsA==
X-Gm-Message-State: AOAM532piiZ4beMGWED0NBMPAMcagtD1FREHsoyOE2VkM070/UqVLsli
        e9krnTV5z4zEBIxHFc/dCoE=
X-Google-Smtp-Source: ABdhPJw+3+upS6Y8szLFRK1M7jQuDS+kNgSwi9O2KTrM5d/ESlEqDOL9XgQ/Mnvc8ng0V8MdhhUQ0A==
X-Received: by 2002:a50:ee99:: with SMTP id f25mr9033753edr.17.1612208479932;
        Mon, 01 Feb 2021 11:41:19 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id du6sm6702799ejc.78.2021.02.01.11.41.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:41:19 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] arm64: dts: rockchip: add rk3328 dwc3 usb controller node
Date:   Mon,  1 Feb 2021 20:41:04 +0100
Message-Id: <20210201194105.32673-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210201194105.32673-1-jbx6244@gmail.com>
References: <20210201194105.32673-1-jbx6244@gmail.com>
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

