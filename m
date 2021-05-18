Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0A387E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351021AbhERQ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350992AbhERQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:58:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32024C06175F;
        Tue, 18 May 2021 09:57:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n2so15656492ejy.7;
        Tue, 18 May 2021 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DHH8YHAlTPU5T8bDwFoNt/piYkwaeBsEh0BIqwvr1v8=;
        b=Pr9vJRvAGeRZq3F9LEs3Ot8+o+c5VHPHPU2rvqxAlJqLbyhmKZdXY577NAgttua00w
         sLwqNiuRl/ipGfTh2jE4DVXIKXZWsk1vhGHmz3NLj5OjCiEGP+p1BKJ3rURY1vsgqPZr
         pqZzJaS7Zz0X4FTIkLwSH5yk5N2RZqvKhDtsalejQT51T1CYi7cevbzybEy+G2aQfsKS
         11jN/tgEaC7v2zv+IuO9AzlGILN8RjTJrrtRNEskXtLd8adb8jEwM1ThqD0Yvs2fRjS8
         3PAmmymqEwLRPi6FZ7FHI/Dnc8iOhCY0w/Yw5h6nZzcRXKI+98QAA7RcF9iaJuRgFI+E
         g9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DHH8YHAlTPU5T8bDwFoNt/piYkwaeBsEh0BIqwvr1v8=;
        b=SUrg0D13/6jN95aAE05URP1S6WYl+2+sL182gEPt9d1u3lOaawCKXiVhnNjCJDOjz4
         q93iIaNvssZmZOGdoEhT5HYBVeaYW31iAAY1Jy9qj+uvwNt33SL6cC+R4rlMZ0jRruy+
         Ca4LK8htPIPdiTEGhtCM1kcfzDZm2z7WgooqgBfe8qonXcr9UFiEyhhkmiuw8v8TsciL
         wEqo5PzIOVjobYoqW5I5D+X5riIbW9x4mHxUMFIr8NizWXIzh9GOM+JKuSHCzDIrXUrG
         maQiz9z2adno9mN+nbQRizcjnZU75d53PHsZ160Igh1Rfa4VDfaNfdpIcxsnLSzNeIM+
         KYxw==
X-Gm-Message-State: AOAM531DZuw1s6gxEmvxCT3N7YftTXZE6jvG21rbzSwv4B/Ws+TB4g3v
        iNtjN8A5KsS3PHA70ufZZww=
X-Google-Smtp-Source: ABdhPJxCoRdQlBvUqCnmlq7ggRW09bTbmA0gtEsyu7TsFhhhCSuIPzqLSP7/iEmVQZpJfCnZxMrNnQ==
X-Received: by 2002:a17:906:a0d3:: with SMTP id bh19mr6259825ejb.205.1621357031934;
        Tue, 18 May 2021 09:57:11 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n2sm13525676edi.32.2021.05.18.09.57.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 09:57:11 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
Date:   Tue, 18 May 2021 18:56:58 +0200
Message-Id: <20210518165658.12764-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210518165658.12764-1-jbx6244@gmail.com>
References: <20210518165658.12764-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"
in phy-provider.yaml has required "#phy-cells" for phy nodes.
The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
notifications.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 2 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 4e243d72e..248ebb61a 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -822,7 +822,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy: usb2-phy@100 {
+		u2phy: usb2phy@100 {
 			compatible = "rockchip,px30-usb2phy";
 			reg = <0x100 0x20>;
 			clocks = <&pmucru SCLK_USBPHY_REF>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index bc0bdc3d8..8c821acb2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -819,7 +819,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy: usb2-phy@100 {
+		u2phy: usb2phy@100 {
 			compatible = "rockchip,rk3328-usb2phy";
 			reg = <0x100 0x10>;
 			clocks = <&xin24m>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index a2eba5357..c1a253507 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1418,7 +1418,7 @@
 			status = "disabled";
 		};
 
-		u2phy0: usb2-phy@e450 {
+		u2phy0: usb2phy@e450 {
 			compatible = "rockchip,rk3399-usb2phy";
 			reg = <0xe450 0x10>;
 			clocks = <&cru SCLK_USB2PHY0_REF>;
@@ -1445,7 +1445,7 @@
 			};
 		};
 
-		u2phy1: usb2-phy@e460 {
+		u2phy1: usb2phy@e460 {
 			compatible = "rockchip,rk3399-usb2phy";
 			reg = <0xe460 0x10>;
 			clocks = <&cru SCLK_USB2PHY1_REF>;
-- 
2.11.0

