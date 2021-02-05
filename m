Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7302B310A92
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhBELq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhBELlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:41:18 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880BBC061797;
        Fri,  5 Feb 2021 03:40:37 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id f14so11438479ejc.8;
        Fri, 05 Feb 2021 03:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CZhB/NEJnRkF+TAIIRVQHf9Sf3lp8bbtJmnwDMjx8Fs=;
        b=qZ/94xf6MG08r4w7hVn8z1SwUqu0COFjxcj1qj0P3OkbC+LKT7JTnh3x0p9YGT7OUc
         4NOzhjzQnZ6byKaC1vtwHoYv62/LmhnuXair7xSkE1a1zz77fU9YaGO0d7LL3MPhjWyk
         60IKWrI008ayInQLWynwUb0sDlOH11ke2R7SQdS36zmcclXcmXAZ7LVGbtoijpDwrTTn
         n8s5NYhkhtXPsjVj4sEFRcTxFSSvdNsaRupVOZdtcADKhe0FYMbCgLuVqgXKGZlpGgeT
         ltCPh6RyUF46RsfwBtWV6KFBFASk5qPI32TwC69EaJB8etHQRRYvCynOUkDMkbz42EVN
         6XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CZhB/NEJnRkF+TAIIRVQHf9Sf3lp8bbtJmnwDMjx8Fs=;
        b=dE6YjOKEheUMtuJ1trAIbpSxjQh0pORsy1enK9LJL+5phFOu7aOVMACK5H8eEmXyoE
         X/VmCaJGGQhLgKv+L5O80Wk04N51ddxWVdOSnBM4i322Gm58I80z0rfwhuVEsHeTNTYF
         0sfAyb1FaqyVbLtVNGtL/azFr4evy+cnGYPhIFjl75uftKz1WFQTmJX1Ej0oM3UfrESO
         kJPuVmtSO+illMwO2Jwp1F9ZT4SW0Owvls7UFT/Noby7VVoXfiS34j246TNpkbwT4OeH
         n74Y+Ii+Z7K6jgatXx4hHX56rEqDT0MPw6W361tWYWcwDqT7ZBwcbgnm1+X14aCgB2xN
         cy+A==
X-Gm-Message-State: AOAM5332Ri7VJWp4xRMjByjIhiex7H2S8xgKeI1L/OBrQkV+9X8pcg2O
        Dq4suDF5qh0Ewgrt74B2oTY=
X-Google-Smtp-Source: ABdhPJywtesZHFp+KrSzQp3X9HLOTFBmKOJ78T5WeWs6ktXQP5xkxzl7wAKVwq9a9f59wFqjUIxjWw==
X-Received: by 2002:a17:906:24ca:: with SMTP id f10mr3567882ejb.96.1612525236366;
        Fri, 05 Feb 2021 03:40:36 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o4sm3883476edw.78.2021.02.05.03.40.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 03:40:35 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] arm64: dts: rockchip: add rk3328 dwc3 usb controller node
Date:   Fri,  5 Feb 2021 12:40:10 +0100
Message-Id: <20210205114011.10381-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210205114011.10381-1-jbx6244@gmail.com>
References: <20210205114011.10381-1-jbx6244@gmail.com>
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
Changed V2:
  remove node wrapper
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

