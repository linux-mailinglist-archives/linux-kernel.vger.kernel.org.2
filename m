Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A893730E034
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhBCQy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhBCQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:53:28 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA40C06178B;
        Wed,  3 Feb 2021 08:52:47 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w2so37026ejk.13;
        Wed, 03 Feb 2021 08:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+BJMGWHLsTX5MlRIS1oP4w6pgHVT3Wm6jubVVravIM=;
        b=H8j8elFQyAQT596KLgHEEXafZKHCs59NI9h7Ew5zGRsxXwcC/Set/ikAFksjfUGOvg
         IvLoV9T8B+qSQL788a5C/YOAuJBbrKVc32YrijLgxmaEZmgQRrjruCgz75mw73SBJOzl
         3gmWRJ9qRJ84B3akc1Zx6m/y9V8SqvskUkYRLmFU3fdLXCG1KXXXodRJyp+h+CxXvrh6
         vPqT4nZQz+PBMgWyZtjWWXCmmpYYV43myxmasY5rU/H/9uLyfllJiSNImJzVRFxH7TSK
         I4T43jEqpmClBMEC6o9f3o05lzeUQe7WV8LEM0l/Ye2odw5yFOiAlQh0+6ESx1YLbIBH
         ne+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2+BJMGWHLsTX5MlRIS1oP4w6pgHVT3Wm6jubVVravIM=;
        b=QTe51suNEi6IJ0vGCbe601sIHzsY5GlUYWRWUFGbyl2uL65QLHH4ZqBwe4caesWysk
         +KiuKBygRYiOr25/VpLkNkjg3GWt44vftZsFwnDRchvkU4mCdTLl56+ICiEDyEdAY9cN
         ZCJpGVDroz25d/+LLdk+/qlBEPZkKw3qmhYGqqxF1gAov+KfTTUEWvbpUkfdAG7I+rra
         jS0dZPjCD7h3pXKsWkIgr1EXdmS5dbZdpS56HJm3kDHiojt2L0upXIutdD0zHVbX88E3
         ZzBE+aqDf/X7+hLdukfWtBmjw4OhfrY7fATynP7fLi/ujqXEkQWy3Q5firm5S5fAeLNh
         n7Cw==
X-Gm-Message-State: AOAM532AG7WyeDy83uWlZbFbw7Zh8lIRyUvd01Aaeqk54ddYNLqj6TN5
        uMS3wvJRpdb3MIJnO/DCTP8=
X-Google-Smtp-Source: ABdhPJwGyqtK6IyX2vJyppK8AP4yJzS7aB6LYD1lBXXP05MyfuwOsBrgsOGj3a9AxLbcRHCU3i2akA==
X-Received: by 2002:a17:906:6449:: with SMTP id l9mr4287601ejn.320.1612371166492;
        Wed, 03 Feb 2021 08:52:46 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a25sm1135471eds.48.2021.02.03.08.52.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 08:52:46 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] arm64: dts: rockchip: add rk3328 dwc3 usb controller node
Date:   Wed,  3 Feb 2021 17:52:32 +0100
Message-Id: <20210203165233.22177-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210203165233.22177-1-jbx6244@gmail.com>
References: <20210203165233.22177-1-jbx6244@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 4d4cd1830..a3b069a10 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -988,6 +988,25 @@
 		status = "disabled";
 	};
 
+	usbdrd3: usb@ff600000 {
+		compatible = "rockchip,rk3328-dwc3", "snps,dwc3";
+		reg = <0x0 0xff600000 0x0 0x100000>;
+		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_USB3OTG_REF>, <&cru SCLK_USB3OTG_SUSPEND>,
+			 <&cru ACLK_USB3OTG>;
+		clock-names = "ref_clk", "suspend_clk",
+			      "bus_clk";
+		dr_mode = "otg";
+		phy_type = "utmi_wide";
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis_enblslpm_quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis_u2_susphy_quirk;
+		snps,dis_u3_susphy_quirk;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@ff811000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
2.11.0

